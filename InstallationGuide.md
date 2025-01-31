# Instalační průvodce Arch Linux

## Příprava

### Stažení ISO
1. Stáhněte nejnovější ISO z [archlinux.org](https://archlinux.org/download/)
2. Ověřte podpis ISO:
```bash
gpg --keyserver-options auto-key-retrieve --verify archlinux-version-x86_64.iso.sig
```

### Vytvoření bootovatelného USB
```bash
# Na Linuxu
dd bs=4M if=archlinux.iso of=/dev/sdX status=progress oflag=sync

# Nebo použijte:
# - Rufus (Windows)
# - balenaEtcher (multiplatformní)
```

## Bootování live prostředí

### BIOS nastavení
1. Vypněte Secure Boot
2. Nastavte USB jako první boot zařízení
3. Vypněte Fast Boot

### Připojení k internetu
```bash
# WiFi
iwctl
station wlan0 scan
station wlan0 get-networks
station wlan0 connect SSID

# Ověření připojení
ping archlinux.org
```

## Příprava disku

### Rozdělení disku
```bash
# Zobrazení disků
lsblk

# Vytvoření GPT tabulky oddílů
gdisk /dev/sda
# nebo
cfdisk /dev/sda
```

#### Doporučené schéma (UEFI)
```
/dev/sda1  - EFI       (550M)  - EFI System Partition
/dev/sda2  - /boot     (1G)    - Linux filesystem
/dev/sda3  - [SWAP]    (8G)    - Linux swap
/dev/sda4  - /         (50G)   - Linux filesystem
/dev/sda5  - /home     (zbytek) - Linux filesystem
```

### Formátování oddílů
```bash
# EFI oddíl
mkfs.fat -F32 /dev/sda1

# Boot oddíl
mkfs.ext4 /dev/sda2

# Swap
mkswap /dev/sda3
swapon /dev/sda3

# Root
mkfs.ext4 /dev/sda4

# Home
mkfs.ext4 /dev/sda5
```

## Základní instalace

### Montování oddílů
```bash
# Root
mount /dev/sda4 /mnt

# Vytvoření a montování dalších adresářů
mkdir /mnt/{boot,home}
mount /dev/sda2 /mnt/boot
mount /dev/sda5 /mnt/home
mkdir /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi
```

### Instalace základního systému
```bash
# Aktualizace mirrorlistu
reflector --country Czechia,Germany,Poland --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

# Instalace základních balíčků
pacstrap /mnt base base-devel linux linux-firmware

# Základní nástroje
pacstrap /mnt networkmanager vim sudo
```

### Generování fstab
```bash
genfstab -U /mnt >> /mnt/etc/fstab
```

## Konfigurace systému

### Chroot
```bash
arch-chroot /mnt
```

### Základní nastavení
```bash
# Časová zóna
ln -sf /usr/share/zoneinfo/Europe/Prague /etc/localtime
hwclock --systohc

# Lokalizace
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "cs_CZ.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=cs_CZ.UTF-8" > /etc/locale.conf
echo "KEYMAP=cz-qwertz" > /etc/vconsole.conf

# Hostname
echo "archlinux" > /etc/hostname
```

### Síťová konfigurace
```bash
# /etc/hosts
127.0.0.1   localhost
::1         localhost
127.0.1.1   archlinux.localdomain archlinux

# Aktivace služeb
systemctl enable NetworkManager
```

### Uživatelé a hesla
```bash
# Root heslo
passwd

# Vytvoření uživatele
useradd -m -G wheel -s /bin/bash uzivatel
passwd uzivatel

# Sudo práva
EDITOR=vim visudo
# Odkomentujte: %wheel ALL=(ALL:ALL) ALL
```

### Bootloader (GRUB)
```bash
# Instalace
pacman -S grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB

# Konfigurace
grub-mkconfig -o /boot/grub/grub.cfg
```

## Dokončení instalace

### Další užitečné balíčky
```bash
# Základní nástroje
pacman -S git wget curl

# Správa zvuku
pacman -S pulseaudio pulseaudio-alsa pavucontrol

# Grafické prostředí (příklad s KDE)
pacman -S xorg plasma plasma-wayland-session kde-applications
systemctl enable sddm
```

### Restart
```bash
# Odpojení
exit
umount -R /mnt
reboot
```

## Po instalaci

### První kroky
1. Přihlášení do systému
2. Aktualizace systému:
```bash
sudo pacman -Syu
```

### Základní nastavení
```bash
# AUR helper (yay)
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Firewall
sudo pacman -S ufw
sudo systemctl enable --now ufw
sudo ufw enable
```

### Grafické ovladače
```bash
# NVIDIA
sudo pacman -S nvidia nvidia-utils

# AMD
sudo pacman -S xf86-video-amdgpu

# Intel
sudo pacman -S xf86-video-intel
```

## Zjednodušená instalace pomocí archinstall

### Použití archinstall skriptu
```bash
# Spuštění interaktivního průvodce
archinstall

# Hlavní kroky:
1. Vyberte jazyk
2. Nastavte klávesnici (cz-qwertz)
3. Vyberte profil (minimal, desktop, server)
4. Nastavte disk (automatické nebo manuální)
5. Vyberte síť (WiFi/Ethernet)
6. Nastavte uživatele a heslo
7. Vyberte desktopové prostředí (volitelné)
8. Potvrďte instalaci
```

### Výhody archinstall
- Automatizace rutinních úkolů
- Předkonfigurované profily
- Rychlejší instalace
- Vhodné pro začátečníky

### Nevýhody archinstall
- Méně flexibilní než manuální instalace
- Omezené možnosti přizpůsobení
- Může skrýt některé důležité kroky

## Příprava klíčů pro AUR

### Aktualizace keyringu
```bash
# Před instalací
pacman -Sy archlinux-keyring
pacman-key --init
pacman-key --populate archlinux
pacman-key --refresh-keys

# Po instalaci
sudo pacman -S archlinux-keyring
sudo pacman-key --init
sudo pacman-key --populate archlinux
sudo pacman-key --refresh-keys
```

### Řešení problémů s klíči
```bash
# Pokud se objeví chyby s podpisy
sudo pacman-key --refresh-keys
sudo pacman -S archlinux-keyring
sudo pacman -Syu

# Ruční import klíče
gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys KEYID
pacman-key --recv-keys KEYID
pacman-key --lsign-key KEYID
```

### Instalace z AUR
```bash
# Příklad instalace yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Aktualizace AUR balíčků
yay -Syu
```

## Řešení problémů

### Běžné problémy
1. **Nelze bootovat**
   - Zkontrolujte GRUB konfiguraci
   - Ověřte EFI nastavení

2. **Nefunguje internet**
   ```bash
   systemctl start NetworkManager
   nmtui
   ```

3. **Nefunguje zvuk**
   ```bash
   pulseaudio -k
   pulseaudio --start
   ```

## Doporučené postupy

1. **Bezpečnost**
   - Pravidelné aktualizace
   - Silná hesla
   - Firewall

2. **Zálohování**
   - Důležitá data
   - Konfigurační soubory
   - Seznam nainstalovaných balíčků

3. **Dokumentace**
   - Zapisujte si změny
   - Uchovávejte důležité příkazy
   - Zálohujte konfigurační soubory

## Odkazy
- [Arch Wiki - Installation guide](https://wiki.archlinux.org/title/Installation_guide)
- [Arch Wiki - General recommendations](https://wiki.archlinux.org/title/General_recommendations)
- [Arch Wiki - List of applications](https://wiki.archlinux.org/title/List_of_applications) 