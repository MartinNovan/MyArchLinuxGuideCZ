# Synchronizace dat - Užitečné příkazy

## Rsync
### Základní synchronizace
```bash
# Základní synchronizace
rsync -av zdroj/ cíl/

# Synchronizace s vymazáním
rsync -av --delete zdroj/ cíl/

# Synchronizace přes SSH
rsync -avz -e ssh zdroj/ user@server:cíl/

# Dry run (test)
rsync -av --dry-run zdroj/ cíl/
```

### Pokročilé možnosti
```bash
# Vyloučení souborů
rsync -av --exclude='*.tmp' zdroj/ cíl/

# Zachování oprávnění
rsync -avp zdroj/ cíl/

# Omezení šířky pásma
rsync -av --bwlimit=1000 zdroj/ cíl/

# Inkrementální zálohy
rsync -av --link-dest=../backup.1 zdroj/ backup.0/
```

## Unison
### Základní použití
```bash
# Synchronizace dvou adresářů
unison dir1 dir2

# Synchronizace s profilem
unison profil

# Automatická synchronizace
unison -batch profil

# Synchronizace přes SSH
unison local ssh://user@host//path
```

### Konfigurace
```bash
# Vytvoření profilu
# ~/.unison/profil.prf
root = /cesta/k/dir1
root = ssh://user@host//cesta/k/dir2
ignore = Name *.tmp
```

## Syncthing
### Správa služby
```bash
# Start služby
systemctl start syncthing@user

# Povolení při startu
systemctl enable syncthing@user

# Kontrola stavu
systemctl status syncthing@user
```

### Konfigurace
```bash
# Webové rozhraní
http://localhost:8384

# Konfigurace přes CLI
syncthing cli
```

## Git
### Základní synchronizace
```bash
# Klonování repozitáře
git clone url

# Stažení změn
git pull

# Odeslání změn
git push

# Synchronizace všech větví
git fetch --all
```

### Pokročilé operace
```bash
# Synchronizace konkrétní větve
git pull origin větev

# Synchronizace s rebase
git pull --rebase

# Synchronizace submodulů
git submodule update --init --recursive
```

## Rclone
### Základní operace
```bash
# Synchronizace do cloudu
rclone sync zdroj remote:cíl

# Kopírování souborů
rclone copy zdroj remote:cíl

# Výpis obsahu
rclone ls remote:cesta

# Test konfigurace
rclone check zdroj remote:cíl
```

### Cloud služby
```bash
# Google Drive
rclone sync /local/path gdrive:backup

# Dropbox
rclone sync /local/path dropbox:backup

# OneDrive
rclone sync /local/path onedrive:backup
```

## Automatická synchronizace
### Inotify
```bash
# Sledování změn
inotifywait -m -r -e modify,create,delete /cesta

# Automatická synchronizace
while inotifywait -r -e modify,create,delete /zdroj; do
    rsync -av /zdroj/ /cíl/
done
```

### Cron úlohy
```bash
# Pravidelná synchronizace
*/15 * * * * rsync -av /zdroj/ /cíl/

# Denní synchronizace
0 2 * * * unison -batch profil

# Týdenní plná synchronizace
0 3 * * 0 rsync -av --delete /zdroj/ /cíl/
```

## Síťová synchronizace
### NFS
```bash
# Připojení NFS
mount -t nfs server:/sdílení /mnt/point

# Automatické připojení (fstab)
server:/sdílení /mnt/point nfs defaults 0 0

# Synchronizace s NFS
rsync -av /data/ /mnt/point/
```

### Samba
```bash
# Připojení Samba sdílení
mount -t cifs //server/share /mnt/point -o user=uživatel

# Synchronizace se Samba
rsync -av /data/ /mnt/point/

# Automatické připojení
//server/share /mnt/point cifs credentials=/etc/samba/credentials 0 0
```

## Monitoring synchronizace
### Logy a notifikace
```bash
# Logování rsync
rsync -av --log-file=sync.log zdroj/ cíl/

# Email notifikace
rsync -av zdroj/ cíl/ && mail -s "Sync complete" admin@example.com

# Monitoring chyb
tail -f sync.log | grep "error"
```

### Statistiky
```bash
# Statistiky přenosu
rsync -av --stats zdroj/ cíl/

# Průběh synchronizace
rsync -av --progress zdroj/ cíl/

# Detailní statistiky
rsync -av --info=progress2 zdroj/ cíl/
```

## Užitečné aliasy
```bash
# Přidat do ~/.bashrc nebo ~/.zshrc
alias rsync-safe='rsync -av --dry-run'
alias rsync-sync='rsync -av --delete'
alias rsync-backup='rsync -av --backup --backup-dir'
alias unison-auto='unison -batch'
```

## Řešení problémů
```bash
# Debug mód
rsync -avv --progress zdroj/ cíl/

# Kontrola připojení
ping server
nc -zv server 22

# Kontrola oprávnění
ls -la /zdroj/
ls -la /cíl/
```

## Bezpečnost
```bash
# SSH klíče pro automatickou synchronizaci
ssh-keygen -t ed25519
ssh-copy-id user@server

# Omezení přístupu
chmod 600 ~/.ssh/config
chmod 700 ~/.ssh

# Šifrovaný přenos
rsync -av -e "ssh -c aes256-gcm@openssh.com" zdroj/ cíl/