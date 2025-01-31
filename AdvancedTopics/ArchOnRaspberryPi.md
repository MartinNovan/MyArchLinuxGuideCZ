# Arch Linux na Raspberry Pi

## Úvod
Tento dokument popisuje instalaci a konfiguraci Arch Linuxu na Raspberry Pi. Zaměřuje se na optimalizaci pro ARM architekturu a řešení specifických problémů.

## Požadavky
- Raspberry Pi (doporučeno 3B+ nebo novější)
- MicroSD karta (min. 16 GB)
- Napájecí adaptér
- Ethernet kabel nebo WiFi

## Instalace

### Stažení image
```bash
wget http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-latest.tar.gz
```

### Příprava SD karty
1. Najděte zařízení:
```bash
lsblk
```
2. Vymažte SD kartu:
```bash
sudo dd if=/dev/zero of=/dev/mmcblk0 bs=1M
```
3. Vytvořte oddíly:
```bash
sudo fdisk /dev/mmcblk0
# Vytvořte boot oddíl (typ W95 FAT32, 200M)
# Vytvořte root oddíl (typ Linux)
```

### Formátování
```bash
sudo mkfs.vfat /dev/mmcblk0p1
sudo mkfs.ext4 /dev/mmcblk0p2
```

### Instalace
1. Připojte oddíly:
```bash
sudo mount /dev/mmcblk0p2 /mnt
sudo mkdir /mnt/boot
sudo mount /dev/mmcblk0p1 /mnt/boot
```
2. Rozbalte image:
```bash
sudo bsdtar -xpf ArchLinuxARM-rpi-latest.tar.gz -C /mnt
```
3. Synchronizujte:
```bash
sync
```

### Konfigurace
1. Upravte fstab:
```bash
sudo nano /mnt/etc/fstab
```
2. Upravte cmdline.txt:
```bash
sudo nano /mnt/boot/cmdline.txt
```

## První spuštění

### Přihlášení
- Uživatel: alarm
- Heslo: alarm
- Root heslo: root

### Aktualizace systému
```bash
sudo pacman -Syu
```

### Změna hesla
```bash
passwd
```

## Optimalizace

### Overclocking
```bash
sudo nano /boot/config.txt
```
```ini
over_voltage=2
arm_freq=1400
```

### Zvýšení výkonu GPU
```bash
gpu_mem=256
```

### Zvýšení výkonu I/O
```bash
sudo nano /etc/fstab
```
```bash
/dev/mmcblk0p1  /boot  vfat  defaults,noatime  0  2
/dev/mmcblk0p2  /      ext4  defaults,noatime  0  1
```

## Řešení problémů

### Nefunkční WiFi
```bash
sudo pacman -S wpa_supplicant
sudo systemctl enable wpa_supplicant@wlan0
```

### Nefunkční Bluetooth
```bash
sudo pacman -S bluez bluez-utils
sudo systemctl enable bluetooth
```

### Nízký výkon
```bash
sudo pacman -S cpupower
sudo cpupower frequency-set -g performance
```

## Užitečné balíčky

### Základní nástroje
```bash
sudo pacman -S vim htop git
```

### Grafické prostředí
```bash
sudo pacman -S xfce4 xfce4-goodies lightdm
sudo systemctl enable lightdm
```

### Vývojové nástroje
```bash
sudo pacman -S python nodejs
```

## Doporučené postupy

1. **Zálohování**
   - Pravidelně zálohujte SD kartu
   - Udržujte seznam nainstalovaných balíčků

2. **Monitorování**
   - Sledujte teplotu procesoru
   - Monitorujte využití paměti

3. **Údržba**
   - Pravidelně aktualizujte systém
   - Čistěte cache a dočasné soubory

## Užitečné odkazy
- [Arch Linux ARM](https://archlinuxarm.org/)
- [Raspberry Pi Documentation](https://www.raspberrypi.org/documentation/)
- [Arch Wiki - Raspberry Pi](https://wiki.archlinux.org/title/Raspberry_Pi) 