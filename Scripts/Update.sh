#!/bin/bash

# Skript pro aktualizaci systému

echo "Začíná aktualizace systému..."

# Aktualizace mirrorlistu
echo "Aktualizuji mirrorlist..."
sudo reflector --country Czechia,Germany,Poland --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

# Aktualizace systémových balíčků
echo "Aktualizuji systémové balíčky..."
sudo pacman -Syu --noconfirm

# Aktualizace AUR balíčků (pokud je nainstalován yay)
if command -v yay &> /dev/null; then
    echo "Aktualizuji AUR balíčky..."
    yay -Syu --noconfirm
else
    echo "Yay není nainstalován, přeskočeno aktualizování AUR balíčků."
fi

# Kontrola osamocených balíčků
orphans=$(pacman -Qtdq)
if [[ -n "$orphans" ]]; then
    echo "Nalezeny osamocené balíčky:"
    echo "$orphans"
    read -p "Chcete je odstranit? [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sudo pacman -Rns $orphans
    fi
else
    echo "Žádné osamocené balíčky nebyly nalezeny."
fi

echo "Aktualizace dokončena!" 