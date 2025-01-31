# Arch Linux pro hráče

## Úvod
Tento dokument popisuje nastavení a konfiguraci Arch Linuxu pro hraní her, včetně instalace ovladačů, optimalizace výkonu a konfigurace herních platforem.

## Základní nastavení

### Ovladače GPU
```bash
sudo pacman -S nvidia nvidia-utils
```

### Herní prostředí
```bash
sudo pacman -S steam lutris wine
```

### Herní nástroje
```bash
sudo pacman -S gamemode
```

## Optimalizace výkonu

### Frekvence procesoru
```bash
sudo pacman -S cpupower
sudo cpupower frequency-set -g performance
```

### GPU akcelerace
```bash
sudo pacman -S mesa
```

### Zvýšení výkonu I/O
```bash
echo deadline | sudo tee /sys/block/sda/queue/scheduler
```

## Herní platformy

### Steam
```bash
sudo pacman -S steam
```
- Proton je integrován přímo v Steamu
- Není potřeba samostatná instalace

### Lutris
```bash
sudo pacman -S lutris
```
- Wine se stáhne automaticky s Lutris
- Podporuje různé verze Wine

### Wine
```bash
sudo pacman -S wine
```
- Pouze pokud potřebujete samostatnou instalaci
- Pro většinu her postačuje Proton nebo Wine v Lutris

## Řešení problémů

### Nefunkční zvuk
```bash
sudo pacman -S alsa-utils
alsamixer
```

### Nefunkční ovladače
```bash
sudo pacman -S xf86-video-intel
```

### Problémy s výkonem
```bash
sudo pacman -S gamemode
```

## Doporučené postupy

1. **Aktualizace**
   - Pravidelně aktualizujte ovladače
   - Aktualizujte herní platformy
   - Sledujte novinky v herní komunitě

2. **Monitorování**
   - Sledujte teplotu procesoru a GPU
   - Monitorujte využití paměti
   - Analyzujte výkon her

3. **Zálohování**
   - Pravidelně zálohujte herní data
   - Udržujte seznam nainstalovaných her
   - Uchovávejte zálohy na externím úložišti

## Užitečné odkazy
- [Arch Wiki - Gaming](https://wiki.archlinux.org/title/Gaming)
- [Arch Wiki - NVIDIA](https://wiki.archlinux.org/title/NVIDIA)
- [Arch Wiki - Wine](https://wiki.archlinux.org/title/Wine) 