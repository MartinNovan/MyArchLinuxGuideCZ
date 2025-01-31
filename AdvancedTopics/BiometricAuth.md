# Biometrické přihlašování v Arch Linux

## Úvod
Tento dokument popisuje nastavení a konfiguraci biometrického přihlašování v Arch Linuxu, včetně otisků prstů a rozpoznávání obličeje.

## Otisky prstů

### Požadavky
- Podporovaný čtečka otisků prstů
- Balíček `fprintd`

### Instalace
```bash
sudo pacman -S fprintd
```

### Registrace otisků
1. Zaregistrujte otisk prstu:
```bash
fprintd-enroll
```
2. Ověřte funkčnost:
```bash
fprintd-verify
```

### Integrace s PAM
1. Upravte PAM konfiguraci:
```bash
sudo nano /etc/pam.d/system-auth
```
2. Přidejte následující řádek před `auth required pam_unix.so`:
```bash
auth sufficient pam_fprintd.so
```

### Řešení problémů
```bash
# Zkontrolujte stav služby
systemctl status fprintd

# Zkontrolujte podporu zařízení
lsusb | grep -i fingerprint
```

## Rozpoznávání obličeje (Howdy)

### Požadavky
- Webkamera s podporou IR
- Balíček `howdy`

### Instalace
```bash
yay -S howdy
```

### Konfigurace
1. Upravte konfigurační soubor:
```bash
sudo howdy config
```
2. Důležité nastavení:
```ini
[core]
detection_notice = false
```

### Přidání obličeje
```bash
sudo howdy add
```

### Testování
```bash
sudo howdy test
```

### Integrace s PAM
1. Upravte PAM konfiguraci:
```bash
sudo nano /etc/pam.d/system-auth
```
2. Přidejte následující řádek před `auth required pam_unix.so`:
```bash
auth sufficient pam_python.so /usr/lib/security/howdy/pam.py
```

### Řešení problémů
```bash
# Zkontrolujte logy
journalctl -u howdy

# Zkontrolujte podporu kamery
ls /dev/video*
```

## Bezpečnostní doporučení

1. **Záloha PAM konfigurace**
   - Před úpravami vždy zálohujte PAM soubory
   - Uchovávejte funkční kopii pro případ chyb

2. **Vícefaktorové ověřování**
   - Kombinujte biometrické metody s heslem
   - Používejte biometrii jako doplňkovou metodu

3. **Monitorování**
   - Pravidelně kontrolujte logy
   - Testujte funkčnost po aktualizacích

## Odkazy
- [Arch Wiki - Fprint](https://wiki.archlinux.org/title/Fprint)
- [Howdy GitHub](https://github.com/boltgolt/howdy)
- [PAM Documentation](https://linux.die.net/man/8/pam) 