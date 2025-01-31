# Správa uživatelů - Užitečné příkazy

## Správa uživatelů
### Vytváření uživatelů
```bash
# Vytvoření nového uživatele
useradd uživatel

# Vytvoření uživatele s domovským adresářem
useradd -m uživatel

# Vytvoření uživatele s konkrétním shellem
useradd -m -s /bin/bash uživatel

# Vytvoření uživatele s popisem
useradd -m -c "Celé jméno" uživatel
```

### Modifikace uživatelů
```bash
# Změna hesla
passwd uživatel

# Změna shellu
chsh -s /bin/bash uživatel

# Změna domovského adresáře
usermod -d /nový/domov uživatel

# Uzamčení účtu
usermod -L uživatel

# Odemčení účtu
usermod -U uživatel
```

### Mazání uživatelů
```bash
# Smazání uživatele
userdel uživatel

# Smazání uživatele včetně domovského adresáře
userdel -r uživatel

# Smazání uživatele a všech jeho souborů
find / -user uživatel -delete
userdel -r uživatel
```

## Správa skupin
### Vytváření a mazání skupin
```bash
# Vytvoření nové skupiny
groupadd skupina

# Smazání skupiny
groupdel skupina

# Vytvoření systémové skupiny
groupadd -r skupina
```

### Správa členství ve skupinách
```bash
# Přidání uživatele do skupiny
usermod -aG skupina uživatel

# Přidání do více skupin najednou
usermod -aG skupina1,skupina2 uživatel

# Odebrání ze skupiny
gpasswd -d uživatel skupina

# Nastavení primární skupiny
usermod -g skupina uživatel
```

## Informace o účtech
### Zobrazení informací
```bash
# Informace o uživateli
id uživatel

# Seznam skupin uživatele
groups uživatel

# Informace o účtu
finger uživatel

# Detailní informace
getent passwd uživatel
```

### Monitorování
```bash
# Kdo je přihlášen
who
w

# Historie přihlášení
last

# Neúspěšné pokusy o přihlášení
lastb
```

## Oprávnění a sudo
### Správa sudo
```bash
# Editace sudo konfigurace
visudo

# Přidání uživatele do sudo skupiny
usermod -aG sudo uživatel

# Přidání do wheel skupiny (na některých systémech)
usermod -aG wheel uživatel
```

### Kontrola oprávnění
```bash
# Zobrazení sudo oprávnění
sudo -l

# Dočasné spuštění shellu jako jiný uživatel
su - uživatel

# Spuštění příkazu jako jiný uživatel
su - uživatel -c 'příkaz'
```

## Hromadná správa
### Dávkové operace
```bash
# Vytvoření více uživatelů ze souboru
while IFS=: read -r user pass; do
    useradd -m "$user"
    echo "$user:$pass" | chpasswd
done < users.txt

# Smazání více uživatelů
for user in user1 user2 user3; do
    userdel -r "$user"
done
```

### Zálohování a přenos
```bash
# Záloha informací o uživatelích
getent passwd > passwd.bak
getent group > group.bak

# Záloha domovských adresářů
tar -czf home_backup.tar.gz /home/
```

## Bezpečnost
### Kontrola hesel
```bash
# Nastavení požadavků na hesla
chage -M 90 uživatel  # Maximum dnů platnosti
chage -m 7 uživatel   # Minimum dnů mezi změnami
chage -W 7 uživatel   # Varování před expirací

# Vynucení změny hesla při příštím přihlášení
chage -d 0 uživatel
```

### Audit
```bash
# Kontrola prázdných hesel
awk -F: '($2 == "") {print $1}' /etc/shadow

# Kontrola UID 0 (root práva)
awk -F: '($3 == "0") {print $1}' /etc/passwd

# Seznam uživatelů s přihlašovacím shellem
grep -v '/nologin\|/false' /etc/passwd
```

## Užitečné aliasy
```bash
# Přidat do ~/.bashrc nebo ~/.zshrc
alias userlist='cut -d: -f1 /etc/passwd'
alias grouplist='cut -d: -f1 /etc/group'
alias sudoers='grep -Po "^%sudo.+ALL" /etc/sudoers'
``` 