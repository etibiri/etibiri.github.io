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
mkdir ~/TP_AMR/data
mkdir ~/TP_AMR/annotation
mkdir ~/TP_AMR/assembly
mkdir ~/TP_AMR/arm
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
# Afficher les 10 prèmières et 10 dernière lignes du fichier qui se trouve dans le repertoire wf-bacterial-genomes-demo
head ~/TP_AMR/data/wf-bacterial-genomes-demo/isolates_sample_sheet.csv
# Compter le nombre de ligne
wc -l ~/TP_AMR/data/wf-bacterial-genomes-demo/isolates_sample_sheet.csv
```

### 4.2. Evaluer les QC des sequences
 * - Les formats 
      - FASTA [FASTA](https://fr.wikipedia.org/wiki/FASTA_(format_de_fichier))
      - FASTQ [FASTQ](https://fr.wikipedia.org/wiki/FASTQ)

```bash
# evaluer la qualité de sequence avec *seqkit*
conda activate bacterial_tp
seqkit stats -a ~/TP_AMR/data/wf-bacterial-genomes-demo/isolates_fastq/barcode01/myco.fastq.gz
conda deactivate
```

### 4.3 Assemblage de genome bacterien

L'[assemblage de génome](https://www.genoscreen.fr/fr/services-genomiques/bioinformatique/assemblage) permet de reconstituer un génome complet à partir des nouvelles techniques de séquençage, soit en s’appuyant sur des génomes de référence, soit dans une démarche _de novo_. Cette reconstruction donne une image plus complète et plus détaillée des données génomiques, pour en faciliter l’interprétation.

```bash
conda activate flye_env
flye --nano-hq \
    ~/TP_AMR/data/wf-bacterial-genomes-demo/isolates_fastq/barcode01/myco.fastq.gz \
    --genome-size 5m \
    --out-dir ~/TP_AMR/assembly/barcode01 \
    --threads 4
```

### 4.4. Annotation de génome

Les [annotations génomiques](https://www.genoscreen.fr/fr/services-genomiques/bioinformatique/annotation) visent à associer le séquençage d’un génome ou d’un transcriptome à une information biologique exploitable. À partir d’assemblages de haute qualité, GenoScreen fournit des annotations précises qui sont indispensables à la compréhension des fonctions biologiques des organismes.

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


### 4.5. Identification des AMR

Vous trouverez les ressources nécéssaire sur ce site pour réaliser les analyses [Center for Genomic Epidemiology](https://www.genomicepidemiology.org/)

```bash
conda activate resfinder_env
```
```bash
cd ~/TP_AMR/arm 
git clone https://git@bitbucket.org/genomicepidemiology/resfinder_db.git db_resfinder

```
```bash
run_resfinder.py \
  -ifa ~/TP_AMR/assembly/barcode01/assembly.fasta \
  -o ~/TP_AMR/arm \
  -db_res ~/TP_AMR/arm/db_resfinder \
  --acquired \
  -s "Mycobacterium tuberculosis" \
  --point \
  -l 0.6 \
  -t 0.8

```

