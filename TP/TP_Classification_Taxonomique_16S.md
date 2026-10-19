
# 🧬 TP Bioinformatique : Classification taxonomique de séquences 16S rDNA

---

## 🎯 Objectifs pédagogiques

Dans ce TP, vous allez apprendre à :

- Utiliser des outils bioinformatiques pour analyser des données de séquençage 16S rDNA.
- Identifier les microorganismes présents dans des échantillons alimentaires.
- Visualiser la composition microbienne à l'aide d'outils comme **Kraken2** et **Krona**.

---

## 🧪 Contexte

Les séquences 16S rDNA sont des marqueurs moléculaires très utilisés pour identifier les bactéries dans des échantillons environnementaux, cliniques ou alimentaires.  
Ici, nous étudions **trois échantillons alimentaires suspects de contamination microbienne**.  
L’analyse 16S permet de :

- Révéler la **diversité bactérienne** dans un produit
- Mettre en évidence des **contaminations** d’origine alimentaire
- Contribuer au **contrôle qualité** dans l’industrie agroalimentaire

---

## 🧬 Pourquoi le gène 16S rDNA ?

Le gène 16S rDNA code pour une sous-unité du ribosome chez les procaryotes. Il possède :

  -  🔒 Des régions conservées (identiques entre espèces) → pour l’alignement

  -  🧩 Des régions variables (différentes selon les espèces) → pour l’identification

Cela en fait un excellent marqueur moléculaire pour l’identification des bactéries.

---
## 🧰 Comment fait-on la classification taxonomique à partir d’une séquence 16S ?

Voici les étapes clés :

 -  1. 🔬 Extraction de l’ADN et séquençage des amplicons 16S (ex. : via Oxford Nanopore, Illumina…)

 -  2.  💻 Nettoyage et préparation des données

 -  3.  🧠 Comparaison des séquences avec une base de données de référence (ex : SILVA, Greengenes, RDP)

 -  4.  📊 Attribution d’un taxon (nom scientifique) à chaque séquence selon sa similarité

 -   5. 🌐 Visualisation des résultats (ex. : diagrammes, Krona)
---
## 📦 Prérequis

Avant de commencer, assurez-vous que les outils suivants sont installés sur votre système (Linux ou WSL recommandé) :

### 🔧 Installation des outils

```bash
# Mise à jour système
sudo apt update && sudo apt upgrade -y

# Installation des outils nécessaires
sudo apt install -y minimap2 samtools kraken2 python3-pip git wget curl

# Installation de Krona (outil de visualisation interactive)
wget https://raw.githubusercontent.com/etibiri/etibiri.github.io/main/scripts/Krona_install.sh
bash Krona_install.sh
source ~/.bashrc
```

---

## 📁 Étape 1 : Préparation des données

Téléchargez les données de démonstration fournies par Oxford Nanopore.

```bash
cd ~
wget -c https://ont-exd-int-s3-euwst1-epi2me-labs.s3.amazonaws.com/wf-16s/wf-16s-demo.tar.gz
tar -xzvf wf-16s-demo.tar.gz

# Organisation du projet
mkdir -p ~/TP-BMGB/DATA
cp -r ~/wf-16s-demo/test_data ~/TP-BMGB/DATA
```

---

## 🧬 Étape 2 : Préparer la base de données taxonomique

### 🧠 Comprendre la classification taxonomique
* 🔍 Qu’est-ce que la classification taxonomique ?

La classification taxonomique est une méthode utilisée pour organiser les êtres vivants (plantes, animaux, micro-organismes, etc.) en groupes hiérarchiques basés sur leurs caractéristiques génétiques et évolutives.
Elle permet de nommer, identifier et regrouper les organismes selon des catégories standardisées.

Dans le cadre de la bioinformatique, cette classification est faite à partir des séquences d’ADN. L’analyse du gène 16S rDNA, présent dans toutes les bactéries, est une méthode très puissante pour :

  -  Identifier les espèces présentes dans un échantillon complexe (ex. : sol, intestin, aliment contaminé)

  -  Comparer les communautés microbiennes entre différents environnements

  -  Étudier la diversité microbienne
---
### 💡 Exemple simple d’arbre taxonomique

```yaml
Règne       : Bacteria  
  └── Phylum : Proteobacteria  
       └── Classe : Gammaproteobacteria  
            └── Ordre : Enterobacterales  
                 └── Famille : Enterobacteriaceae  
                      └── Genre : Escherichia  
                           └── Espèce : Escherichia coli

```
---
### 🔹 Télécharger une base 16S (SILVA) compatible minimap2

```bash
mkdir -p ~/TP-BMGB/DB
cd ~/TP-BMGB/DB

# Téléchargement de la base SILVA 16S avec annotation taxonomique
wget https://zenodo.org/record/3986799/files/silva_nr99_v138_wSpecies_train_set.fa.gz
gunzip -k silva_nr99_v138_wSpecies_train_set.fa.gz

# Nettoyage des en-têtes pour minimap2 : chaque en-tête reçoit un identifiant unique
# (seq1, seq2...) suivi de la taxonomie, avec "_" à la place des ";"
awk '/^>/{n++; h=substr($0,2); sub(/;$/,"",h); gsub(/;/,"_",h); print ">seq" n "|" h; next} {print}' silva_nr99_v138_wSpecies_train_set.fa > database_clean.fasta

# Vérification : le nombre d'en-têtes doit être identique dans les deux fichiers
grep -c "^>" silva_nr99_v138_wSpecies_train_set.fa database_clean.fasta
```

### 🔹 Construire une base Kraken2

```bash
cd ~/TP-BMGB/DB
# Télécharge SILVA et construit la base en une seule commande
kraken2-build --special silva --db kraken2_16S_db --threads 4
```

⏳ **Note : Cette étape peut prendre du temps (~20–30 minutes selon votre machine).**

---

## 🔍 Étape 3 : Alignement et classification

### Alignement de séquences
🧠 Définition :

L’alignement est une technique bioinformatique qui permet de comparer une séquence d’ADN à une ou plusieurs séquences de référence (généralement issues d’une base de données).
L’objectif est de trouver les régions similaires entre les séquences afin d’identifier leur origine biologique.

* 🧰 Pourquoi aligner une séquence ?

  -  Pour identifier un micro-organisme à partir de son ADN.

  - Pour localiser des mutations ou des régions variables.

  - Pour comparer des séquences d'espèces différentes ou d'individus.

* 🔧 Exemple d’outil : minimap2

  -  Utilisé pour aligner rapidement des lectures longues (ONT, PacBio) sur une base de données.

  -  Produit un fichier .sam ou .bam contenant les positions des alignements.

* 🔎 Analogie :

Imaginez que vous ayez un mot inconnu et un dictionnaire : l’alignement revient à chercher le mot qui ressemble le plus dans le dictionnaire.

### 💠 Approche 1 : Alignement avec Minimap2

```bash
mkdir -p ~/TP-BMGB/MAPPING
cd ~/TP-BMGB/MAPPING

# Indexation de la base
minimap2 -d database_clean.mmi ~/TP-BMGB/DB/database_clean.fasta

# Alignement des séquences des 3 échantillons
minimap2 -ax map-ont database_clean.mmi ~/TP-BMGB/DATA/test_data/barcode01/*.fastq.gz > barcode01_alignment.sam
minimap2 -ax map-ont database_clean.mmi ~/TP-BMGB/DATA/test_data/barcode02/*.fastq.gz > barcode02_alignment.sam
minimap2 -ax map-ont database_clean.mmi ~/TP-BMGB/DATA/test_data/barcode03/*.fastq.gz > barcode03_alignment.sam

# Conversion SAM en BAM et tri
samtools view -Sb barcode02_alignment.sam | samtools sort > barcode02_alignment.sorted.bam
samtools view -Sb barcode03_alignment.sam | samtools sort > barcode03_alignment.sorted.bam

samtools index barcode01_alignment.sorted.bam
samtools index barcode02_alignment.sorted.bam
samtools index barcode03_alignment.sorted.bam

```

### 💠 Approche 2 : Classification avec Kraken2

```bash
mkdir -p ~/TP-BMGB/KRAKEN2
cd ~/TP-BMGB/KRAKEN2

# Analyse de chaque échantillon avec Kraken2
kraken2 --db ~/TP-BMGB/DB/kraken2_16S_db --report barcode01_kraken_report.txt --output barcode01_kraken_output.tsv ~/TP-BMGB/DATA/test_data/barcode01/*.fastq.gz
kraken2 --db ~/TP-BMGB/DB/kraken2_16S_db --report barcode02_kraken_report.txt --output barcode02_kraken_output.tsv ~/TP-BMGB/DATA/test_data/barcode02/*.fastq.gz
kraken2 --db ~/TP-BMGB/DB/kraken2_16S_db --report barcode03_kraken_report.txt --output barcode03_kraken_output.tsv ~/TP-BMGB/DATA/test_data/barcode03/*.fastq.gz
```

---

## 📊 Étape 4 : Générer un profil taxonomique

### 🧾 Générer les fichiers complets avec zéros

```bash
kraken2 --db ~/TP-BMGB/DB/kraken2_16S_db --report-zero-counts --output barcode01_output.tsv ~/TP-BMGB/DATA/test_data/barcode01/*.fastq.gz
kraken2 --db ~/TP-BMGB/DB/kraken2_16S_db --report-zero-counts --output barcode02_output.tsv ~/TP-BMGB/DATA/test_data/barcode02/*.fastq.gz
kraken2 --db ~/TP-BMGB/DB/kraken2_16S_db --report-zero-counts --output barcode03_output.tsv ~/TP-BMGB/DATA/test_data/barcode03/*.fastq.gz
```

---

## 🌐 Étape 5 : Visualisation avec Krona

Krona génère une page HTML interactive montrant les taxons détectés.

```bash
# La base Kraken2 SILVA utilise ses propres identifiants de taxons, différents de ceux
# du NCBI utilisés par ktImportTaxonomy : on convertit d'abord le rapport en texte
# avec KrakenTools, puis on l'importe avec ktImportText.
git clone https://github.com/jenniferlu717/KrakenTools.git ~/KrakenTools

for b in barcode01 barcode02 barcode03; do
  python3 ~/KrakenTools/kreport2krona.py -r ${b}_kraken_report.txt -o ${b}_krona.txt
  ktImportText ${b}_krona.txt -o ${b}_krona_output.html
done
```

Ouvrir les fichiers `.html` dans un navigateur pour explorer la diversité microbienne par échantillon.

---

## ✅ Résultats attendus

- Fichiers d’alignement `.bam` par échantillon
- Fichiers Kraken2 : `.tsv`, `.txt`
- Graphiques Krona interactifs : `barcode0X_krona_output.html`

---

## 📚 Ressources utiles

- [Documentation Kraken2](https://ccb.jhu.edu/software/kraken2/)
- [Base de données SILVA 16S](https://www.arb-silva.de/)
- [Krona GitHub](https://github.com/marbl/Krona)
- [Minimap2 GitHub](https://github.com/lh3/minimap2)

---

## 💡 Astuce pour aller plus loin

Vous pouvez également explorer :

- L’export de vos résultats au format `.csv` pour analyse sous Excel/R ou Python
- La comparaison des profils microbiens entre les trois échantillons
- L’application du même pipeline sur le 4ème échantillons ou d'autres données 16S disponobles dans les banques de données


## 📚 Ressources pédagogiques pour approfondir

| Type     | Titre / Lien                                                                                      | Description                                                                 |
|----------|---------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------|
| 🌍 Site  | [NCBI Taxonomy Database](https://www.ncbi.nlm.nih.gov/taxonomy)                                   | Base de données taxonomique utilisée par les outils bioinformatiques       |
| 🧠 Tutoriel | [Introduction to Taxonomic Classification – EMBL-EBI](https://www.ebi.ac.uk/training/online/course/introduction-taxonomy) | Cours en ligne interactif pour débutants                                   |
| 📘 Livre | *Bioinformatics for Beginners* – Wiley (2016)                                                     | Introduction aux bases de la bioinformatique (chapitres sur la classification 16S) |
| 📄 Article | [Schloss et al., 2009 – Introducing mothur](https://doi.org/10.1128/AEM.01541-09)               | Article fondamental sur l’analyse 16S et la communauté microbienne         |
| 🎓 MOOC  | [Coursera - Genomic Data Science](https://www.coursera.org/specializations/genomic-data-science) | Cours incluant l’analyse 16S et outils de classification                   |
| 📘 Livre    | *Bioinformatics Algorithms* – Phillip Compeau & Pavel Pevzner ([Coursera/UCSD](https://www.coursera.org/specializations/bioinformatics))          | Couvre l’alignement, les arbres phylogénétiques et la taxonomie            |
| 📄 Article  | [Minimap2: pairwise alignment for nucleotide sequences – Li, 2018](https://doi.org/10.1093/bioinformatics/bty191)                                | Article scientifique de référence sur minimap2                             |
| 📄 Article  | [Kraken: Ultrafast Metagenomic Sequence Classification – Wood et Salzberg, 2014](https://doi.org/10.1186/gb-2014-15-3-r46)                        | Base méthodologique de Kraken/Kraken2                                      |
| 🧠 Tutoriel | [EBI Training – Sequence alignment](https://www.ebi.ac.uk/training/online/course/introduction-sequence-search-and-alignment)                     | Cours interactif pour débuter avec l’alignement                            |
| 🎓 MOOC     | [Coursera – Metagenomics](https://www.mooc-list.com/tags/metagenomics)                                                                            | Couvre alignement, classification, diversité microbienne                   |

