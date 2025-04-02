---
layout: default
title: Installation de l'environnement de travail
description: Guide pour installer les outils n??cessaires ?? la bioinformatique.
---

# Installation de l'environnement de travail

## Installation de WSL (Windows Subsystem for Linux)
Pour plus d'informations, consultez le guide [WSL pour Windows](https://learn.microsoft.com/en-us/windows/wsl/).

1. Activez WSL sur votre syst??me Windows.
   ```bash
   wsl --install
   # To see a list of available Linux distributions available for download through the online
   wsl -l -o
   To install additional Linux distributions after the initial install,you may also use the command:
   wsl --install -d
   ``` 
2. Installez Ubuntu 24.04 LTS via le Microsoft Store.

   ```bash
   sudo apt update && sudo apt upgrade -y
   sudo apt install python3 python3-pip git
   pip3 install jupyter bash_kernel
   ```

