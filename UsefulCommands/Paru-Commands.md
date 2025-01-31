# Paru - Užitečné příkazy

## Základní operace
### Instalace balíčků
```bash
# Instalace balíčku
paru -S název_balíčku

# Instalace bez potvrzení
paru -S --noconfirm název_balíčku

# Instalace pouze AUR balíčků
paru -Sa název_balíčku
```

### Aktualizace systému
```bash
# Aktualizace všech balíčků
paru -Syu

# Aktualizace pouze AUR balíčků
paru -Sua

# Vynucená aktualizace
paru -Syyu
```

## Vyhledávání
```bash
# Vyhledání balíčku
paru -Ss klíčové_slovo

# Vyhledání pouze v AUR
paru -Sa klíčové_slovo

# Zobrazení informací o balíčku
paru -Si název_balíčku
```

## Správa balíčků
```bash
# Odstranění balíčku
paru -R název_balíčku

# Odstranění balíčku a závislostí
paru -Rs název_balíčku

# Vyčištění mezipaměti
paru -Sc

# Úplné vyčištění mezipaměti
paru -Scc
```

## Práce se zdrojovými kódy
```bash
# Stažení PKGBUILD
paru -G název_balíčku

# Zobrazení PKGBUILD
paru -Gp název_balíčku

# Editace PKGBUILD před instalací
PARU_EDITOR=vim paru -S název_balíčku
```

## Pokročilé funkce
```bash
# Zobrazení news z arch linux
paru -Pw

# Zobrazení závislostí
paru -Si název_balíčku

# Kontrola aktualizací bez instalace
paru -Qu
```

## Údržba systému
```bash
# Seznam osiřelých balíčků
paru -Qtd

# Odstranění osiřelých balíčků
paru -Rns $(paru -Qtdq)

# Kontrola problémů v systému
paru -Dk
```

## Užitečné aliasy
```bash
# Přidat do ~/.bashrc nebo ~/.zshrc
alias pain='paru -S'              # Instalace
alias pass='paru -Ss'            # Vyhledávání
alias paup='paru -Syu'           # Aktualizace
alias paupf='paru -Syyu'         # Vynucená aktualizace
```

## Řešení problémů
```bash
# Přeinstalace balíčku
paru -S --rebuildall název_balíčku

# Vynucená instalace
paru -S --overwrite "*" název_balíčku

# Debug mód
PARU_DEBUG=1 paru -S název_balíčku
```
