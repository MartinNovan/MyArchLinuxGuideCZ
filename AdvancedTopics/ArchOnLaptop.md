# Arch Linux na notebooku

## Úvod
Tento dokument popisuje specifické aspekty používání Arch Linuxu na notebooku, včetně správy napájení, řešení problémů s hardwarem a optimalizace pro mobilní použití.

## Základní nastavení

### Správa napájení
```bash
sudo pacman -S tlp
sudo systemctl enable tlp
```

### Zjištění stavu baterie
```bash
upower -i /org/freedesktop/UPower/devices/battery_BAT0
```

### Optimalizace spotřeby
```bash
sudo nano /etc/tlp.conf
```
```ini
CPU_SCALING_GOVERNOR_ON_BAT=powersave
CPU_SCALING_MIN_FREQ_ON_BAT=800000
CPU_SCALING_MAX_FREQ_ON_BAT=2000000
```

## Řešení problémů s hardwarem

### Touchpad
```bash
sudo pacman -S xf86-input-libinput
```

### Klávesové zkratky
```bash
sudo pacman -S xbindkeys
```

### Webkamera
```bash
sudo pacman -S cheese
```

### Bluetooth
```bash
sudo pacman -S bluez bluez-utils
sudo systemctl enable bluetooth
```

## Optimalizace výkonu

### Frekvence procesoru
```bash
sudo pacman -S cpupower
sudo cpupower frequency-set -g powersave
```

### GPU akcelerace
```bash
sudo pacman -S mesa
```

### Hybridní grafika
```bash
sudo pacman -S optimus-manager
```

## Užitečné nástroje

### Monitorování baterie
```bash
sudo pacman -S powertop
```

### Správa jasu
```bash
sudo pacman -S light
```

### Automatické vypínání displeje
```bash
sudo pacman -S xautolock
```

## Řešení problémů

### Nefunkční WiFi
```bash
sudo pacman -S wpa_supplicant
sudo systemctl enable wpa_supplicant@wlan0
```

### Nefunkční zvuk
```bash
sudo pacman -S alsa-utils
alsamixer
```

### Problémy s hibernací
```bash
sudo nano /etc/mkinitcpio.conf
```
```ini
HOOKS=(base udev autodetect modconf block filesystems keyboard resume fsck)
```

## Doporučené postupy

1. **Zálohování**
   - Pravidelně zálohujte důležité soubory
   - Udržujte seznam nainstalovaných balíčků

2. **Monitorování**
   - Sledujte stav baterie
   - Monitorujte teplotu procesoru

3. **Údržba**
   - Pravidelně aktualizujte systém
   - Čistěte cache a dočasné soubory

## Užitečné odkazy
- [Arch Wiki - Laptops](https://wiki.archlinux.org/title/Laptop)
- [Arch Wiki - Power management](https://wiki.archlinux.org/title/Power_management)
- [Arch Wiki - Touchpad](https://wiki.archlinux.org/title/Touchpad) 