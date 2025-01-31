# Řešení problémů v Arch Linux

## Úvod
Tento dokument popisuje řešení běžných problémů, se kterými se můžete setkat při používání Arch Linuxu.

ČTĚTE AŽ PO TOM CO JSTE POČÍTAČ ZKUSILI RESTARTOVAT!

## Běžné problémy a jejich řešení

### 1. Systém se nespustí
**Příznaky:**
- Černá obrazovka po bootu
- Chybějící GRUB menu
- Kernel panic

**Řešení:**
1. Zkuste bootovat z live USB
2. Chroot do systému:
```bash
mount /dev/sdX1 /mnt
mount /dev/sdX2 /mnt/boot
arch-chroot /mnt
```
3. Opravte bootloader:
```bash
grub-install /dev/sdX
grub-mkconfig -o /boot/grub/grub.cfg
```

### 2. Chybějící moduly kernelu
**Příznaky:**
- Nefungující síť
- Chybějící ovladače
- Chyby při bootu

**Řešení:**
1. Zkontrolujte nainstalované moduly:
```bash
lsmod
```
2. Nainstalujte chybějící moduly:
```bash
sudo pacman -S linux-headers
sudo pacman -S linux-firmware
```
3. Regenerujte initramfs:
```bash
mkinitcpio -P
```

### 3. Problémy s AUR balíčky
**Příznaky:**
- Chyby při instalaci z AUR
- Chybějící závislosti
- Problémy s podpisy

**Řešení:**
1. Aktualizujte klíče:
```bash
sudo pacman-key --refresh-keys
sudo pacman -S archlinux-keyring
```
2. Zkontrolujte závislosti:
```bash
yay -Syu
```
3. Ruční instalace:
```bash
git clone https://aur.archlinux.org/balicek.git
cd balicek
makepkg -si
```

### 4. Problémy se sítí
**Příznaky:**
- Nefunkční WiFi/Ethernet
- Chybějící IP adresa
- Problémy s DNS

**Řešení:**
1. Zkontrolujte stav sítě:
```bash
ip a
nmcli device status
```
2. Restartujte NetworkManager:
```bash
sudo systemctl restart NetworkManager
```
3. Zkontrolujte konfiguraci:
```bash
cat /etc/resolv.conf
```

### 5. Problémy se zvukem
**Příznaky:**
- Žádný zvuk
- Chybějící zařízení
- Problémy s hlasitostí

**Řešení:**
1. Zkontrolujte zvuková zařízení:
```bash
aplay -l
pacmd list-sinks
```
2. Restartujte PulseAudio:
```bash
pulseaudio -k
pulseaudio --start
```
3. Nainstalujte potřebné balíčky:
```bash
sudo pacman -S alsa-utils pulseaudio pavucontrol
```

## Užitečné nástroje

### Systemd Journal
```bash
journalctl -xe
```

### Logy bootování
```bash
dmesg | less
```

### Kontrola souborových systémů
```bash
sudo fsck /dev/sdX1
```

### Monitorování procesů
```bash
htop
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
- [Arch Wiki - Troubleshooting](https://wiki.archlinux.org/title/General_troubleshooting)
- [Arch Wiki - Boot problems](https://wiki.archlinux.org/title/Arch_boot_process#Troubleshooting)
- [Arch Wiki - Network troubleshooting](https://wiki.archlinux.org/title/Network_configuration#Troubleshooting) 