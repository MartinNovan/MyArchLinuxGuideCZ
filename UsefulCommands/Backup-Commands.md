# Zálohování - Užitečné příkazy

## Základní zálohování
### Rsync
```bash
# Základní záloha
rsync -av zdroj/ cíl/

# Záloha s vyloučením
rsync -av --exclude='*.tmp' zdroj/ cíl/

# Inkrementální záloha
rsync -av --link-dest=../záloha.1 zdroj/ záloha.0/

# Záloha přes SSH
rsync -avz -e ssh zdroj/ user@server:cíl/
```

### Tar
```bash
# Vytvoření archivu
tar -czf záloha.tar.gz /cesta/k/datům

# Extrakce archivu
tar -xzf záloha.tar.gz

# Inkrementální záloha
tar --create --listed-incremental=snapshot.file \
    --file=backup.1.tar /cesta/k/datům
```

## Systémové zálohy
### DD
```bash
# Záloha celého disku
dd if=/dev/sda of=/path/to/disk.img bs=4M status=progress

# Komprimovaná záloha
dd if=/dev/sda | gzip > disk.img.gz

# Obnova ze zálohy
dd if=disk.img of=/dev/sda bs=4M status=progress
```

### Clonezilla
```bash
# Záloha oddílu
clonezilla

# Klonování disku
clonezilla-live

# Obnova systému
clonezilla-restore
```

## Databázové zálohy
### MySQL/MariaDB
```bash
# Záloha databáze
mysqldump -u user -p databáze > záloha.sql

# Záloha všech databází
mysqldump -u root -p --all-databases > all_db.sql

# Obnova databáze
mysql -u user -p databáze < záloha.sql
```

### PostgreSQL
```bash
# Záloha databáze
pg_dump databáze > záloha.sql

# Záloha všech databází
pg_dumpall > all_db.sql

# Obnova databáze
psql databáze < záloha.sql
```

## Automatizace záloh
### Cron úlohy
```bash
# Denní záloha
0 2 * * * rsync -av /data/ /backup/

# Týdenní záloha
0 2 * * 0 tar -czf /backup/weekly.tar.gz /data/

# Měsíční záloha
0 2 1 * * mysqldump -u root -p"heslo" --all-databases > /backup/monthly_db.sql
```

### Skripty
```bash
#!/bin/bash
# Rotace záloh
mv backup.2 backup.3
mv backup.1 backup.2
mv backup.0 backup.1
rsync -av --link-dest=../backup.1 /data/ backup.0/
```

## Síťové zálohy
### Vzdálené zálohy
```bash
# Záloha na NFS
mount -t nfs server:/backup /mnt/backup
rsync -av /data/ /mnt/backup/

# Záloha přes SSH
scp -r /data/ user@server:/backup/

# Záloha pomocí rclone
rclone sync /data/ remote:backup/
```

### Cloud zálohy
```bash
# AWS S3
aws s3 sync /data/ s3://bucket/backup/

# Google Cloud Storage
gsutil -m rsync -r /data/ gs://bucket/backup/

# Rclone s cloud službami
rclone sync /data/ gdrive:backup/
```

## Šifrované zálohy
### GPG
```bash
# Šifrovaná záloha
tar -czf - /data/ | gpg -c > backup.tar.gz.gpg

# Dešifrování zálohy
gpg -d backup.tar.gz.gpg | tar -xzf -

# Šifrovaná síťová záloha
tar -czf - /data/ | gpg -e -r "user" | ssh user@server "cat > backup.gpg"
```

## Monitoring záloh
### Kontrola
```bash
# Kontrola integrity tar archivu
tar -tvf záloha.tar.gz

# Kontrola rsync logu
grep -i "error" /var/log/rsync.log

# Kontrola volného místa
df -h /backup
```

## Užitečné aliasy
```bash
# Přidat do ~/.bashrc nebo ~/.zshrc
alias backup='rsync -av --progress'
alias backup-db='mysqldump -u root -p'
alias check-backup='tar -tvf'
```

## Obnova dat
```bash
# Test obnovy
tar -tzvf záloha.tar.gz

# Selektivní obnova
tar -xzf záloha.tar.gz cesta/k/souboru

# Obnova s přepisem
rsync -av --delete záloha/ /data/
``` 