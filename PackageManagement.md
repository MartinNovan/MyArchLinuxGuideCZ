# Správa balíčků v Arch Linux

## Úvod
Arch Linux používá vlastní balíčkovací systém `pacman` (Package Manager) spolu s AUR (Arch User Repository). Tento systém je jedním z hlavních pilířů filozofie Arch Linuxu - jednoduchý a transparentní přístup ke správě systému.

## Pacman
### Základní koncept
Pacman je:
- Nativní správce balíčků pro Arch Linux
- Kombinuje jednoduchou binární balíčkovací databázi s jednoduchým build systémem
- Umožňuje snadnou správu balíčků, ať už z oficiálních repozitářů nebo vlastních zdrojů

### Repozitáře
Arch Linux používá několik oficiálních repozitářů:
- **core** - Základní balíčky potřebné pro funkční systém
- **extra** - Balíčky, které nejsou nezbytné pro základní systém
- **community** - Balíčky spravované důvěryhodnými uživateli (TU)
- **multilib** - 32bitové knihovny a aplikace pro 64bitové systémy
- **testing** - Testovací verze balíčků před vydáním do core/extra
- **community-testing** - Testovací verze balíčků před vydáním do community

### Formát balíčků
Balíčky v Arch Linuxu:
- Používají příponu `.pkg.tar.zst`
- Obsahují:
  - Binární soubory
  - Konfigurační soubory
  - Metadata (závislosti, verze, atd.)
  - Instalační skripty (volitelné)

## AUR (Arch User Repository)
### Co je AUR?
- Komunitní repozitář uživatelsky vytvořených balíčků
- Obsahuje PKGBUILD soubory (skripty pro sestavení balíčků)
- Není přímo podporován Arch Linux týmem
- Vyžaduje ruční sestavení balíčků

### Jak AUR funguje
1. Uživatel stáhne PKGBUILD a související soubory
2. Zkontroluje obsah PKGBUILD (důležité pro bezpečnost)
3. Sestaví balíček pomocí `makepkg`
4. Nainstaluje výsledný balíček pomocí `pacman`

### AUR Helpers
Populární AUR helpers:
- **yay** - Napsaný v Go, velmi populární
- **paru** - Napsaný v Rust, respektuje systémové nastavení
- **pikaur** - Pythonová alternativa
- **aurman** - Pokročilé funkce pro řešení závislostí

## Správa balíčků

### Základní operace
```bash
# Instalace balíčku
pacman -S balíček

# Odstranění balíčku
pacman -R balíček
pacman -Rs balíček  # Včetně závislostí

# Aktualizace systému
pacman -Syu

# Vyhledávání balíčků
pacman -Ss klíčové_slovo

# Informace o balíčku
pacman -Si balíček
```

### Pokročilé operace
```bash
# Čištění cache
pacman -Sc  # Staré verze
pacman -Scc # Všechny cache

# Seznam nainstalovaných balíčků
pacman -Q
pacman -Qe  # Explicitně instalované

# Ověření integrity systému
pacman -Qk

# Vynucená reinstalace
pacman -S --force balíček
```

## Konfigurace
### Hlavní konfigurační soubor
Umístění: `/etc/pacman.conf`
```ini
# Příklad konfigurace
[options]
HoldPkg     = pacman glibc
Architecture = auto
CheckSpace
SigLevel    = Required DatabaseOptional
LocalFileSigLevel = Optional

# Příklad repozitáře
[core]
Include = /etc/pacman.d/mirrorlist

[extra]
Include = /etc/pacman.d/mirrorlist
```

### Mirrorlist
Umístění: `/etc/pacman.d/mirrorlist`
- Seznam zrcadel pro stahování balíčků
- Seřazen podle rychlosti a dostupnosti
- Lze aktualizovat pomocí `reflector`

## Bezpečnost
### Podpisy balíčků
- Všechny oficiální balíčky jsou digitálně podepsané
- Správa klíčů pomocí `pacman-key`
```bash
# Inicializace keyring
pacman-key --init

# Aktualizace klíčů
pacman-key --refresh-keys

# Přidání klíče
pacman-key --add soubor.key
pacman-key --lsign-key ID_KLÍČE
```

### Ověřování balíčků
```bash
# Kontrola podpisů
pacman -V balíček.pkg.tar.zst

# Kontrola databáze
pacman -Dk

# Kontrola souborů
pacman -Qk balíček
```

## Řešení problémů
### Časté problémy
1. Konflikt souborů
```bash
# Řešení
pacman -S --force balíček
```

2. Poškozená databáze
```bash
# Obnovení databáze
rm /var/lib/pacman/sync/*
pacman -Syy
```

3. Závislosti nelze vyřešit
```bash
# Aktualizace databáze
pacman -Syy
# Kontrola rozbitých závislostí
pacman -Dk
```

### Údržba systému
```bash
# Pravidelná údržba
pacman -Syu  # Aktualizace systému
paccache -r  # Vyčištění cache
pacman -Rns $(pacman -Qtdq)  # Odstranění sirotků
```

## Doporučené postupy
1. **Pravidelné aktualizace**
   - Aktualizujte systém pravidelně
   - Čtěte oznámení před aktualizací
   - Zálohujte před velkými aktualizacemi

2. **Bezpečnost**
   - Kontrolujte PKGBUILD před instalací z AUR
   - Používejte pouze důvěryhodné zdroje
   - Udržujte aktuální klíče

3. **Optimalizace**
   - Pravidelně čistěte cache
   - Odstraňujte nepotřebné balíčky
   - Udržujte čistý systém bez sirotků

## Užitečné nástroje
- **reflector** - Správa mirrorlistu
- **pkgfile** - Vyhledávání souborů v balíčcích
- **pacgraph** - Vizualizace závislostí
- **namcap** - Kontrola kvality balíčků

## Odkazy
- [Arch Wiki - Pacman](https://wiki.archlinux.org/title/Pacman)
- [Arch Wiki - AUR](https://wiki.archlinux.org/title/Arch_User_Repository)
- [Arch Linux - Oficiální repozitáře](https://archlinux.org/packages/)

## Přípony balíčků
### Běžné přípony v AUR a oficiálních repozitářích

#### Typ sestavení
- **-bin** - Předkompilovaná binární verze programu
  - Rychlejší instalace
  - Nevyžaduje kompilaci
  - Příklad: `discord-bin` vs `discord`

- **-git** - Verze přímo z Git repozitáře
  - Nejnovější vývojová verze
  - Může být nestabilní
  - Příklad: `neovim-git` vs `neovim`

- **-stable** - Stabilní verze programu
  - Důraz na stabilitu
  - Méně časté aktualizace
  - Příklad: `nginx-stable` vs `nginx`

#### Jazykové varianty
- **-python** - Python implementace
  - Napsáno v Pythonu nebo Python binding
  - Příklad: `meson-python`

- **-rust** - Rust implementace
  - Napsáno v Rustu
  - Příklad: `ripgrep-rust`

#### Funkční varianty
- **-debug** - Verze s debug symboly
  - Užitečné pro vývoj a debugování
  - Větší velikost
  - Příklad: `firefox-debug`

- **-nox** - Verze bez X závislostí
  - Pro systémy bez GUI
  - Minimální závislosti
  - Příklad: `vim-nox`

#### Vývojové verze
- **-dev** - Vývojová verze
  - Podobné jako -git
  - Nejnovější funkce
  - Příklad: `wine-dev`

- **-svn** - Verze ze Subversion repozitáře
  - Podobné jako -git
  - Příklad: `package-svn`

#### Architektura
- **-x86_64** - 64-bitová verze
  - Pro moderní systémy
  - Příklad: `steam-x86_64`

- **-i686** - 32-bitová verze
  - Pro starší systémy
  - Příklad: `lib32-package`

### Doporučení pro výběr verze
1. **Standardní použití**
   - Používejte verze bez přípon
   - Jsou obvykle nejlépe testované
   - Příklad: `firefox`

2. **Rychlá instalace**
   - Použijte -bin verze
   - Vhodné pro velké programy
   - Příklad: `android-studio-bin`

3. **Nejnovější funkce**
   - Použijte -git nebo -dev verze
   - Počítejte s možnou nestabilitou
   - Příklad: `neovim-git`

4. **Produkční servery**
   - Preferujte -stable verze
   - Vyhněte se -git a -dev verzím
   - Příklad: `nginx-stable`