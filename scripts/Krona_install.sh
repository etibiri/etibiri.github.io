#!/bin/bash

# ==============================================
# Script d'installation complète de Krona (local)
# ==============================================

# Arrêter le script si une commande échoue
set -e

# Définir le dossier d'installation local
KRONA_DIR="$HOME/Krona/KronaTools"
KRONA_TAX_DIR="$KRONA_DIR/taxonomy"

# 1. Clonage de Krona depuis GitHub
if [ ! -d "$KRONA_DIR" ]; then
  echo "Clonage du dépôt Krona..."
  git clone https://github.com/marbl/Krona.git "$HOME/Krona"
fi

# 2. Installation locale des scripts
cd "$KRONA_DIR"
echo "Installation de Krona en local..."
sudo ./install.pl --prefix "$KRONA_DIR"

# 3. Ajout du dossier bin dans le PATH (si pas déjà fait)
if ! grep -q "Krona/KronaTools" ~/.bashrc; then
  echo 'export PATH="$HOME/Krona/KronaTools/bin:$PATH"' >> ~/.bashrc
  source ~/.bashrc
fi

# 4. Téléchargement et extraction de la taxonomie NCBI
mkdir -p "$KRONA_TAX_DIR"
cd "$KRONA_TAX_DIR"

if [ ! -f taxdump.tar.gz ]; then
  echo "Téléchargement de la taxonomie NCBI..."
  wget --no-check-certificate https://ftp.ncbi.nlm.nih.gov/pub/taxonomy/taxdump.tar.gz
fi

echo "Extraction de la taxonomie..."
tar -xzvf taxdump.tar.gz

# 5. Correction dans KronaTools.pm pour la taxonomie
PERL_MODULE="$KRONA_DIR/lib/KronaTools.pm"
FIX_LINE="    \$options{'taxonomy'} = \"\\$ENV{HOME}/Krona/KronaTools/taxonomy\" unless defined \$options{'taxonomy'};"

if ! grep -q "unless defined \$options{'taxonomy'}" "$PERL_MODULE"; then
  awk -v fix_line="$FIX_LINE" '
    /sub loadTaxonomy/ { print; in_block=1; next }
    in_block && /open INFO/ && !patched { print fix_line; patched=1 }
    { print }
  ' "$PERL_MODULE" > "$PERL_MODULE.tmp" && mv "$PERL_MODULE.tmp" "$PERL_MODULE"
fi

# 6. Génération du fichier taxonomy.tab nécessaire
cd "$KRONA_DIR"
echo "Génération du fichier taxonomy.tab..."
perl scripts/extractTaxonomy.pl taxonomy taxonomy/taxonomy.tab

# 7. Vérification de la présence du script principal
if [ ! -f "$KRONA_DIR/bin/ktImportTaxonomy" ]; then
  echo "Erreur : ktImportTaxonomy est introuvable après installation."
  exit 1
fi

# 8. Message de fin
echo "✅ Krona installé avec succès dans : $KRONA_DIR"
echo "➡️  Utilise la commande suivante pour visualiser un rapport Kraken2 :"
echo "   ktImportTaxonomy <rapport_kraken> -o <rapport_krona.html>"
echo "➡️  Redémarre ton terminal ou exécute 'source ~/.bashrc' pour utiliser 'ktImportTaxonomy' partout."
