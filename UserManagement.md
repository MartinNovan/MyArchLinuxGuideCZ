# Správa uživatelů v Arch Linux

## Úvod
Správa uživatelů je klíčovou součástí administrace systému Linux. Zahrnuje vytváření a správu uživatelských účtů, skupin a oprávnění.

## Základní koncepty

### Uživatelé
- **root** - Superuživatel s plnými právy
- **systémoví uživatelé** - Účty pro služby (UID < 1000)
- **běžní uživatelé** - Normální uživatelské účty (UID >= 1000)

### Skupiny
- **primární skupina** - Hlavní skupina uživatele
- **sekundární skupiny** - Dodatečné skupiny pro přístupová práva

### Důležité soubory
```bash
/etc/passwd   # Databáze uživatelů
/etc/shadow   # Šifrovaná hesla
/etc/group    # Databáze skupin
/etc/gshadow  # Šifrovaná hesla skupin
```

## Správa uživatelů

### Vytváření uživatelů
```bash
# Základní vytvoření uživatele
useradd -m -G wheel,audio,video uzivatel

# Vytvoření s dodatečnými parametry
useradd -m -G wheel,audio,video -s /bin/bash -c "Celé jméno" uzivatel

# Vytvoření systémového uživatele
useradd -r -s /usr/bin/nologin sluzba
```

### Modifikace uživatelů
```bash
# Změna skupin
usermod -aG skupina uzivatel

# Změna shellu
usermod -s /bin/zsh uzivatel

# Změna domovského adresáře
usermod -d /new/home uzivatel

# Uzamčení účtu
usermod -L uzivatel

# Odemčení účtu
usermod -U uzivatel
```

### Mazání uživatelů
```bash
# Smazání uživatele
userdel uzivatel

# Smazání včetně domovského adresáře
userdel -r uzivatel

# Záloha před smazáním
tar -czf user-backup.tar.gz /home/uzivatel
userdel -r uzivatel
```

## Správa skupin

### Vytváření skupin
```bash
# Vytvoření nové skupiny
groupadd skupina

# Vytvoření systémové skupiny
groupadd -r skupina

# Vytvoření s konkrétním GID
groupadd -g 1500 skupina
```

### Modifikace skupin
```bash
# Přidání uživatele do skupiny
gpasswd -a uzivatel skupina

# Odebrání uživatele ze skupiny
gpasswd -d uzivatel skupina

# Změna názvu skupiny
groupmod -n nova_skupina stara_skupina
```

### Mazání skupin
```bash
# Smazání skupiny
groupdel skupina
```

## Oprávnění

### Základní oprávnění
```bash
# Změna vlastníka
chown uzivatel:skupina soubor

# Změna oprávnění
chmod 755 soubor  # rwxr-xr-x
chmod u+x soubor  # Přidání práva spouštění pro vlastníka

# Rekurzivní změna
chown -R uzivatel:skupina /adresar
chmod -R 755 /adresar
```

### Speciální oprávnění
```bash
# SUID (spuštění s právy vlastníka)
chmod u+s soubor  # nebo chmod 4755 soubor

# SGID (spuštění s právy skupiny)
chmod g+s adresar  # nebo chmod 2755 adresar

# Sticky bit (pouze vlastník může mazat)
chmod +t adresar  # nebo chmod 1755 adresar
```

## ACL (Access Control Lists)

### Základní použití
```bash
# Nastavení ACL
setfacl -m u:uzivatel:rwx soubor
setfacl -m g:skupina:rx soubor

# Zobrazení ACL
getfacl soubor

# Odstranění ACL
setfacl -b soubor
```

### Pokročilé ACL
```bash
# Výchozí ACL pro nové soubory
setfacl -d -m u:uzivatel:rwx adresar

# Kopírování ACL
getfacl zdroj | setfacl --set-file=- cil
```

## Sudo konfigurace

### Základní nastavení
```bash
# /etc/sudoers
# Editovat pomocí visudo!

# Povolení skupiny wheel
%wheel ALL=(ALL:ALL) ALL

# Bez hesla pro konkrétní příkazy
uzivatel ALL=(ALL) NOPASSWD: /usr/bin/pacman -Syu
```

### Pokročilá konfigurace
```bash
# Omezení příkazů
uzivatel ALL=(ALL) /usr/bin/systemctl restart apache

# Aliasy
Cmnd_Alias UPDATE = /usr/bin/pacman -Syu
uzivatel ALL=(ALL) UPDATE
```

## Bezpečnost

### Politika hesel
```bash
# /etc/security/pwquality.conf
minlen = 12
minclass = 4
maxrepeat = 3
```

### Omezení přístupu
```bash
# /etc/security/access.conf
+ : root : ALL
+ : @wheel : ALL
- : ALL : ALL
```

### Limity zdrojů
```bash
# /etc/security/limits.conf
@users soft nproc 1000
@users hard nproc 2000
```

## Automatizace

### Skripty pro správu
```bash
#!/bin/bash
# Vytvoření nového uživatele s standardní konfigurací
create_user() {
    useradd -m -G wheel,audio,video -s /bin/bash "$1"
    passwd "$1"
    mkdir -p /home/"$1"/.config
    chown -R "$1":"$1" /home/"$1"
}
```

### Hromadné operace
```bash
#!/bin/bash
# Přidání všech uživatelů do nové skupiny
for user in $(awk -F: '$3 >= 1000 {print $1}' /etc/passwd); do
    usermod -aG newgroup "$user"
done
```

## Monitoring

### Sledování aktivit
```bash
# Aktuálně přihlášení uživatelé
who
w

# Historie přihlášení
last
lastlog

# Sledování změn v /etc/passwd
ausearch -f /etc/passwd
```

### Audit
```bash
# Nastavení auditování
auditctl -w /etc/passwd -p wa -k user-modify
auditctl -w /etc/group -p wa -k group-modify

# Kontrola logů
aureport --auth
```

## Doporučené postupy

1. **Bezpečnost**
   - Pravidelná změna hesel
   - Kontrola oprávnění
   - Audit uživatelských účtů

2. **Organizace**
   - Konzistentní pojmenování
   - Dokumentace změn
   - Pravidelné revize

3. **Automatizace**
   - Skriptování rutinních úkolů
   - Automatické zálohy
   - Monitoring změn

## Typy uživatelů

### Root uživatel
- **UID 0**
- Má absolutní kontrolu nad systémem
- Může měnit cokoliv v systému
- Není omezen žádnými oprávněními
- **Bezpečnostní doporučení:**
  - Nepoužívat pro běžnou práci
  - Přístup pouze přes sudo
  - Zakázat přímé přihlášení přes SSH

### Systémoví uživatelé
- **UID 1-999**
- Vytvářeni automaticky při instalaci služeb
- Nemají interaktivní shell
- Příklady:
  - `http` - pro webový server
  - `mysql` - pro databázový server
  - `nginx` - pro NGINX server
  - `git` - pro Git služby
- **Účel:**
  - Izolace služeb
  - Omezení přístupu k systémovým zdrojům
  - Zvýšení bezpečnosti

### Běžní uživatelé
- **UID 1000+**
- Určeni pro reálné osoby
- Mají interaktivní shell
- Omezená oprávnění
- **Doporučení:**
  - Vytvářet pro každou fyzickou osobu
  - Nastavit silná hesla
  - Pravidelně revidovat oprávnění

## Systémové skupiny a jejich využití

### Základní systémové skupiny
- **root (GID 0)**
  - Administrátorská skupina
  - Plný přístup k systému

- **wheel**
  - Uživatelé s právem používat sudo
  - ```bash
    # Přidání uživatele do wheel
    usermod -aG wheel uzivatel
    ```

- **users**
  - Standardní skupina pro běžné uživatele
  - Základní přístup k sdíleným souborům

### Hardwarové skupiny
- **audio**
  - Přístup k zvukovým zařízením
  - Nutné pro přehrávání zvuku

- **video**
  - Přístup ke grafickým zařízením
  - Potřebné pro hardwarovou akceleraci

- **input**
  - Přístup k vstupním zařízením
  - Myš, klávesnice, joysticky

- **storage**
  - Přístup k úložným zařízením
  - Možnost připojovat/odpojovat disky

### Síťové skupiny
- **network**
  - Správa síťových rozhraní
  - ```bash
    # Povolení správy sítě
    usermod -aG network uzivatel
    ```

- **wireshark**
  - Přístup k síťovému sniffingu
  - Nutné pro analýzu síťového provozu

### Systémové služby
- **docker**
  - Přístup k Docker démonovi
  - ```bash
    # Povolení práce s Dockerem
    usermod -aG docker uzivatel
    ```

- **vboxusers**
  - Pro práci s VirtualBoxem
  - Přístup k USB zařízením ve VM

### Správa oprávnění pro skupiny

#### Doporučené nastavení
```bash
# Vytvoření sdílené skupiny pro projekt
groupadd projekt
usermod -aG projekt uzivatel1
usermod -aG projekt uzivatel2

# Nastavení sdíleného adresáře
mkdir /srv/projekt
chown :projekt /srv/projekt
chmod 2775 /srv/projekt  # SGID bit pro dědění skupiny
```

#### Hierarchie skupin
```bash
# Vývojářské skupiny
groupadd developers
groupadd frontend-dev
groupadd backend-dev

# Přidání podskupin
usermod -aG developers,frontend-dev frontend-uzivatel
usermod -aG developers,backend-dev backend-uzivatel
```

### Správa projektových skupin

#### Vytvoření projektové struktury
```bash
#!/bin/bash
create_project_structure() {
    local project=$1
    local group=$2
    
    # Vytvoření skupiny
    groupadd $group
    
    # Vytvoření adresářové struktury
    mkdir -p /srv/projects/$project/{src,docs,data}
    
    # Nastavení oprávnění
    chown -R :$group /srv/projects/$project
    chmod -R 2775 /srv/projects/$project
    
    # Nastavení ACL pro budoucí soubory
    setfacl -d -m g::rwx /srv/projects/$project
}
```

#### Automatická správa členství
```bash
#!/bin/bash
# Skript pro správu členství ve skupinách
manage_project_access() {
    local user=$1
    local project=$2
    local access_level=$3
    
    case $access_level in
        "read")
            setfacl -m u:$user:rx /srv/projects/$project
            ;;
        "write")
            setfacl -m u:$user:rwx /srv/projects/$project
            usermod -aG project-$project $user
            ;;
        "admin")
            usermod -aG project-$project-admin $user
            ;;
    esac
}
``` 

## Odkazy
- [Arch Wiki - Users and groups](https://wiki.archlinux.org/title/Users_and_groups)
- [Arch Wiki - Sudo](https://wiki.archlinux.org/title/Sudo)
- [Arch Wiki - Security](https://wiki.archlinux.org/title/Security)
