# Dotfiles

Tato složka obsahuje konfigurační soubory pro různé aplikace a nástroje. Tyto soubory lze použít pro rychlé nastavení systému.
(Toto ještě není hotové a pracuje se na tom)

## Struktura složky

```
dotfiles/
├── bash/
│   ├── .bashrc
│   ├── .bash_profile
│   └── .bash_aliases
├── zsh/
│   ├── .zshrc
│   ├── .zprofile
│   └── .zsh_aliases
├── vim/
│   ├── .vimrc
│   └── .vim/
├── tmux/
│   └── .tmux.conf
├── git/
│   ├── .gitconfig
│   └── .gitignore_global
├── config/
│   ├── i3/
│   ├── polybar/
│   └── rofi/
└── scripts/
    ├── backup.sh
    └── update.sh
```

## Použití

### Ruční kopírování
```bash
cp -r dotfiles/bash/ ~/
cp -r dotfiles/vim/ ~/
```

### Použití symlinků
```bash
ln -s ~/dotfiles/bash/.bashrc ~/.bashrc
ln -s ~/dotfiles/vim/.vimrc ~/.vimrc
```

### Automatizované nasazení
```bash
# Skript pro nasazení dotfiles
#!/bin/bash
for file in $(find ~/dotfiles -name ".*"); do
    ln -sf $file ~/$(basename $file)
done
```

## Obsah jednotlivých souborů

### .bashrc
```bash
# Základní nastavení
export EDITOR=vim
export VISUAL=vim

# Aliasy
alias ll='ls -la'
alias update='sudo pacman -Syu'
alias clean='sudo pacman -Rns $(pacman -Qtdq)'

# Prompt
PS1='\[\e[1;32m\]\u@\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\]\$ '
```

### .vimrc
```vim
" Základní nastavení
set number
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
syntax on

" Klávesové zkratky
nnoremap <C-s> :w<CR>
nnoremap <C-q> :q<CR>
```

### .tmux.conf
```tmux
# Základní nastavení
set -g mouse on
set -g base-index 1
set -g pane-base-index 1

# Klávesové zkratky
bind-key C new-window
bind-key x kill-pane
```

### .gitconfig
```git
[core]
    editor = vim
    excludesfile = ~/.gitignore_global
[alias]
    co = checkout
    ci = commit
    st = status
    br = branch
    hist = log --pretty=format:\"%h %ad | %s%d [%an]\" --graph --date=short
```

## Užitečné skripty

### backup.sh
```bash
#!/bin/bash
# Záloha důležitých souborů
tar -czf backup_$(date +%F).tar.gz \
    ~/.bashrc \
    ~/.vimrc \
    ~/.tmux.conf \
    ~/.gitconfig
```

### update.sh
```bash
#!/bin/bash
# Aktualizace systému a dotfiles
sudo pacman -Syu
cd ~/dotfiles
git pull origin main
```

## Synchronizace mezi systémy

### Použití Git
```bash
# Inicializace repozitáře
cd ~/dotfiles
git init
git remote add origin https://github.com/uzivatel/dotfiles.git

# Push změn
git add .
git commit -m "Update dotfiles"
git push origin main

# Pull změn
git pull origin main
```

## Doporučené postupy

1. **Verzování**
   - Používejte Git pro správu změn
   - Pravidelně commitovat změny
   - Používejte smysluplné commit zprávy

2. **Modularita**
   - Rozdělte konfigurace do logických celků
   - Používejte podmíněné bloky pro různé systémy

3. **Dokumentace**
   - Komentujte důležité části konfigurací
   - Udržujte aktuální README
   - Zaznamenávejte změny v CHANGELOG

## Odkazy
- [Arch Wiki - Dotfiles](https://wiki.archlinux.org/title/Dotfiles)
- [Awesome Dotfiles](https://github.com/webpro/awesome-dotfiles)
- [Dotfiles GitHub](https://dotfiles.github.io/) 
