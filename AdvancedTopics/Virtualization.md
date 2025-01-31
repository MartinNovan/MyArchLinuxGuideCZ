# Virtualizace v Arch Linuxu

## Úvod
Virtualizace umožňuje spouštět více operačních systémů na jednom fyzickém stroji. Tento dokument popisuje nastavení a použití různých virtualizačních technologií v Arch Linuxu.

## Porovnání technologií

### KVM/QEMU
**Výhody:**
- Plná virtualizace (Type 1 hypervisor)
- Vysoký výkon díky hardwarové akceleraci
- Integrace s Linuxem
- Podpora Virtio pro optimalizaci

**Nevýhody:**
- Složitější konfigurace
- Vyžaduje podporu VT-x/AMD-V

**Použití:**
- Produkční servery
- Vývoj a testování
- Cloudové prostředí

### VirtualBox
**Výhody:**
- Snadné použití
- Křížová platforma
- Široká podpora hostovaných OS
- Snapshoty a klonování

**Nevýhody:**
- Nižší výkon než KVM
- Omezená škálovatelnost
- Závislost na Oracle

**Použití:**
- Desktopové prostředí
- Testování různých OS
- Výukové účely

### LXC/LXD
**Výhody:**
- Lehké kontejnery (sdílený kernel)
- Rychlé spouštění
- Nízká režie
- Snadná správa

**Nevýhody:**
- Pouze Linuxové kontejnery
- Méně izolace než plná virtualizace
- Sdílený kernel může být rizikem

**Použití:**
- Mikroslužby
- CI/CD pipeline
- Vývojové prostředí

### Docker
**Výhody:**
- Standardizované balíčky (images)
- Snadná distribuce aplikací
- Velká komunita
- Rozsáhlá knihovna images

**Nevýhody:**
- Primárně pro aplikace, ne celé OS
- Složitější síťová konfigurace
- Bezpečnostní rizika

**Použití:**
- Kontejnerizace aplikací
- Vývoj a nasazování
- Cloudové aplikace

## Jak fungují

### KVM/QEMU
- Type 1 hypervisor
- Přímý přístup k hardwaru
- Virtuální stroje s vlastním jádrem
- Hardwarová akcelerace

### VirtualBox
- Type 2 hypervisor
- Emulace hardwaru
- Hostovaný OS běží nad hostitelským OS
- Softwarová emulace

### LXC/LXD
- Kontejnerová virtualizace
- Sdílené jádro hostitelského systému
- Izolované uživatelské prostředí
- Cgroups a namespaces

### Docker
- Aplikační kontejnery
- Sdílené jádro hostitelského systému
- Izolované prostředí pro aplikace
- Vrstvený souborový systém

## KVM/QEMU

### Instalace
```bash
sudo pacman -S qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat
```

### Konfigurace
1. Povolte a spusťte služby:
```bash
sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service
```
2. Přidejte uživatele do skupiny:
```bash
sudo usermod -aG libvirt $USER
```

### Vytvoření virtuálního stroje
1. Spusťte Virt-Manager:
```bash
virt-manager
```
2. Postupujte podle průvodce:
   - Vyberte typ instalace
   - Přidejte ISO obraz
   - Nastavte parametry (RAM, CPU, disk)

### Řízení z příkazové řádky
```bash
# Seznam virtuálních strojů
virsh list --all

# Spuštění VM
virsh start vm_name

# Vypnutí VM
virsh shutdown vm_name
```

## VirtualBox

### Instalace
```bash
sudo pacman -S virtualbox virtualbox-host-dkms
```

### Konfigurace
1. Načtěte kernel moduly:
```bash
sudo modprobe vboxdrv vboxnetadp vboxnetflt
```
2. Přidejte uživatele do skupiny:
```bash
sudo usermod -aG vboxusers $USER
```

### Vytvoření virtuálního stroje
1. Spusťte VirtualBox
2. Klikněte na "Nový" a postupujte podle průvodce

## LXC/LXD

### Instalace
```bash
sudo pacman -S lxc lxd
```

### Konfigurace
1. Inicializujte LXD:
```bash
sudo lxd init
```
2. Přidejte uživatele do skupiny:
```bash
sudo usermod -aG lxd $USER
```

### Vytvoření kontejneru
```bash
lxc launch ubuntu:20.04 mycontainer
```

### Správa kontejnerů
```bash
# Seznam kontejnerů
lxc list

# Spuštění kontejneru
lxc start mycontainer

# Připojení ke kontejneru
lxc exec mycontainer -- /bin/bash
```

## Docker

### Instalace
```bash
sudo pacman -S docker docker-compose
```

### Konfigurace
1. Povolte a spusťte službu:
```bash
sudo systemctl enable docker.service
sudo systemctl start docker.service
```
2. Přidejte uživatele do skupiny:
```bash
sudo usermod -aG docker $USER
```

### Základní příkazy
```bash
# Stažení image
docker pull ubuntu:20.04

# Spuštění kontejneru
docker run -it ubuntu:20.04 /bin/bash

# Seznam kontejnerů
docker ps -a
```

## Optimalizace

### Virtio
- Používejte Virtio ovladače pro lepší výkon
- Virtio disk, síť a další periferie

### CPU pinning
- Připněte virtuální CPU k fyzickým jádrům
- Zlepšuje výkon a snižuje latenci

### I/O caching
- Používejte writeback caching pro lepší výkon disku
- Buďte opatrní s rizikem ztráty dat

## Řešení problémů

### KVM
```bash
# Zkontrolujte podporu virtualizace
egrep -c '(vmx|svm)' /proc/cpuinfo

# Zkontrolujte načtené moduly
lsmod | grep kvm
```

### VirtualBox
```bash
# Zkontrolujte stav služby
systemctl status vboxdrv

# Znovu sestavte kernel moduly
sudo vboxreload
```

### LXC/LXD
```bash
# Zkontrolujte konfiguraci
lxc config show

# Zkontrolujte logy
journalctl -u lxd
```

## Užitečné odkazy
- [Arch Wiki - KVM](https://wiki.archlinux.org/title/KVM)
- [Arch Wiki - VirtualBox](https://wiki.archlinux.org/title/VirtualBox)
- [Arch Wiki - LXC](https://wiki.archlinux.org/title/LXC)
- [Arch Wiki - Docker](https://wiki.archlinux.org/title/Docker) 