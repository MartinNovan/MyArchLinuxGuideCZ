# Desktopová prostředí a správci přihlášení

## Úvod
Tento dokument podrobně popisuje různé desktopová prostředí (DE) a správce přihlášení (DM) dostupné v Arch Linuxu, včetně jejich výhod, nevýhod, konfigurace a doporučeného použití.

## Desktopová prostředí (DE - Desktop Enviroments)

### KDE Plasma
**Výhody:**
- Vysoce přizpůsobitelné (widgety, panely, efekty)
- Moderní vzhled s efektním kompozitingem
- Široká podpora aplikací (KDE aplikace)
- Integrovaný systém nastavení

**Nevýhody:**
- Vyšší nároky na systémové zdroje (RAM, CPU)
- Složitější konfigurace (mnoho možností)
- Někdy nestabilní (hlavně s vlastními efekty)

**Instalace:**
```bash
sudo pacman -S plasma-meta kde-applications-meta
```

**Konfigurace:**
- System Settings → Vlastní nastavení
- KWin kompozitor → Efekty
- Plasma Widgets → Přidat widgety

### GNOME
**Výhody:**
- Jednoduché a intuitivní (minimalistické)
- Dobrá podpora Wayland (výchozí od GNOME 40)
- Integrované aplikations (GNOME Software, Files)
- Touch-friendly rozhraní

**Nevýhody:**
- Méně přizpůsobitelné (omezené rozšíření)
- Vyšší nároky na systémové zdroje
- GNOME Shell může být pro některé neintuitivní

**Instalace:**
```bash
sudo pacman -S gnome gnome-extra
```

**Konfigurace:**
- GNOME Tweaks → Rozšíření
- GNOME Software → Aplikace
- dconf Editor → Pokročilé nastavení

### XFCE
**Výhody:**
- Lehké a rychlé (nízké nároky na zdroje)
- Vysoce přizpůsobitelné (panely, menu)
- Stabilní a spolehlivé
- Ideální pro starší hardware

**Nevýhody:**
- Starší vzhled (méně moderní)
- Méně moderních funkcí (omezený kompoziting)
- Omezená podpora Wayland

**Instalace:**
```bash
sudo pacman -S xfce4 xfce4-goodies
```

**Konfigurace:**
- XFCE Settings Manager → Všechna nastavení
- Panel → Přidat/odebrat položky
- Window Manager → Styly a efekty

### MATE
**Výhody:**
- Tradiční vzhled (inspirováno GNOME 2)
- Nízké nároky na systémové zdroje
- Dobrá stabilita a spolehlivost
- Snadné přechod z GNOME 2

**Nevýhody:**
- Méně moderních funkcí (omezené efekty)
- Omezená podpora Wayland
- Menší komunita

**Instalace:**
```bash
sudo pacman -S mate mate-extra
```

**Konfigurace:**
- MATE Control Center → Všechna nastavení
- Panel → Přizpůsobení
- Window Manager → Styly a efekty

### Hyprland
**Výhody:**
- Moderní Wayland kompozitor
- Vysoce přizpůsobitelné (animace, efekty)
- Dobrá podpora HiDPI
- Aktivní vývoj

**Nevýhody:**
- Méně zralá technologie
- Omezená podpora aplikací
- Vyžaduje ruční konfiguraci

**Instalace:**
```bash
yay -S hyprland
```

**Konfigurace:**
```bash
mkdir -p ~/.config/hypr
nano ~/.config/hypr/hyprland.conf
```

### Sway
**Výhody:**
- Wayland alternativa k i3
- Nízké nároky na systémové zdroje
- Dobrá podpora HiDPI
- Snadná konfigurace

**Nevýhody:**
- Omezená podpora aplikací
- Vyžaduje ruční konfiguraci
- Méně efektů než Hyprland

**Instalace:**
```bash
sudo pacman -S sway
```

**Konfigurace:**
```bash
mkdir -p ~/.config/sway
cp /etc/sway/config ~/.config/sway/
nano ~/.config/sway/config
```

### i3
**Výhody:**
- Lehké a rychlé
- Vysoce přizpůsobitelné
- Široká podpora aplikací
- Velká komunita

**Nevýhody:**
- Pouze X11 (žádná podpora Wayland)
- Vyžaduje ruční konfiguraci
- Méně efektů než moderní WM

**Instalace:**
```bash
sudo pacman -S i3
```

**Konfigurace:**
```bash
mkdir -p ~/.config/i3
cp /etc/i3/config ~/.config/i3/
nano ~/.config/i3/config
```

### Budgie
**Výhody:**
- Moderní vzhled
- Integrované aplikace
- Dobrá stabilita
- Snadné použití

**Nevýhody:**
- Vyšší nároky na systémové zdroje
- Menší komunita
- Omezená podpora Wayland

**Instalace:**
```bash
sudo pacman -S budgie-desktop
```

**Konfigurace:**
- Budgie Settings → Všechna nastavení
- Raven → Přizpůsobení panelu
- Applets → Přidat/odebrat applety

### Cinnamon
**Výhody:**
- Tradiční vzhled (inspirováno GNOME 3)
- Snadné použití
- Dobrá stabilita
- Integrované aplikace

**Nevýhody:**
- Vyšší nároky na systémové zdroje
- Omezená podpora Wayland
- Menší komunita

**Instalace:**
```bash
sudo pacman -S cinnamon
```

**Konfigurace:**
- Cinnamon Settings → Všechna nastavení
- Panel → Přizpůsobení
- Applets → Přidat/odebrat applety

## Správci přihlášení (DM - Display Managers)

### GDM (GNOME Display Manager)
**Výhody:**
- Integrace s GNOME (výchozí pro GNOME)
- Podpora Wayland (výchozí od GNOME 40)
- Moderní vzhled (animace, pozadí)
- Automatické detekce monitorů

**Nevýhody:**
- Vyšší nároky na systémové zdroje
- Omezená přizpůsobitelnost
- Problémy s některými tématy

**Instalace:**
```bash
sudo pacman -S gdm
```

**Konfigurace:**
```bash
sudo nano /etc/gdm/custom.conf
```
```ini
[daemon]
WaylandEnable=true
AutomaticLoginEnable=true
AutomaticLogin=username
```

### SDDM (Simple Desktop Display Manager)
**Výhody:**
- Integrace s KDE (výchozí pro KDE)
- Přizpůsobitelné (témata, pozadí)
- Nízké nároky na systémové zdroje
- Podpora Wayland

**Nevýhody:**
- Méně moderních funkcí
- Omezená podpora Wayland
- Problémy s některými tématy

**Instalace:**
```bash
sudo pacman -S sddm
```

**Konfigurace:**
```bash
sudo nano /etc/sddm.conf
```
```ini
[Theme]
Current=breeze
CursorTheme=breeze_cursors
```

### LightDM
**Výhody:**
- Lehké a rychlé (nízké nároky na zdroje)
- Vysoce přizpůsobitelné (různé greetery)
- Podpora různých DE
- Snadná konfigurace

**Nevýhody:**
- Základní vzhled
- Omezená podpora Wayland
- Problémy s některými tématy

**Instalace:**
```bash
sudo pacman -S lightdm lightdm-gtk-greeter
```

**Konfigurace:**
```bash
sudo nano /etc/lightdm/lightdm.conf
```
```ini
[Seat:*]
greeter-session=lightdm-gtk-greeter
user-session=xfce
```

## Display Servers a Compository (DS - Display Servers)

Tato sekce popisuje různé technologie pro zobrazování a správu oken v Linuxu.

### X.Org (X11)
**Výhody:**
- Zralá technologie (desítky let vývoje)
- Široká podpora aplikací (včetně starších)
- Dobrá stabilita (prokázaná v praxi)
- Podpora více monitorů (včetně různých DPI)

**Nevýhody:**
- Složitá architektura (starší design)
- Problémy s bezpečností (X11 forwarding)
- Omezená podpora HiDPI (špatné škálování)
- Problémy s moderními funkcemi (sync, tearing)

**Technologie:**
- **Display Server**: X.Org Server
- **Compositor**: Samostatný (Compiz, Picom) nebo integrovaný (KWin, Mutter)

### Wayland
**Výhody:**
- Moderní architektura (jednodušší design)
- Lepší bezpečnost (izolované klienty)
- Lepší podpora HiDPI (automatické škálování)
- Lepší výkon (méně overheadu)

**Nevýhody:**
- Méně zralá technologie (stále ve vývoji)
- Omezená podpora aplikací (hlavně starší)
- Problémy s některými funkcemi (screenshoty)
- Omezená podpora více monitorů (různé DPI)

**Technologie:**
- **Display Server + Compositor**: Wayland compositor (Weston, Sway, Hyprland)
- **Integrované**: Compositor je přímo součástí Wayland serveru

### XWayland
**Výhody:**
- Kompatibilita s X11 aplikacemi
- Integrace s Wayland
- Automatické použití pro starší aplikace

**Nevýhody:**
- Dodatečná režie (X11 emulace)
- Omezená podpora některých funkcí
- Problémy s výkonem

**Technologie:**
- **Emulace X11**: XWayland běží jako Wayland klient
- **Automatické použití**: Pro aplikace, které nepodporují Wayland

## Doporučené postupy

1. **Výběr DE**
   - Zvažte své potřeby a hardware
   - Vyzkoušejte různé DE (live USB)
   - Používejte to, co vám vyhovuje

2. **Konfigurace**
   - Pravidelně zálohujte konfigurační soubory
   - Experimentujte s různými nastaveními
   - Sledujte novinky v komunitě

3. **Aktualizace**
   - Pravidelně aktualizujte DE a DM
   - Sledujte změny v podpoře Wayland
   - Testujte nové funkce

## Užitečné odkazy
- [Arch Wiki - Desktop environment](https://wiki.archlinux.org/title/Desktop_environment)
- [Arch Wiki - Display manager](https://wiki.archlinux.org/title/Display_manager)
- [Arch Wiki - Wayland](https://wiki.archlinux.org/title/Wayland)
- [KDE Plasma](https://kde.org/plasma-desktop/)
- [GNOME](https://www.gnome.org/)
- [XFCE](https://www.xfce.org/)
- [MATE](https://mate-desktop.org/)
- [Hyprland](https://hyprland.org/)
- [Sway](https://swaywm.org/)
- [i3](https://i3wm.org/)
- [Budgie](https://buddiesofbudgie.org/)
- [Cinnamon](https://projects.linuxmint.com/cinnamon/) 