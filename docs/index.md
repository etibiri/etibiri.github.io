---
layout: default
title: Introduction  la Bioinformatique
description: Introduction au cours de bioinformatique - Objectifs, contenu, ressources et outils.
---

# Introduction  la Bioinformatique

Bienvenue dans le cours d'introduction  la bioinformatique. Ce site vous fournira toutes les informations et ressources nécessaires pour comprendre les bases et outils essentiels de la bioinformatique.

**Note :** La prsence physique  ce cours est obligatoire.

---

##  Objectifs du cours

- Comprendre les bases de la génomique et du séquençage.
- Explorer les outils bioinformatiques essentiels  l'analyse des donnes.
- Installer et configurer un environnement de dveloppement pour la bioinformatique.
- S'initier  la programmation applique  la bioinformatique.

---

##  Intervenant

**Ezechiel B. TIBIRI**  
Chercheur  l'INERA/CNRST  
Email : [ezechiel.tibiri@ujkz.bf](mailto:ezechiel.tibiri@ujkz.bf)

---

##  Prrequis

Pour tirer le meilleur parti de ce cours, il est recommand d'avoir :

- Des notions de biologie molculaire et gnomique.
- Une connaissance de base en informatique.
- Une machine avec les spcifications suivantes :
  - Processeur : 4 curs minimum.
  - RAM : 8 Go ou plus.
  - Stockage : 250 Go disponibles.

---

##  Contenu du cours

1. **Introduction  la Bioinformatique :** Dfinition et concepts cls.
2. **Installation de l'environnement de travail :** Utilisation de WSL (Windows Subsystem for Linux) et d'outils comme Jupyter Notebook.
3. **Programmation en bioinformatique :** Introduction  Python et  l'automatisation avec Bash.
4. **tudes de cas :** Analyse de squences ADN et exploration de donnes mtagnomiques.

---

##  Ressources

- [NCBI (National Center for Biotechnology Information)](https://www.ncbi.nlm.nih.gov)
- [Ensembl Genome Browser](https://www.ensembl.org)
- [Guide WSL pour Windows](https://learn.microsoft.com/en-us/windows/wsl/)
- [Jupyter Notebook Documentation](https://jupyter.org/documentation)

---

##  Installation

Pour commencer avec ce cours :

1. Clonez ce dpt :

```bash
   git clone https://github.com/etibiri/cours-bioinformatique.git
```
2. Installez les dpendances ncessaires via Bash :

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install python3 python3-pip git
pip3 install jupyter bash_kernel
```

3. Lancez Jupyter Notebook :

````bash
jupyter notebook
```
