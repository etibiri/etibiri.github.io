---
layout: default
title: Installation de l'environnement de travail
description: Guide pour installer les outils nécessaires à la bioinformatique.
---

# Installation de l'environnement de travail

## Installation de WSL (Windows Subsystem for Linux)
Pour plus d'informations, consultez le guide officiel de [WSL pour Windows](https://learn.microsoft.com/en-us/windows/wsl/).

### Étapes d'installation :

1. **Activation de WSL**
   Exécutez la commande suivante dans un terminal PowerShell en mode administrateur :
   
   ```powershell
   wsl --install
   ```
   
   Vous pouvez voir la liste des distributions Linux disponibles avec :
   
   ```powershell
   wsl -l -o
   ```
   
   Pour installer une distribution spécifique (ex. Ubuntu 24.04 LTS) :
   
   ```powershell
   wsl --install -d Ubuntu-24.04
   ```

2. **Mise à jour et installation des outils essentiels**
   Après l'installation, ouvrez votre terminal WSL et mettez à jour votre système :
   
   ```bash
   sudo apt update && sudo apt upgrade -y
   ```
   
   Installez les outils nécessaires :
   
   ```bash
   sudo apt install -y python3 python3-pip git
   ```

### Vérification de l'installation
Pour vérifier que tout est bien installé, exécutez :

```bash
python3 --version
git --version
```

Si vous voyez les versions respectives s'afficher, votre environnement est prêt ! 🎉

### Ressources supplémentaires
- [Documentation officielle de WSL](https://learn.microsoft.com/en-us/windows/wsl/)

---
Avec cette configuration, vous êtes maintenant prêt à commencer vos analyses bioinformatiques ! 🚀
---
<!-- Pied de page -->

© 2025 **Ezechiel B. TIBIRI. Tous droits réservés.**

Site hébergé sur [GitHub](https://github.com/etibiri).
---
