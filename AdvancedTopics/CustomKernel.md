# Vlastní kernel v Arch Linuxu

## Úvod
Kompilace vlastního kernelu umožňuje optimalizovat systém pro specifický hardware, přidat nebo odebrat funkce a zlepšit výkon. Tento průvodce vás provede procesem kompilace a instalace vlastního kernelu.

## Požadavky
- Základní znalost příkazového řádku
- Dostatek místa na disku (min. 10 GB)
- Nainstalované vývojové nástroje

## Instalace potřebných balíčků
```bash
sudo pacman -S base-devel bc kmod libelf pahole cpio perl tar xz git
```

## Stažení zdrojových kódů kernelu
1. Stáhněte zdrojové kódy:
```bash
git clone https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
cd linux
```
2. Vyberte verzi kernelu:
```bash
git tag -l | grep v5.
git checkout v5.15
```

## Konfigurace kernelu
1. Zkopírujte aktuální konfiguraci:
```bash
cp /proc/config.gz .
gunzip config.gz
mv config .config
```
2. Spusťte konfigurační nástroj:
```bash
make menuconfig
```
3. Proveďte potřebné změny:
   - Optimalizace pro specifický procesor
   - Přidání/odebrání ovladačů
   - Zapnutí/vypnutí experimentálních funkcí

## Kompilace kernelu
1. Spusťte kompilaci:
```bash
make -j$(nproc)
```
2. Kompilace modulů:
```bash
make modules
```
3. Instalace modulů:
```bash
sudo make modules_install
```

## Instalace kernelu
1. Instalace kernelu:
```bash
sudo make install
```
2. Aktualizace GRUB:
```bash
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

## Řešení problémů
### Kernel se nespustí
1. Bootujte z předchozího kernelu
2. Zkontrolujte konfiguraci:
```bash
dmesg | grep -i error
```

### Chybějící ovladače
1. Zkontrolujte podporu zařízení:
```bash
lspci -k
```
2. Přidejte potřebné ovladače do konfigurace

## Optimalizace
### Procesor
```bash
Processor type and features  --->
  Processor family (Core 2/newer Xeon)  --->
    (X) Core 2/newer Xeon
```

### I/O scheduler
```bash
Device Drivers  --->
  Multi-device support (RAID and LVM)  --->
    <*> RAID support
    <*> Device mapper support
```

### Bezpečnost
```bash
Security options  --->
  <*> Enable different security models
  <*> Integrity subsystem
```

## Užitečné odkazy
- [Arch Wiki - Kernel](https://wiki.archlinux.org/title/Kernel)
- [Kernel Newbies](https://kernelnewbies.org/)
- [Linux Kernel Documentation](https://www.kernel.org/doc/html/latest/) 