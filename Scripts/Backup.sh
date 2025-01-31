#!/bin/bash

# Skript pro zálohování důležitých souborů

# Základní proměnné
BACKUP_DIR="$HOME/backups"
DATE=$(date +%F)
BACKUP_NAME="backup_$DATE.tar.gz"
CONFIG_FILES=(
    "$HOME/.bashrc"
    "$HOME/.zshrc"
    "$HOME/.vimrc"
    "$HOME/.tmux.conf"
    "$HOME/.gitconfig"
    "$HOME/.config/"
    "/etc/pacman.conf"
    "/etc/fstab"
)

# Vytvoření zálohovacího adresáře
mkdir -p "$BACKUP_DIR"

# Záloha konfiguračních souborů
echo "Zálohuji konfigurační soubory..."
tar -czf "$BACKUP_DIR/$BACKUP_NAME" "${CONFIG_FILES[@]}"

# Záloha seznamu nainstalovaných balíčků
echo "Zálohuji seznam nainstalovaných balíčků..."
pacman -Qqe > "$BACKUP_DIR/pkglist_$DATE.txt"

# Záloha AUR balíčků (pokud je nainstalován yay)
if command -v yay &> /dev/null; then
    echo "Zálohuji seznam AUR balíčků..."
    yay -Qqm > "$BACKUP_DIR/aurlist_$DATE.txt"
fi

# Kontrola velikosti zálohy
BACKUP_SIZE=$(du -h "$BACKUP_DIR/$BACKUP_NAME" | awk '{print $1}')
echo "Záloha úspěšně vytvořena: $BACKUP_DIR/$BACKUP_NAME ($BACKUP_SIZE)"

# Upozornění na uložení zálohy
echo "Nezapomeňte zálohu uložit na externí úložiště!" 