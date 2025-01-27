---
layout: default
title: Installation de l'environnement de travail
description: Guide pour installer les outils nécessaires à la bioinformatique.
---

# Installation de l'environnement de travail

## Installation de WSL (Windows Subsystem for Linux)
Pour plus d'informations, consultez le guide [WSL pour Windows](https://learn.microsoft.com/en-us/windows/wsl/).

1. Activez WSL sur votre système Windows.
   ```bash
   wsl --install


2. Installez Ubuntu 24.04 LTS via le Microsoft Store.

   ```bash
   sudo apt update && sudo apt upgrade -y
   sudo apt install python3 python3-pip git
   pip3 install jupyter bash_kernel


