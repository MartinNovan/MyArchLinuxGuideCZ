# Správa souborů - Užitečné příkazy

## Základní operace se soubory
### Vytváření a mazání
```bash
# Vytvoření souboru
touch soubor.txt

# Vytvoření adresáře
mkdir nový_adresář

# Vytvoření více vnořených adresářů
mkdir -p cesta/k/novému/adresáři

# Mazání souborů
rm soubor.txt

# Mazání adresářů
rm -r adresář
rm -rf adresář  # Vynucené mazání
```

### Kopírování a přesouvání
```bash
# Kopírování souboru
cp zdroj.txt cíl.txt

# Kopírování adresáře
cp -r zdrojový_adresář cílový_adresář

# Přesunutí/přejmenování
mv starý_název.txt nový_název.txt

# Přesunutí s potvrzením
mv -i soubor.txt nový/adresář/
```

## Vyhledávání souborů
### Find
```bash
# Vyhledání podle názvu
find /cesta -name "*.txt"

# Vyhledání podle velikosti
find /home -size +100M  # Větší než 100MB
find /home -size -1M    # Menší než 1MB

# Vyhledání podle data modifikace
find /home -mtime -7    # Změněno v posledních 7 dnech

# Vyhledání a provedení příkazu
find . -name "*.log" -exec rm {} \;
```

### Locate
```bash
# Rychlé vyhledání souboru
locate název_souboru

# Aktualizace databáze
sudo updatedb
```

## Práce s obsahem souborů
### Zobrazení obsahu
```bash
# Zobrazení celého souboru
cat soubor.txt

# Zobrazení s čísly řádků
nl soubor.txt

# Zobrazení po stránkách
less soubor.txt

# Zobrazení prvních/posledních řádků
head -n 10 soubor.txt
tail -n 10 soubor.txt
```

### Úprava obsahu
```bash
# Nahrazení textu
sed 's/starý/nový/g' soubor.txt

# Filtrování řádků
grep "hledaný_text" soubor.txt

# Počítání řádků/slov/znaků
wc soubor.txt
```

## Oprávnění a vlastnictví
### Změna oprávnění
```bash
# Změna pomocí čísel
chmod 755 soubor.txt

# Změna pomocí symbolů
chmod u+x soubor.txt    # Přidání práva spouštění pro vlastníka
chmod go-w soubor.txt   # Odebrání práva zápisu pro skupinu a ostatní

# Rekurzivní změna
chmod -R 755 adresář
```

### Změna vlastnictví
```bash
# Změna vlastníka
chown uživatel soubor.txt

# Změna vlastníka a skupiny
chown uživatel:skupina soubor.txt

# Rekurzivní změna
chown -R uživatel:skupina adresář
```

## Komprese a archivace
### Tar
```bash
# Vytvoření archivu
tar -czf archiv.tar.gz adresář/

# Rozbalení archivu
tar -xzf archiv.tar.gz

# Zobrazení obsahu archivu
tar -tvf archiv.tar.gz
```

### Zip/Unzip
```bash
# Vytvoření zip archivu
zip -r archiv.zip adresář/

# Rozbalení zip archivu
unzip archiv.zip

# Zobrazení obsahu zip archivu
unzip -l archiv.zip
```

## Monitoring a analýza
### Využití disku
```bash
# Zobrazení velikosti adresářů
du -sh *

# Zobrazení volného místa
df -h

# Analýza využití disku
ncdu /cesta
```

### Kontrola souborů
```bash
# Výpočet kontrolního součtu
md5sum soubor.txt
sha256sum soubor.txt

# Porovnání souborů
diff soubor1.txt soubor2.txt

# Kontrola typu souboru
file soubor
```

## Užitečné aliasy
```bash
# Přidat do ~/.bashrc nebo ~/.zshrc
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias df='df -h'
alias du='du -h'
```

## Pokročilé operace
```bash
# Hledání duplicitních souborů
fdupes -r /cesta

# Synchronizace adresářů
rsync -av zdroj/ cíl/

# Bezpečné mazání
shred -u soubor.txt

# Vytvoření symbolického odkazu
ln -s cílový_soubor název_odkazu
``` 