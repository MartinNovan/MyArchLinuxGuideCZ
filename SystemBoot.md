# Bootování systému v Arch Linux

## Úvod
Bootování je proces, který se spustí po zapnutí počítače a končí načtením operačního systému. Tento dokument popisuje celý proces bootování v Arch Linuxu.

## Bootovací sekvence

### 1. BIOS/UEFI
- **BIOS (Basic Input/Output System)**
  - Starší systém
  - Omezení na 2TB disky
  - MBR tabulka oddílů

- **UEFI (Unified Extensible Firmware Interface)**
  - Modernější náhrada BIOSu
  - Podpora GPT
  - Secure Boot
  - Bootování z velkých disků

### 2. Bootloader
Arch Linux podporuje různé bootloadery:

#### GRUB
```bash
# Instalace
pacman -S grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# Konfigurace v /etc/default/grub
GRUB_DEFAULT=0
GRUB_TIMEOUT=5
GRUB_CMDLINE_LINUX_DEFAULT="quiet loglevel=3"
```

#### systemd-boot
```bash
# Instalace
bootctl install

# Konfigurace v /boot/loader/entries/arch.conf
title   Arch Linux
linux   /vmlinuz-linux
initrd  /initramfs-linux.img
options root=PARTUUID=xxxx rw
```

#### EFISTUB
```bash
# Přímé bootování kernelu přes UEFI
efibootmgr --disk /dev/sda \
  --part 1 \
  --create \
  --label "Arch Linux" \
  --loader /vmlinuz-linux \
  --unicode 'root=PARTUUID=xxxx rw initrd=\initramfs-linux.img'
```

### 3. Kernel a initramfs

#### Kernel
- Jádro operačního systému
- Správa hardwaru a systémových prostředků
```bash
# Instalace kernelu
pacman -S linux linux-headers

# Parametry kernelu v bootloaderu
root=PARTUUID=xxxx        # Root oddíl
rw                        # Read-write mount
quiet                     # Omezení výpisu
```

#### Initramfs
- Dočasný root filesystem
- Obsahuje moduly a skripty pro boot
```bash
# Generování initramfs
mkinitcpio -P

# Konfigurace v /etc/mkinitcpio.conf
MODULES=(ext4 ahci)
HOOKS=(base udev autodetect modconf block filesystems keyboard fsck)
```

## Správa bootování

### Kernel parametry
```bash
# Běžné parametry
nomodeset          # Zakázání KMS
debug              # Verbose boot
single             # Single user mode
emergency          # Emergency shell

# Přidání parametrů v GRUB
GRUB_CMDLINE_LINUX_DEFAULT="parametr1 parametr2"
```

### Dual boot
```bash
# GRUB automaticky detekuje jiné OS
os-prober          # Detekce OS
grub-mkconfig     # Aktualizace konfigurace

# Manuální přidání v /boot/grub/custom.cfg
menuentry "Windows" {
    chainloader (hd0,1)+1
}
```

## Zabezpečení bootu

### Secure Boot
```bash
# Generování klíčů
openssl req -new -x509 -newkey rsa:2048 -keyout MOK.key -out MOK.crt
sbsign --key MOK.key --cert MOK.crt --output vmlinuz-signed vmlinuz-linux

# Instalace klíčů
mokutil --import MOK.crt
```

### Šifrování
```bash
# LUKS šifrování
cryptsetup luksFormat /dev/sda2
cryptsetup open /dev/sda2 cryptroot

# /etc/crypttab
cryptroot UUID=xxx none luks

# Úprava initramfs
HOOKS=(base udev autodetect keyboard keymap modconf block encrypt filesystems fsck)
```

## Řešení problémů

### Nouzový režim
```bash
# Bootování do emergency shell
systemd.unit=emergency.target

# Oprava systému
fsck /dev/sda1
mount -o remount,rw /
```

### Obnova bootloaderu
```bash
# Z live CD
arch-chroot /mnt
grub-install --target=x86_64-efi --efi-directory=/boot
grub-mkconfig -o /boot/grub/grub.cfg
```

### Běžné problémy
1. **Kernel panic**
   - Kontrola initramfs
   - Ověření parametrů kernelu
   - Kontrola root oddílu

2. **GRUB rescue**
   ```bash
   set prefix=(hd0,1)/boot/grub
   set root=(hd0,1)
   insmod normal
   normal
   ```

3. **Chybějící firmware**
   ```bash
   pacman -S linux-firmware
   mkinitcpio -P
   ```

## Optimalizace

### Rychlý boot
```bash
# Systemd analýza
systemd-analyze
systemd-analyze blame
systemd-analyze critical-chain

# Optimalizace služeb
systemctl disable nepotrebna.service
systemctl mask problematicka.service
```

### Bootovací skripty
```bash
# /etc/initcpio/hooks/custom
#!/bin/bash
run_hook() {
    # Vlastní inicializace
}

# /etc/initcpio/install/custom
#!/bin/bash
build() {
    add_binary /usr/bin/custom
    add_runscript
}
```

## Údržba

### Aktualizace bootloaderu
```bash
# GRUB
grub-install --target=x86_64-efi --efi-directory=/boot
grub-mkconfig -o /boot/grub/grub.cfg

# systemd-boot
bootctl update
```

### Záloha boot oddílu
```bash
# Záloha
dd if=/dev/sda1 of=/path/to/boot_backup.img

# Obnova
dd if=/path/to/boot_backup.img of=/dev/sda1
```

## Doporučené postupy

1. **Bezpečnost**
   - Používat UEFI Secure Boot
   - Šifrovat důležité oddíly
   - Pravidelně aktualizovat bootloader

2. **Údržba**
   - Zálohovat boot oddíl
   - Udržovat více kernel verzí
   - Testovat změny konfigurace

3. **Dokumentace**
   - Zaznamenávat změny konfigurace
   - Uchovávat zálohy konfiguračních souborů
   - Dokumentovat nestandardní nastavení

## Odkazy
- [Arch Wiki - Boot process](https://wiki.archlinux.org/title/Arch_boot_process)
- [Arch Wiki - GRUB](https://wiki.archlinux.org/title/GRUB)
- [Arch Wiki - Systemd-boot](https://wiki.archlinux.org/title/Systemd-boot)

## Detailní konfigurace bootloaderů

### GRUB

#### Základní konfigurace
```bash
# /etc/default/grub
GRUB_DEFAULT=0                     # Výchozí položka (0 = první)
GRUB_SAVEDEFAULT=true             # Zapamatovat poslední výběr
GRUB_TIMEOUT=5                    # Časový limit v sekundách
GRUB_TIMEOUT_STYLE=menu          # menu/countdown/hidden
GRUB_DISTRIBUTOR="Arch Linux"    # Název distribuce
GRUB_CMDLINE_LINUX_DEFAULT=""    # Parametry kernelu
GRUB_CMDLINE_LINUX=""            # Parametry pro všechny kernely
GRUB_DISABLE_RECOVERY=false      # Zobrazit recovery možnosti
```

#### Vizuální přizpůsobení
```bash
# Instalace GRUB Customizer
pacman -S grub-customizer

# Ruční instalace témat
# 1. Stažení tématu (např. Vimix)
git clone https://github.com/vinceliuice/grub2-themes.git
cd grub2-themes
./install.sh -t vimix

# 2. Konfigurace v /etc/default/grub
GRUB_THEME="/boot/grub/themes/vimix/theme.txt"
GRUB_BACKGROUND="/boot/grub/themes/vimix/background.png"
GRUB_GFXMODE="1920x1080,auto"    # Rozlišení
GRUB_COLOR_NORMAL="white/black"   # Normální barvy
GRUB_COLOR_HIGHLIGHT="black/white" # Zvýrazněné barvy
```

#### Pokročilé možnosti
```bash
# Vlastní menu entries
# /etc/grub.d/40_custom
menuentry "Vlastní systém" {
    set root=(hd0,1)
    linux /vmlinuz-linux root=/dev/sda2
    initrd /initramfs-linux.img
}

# Podmíněné menu
if [ "${grub_platform}" == "efi" ]; then
    menuentry "UEFI Firmware Settings" {
        fwsetup
    }
fi

# Skrytí menu entries
GRUB_DISABLE_OS_PROBER=true      # Zakázat detekci jiných OS
```

### systemd-boot

#### Základní konfigurace
```bash
# /boot/loader/loader.conf
default arch.conf     # Výchozí konfigurace
timeout 3            # Časový limit
console-mode max     # Rozlišení konzole
editor no           # Zakázat editaci parametrů
```

#### Konfigurace záznamů
```bash
# /boot/loader/entries/arch.conf
title   Arch Linux
linux   /vmlinuz-linux
initrd  /amd-ucode.img  # nebo intel-ucode.img
initrd  /initramfs-linux.img
options root=PARTUUID=xxxx rw quiet splash

# /boot/loader/entries/arch-fallback.conf
title   Arch Linux (fallback)
linux   /vmlinuz-linux
initrd  /amd-ucode.img
initrd  /initramfs-linux-fallback.img
options root=PARTUUID=xxxx rw
```

#### Pokročilé možnosti
```bash
# Více konfigurací pro různé případy
# /boot/loader/entries/arch-debug.conf
title   Arch Linux (debug)
linux   /vmlinuz-linux
initrd  /initramfs-linux.img
options root=PARTUUID=xxxx rw debug

# /boot/loader/entries/arch-rescue.conf
title   Arch Linux (rescue)
linux   /vmlinuz-linux
initrd  /initramfs-linux.img
options root=PARTUUID=xxxx rw single
```

### GRUB vs systemd-boot

#### GRUB výhody
- Podpora více OS (dual boot)
- Bohatší možnosti konfigurace
- Grafické rozhraní a témata
- Podpora starších systémů
- Skriptovací možnosti

#### systemd-boot výhody
- Jednodušší konfigurace
- Rychlejší boot
- Lepší integrace s UEFI
- Menší velikost
- Modernější přístup

### Vlastní splash screen

#### Plymouth
```bash
# Instalace Plymouth
pacman -S plymouth

# Konfigurace
# /etc/plymouth/plymouthd.conf
[Daemon]
Theme=spinner
ShowDelay=0
DeviceTimeout=5

# Aktivace v GRUB
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"

# Instalace témat
pacman -S plymouth-theme-monoarch
plymouth-set-default-theme -R monoarch
```

### Bootovací animace
```bash
# GRUB animace
# /etc/default/grub
GRUB_INIT_TUNE="480 440 1"

# Vlastní bootovací logo
# Přidání do initramfs
# /etc/mkinitcpio.conf
MODULES=(... uvesafb)
FILES=(/path/to/logo.png)
``` 