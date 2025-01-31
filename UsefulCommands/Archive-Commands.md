# Práce s archivy - Užitečné příkazy

## Tar
### Základní operace
```bash
# Vytvoření archivu
tar -czf archiv.tar.gz soubory/

# Rozbalení archivu
tar -xzf archiv.tar.gz

# Výpis obsahu
tar -tvf archiv.tar.gz

# Přidání do archivu
tar -rf archiv.tar soubor
```

### Pokročilé možnosti
```bash
# Komprese s různými algoritmy
tar -cjf archiv.tar.bz2 soubory/  # bzip2
tar -cJf archiv.tar.xz soubory/   # xz
tar --zstd -cf archiv.tar.zst soubory/  # zstd

# Vyloučení souborů
tar -czf archiv.tar.gz --exclude='*.tmp' soubory/

# Zachování oprávnění
tar -czpf archiv.tar.gz soubory/
```

## Zip/Unzip
### Základní operace
```bash
# Vytvoření zip archivu
zip -r archiv.zip soubory/

# Rozbalení zip archivu
unzip archiv.zip

# Výpis obsahu
unzip -l archiv.zip

# Testování archivu
unzip -t archiv.zip
```

### Pokročilé možnosti
```bash
# Komprese s heslem
zip -e archiv.zip soubory/

# Aktualizace existujícího archivu
zip -u archiv.zip nové_soubory/

# Rozdělení na části
zip -s 10m archiv.zip soubory/
```

## 7-Zip
### Základní operace
```bash
# Vytvoření archivu
7z a archiv.7z soubory/

# Rozbalení archivu
7z x archiv.7z

# Výpis obsahu
7z l archiv.7z

# Test integrity
7z t archiv.7z
```

### Pokročilé možnosti
```bash
# Nastavení úrovně komprese
7z a -mx=9 archiv.7z soubory/

# Šifrování
7z a -p archiv.7z soubory/

# Rozdělení na části
7z a -v100m archiv.7z soubory/
```

## Rar
### Základní operace
```bash
# Vytvoření archivu
rar a archiv.rar soubory/

# Rozbalení archivu
unrar x archiv.rar

# Výpis obsahu
unrar l archiv.rar

# Test archivu
unrar t archiv.rar
```

### Pokročilé možnosti
```bash
# Vytvoření SFX archivu
rar a -sfx archiv.exe soubory/

# Oprava poškozeného archivu
rar r archiv.rar

# Šifrování
rar a -p archiv.rar soubory/
```

## Komprese souborů
### Gzip
```bash
# Komprese souboru
gzip soubor

# Dekomprese
gunzip soubor.gz

# Zachování originálu
gzip -k soubor

# Test integrity
gzip -t soubor.gz
```

### Bzip2
```bash
# Komprese souboru
bzip2 soubor

# Dekomprese
bunzip2 soubor.bz2

# Zachování originálu
bzip2 -k soubor

# Komprese s maximální kompresí
bzip2 -9 soubor
```

## Správa archivů
### Konverze formátů
```bash
# Konverze tar.gz na zip
tar -xzf archiv.tar.gz && zip -r archiv.zip soubory/

# Konverze zip na 7z
7z a archiv.7z archiv.zip

# Extrakce a překomprese
tar -xzf old.tar.gz && tar -cjf new.tar.bz2 soubory/
```

### Údržba
```bash
# Kontrola integrity
tar -tvf archiv.tar.gz
unzip -t archiv.zip
7z t archiv.7z

# Oprava poškozených archivů
zip -F archiv.zip --out opraveny.zip
rar r archiv.rar
```

## Užitečné aliasy
```bash
# Přidat do ~/.bashrc nebo ~/.zshrc
alias targz='tar -czf'
alias untargz='tar -xzf'
alias zipdir='zip -r'
alias 7zc='7z a'
alias 7zx='7z x'
```

## Automatizace
```bash
# Automatická komprese logů
#!/bin/bash
find /var/log -name "*.log" -mtime +7 -exec gzip {} \;

# Pravidelné archivování
#!/bin/bash
tar -czf backup-$(date +%Y%m%d).tar.gz /data/
find . -name "backup-*.tar.gz" -mtime +30 -delete
``` 