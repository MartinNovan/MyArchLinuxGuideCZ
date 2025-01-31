# Správa disků v Arch Linux

## Úvod
Správa disků je klíčovou součástí administrace systému. Zahrnuje práci s fyzickými disky, oddíly, souborovými systémy a jejich monitorování.

## Souborové systémy - Přehled a porovnání

### ext4
**Výhody:**
- Stabilní a ověřený časem
- Dobrý výkon pro běžné použití
- Snadná obnova dat
- Nízká fragmentace
- Rychlé kontroly systému

**Nevýhody:**
- Chybí pokročilé funkce (snapshoty, komprese)
- Omezená škálovatelnost
- Maximální velikost souboru 16TB
- Bez podpory deduplikace

**Doporučené použití:**
- Systémové oddíly
- Běžné uživatelské systémy
- Servery vyžadující stabilitu

### btrfs
**Výhody:**
- Integrované snapshoty
- Komprese dat za běhu
- Podpora RAID
- Kontrola integrity dat
- Dynamická správa oddílů
- Subvolumes (podobné LVM)

**Nevýhody:**
- Vyšší využití CPU při kompresi
- Složitější správa
- RAID 5/6 není doporučen pro produkci
- Větší spotřeba RAM

**Doporučené použití:**
- Domácí systémy
- Systémy vyžadující snapshoty
- Systémy s omezeným místem (díky kompresi)

### XFS
**Výhody:**
- Vynikající výkon pro velké soubory
- Dobrá škálovatelnost
- Stabilní při vysoké zátěži
- Rychlá obnova po pádu

**Nevýhody:**
- Nelze zmenšit oddíl
- Horší výkon s malými soubory
- Bez podpory snapshots
- Složitější obnova smazaných souborů

**Doporučené použití:**
- Serverové systémy
- Multimediální úložiště
- Databázové servery

### ZFS
**Výhody:**
- Pokročilá ochrana dat
- Integrovaný RAID (RAIDZ)
- Komprese a deduplikace
- Snapshoty a klony
- Samouzdravovací schopnosti

**Nevýhody:**
- Vysoká spotřeba RAM
- Licenční omezení
- Složitější instalace na Linux
- Není v základním jádře

**Doporučené použití:**
- NAS systémy
- Kritická datová úložiště
- Enterprise servery

### F2FS
**Výhody:**
- Optimalizováno pro SSD a flash
- Nižší opotřebení SSD
- Dobrý výkon pro malé soubory
- Rychlé mount/umount

**Nevýhody:**
- Méně nástrojů pro správu
- Omezená podpora v některých systémech
- Mladší systém s méně zkušenostmi

**Doporučené použití:**
- SSD disky
- Mobilní zařízení
- Embedded systémy

### Porovnání výkonu
```bash
# Sekvenční čtení (MB/s)
ext4:   250
btrfs:  245 (bez komprese)
xfs:    255
zfs:    240

# Náhodné I/O (IOPS)
ext4:   8000
btrfs:  7500
xfs:    8200
zfs:    7800
```

### Doporučené konfigurace

#### Desktop systém
```bash
# Root (/)
Filesystem: ext4 nebo btrfs
Options: noatime,discard=async

# Home (/home)
Filesystem: btrfs
Options: noatime,compress=zstd,discard=async

# Swap
Filesystem: swap
Options: pri=100
```

#### Server
```bash
# Root (/)
Filesystem: ext4
Options: noatime,errors=remount-ro

# Data (/var)
Filesystem: XFS
Options: noatime,nodiratime

# Logy (/var/log)
Filesystem: ext4
Options: noatime,nodiratime
```

#### NAS/Úložiště
```bash
# Datové úložiště
Filesystem: ZFS nebo btrfs
Options: compress=zstd,nodatacow (pro databáze)
```

## Základní koncepty

### Typy disků
- **HDD** - Klasické pevné disky
- **SSD** - Solid State Drive
- **NVMe** - Rychlé SSD přes PCIe
- **eMMC** - Vestavěná flash paměť

### Pojmenování zařízení
- **/dev/sdX** - SATA/USB disky
- **/dev/nvmeXnY** - NVMe disky
- **/dev/mmcblkX** - eMMC/SD karty

## Správa oddílů

### Tabulky oddílů
#### GPT (GUID Partition Table)
```bash
# Vytvoření GPT tabulky
gdisk /dev/sda
# nebo
parted -s /dev/sda mklabel gpt

# Zobrazení oddílů
gdisk -l /dev/sda
```

#### MBR (Master Boot Record)
```bash
# Vytvoření MBR tabulky
fdisk /dev/sda
# nebo
parted -s /dev/sda mklabel msdos
```

### Nástroje pro správu oddílů

#### fdisk
```bash
# Interaktivní režim
fdisk /dev/sda

# Běžné příkazy
n    # nový oddíl
d    # smazat oddíl
t    # změnit typ
w    # zapsat změny
```

#### parted
```bash
# Vytvoření oddílu
parted /dev/sda mkpart primary ext4 1MiB 100GiB

# Změna velikosti
parted /dev/sda resizepart 1 120GiB

# Kontrola
parted /dev/sda print
```

## Souborové systémy

### Typy souborových systémů

#### ext4
```bash
# Vytvoření
mkfs.ext4 /dev/sda1

# Ladění
tune2fs -c 30 /dev/sda1  # Počet mountů mezi kontrolami
tune2fs -L "ROOT" /dev/sda1  # Nastavení labelu
```

#### btrfs
```bash
# Vytvoření
mkfs.btrfs /dev/sda1

# Subvolumes
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home

# Snapshoty
btrfs subvolume snapshot /mnt/@ /mnt/@snapshot
```

#### XFS
```bash
# Vytvoření
mkfs.xfs /dev/sda1

# Správa
xfs_repair /dev/sda1
xfs_fsr /dev/sda1  # Defragmentace
```

### Montování

#### Základní montování
```bash
# Ruční montování
mount /dev/sda1 /mnt

# Automatické montování (/etc/fstab)
/dev/sda1  /         ext4    defaults,noatime  0 1
/dev/sda2  /home     ext4    defaults,noatime  0 2
```

#### Pokročilé možnosti
```bash
# Montování s options
mount -o noatime,compress=zstd /dev/sda1 /mnt

# Bind mount
mount --bind /source /target
```

## RAID a LVM

### Software RAID (mdadm)
```bash
# Vytvoření RAID 1
mdadm --create /dev/md0 --level=1 --raid-devices=2 /dev/sda1 /dev/sdb1

# Monitoring
mdadm --detail /dev/md0
mdadm --monitor --scan --daemonize

# Obnova
mdadm /dev/md0 --add /dev/sdc1
```

### LVM (Logical Volume Management)

#### Fyzické svazky (PV)
```bash
# Vytvoření PV
pvcreate /dev/sda1 /dev/sdb1

# Zobrazení
pvdisplay
pvs
```

#### Skupiny svazků (VG)
```bash
# Vytvoření VG
vgcreate data /dev/sda1 /dev/sdb1

# Rozšíření
vgextend data /dev/sdc1
```

#### Logické svazky (LV)
```bash
# Vytvoření LV
lvcreate -L 100G -n home data

# Změna velikosti
lvresize -L +50G /dev/data/home
resize2fs /dev/data/home
```

## Šifrování

### LUKS
```bash
# Vytvoření šifrovaného oddílu
cryptsetup luksFormat /dev/sda1

# Otevření
cryptsetup open /dev/sda1 crypt

# Automatické odemykání (/etc/crypttab)
crypt  UUID=xxx  none  luks
```

### VeraCrypt
```bash
# Vytvoření kontejneru
veracrypt -c

# Montování
veracrypt /path/to/container /mnt/veracrypt1
```

## Monitoring a údržba

### Monitoring disků

#### SMART
```bash
# Instalace
pacman -S smartmontools

# Kontrola zdraví
smartctl -H /dev/sda

# Detailní informace
smartctl -a /dev/sda

# Aktivace monitoringu
smartd -s on
```

#### I/O monitoring
```bash
# Sledování I/O
iotop
iostat -x 1

# Latence
ioping -c 10 /dev/sda
```

### Údržba

#### Defragmentace
```bash
# ext4
e4defrag /

# btrfs
btrfs filesystem defragment -r /
```

#### Kontrola souborových systémů
```bash
# ext4
fsck.ext4 -f /dev/sda1

# btrfs
btrfs check /dev/sda1
```

## Výkon a optimalizace

### SSD optimalizace
```bash
# TRIM
systemctl enable fstrim.timer

# I/O scheduler
echo "mq-deadline" > /sys/block/sda/queue/scheduler

# Mount options
noatime,discard=async
```

### Vyrovnávací paměť
```bash
# /etc/sysctl.d/99-sysctl.conf
vm.dirty_ratio = 10
vm.dirty_background_ratio = 5
vm.swappiness = 10
```

## Zálohování

### Nástroje pro zálohování

#### rsync
```bash
# Základní záloha
rsync -av --delete /source/ /backup/

# Inkrementální záloha
rsync -av --link-dest=/backup/previous /source/ /backup/current
```

#### timeshift
```bash
# Vytvoření snapshotu
timeshift --create

# Obnova
timeshift --restore
```

## Doporučené postupy

1. **Plánování**
   - Promyslet schéma oddílů
   - Vybrat vhodné souborové systémy
   - Zvážit RAID/LVM

2. **Bezpečnost**
   - Pravidelné zálohy
   - Monitoring SMART
   - Šifrování citlivých dat

3. **Údržba**
   - Pravidelné kontroly
   - Aktualizace firmwaru
   - Sledování volného místa

## Odkazy
- [Arch Wiki - Partitioning](https://wiki.archlinux.org/title/Partitioning)
- [Arch Wiki - File systems](https://wiki.archlinux.org/title/File_systems)
- [Arch Wiki - LVM](https://wiki.archlinux.org/title/LVM) 