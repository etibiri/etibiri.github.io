# Les commandes de base de LINUX

La matrise des commandes de base de Linux est essentielle pour les bioinformaticiens. Voici un guide simplifi et illustr pour vous aider  comprendre et utiliser efficacement ces commandes.

---

## 1. Gestion des rpertoires et des fichiers

Ces commandes vous permettent de naviguer dans vos rpertoires, de grer vos fichiers et de crer de nouvelles structures pour organiser vos donnes.

| **Commande** | **Description**                         | **Exemple**                                |
|--------------|-----------------------------------------|--------------------------------------------|
| `pwd`        | Affiche le chemin absolu du rpertoire courant. | `pwd`  `/home/user/Documents`            |
| `ls`         | Liste les fichiers et dossiers du rpertoire actuel. | `ls`  affiche `file1`, `file2`, etc.      |
| `ls -l`      | Affiche les dtails des fichiers (permissions, taille, etc.). | `ls -l`  dtails complets des fichiers.   |
| `ls toto*`   | Liste les fichiers dont le nom commence par "toto". | `ls toto*`  `toto1.txt`, `toto_notes`     |
| `cd`         | Change de rpertoire.                  | `cd Documents`  Dplace vers "Documents". |
| `mkdir -p`   | Cre un rpertoire, y compris les sous-dossiers. | `mkdir -p bioinfo/data`                    |
| `touch`      | Cre un fichier vide ou met  jour la date de modification. | `touch fichier.txt`                        |
| `cp`         | Copie des fichiers.                    | `cp fichier.txt /home/user/Desktop`        |
| `cp -r`      | Copie un rpertoire et son contenu.     | `cp -r dossier1 dossier2`                  |
| `mv`         | Dplace ou renomme des fichiers.        | `mv fichier.txt nouveau_nom.txt`           |
| `rm`         | Supprime des fichiers (irrversible).   | `rm fichier.txt`                           |
| `rm -R`      | Supprime un rpertoire et tout son contenu. | `rm -R dossier`                           |

---

## 2. Commandes d'dition

Ces commandes sont utilises pour afficher ou modifier des fichiers directement depuis le terminal.

| **Commande** | **Description**                                      | **Exemple**                                     |
|--------------|------------------------------------------------------|-------------------------------------------------|
| `cat`        | Affiche le contenu dun fichier.                    | `cat fichier.txt`                               |
| `more`       | Affiche le contenu dun fichier page par page (sans retour arrire). | `more fichier.txt`                              |
| `less`       | Comme `more`, mais permet un dfilement arrire.     | `less fichier.txt`                              |
| `head`       | Affiche les premires lignes dun fichier.          | `head -n 5 fichier.txt`  Affiche 5 premires lignes. |
| `tail`       | Affiche les dernires lignes dun fichier.          | `tail -n 5 fichier.txt`  Affiche 5 dernires lignes. |
| `nano`       | Editeur de texte simple en terminal.                 | `nano fichier.txt`                              |
| `gedit`      | Editeur graphique pour les fichiers texte.           | `gedit fichier.txt`                             |
| `grep`       | Recherche une chane dans un fichier.                | `grep "motif" fichier.txt`                     |
| `echo`       | Rpte une chane de caractres dans le terminal.    | `echo "Bonjour!"`                              |

---

## 3. Commandes diverses

Ces commandes offrent des fonctionnalits utiles pour diverses tches.

| **Commande** | **Description**                                      | **Exemple**                                     |
|--------------|------------------------------------------------------|-------------------------------------------------|
| `cal`        | Affiche le calendrier du mois courant.               | `cal`                                           |
| `date`       | Affiche la date et lheure actuelles.                | `date`                                         |
| `wc`         | Compte le nombre de lignes, mots et caractres dans un fichier. | `wc fichier.txt`                              |
| `grep`       | Recherche une chane dans des fichiers ou rpertoires. | `grep "motif" fichier.txt`                     |
| `spell`      | Vrifie l'orthographe dans un fichier.               | `cat texte.txt | spell > erreurs.txt`          |
| `read`       | Lit une entre utilisateur (dans les scripts).       | `read nom`  Attend que lutilisateur tape un texte. |

---

## Exemples d'utilisation pour la bioinformatique

### **Organiser vos donnes**
```bash
mkdir -p projets/bioinfo/sequences
cd projets/bioinfo/sequences
touch sequence1.fasta sequence2.fasta
