# Šifrování - Užitečné příkazy

## GPG (GnuPG)
### Správa klíčů
```bash
# Generování nového klíče
gpg --full-generate-key

# Seznam klíčů
gpg --list-keys
gpg --list-secret-keys

# Export klíčů
gpg --export -a "User Name" > public.key
gpg --export-secret-key -a "User Name" > private.key

# Import klíčů
gpg --import public.key
```

### Šifrování souborů
```bash
# Šifrování pro příjemce
gpg -e -r "příjemce" soubor

# Šifrování s heslem
gpg -c soubor

# Dešifrování
gpg -d soubor.gpg

# Podepsání souboru
gpg --sign soubor
```

## LUKS (Disk Encryption)
### Základní operace
```bash
# Vytvoření šifrovaného oddílu
cryptsetup luksFormat /dev/sdX

# Otevření oddílu
cryptsetup open /dev/sdX název

# Zavření oddílu
cryptsetup close název

# Formátování
mkfs.ext4 /dev/mapper/název
```

### Správa LUKS
```bash
# Informace o šifrování
cryptsetup luksDump /dev/sdX

# Přidání záložního klíče
cryptsetup luksAddKey /dev/sdX

# Odebrání klíče
cryptsetup luksRemoveKey /dev/sdX

# Změna hesla
cryptsetup luksChangeKey /dev/sdX
```

## SSL/TLS
### Certifikáty
```bash
# Generování self-signed certifikátu
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout private.key -out certificate.crt

# Generování CSR
openssl req -new -newkey rsa:2048 -nodes \
    -keyout private.key -out request.csr

# Kontrola certifikátu
openssl x509 -in certificate.crt -text
```

### Testování SSL
```bash
# Test SSL spojení
openssl s_client -connect host:443

# Test SSL konfigurace
nmap --script ssl-enum-ciphers -p 443 host

# Kontrola platnosti certifikátu
echo | openssl s_client -servername host -connect host:443 2>/dev/null | openssl x509 -noout -dates
```

## Další nástroje
### VeraCrypt
```bash
# Vytvoření kontejneru
veracrypt -c

# Připojení kontejneru
veracrypt soubor /mnt/point

# Odpojení
veracrypt -d
```

### ccrypt
```bash
# Šifrování souboru
ccrypt soubor.txt

# Dešifrování
ccrypt -d soubor.txt.cpt

# Změna hesla
ccrypt -x soubor.txt.cpt
```

## Hashování
### Generování hashů
```bash
# MD5
md5sum soubor

# SHA-256
sha256sum soubor

# SHA-512
sha512sum soubor

# Kontrola hashů
sha256sum -c hash.txt
```

## Bezpečné mazání
### Secure deletion
```bash
# Přepsání souboru
shred -u soubor

# Vícenásobné přepsání
shred -n 7 -u soubor

# Přepsání celého oddílu
dd if=/dev/urandom of=/dev/sdX bs=4M status=progress
```

## Užitečné aliasy
```bash
# Přidat do ~/.bashrc nebo ~/.zshrc
alias encrypt='gpg -c'
alias decrypt='gpg -d'
alias secure-delete='shred -u'
alias checksum='sha256sum'
```

## Automatizace
```bash
# Automatické šifrování
#!/bin/bash
for file in *.txt; do
    gpg -c "$file"
    rm "$file"
done

# Automatické zálohování šifrovaných dat
#!/bin/bash
tar czf - /důležitá/data | gpg -c > backup.tar.gz.gpg
``` 