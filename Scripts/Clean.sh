#!/bin/bash

# Funkce pro převod velikosti z kilobajtů na lidsky čitelný formát (GB)
convert_to_gb() {
    echo "scale=2; $1 / 1024 / 1024" | bc
}

# Zjištění velikosti cache balíčků Pacmanu před vyčištěním
pacman_cache_size_before=$(du -sk /var/cache/pacman/pkg | awk '{print $1}')

# Vyčištění cache balíčků Pacmanu
echo "Čistím cache balíčků Pacmanu..."
sudo pacman -Scc

# Zjištění velikosti cache balíčků Pacmanu po vyčištění
pacman_cache_size_after=$(du -sk /var/cache/pacman/pkg | awk '{print $1}')

# Výpočet uvolněného místa pro Pacman cache
pacman_freed_space=$((pacman_cache_size_before - pacman_cache_size_after))
echo "Uvolněno $(convert_to_gb $pacman_freed_space) GB z Pacman cache."

# Odstranění osamocených balíčků (orphans)
orphans=$(pacman -Qtdq)
if [[ -n "$orphans" ]]; then
    echo "Odstraňuji osamocené balíčky..."
    sudo pacman -Rns $orphans
else
    echo "Žádné osamocené balíčky nebyly nalezeny."
fi

# Zjištění velikosti uživatelské cache před vyčištěním
user_cache_size_before=$(du -sk ~/.cache | awk '{print $1}')

# Vyčištění uživatelské cache
echo "Čistím uživatelskou cache..."
rm -rf ~/.cache/*

# Zjištění velikosti uživatelské cache po vyčištění
user_cache_size_after=$(du -sk ~/.cache | awk '{print $1}')

# Výpočet uvolněného místa pro uživatelskou cache
user_freed_space=$((user_cache_size_before - user_cache_size_after))
echo "Uvolněno $(convert_to_gb $user_freed_space) GB z uživatelské cache."

# Souhrn
total_freed_space=$((pacman_freed_space + user_freed_space))
echo "Celkem uvolněno $(convert_to_gb $total_freed_space) GB."

echo "Hotovo!"
