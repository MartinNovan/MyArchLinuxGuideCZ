# Správa oprávnění - Užitečné příkazy

## Základní oprávnění
### Změna oprávnění (chmod)
```bash
# Základní syntaxe
chmod [opce] mode soubor

# Číselná notace
chmod 755 soubor  # rwxr-xr-x
chmod 644 soubor  # rw-r--r--
chmod 700 soubor  # rwx------

# Symbolická notace
chmod u+x soubor  # Přidání práva spouštění pro vlastníka
chmod g+w soubor  # Přidání práva zápisu pro skupinu
chmod o-r soubor  # Odebrání práva čtení pro ostatní
```

### Změna vlastnictví (chown)
```bash
# Změna vlastníka
chown uživatel soubor

# Změna vlastníka a skupiny
chown uživatel:skupina soubor

# Rekurzivní změna
chown -R uživatel:skupina adresář/

# Změna pouze skupiny (chgrp)
chgrp skupina soubor
```

## Speciální oprávnění
### SUID, SGID a Sticky bit
```bash
# Nastavení SUID (4000)
chmod u+s soubor
chmod 4755 soubor

# Nastavení SGID (2000)
chmod g+s adresář
chmod 2755 adresář

# Nastavení Sticky bit (1000)
chmod +t adresář
chmod 1777 adresář
```

### ACL (Access Control Lists)
```bash
# Zobrazení ACL
getfacl soubor

# Nastavení ACL pro uživatele
setfacl -m u:uživatel:rwx soubor

# Nastavení ACL pro skupinu
setfacl -m g:skupina:rx soubor

# Odstranění všech ACL
setfacl -b soubor
```

## Defaultní oprávnění
### Umask
```bash
# Zobrazení aktuální masky
umask

# Nastavení umask
umask 022  # Pro soubory: 644, Pro adresáře: 755
umask 077  # Pro soubory: 600, Pro adresáře: 700

# Dočasná změna
umask -S u=rwx,g=rx,o=rx
```

### Výchozí ACL
```bash
# Nastavení výchozích ACL pro adresář
setfacl -d -m u:uživatel:rwx adresář

# Kopírování ACL
getfacl zdroj | setfacl --set-file=- cíl
```

## Hromadné změny
### Rekurzivní operace
```bash
# Rekurzivní chmod
chmod -R 755 adresář/

# Pouze soubory
find adresář -type f -exec chmod 644 {} \;

# Pouze adresáře
find adresář -type d -exec chmod 755 {} \;

# Kombinované příkazy
find adresář -type f -exec chmod 644 {} \; -o -type d -exec chmod 755 {} \;
```

## Kontrola a audit
### Zobrazení oprávnění
```bash
# Detailní výpis
ls -l soubor

# Výpis včetně ACL
ls -l+ soubor

# Numerický výpis
stat -c "%a %n" soubor

# Kompletní informace
stat soubor
```

### Vyhledávání podle oprávnění
```bash
# Nalezení SUID souborů
find / -perm -4000

# Nalezení SGID souborů
find / -perm -2000

# Nalezení světově zapisovatelných souborů
find / -perm -2 -type f -print

# Nalezení souborů bez vlastníka
find / -nouser -o -nogroup
```

## Bezpečnostní opatření
### Oprava oprávnění
```bash
# Oprava domovského adresáře
chmod 700 /home/uživatel
chmod 755 /home

# Oprava systémových souborů
chmod 644 /etc/passwd
chmod 600 /etc/shadow

# Oprava spustitelných souborů
chmod 755 /usr/local/bin/*
```

### Kontrola bezpečnosti
```bash
# Kontrola důležitých souborů
ls -l /etc/passwd /etc/shadow /etc/group
ls -l /etc/sudoers
ls -l /etc/ssh/sshd_config

# Kontrola nebezpečných oprávnění
find / -type f -perm -0777 -print
```

## Užitečné aliasy
```bash
# Přidat do ~/.bashrc nebo ~/.zshrc
alias ll='ls -la'
alias lh='ls -lah'
alias perms='stat -c "%a %n"'
alias suid='find / -perm -4000 2>/dev/null'
```

## Řešení problémů
```bash
# Reset oprávnění na výchozí hodnoty
find /home/uživatel -type f -exec chmod 644 {} \;
find /home/uživatel -type d -exec chmod 755 {} \;

# Odstranění rozšířených oprávnění
chmod --reference=/etc/passwd soubor

# Kontrola integrity systému
rpm -Va  # Pro systémy založené na RPM
dpkg -V  # Pro systémy založené na Debian
``` 