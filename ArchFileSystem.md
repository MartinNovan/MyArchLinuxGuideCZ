# Souborový systém Arch Linux

## Úvod
Arch Linux používá standardní hierarchickou strukturu souborového systému podle FHS (Filesystem Hierarchy Standard). Tento dokument popisuje hlavní adresáře a jejich účel.

## Základní struktura
### / (Root)
Kořenový adresář, obsahuje všechny ostatní adresáře. Je to výchozí bod celého souborového systému.

### /boot
- Obsahuje soubory potřebné pro start systému
- Bootloader (GRUB/systemd-boot)
- Linux kernel (obvykle pojmenovaný jako vmlinuz-linux)
- initramfs obrazy (počáteční RAM disk)
- Konfigurační soubory bootloaderu

### /etc
- Systémová konfigurace
- Konfigurační soubory pro služby
- Síťová konfigurace (/etc/network)
- Bezpečnostní nastavení
- Důležité soubory jako:
  - /etc/fstab (konfigurace připojení souborových systémů)
  - /etc/passwd (databáze uživatelů)
  - /etc/hosts (mapování IP adres na názvy hostů)

### /home
- Domovské adresáře uživatelů
- Osobní data a konfigurace
- Dotfiles (.bashrc, .config, atd.)
- Každý uživatel má vlastní adresář /home/uživatel

### /usr
- Programy a aplikace
- Sdílené knihovny
- Dokumentace
- Zdrojové kódy
- Největší adresář v systému
- Obsahuje většinu nainstalovaného software

### /var
- Proměnlivá data
- Systémové logy (/var/log)
- Cache (/var/cache)
- Spoolové soubory
- Databáze
- Velikost se mění během běhu systému

### /tmp
- Dočasné soubory
- Automaticky mazáno při restartu
- Přístupné pro všechny uživatele
- Často umístěno v RAM pro rychlejší přístup

### /opt
- Volitelné balíčky
- Software třetích stran
- Samostatné aplikace (např. Google Chrome, Discord)
- Každá aplikace má vlastní adresář

### /srv
- Data pro služby poskytované systémem
- Webové servery (např. /srv/http)
- FTP servery
- Jiné síťové služby

### /dev
- Obsahuje soubory zařízení (device files)
- Reprezentuje hardwarová zařízení v systému
- Spravováno systémem udev
- Obsahuje například:
  - /dev/sda (první disk)
  - /dev/tty (terminály)
  - /dev/null (prázdné zařízení)

### /lost+found
- Používá se pro obnovení poškozených souborů
- Správně by měl být prázdný
- Každý souborový systém ext má vlastní /lost+found
- Vytvářen automaticky při formátování
- Používán fsck při opravě systému

### /mnt
- Bod pro dočasné připojení souborových systémů
- Používá se pro ruční připojení disků
- Vhodné pro připojení externích zařízení
- Běžně používáno správci systému

### /proc
- Virtuální souborový systém
- Poskytuje informace o běžících procesech
- Obsahuje informace o systému
- Důležité soubory:
  - /proc/cpuinfo (informace o CPU)
  - /proc/meminfo (informace o paměti)
  - /proc/version (verze jádra)

### /root
- Domovský adresář pro uživatele root
- Oddělen od /home z bezpečnostních důvodů
- Obsahuje konfigurační soubory superuživatele
- Přístupný pouze pro root

### /run
- Běhové proměnné data
- Obsahuje informace od startu systému
- Čistí se při startu systému
- Používáno pro PID soubory a socket soubory

## Důležité podsložky
### /usr/bin
- Spustitelné programy
- Příkazy pro všechny uživatele
- V moderních systémech je tento adresář symbolickým odkazem na /bin

### /usr/lib
- Systémové knihovny
- Moduly jádra
- Symbolický odkaz na /lib
- Obsahuje sdílené knihovny potřebné pro programy v /usr/bin

### /usr/share
- Architekturně nezávislá data
- Dokumentace
- Lokalizační soubory
- Ikony, témata a další sdílené zdroje

### Symbolické odkazy v systému
V moderním Arch Linuxu jsou některé tradiční adresáře ve skutečnosti symbolickými odkazy (symlinky) na jiná umístění. Toto je součást konceptu "usr merge", kde se obsah některých kořenových adresářů přesunul do /usr:

- /bin → /usr/bin
- /lib → /usr/lib
- /lib64 → /usr/lib
- /sbin → /usr/bin

#### Co je symbolický odkaz?
Symbolický odkaz (nebo symlink) je speciální typ souboru, který slouží jako reference nebo ukazatel na jiný soubor nebo adresář. Je to podobné jako zástupce ve Windows.

Příklady práce se symbolickými odkazy:

Výhody symbolických odkazů:
- Mohou odkazovat na soubory napříč různými souborovými systémy
- Při smazání symlinku zůstává původní soubor nedotčen
- Lze snadno identifikovat (pomocí ls -l)
- Mohou odkazovat na adresáře

## Správa souborového systému
### Oprávnění
Základní oprávnění v Linuxu:
- r (read) - čtení
- w (write) - zápis
- x (execute) - spouštění

Příklady použití chmod:

```bash
# Přidání práva pro spuštění
chmod +x soubor

# Nastavení práv pomocí čísel
chmod 755 soubor  # rwxr-xr-x
chmod 644 soubor  # rw-r--r--
```

Změna vlastníka pomocí chown:
```bash
# Změna vlastníka
chown uživatel:skupina soubor
```

### Odkazy
#### Symbolické odkazy
- Mohou směřovat kamkoliv v systému
- Při smazání cíle přestávají fungovat
- Zabírají minimální místo

#### Pevné odkazy
- Musí být na stejném souborovém systému
- Fungují i po smazání původního souboru
- Sdílejí stejná data jako původní soubor

## Tipy a triky
### Efektivní organizace /home
- Používejte standardní adresáře (Documents, Downloads, etc.)
- Ukládejte konfigurační soubory do ~/.config
- Využívejte ~/.local pro uživatelské programy

### Zálohování důležitých adresářů
```bash
# Záloha pomocí rsync
rsync -av --delete /home/user /backup/

# Záloha pomocí tar
tar -czf backup.tar.gz /home/user
```
### Čištění systému
 - více pak v [UsefulCommands](UsefulCommands)
```bash
# Vyčištění pacman cache
sudo paccache -r

# Odstranění nepotřebných závislostí
sudo pacman -Rns $(pacman -Qtdq)

# Vyčištění /tmp
sudo rm -rf /tmp/*
```

## Časté problémy
### Řešení problémů s oprávněními
- Zkontrolujte vlastníka a skupinu
- Ověřte oprávnění nadřazených adresářů
- Použijte příkaz `ls -la` pro zobrazení všech oprávnění

### Správa místa na disku
```bash
# Zobrazení využití disku
df -h

# Nalezení velkých souborů
du -sh /* | sort -h

# Analýza využití adresáře
ncdu /
```

### Obnovení smazaných souborů
- Použijte nástroje jako testdisk nebo photorec
- Pravidelně zálohujte důležitá data
- Zvažte použití snapshotů souborového systému

## Závěr
Porozumění struktuře souborového systému je klíčové pro efektivní správu Arch Linuxu. Dodržování standardních konvencí a pravidelná údržba pomohou udržet systém čistý a funkční.
