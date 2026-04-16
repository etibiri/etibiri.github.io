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

```bash
wget https://ont-exd-int-s3-euwst1-epi2me-labs.s3.amazonaws.com/wf-bacterial-genomes/wf-bacterial-genomes-demo.tar.gz
tar -xzvf wf-bacterial-genomes-demo.tar.gz
```


