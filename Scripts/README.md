# Užitečné skripty pro Arch Linux

Tato složka obsahuje různé užitečné skripty pro správu a údržbu Arch Linux systému.

## Obsah

### Clean.sh
- **Popis:** Skript pro vyčištění systému
- **Funkce:**
  - Čištění Pacman cache
  - Odstranění osamocených balíčků
  - Vyčištění uživatelské cache
  - Výpočet uvolněného místa
- **Použití:**
```bash
sh ./Clean.sh
```

### Update.sh
- **Popis:** Skript pro aktualizaci systému
- **Funkce:**
  - Aktualizace systémových balíčků
  - Aktualizace AUR balíčků
  - Kontrola aktualizací
- **Použití:**
```bash
sh ./Update.sh
```

### Backup.sh
- **Popis:** Skript pro zálohování důležitých souborů
- **Funkce:**
  - Záloha konfiguračních souborů
  - Záloha seznamu nainstalovaných balíčků
  - Komprese zálohy
- **Použití:**
```bash
sh ./Backup.sh
```

## Související dokumenty

- [UsefulCommands](../UsefulCommands/README.md) - Seznam užitečných příkazů pro Pacman a Yay
- [PackageManagement.md](../PackageManagement.md) - Průvodce správou balíčků
- [SecurityHardening.md](../SecurityHardening.md) - Doporučení pro zabezpečení systému

## Doporučené postupy

1. **Pravidelná údržba**
   - Spouštějte Clean.sh alespoň jednou měsíčně
   - Pravidelně aktualizujte systém pomocí Update.sh

2. **Zálohování**
   - Provádějte zálohy před většími změnami
   - Uchovávejte zálohy na externím úložišti

3. **Bezpečnost**
   - Před spuštěním skriptů zkontrolujte jejich obsah
   - Používejte pouze důvěryhodné skripty

## Odkazy
- [Arch Wiki - Pacman](https://wiki.archlinux.org/title/Pacman)
- [Arch Wiki - Yay](https://wiki.archlinux.org/title/AUR_helpers)
- [Arch Wiki - System maintenance](https://wiki.archlinux.org/title/System_maintenance) 