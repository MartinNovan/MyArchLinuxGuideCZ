# Obnova systému v Arch Linux

## Úvod
Tento dokument popisuje postupy pro obnovu systému v případě závažných problémů nebo selhání.

## Základní postupy

### 1. Boot z live USB
1. Stáhněte nejnovější ISO z [archlinux.org](https://archlinux.org/download/)
2. Vytvořte bootovatelné USB:
```bash
dd bs=4M if=archlinux.iso of=/dev/sdX status=progress oflag=sync
```
3. Bootujte z USB a připojte se k internetu

### 2. Chroot do systému
1. Najděte root oddíl:
```bash
lsblk
```
2. Připojte oddíly:
```bash
mount /dev/sdX1 /mnt
mount /dev/sdX2 /mnt/boot
mount /dev/sdX3 /mnt/home
```
3. Chroot:
```bash
arch-chroot /mnt
```

### 3. Oprava bootloaderu
#### GRUB
```bash
grub-install /dev/sdX
grub-mkconfig -o /boot/grub/grub.cfg
```

#### systemd-boot
```bash
bootctl install
bootctl update
```

### 4. Obnova balíčků
1. Zkontrolujte poškozené balíčky:
```bash
pacman -Qkk
```
2. Opravte poškozené balíčky:
```bash
pacman -S $(pacman -Qqn)
```

### 5. Obnova konfigurace
1. Obnovte zálohované konfigurační soubory
2. Zkontrolujte důležité soubory:
```bash
/etc/fstab
/etc/mkinitcpio.conf
/etc/pacman.conf
```

## Pokročilé postupy

### 1. Obnova zálohy
1. Připojte externí úložiště
2. Rozbalte zálohu:
```bash
tar -xzf backup.tar.gz -C /
```
3. Obnovte seznam balíčků:
```bash
pacman -S - < pkglist.txt
```

### 2. Obnova z RAID
1. Aktivujte RAID pole:
```bash
mdadm --assemble --scan
```
2. Připojte RAID pole:
```bash
mount /dev/md0 /mnt
```

### 3. Obnova z LVM
1. Aktivujte LVM svazky:
```bash
vgchange -ay
```
2. Připojte LVM svazky:
```bash
mount /dev/vg0/root /mnt
```

## Užitečné nástroje

### TestDisk
```bash
sudo pacman -S testdisk
testdisk
```

### Photorec
```bash
sudo pacman -S photorec
photorec
```

### GParted
```bash
sudo pacman -S gparted
gparted
```

## Doporučené postupy

1. **Pravidelné zálohy**
   - Zálohujte důležité soubory
   - Udržujte seznam nainstalovaných balíčků

2. **Dokumentace**
   - Zapisujte si provedené změny
   - Uchovávejte důležité příkazy

3. **Testování**
   - Před většími změnami testujte na virtuálním stroji
   - Používejte snapshots pro rychlé obnovení

## Odkazy
- [Arch Wiki - System recovery](https://wiki.archlinux.org/title/System_recovery)
- [Arch Wiki - Data recovery](https://wiki.archlinux.org/title/Data_recovery)
- [Arch Wiki - Backup programs](https://wiki.archlinux.org/title/List_of_applications#Backup) 