# Post-instalační nastavení Arch Linux

## Úvod
Po úspěšné instalaci Arch Linuxu je potřeba provést několik kroků pro optimalizaci a přizpůsobení systému. Tento průvodce pokrývá nejdůležitější úkoly po instalaci.

> **Poznámka:** Pokud jste použili `archinstall`, mnoho z těchto kroků již může být nastaveno. Přesto doporučujeme zkontrolovat a případně upravit konfiguraci.

## Základní nastavení

### Kontrola aktualizací
```bash
sudo pacman -Syu
```

### Kontrola časové zóny
```bash
timedatectl status
# Pokud není správně:
sudo timedatectl set-timezone Europe/Prague
sudo timedatectl set-ntp true
```

### Kontrola lokalizace
```bash
locale
# Pokud není správně:
sudo sed -i 's/#cs_CZ.UTF-8 UTF-8/cs_CZ.UTF-8 UTF-8/' /etc/locale.gen
sudo locale-gen
echo "LANG=cs_CZ.UTF-8" | sudo tee /etc/locale.conf
```

## Uživatelské nastavení

### Kontrola skupin
```bash
groups
# Pokud chybí důležité skupiny:
sudo usermod -aG wheel,audio,video,storage,optical,network uzivatel
```

### Kontrola sudo
```bash
sudo -l
# Pokud není nastaveno:
sudo EDITOR=vim visudo
# Odkomentujte: %wheel ALL=(ALL:ALL) ALL
```

## Síťové nastavení

### Kontrola NetworkManager
```bash
nmcli general status
# Pokud není aktivní:
sudo systemctl enable --now NetworkManager
```

### Kontrola firewallu
```bash
sudo ufw status
# Pokud není nastaven:
sudo pacman -S ufw
sudo ufw enable
sudo systemctl enable ufw
```

## Grafické prostředí

### Kontrola grafických ovladačů
```bash
lspci -k | grep -EA3 'VGA|3D|Display'
# Instalace chybějících ovladačů:
# NVIDIA
sudo pacman -S nvidia nvidia-utils nvidia-settings

# AMD
sudo pacman -S xf86-video-amdgpu

# Intel
sudo pacman -S xf86-video-intel
```

## Multimédia

### Kontrola zvuku
```bash
pactl info
# Pokud není nastaven:
sudo pacman -S pulseaudio pulseaudio-alsa pavucontrol
```

## Vývojové nástroje

### Základní nástroje
```bash
sudo pacman -S git vim base-devel
```

## AUR a yay

### Instalace yay
```bash
if ! command -v yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
fi
```

## Optimalizace

### Kontrola TRIM pro SSD
```bash
systemctl status fstrim.timer
# Pokud není aktivní:
sudo systemctl enable fstrim.timer
```

## Bezpečnost

### Aktualizace klíčů
```bash
sudo pacman-key --refresh-keys
sudo pacman -S archlinux-keyring
```

## Užitečné aplikace

### Základní nástroje
```bash
sudo pacman -S firefox thunderbird libreoffice-fresh vlc gimp
```

## Doporučené postupy

1. **Zálohování**
   - Důležitá data
   - Konfigurační soubory
   - Seznam balíčků

2. **Dokumentace**
   - Zapisujte si změny
   - Uchovávejte důležité příkazy
   - Zálohujte konfigurační soubory

3. **Údržba**
   - Pravidelné aktualizace
   - Čištění systému
   - Monitorování výkonu

## Odkazy
- [Arch Wiki - General recommendations](https://wiki.archlinux.org/title/General_recommendations)
- [Arch Wiki - List of applications](https://wiki.archlinux.org/title/List_of_applications)
- [Arch Wiki - AUR helpers](https://wiki.archlinux.org/title/AUR_helpers) 