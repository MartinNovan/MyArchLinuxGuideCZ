# Optimalizace výkonu v Arch Linuxu

## Úvod
Tento dokument popisuje různé techniky a nástroje pro optimalizaci výkonu Arch Linuxu. Zaměřuje se na optimalizaci CPU, paměti, I/O a dalších systémových zdrojů.

## Základní optimalizace

### Zjištění stavu systému
```bash
# Zatížení CPU
htop

# Využití paměti
free -h

# I/O operace
iotop

# Síťová aktivita
nload
```

### Aktualizace systému
```bash
sudo pacman -Syu
```

### Výběr správného kernelu
```bash
# Zkontrolujte aktuální kernel
uname -r

# Vyzkoušejte alternativní kernel
sudo pacman -S linux-zen
```

## Optimalizace CPU

### Frekvence procesoru
```bash
# Instalace cpupower
sudo pacman -S cpupower

# Nastavení výkonného režimu
sudo cpupower frequency-set -g performance
```

### Plánování procesů
```bash
# Zkontrolujte aktuální scheduler
cat /sys/block/sda/queue/scheduler

# Nastavení CFQ scheduler
echo cfq | sudo tee /sys/block/sda/queue/scheduler
```

## Optimalizace paměti

### Swappiness
```bash
# Zkontrolujte aktuální hodnotu
cat /proc/sys/vm/swappiness

# Nastavení swappiness
echo 10 | sudo tee /proc/sys/vm/swappiness
```

### Transparentní huge pages
```bash
# Povolení THP
echo always | sudo tee /sys/kernel/mm/transparent_hugepage/enabled
```

## Optimalizace I/O

### Filesystem
```bash
# Zkontrolujte filesystem
df -T

# Optimalizace ext4
sudo tune2fs -o journal_data_writeback /dev/sda1
```

### I/O scheduler
```bash
# Nastavení deadline scheduler
echo deadline | sudo tee /sys/block/sda/queue/scheduler
```

## Optimalizace sítě

### TCP tuning
```bash
# Zvýšení bufferů
echo 'net.core.rmem_max=16777216' | sudo tee -a /etc/sysctl.conf
echo 'net.core.wmem_max=16777216' | sudo tee -a /etc/sysctl.conf
```

### Offloading
```bash
# Povolení TCP offload
sudo ethtool -K eth0 tx on rx on tso on gso on
```

## Grafické prostředí

### Compositing
```bash
# Vypnutí compositingu v KDE
kwin_x11 --replace &
```

### GPU akcelerace
```bash
# Zkontrolujte GPU
glxinfo | grep "OpenGL renderer"

# Instalace ovladačů
sudo pacman -S nvidia
```

## Užitečné nástroje

### Benchmarking
```bash
# CPU
sudo pacman -S sysbench

# Disk
sudo pacman -S fio

# Síť
sudo pacman -S iperf
```

### Monitorování
```bash
# Celkový přehled
sudo pacman -S glances

# I/O
sudo pacman -S iotop

# Síť
sudo pacman -S nethogs
```

## Doporučené postupy

1. **Postupná optimalizace**
   - Měňte vždy jednu věc najednou
   - Měřte dopad každé změny
   - Udržujte záznamy o změnách

2. **Monitorování**
   - Pravidelně kontrolujte výkon systému
   - Nastavte upozornění na kritické hodnoty
   - Analyzujte dlouhodobé trendy

3. **Zálohování**
   - Před změnami vždy zálohujte
   - Udržujte funkční konfiguraci
   - Mějte plán pro návrat k předchozímu stavu

## Užitečné odkazy
- [Arch Wiki - Improving performance](https://wiki.archlinux.org/title/Improving_performance)
- [Linux Performance](https://www.brendangregg.com/linuxperf.html)
- [Phoronix Test Suite](https://www.phoronix-test-suite.com/) 