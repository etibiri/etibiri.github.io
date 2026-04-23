# Assemblage de génomes bactériens et identification des gènes de résistance aux antibiotiques (AMR)
## 1. Objectifs pédagogiques

À la fin du TP, les étudiants devront être capables de :

* comprendre les étapes d’un pipeline d’analyse génomique bactérienne
* exécuter des outils d’annotation et d’identification AMR
* interpréter la qualité d’un assemblage
* analyser un résistome bactérien
* produire une synthèse scientifique des résultats

Compétences visées :

* Linux
* manipulation FASTQ / FASTA
* annotation génomique
* analyse AMR
* interprétation biologique

## 2. Installation des logiciels
Installation de Conda via Miniconda

```bash
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
```
```bash
bash Miniconda3-latest-Linux-x86_64.sh
```
```bash
source ~/.bashrc
```
Configuration de l'environnement conda

```bash
conda config --set auto_activate_base false
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge
conda config --add channels nanoporetech
conda config --set channel_priority strict
```

Créer environnement

```bash
conda create -n bacterial_tp -y
conda activate bacterial_tp
```
## 3. Installation outils d’analyse génomique
3.1 Installer les logiciel seqkit, mlst, sourmash, abricate dans l'environnement bacterial_tp

```bash
conda install -c bioconda seqkit=2.13 -y
```
```bahs
conda install -c conda-forge -c bioconda  mlst -y
```
```bash
conda install -c conda-forge sourmash-minimal -y
```
```bash
conda install -c bioconda abricate -y
```
```bash
conda deactivate
```

3.2. Installer les autres environnement quast_env, bakta_env, flye_env, busco_env, resfinder_env separement

```bash
conda create -n quast_env -c bioconda quast -y
```
```bash
conda create -n bakta_env -c conda-forge -c bioconda python>=3.10 bakta -y
```
```bash
conda create -n flye_env -c bioconda flye=2.9 -y
```
```bash
conda create -n busco_env  -c conda-forge -c bioconda busco=6.0.0 sepp=4.5.5 -y
```
```bash
conda create -n resfinder_env bioconda::resfinder -y 
```

3.3. installer checkm2

```bash
git clone --recursive https://github.com/chklovski/checkm2.git && cd checkm2
conda env create -n checkm2_env -f checkm2.yml
conda activate checkm2_env
# Pour lancer checkm2 il faut
bin/checkm2 -h
```

## 4. Données à télécharger et decompression de l'archive

 * Contexte du TP

L’essor du séquençage à long reads, notamment avec les technologies Oxford Nanopore, a profondément transformé l’analyse des génomes bactériens. Il est désormais possible, à partir de fichiers FASTQ bruts, de reconstruire un génome bactérien, de l’annoter, puis d’identifier des déterminants moléculaires de résistance aux antimicrobiens.

Dans ce TP, l’étudiant suivra une démarche bioinformatique classique appliquée à des données réelles ou de démonstration :

* - organiser un espace de travail ;
* - télécharger et inspecter les données brutes ;
* - évaluer sommairement la qualité des séquences ;
* - assembler le génome bactérien ;
* - annoter le génome assemblé ;
* - rechercher des marqueurs de résistance aux antimicrobiens.

Ce TP permet ainsi d’illustrer une chaîne d’analyse complète, depuis les données de séquençage jusqu’à l’interprétation biologique.

l'arborescence du repertoire de travail:

```
TP_AMR/
├── data/
│   
├── assembly/
│   
├── annotation/
│   
├── amr/
│   
└── metadata.tsv
```
### 4.1. Creation des repertoires de travail suivant l'arborescence ci-dessus

```bash
# Commande pour créer les differents repertoires
mkdir -p ~/TP_AMR/data
mkdir -p  ~/TP_AMR/annotation
mkdir -p  ~/TP_AMR/assembly
mkdir -p ~/TP_AMR/amr
cd ~/TP_AMR
tree 
```
### 4.2. Téléchargement des données brute

```bash
# Commande pour télécharger une archive
## Deplacez vous dans le repertoire *data* puis lancer la commande ci-dessous
cd ~/TP_AMR/data
wget https://ont-exd-int-s3-euwst1-epi2me-labs.s3.amazonaws.com/wf-bacterial-genomes/wf-bacterial-genomes-demo.tar.gz
# Commande pour decompresser une archive
tar -xzvf wf-bacterial-genomes-demo.tar.gz
# Lister le contenu du repertoire
ls -lh ~/TP_AMR/data/wf-bacterial-genomes-demo/isolates_fastq
```

### 4.2. Evaluer les QC des sequences
Un read brute correspond à une séquence nucléotidique produite directement par le séquenceur. Dans le cas d’Oxford Nanopore, ces reads sont souvent longues, ce qui facilite l’assemblage, mais elles peuvent contenir davantage d’erreurs qu’avec certaines technologies de short reads.

 * - Formats FASTA et FASTQ
      - FASTA: [format simple contenant un identifiant et une séquence](https://fr.wikipedia.org/wiki/FASTA_(format_de_fichier)).
      - FASTQ: [format contenant l’identifiant, la séquence et les scores de qualité de chaque base.](https://fr.wikipedia.org/wiki/FASTQ).

[SeqKit](https://bioinf.shenwei.me/seqkit/usage/) prend en charge directement les formats FASTA et FASTQ et détecte automatiquement le format des séquences.

Le contrôle qualité consiste à examiner des indicateurs simples tels que :

* - le nombre de reads ;
* - la longueur minimale, moyenne et maximale ;
* - le nombre total de bases ;
* - éventuellement le contenu en GC et la distribution des longueurs.

Cette étape permet de vérifier rapidement si les données sont exploitables avant l’assemblage.

```bash
# evaluer la qualité de sequence avec *seqkit*
conda activate bacterial_tp
seqkit stats ~/TP_AMR/data/wf-bacterial-genomes-demo/isolates_fastq/barcode01/myco.fastq.gz
conda deactivate
```

### 4.3 Assemblage de genome bacterien

L'[assemblage de génome](https://www.genoscreen.fr/fr/services-genomiques/bioinformatique/assemblage) permet de reconstituer un génome complet à partir des nouvelles techniques de séquençage, soit en s’appuyant sur des génomes de référence, soit dans une démarche _de novo_. Cette reconstruction donne une image plus complète et plus détaillée des données génomiques, pour en faciliter l’interprétation.
[Flye](https://github.com/mikolmogorov/Flye) est un assembleur conçu pour les long reads de type PacBio et Oxford Nanopore.

```bash
conda activate flye_env
flye --nano-hq \
    ~/TP_AMR/data/wf-bacterial-genomes-demo/isolates_fastq/barcode01/myco.fastq.gz \
    --genome-size 5m \
    --out-dir ~/TP_AMR/assembly/barcode01 \
    --threads 4
```
Explication des paramètres:
- `--nano-hq` : indique que les lectures ONT sont de haute qualité.
- `--genome-size 5m` : taille estimée du génome à assembler, ici 5 Mb.
- `--out-dir` : dossier de sortie.
- `--threads 4` : nombre de cœurs CPU utilisés.

### 4.4. Annotation de génome

L’annotation consiste à identifier dans le génome assemblé des éléments biologiques tels que :

* - gènes codants ;
* - ARN ribosomiques ;
* - ARN de transfert ;
* - autres éléments fonctionnels.

[Bakta](https://bakta.readthedocs.io/en/latest/) est un outil d’annotation rapide et standardisée des génomes bactériens, plasmides et MAGs. Sa [base de données](https://bakta.readthedocs.io/en/latest/cli/database.html) existe en version full et en version light ; la version light est utile lorsque l’on souhaite limiter l’espace disque et réduire le temps de calcul.

```bash
conda activate bakta_env
# Télécharger la base de donnnée bacterienne
bakta_db download --output ~/TP_AMR/annotation/bakta_db_ligth --type light 
conda deactivate
```
```bash
# Annotation
bakta --db ~/TP_AMR/annotation/bakta_db_ligth/db-light \
    ~/TP_AMR/assembly/barcode01/assembly.fasta \
    --genus "Mycobacterium" \
    --species "tuberculosis" \
    --prefix barcode01 \
    --output ~/TP_AMR/annotation \
    --threads 4 \
    --force

```


### 4.5. Résistance aux antimicrobiens (AMR)

La résistance aux antimicrobiens peut être liée :

* - à l’acquisition de gènes de résistance ;
* - à des mutations ponctuelles dans certains gènes chromosomiques.

[ResFinder](https://github.com/cadms/resfinder) identifie principalement des gènes acquis de résistance, tandis que d’autres approches peuvent être nécessaires pour analyser les mutations associées à la résistance.

```bash
conda activate resfinder_env
```
```bash
cd ~/TP_AMR/amr 
git clone https://git@bitbucket.org/genomicepidemiology/resfinder_db.git db_resfinder
```
```bash
cd ~/TP_AMR/amr/db_resfinder
python3 INSTALL.py
```
```bash
run_resfinder.py \
  -ifa ~/TP_AMR/assembly/barcode01/assembly.fasta \
  -o ~/TP_AMR/amr \
  -db_res ~/TP_AMR/amr/db_resfinder \
  --acquired \
  -s "Mycobacterium tuberculosis" \
  -l 0.6 \
  -t 0.8

```

