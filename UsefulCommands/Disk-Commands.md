# Správa disků - Užitečné příkazy

## Informace o discích
### Zobrazení disků
```bash
# Seznam všech disků a oddílů
lsblk

# Detailní informace o discích
fdisk -l

# Informace o filesystémech
df -h

# SMART informace o disku
smartctl -a /dev/sda
```

### Využití místa
```bash
# Využití diskového prostoru
du -sh /*

# Největší adresáře
du -h /home | sort -rh | head -n 10

# Analýza využití disku
ncdu /
```

## Správa oddílů
### Vytváření oddílů
```bash
# Spuštění fdisk
fdisk /dev/sda

# Spuštění cfdisk (přehlednější rozhraní)
cfdisk /dev/sda

# Spuštění parted
parted /dev/sda

# GPT tabulka oddílů
gdisk /dev/sda
```

### Formátování
```bash
# Formátování ext4
mkfs.ext4 /dev/sda1

# Formátování BTRFS
mkfs.btrfs /dev/sda1

# Formátování swap
mkswap /dev/sda2

# Formátování FAT32
mkfs.fat -F32 /dev/sda1
```

## Montování
### Základní montování
```bash
# Připojení oddílu
mount /dev/sda1 /mnt

# Odpojení oddílu
umount /mnt

# Seznam připojených oddílů
mount | column -t

# Automatické připojení (fstab)
echo "/dev/sda1 /mnt ext4 defaults 0 0" >> /etc/fstab
```

### Pokročilé montování
```bash
# Připojení s konkrétními opcemi
mount -o rw,noexec,nosuid /dev/sda1 /mnt

# Připojení ISO souboru
mount -o loop image.iso /mnt

# Připojení síťového disku
mount -t cifs //server/share /mnt -o username=user
```

## RAID a LVM
### RAID operace
```bash
# Vytvoření RAID 1
mdadm --create /dev/md0 --level=1 --raid-devices=2 /dev/sda1 /dev/sdb1

# Kontrola RAID statusu
cat /proc/mdstat
mdadm --detail /dev/md0

# Přidání disku do RAID
mdadm --add /dev/md0 /dev/sdc1
```

### LVM správa
```bash
# Vytvoření fyzického svazku
pvcreate /dev/sda1

# Vytvoření skupiny svazků
vgcreate vg0 /dev/sda1

# Vytvoření logického svazku
lvcreate -L 10G -n lv0 vg0

# Zobrazení LVM informací
pvdisplay
vgdisplay
lvdisplay
```

## Zálohování a obnova
### Zálohování disků
```bash
# Záloha celého disku
dd if=/dev/sda of=/path/to/backup.img

# Záloha s kompresí
dd if=/dev/sda | gzip > backup.img.gz

# Klonování disku
dd if=/dev/sda of=/dev/sdb status=progress
```

### Obnova dat
```bash
# Obnova ze zálohy
dd if=backup.img of=/dev/sda

# Testdisk pro obnovu oddílů
testdisk /dev/sda

# Photorec pro obnovu souborů
photorec /dev/sda
```

## Výkon a údržba
### Testování výkonu
```bash
# Test rychlosti čtení
hdparm -t /dev/sda

# Benchmark disku
dd if=/dev/zero of=test bs=1M count=1000 status=progress

# FIO benchmark
fio --filename=/dev/sda --direct=1 --rw=read --bs=4k --size=1G
```

### Údržba
```bash
# Kontrola filesystému
fsck /dev/sda1

# TRIM pro SSD
fstrim -av

# Defragmentace ext4
e4defrag /dev/sda1

# Kontrola SMART
smartctl -t short /dev/sda
```

## Šifrování
### LUKS operace
```bash
# Vytvoření šifrovaného oddílu
cryptsetup luksFormat /dev/sda1

# Otevření šifrovaného oddílu
cryptsetup open /dev/sda1 cryptroot

# Zavření šifrovaného oddílu
cryptsetup close cryptroot

# Změna hesla
cryptsetup luksChangeKey /dev/sda1
```

## Užitečné aliasy
```bash
# Přidat do ~/.bashrc nebo ~/.zshrc
alias dfh='df -h'
alias duh='du -h'
alias mount='mount | column -t'
alias disks='lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINT'
```

## Řešení problémů
```bash
# Kontrola chyb na disku
badblocks -v /dev/sda

# Sledování I/O
iotop

# Monitoring disku
iostat -x 1

# Kontrola žurnálu
journalctl -f
``` 