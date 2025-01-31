# Detailní analýza PAM konfiguračních souborů

## ags

```
auth include login
```
Jednoduchá konfigurace, která pouze zahrnuje nastavení z [login](#login). Všechny autentizační kontroly jsou delegovány na login konfiguraci.

## groupmems
```groupmems
#%PAM-1.0
auth     sufficient  pam_rootok.so
account  required    pam_permit.so
password include     system-auth
```
- `pam_rootok.so`: Povoluje přímý přístup pro root uživatele bez další autentizace
- `pam_permit.so`: Vždy povolí přístup k účtu po úspěšné autentizaci
- Používá hesla z [system-auth](#system-auth)

## chfn
```chfn
#%PAM-1.0
auth        sufficient  pam_rootok.so
auth        required    pam_unix.so
account     required    pam_unix.so
session     required    pam_unix.so
password    required    pam_permit.so
```
- `pam_rootok.so`: Root má přímý přístup
- `pam_unix.so`: Standardní Unix autentizace pro ostatní uživatele
- `pam_permit.so`: Povoluje změnu hesla

## chpasswd
```chpasswd
#%PAM-1.0
auth     sufficient  pam_rootok.so
account  required    pam_permit.so
password include     system-auth
```
Podobné jako groupmems, používá se pro hromadnou změnu hesel.

## chsh
```chsh
#%PAM-1.0
auth        sufficient  pam_rootok.so
auth        required    pam_unix.so
account     required    pam_unix.so
session     required    pam_unix.so
password    required    pam_permit.so
```
Identická konfigurace jako chfn, používá se pro změnu uživatelského shellu.

## kde
```kde
#%PAM-1.0
auth       include     system-local-login
account    include     system-local-login
password   include     system-local-login
session    include     system-local-login
```
Kompletně deleguje všechny kontroly na [system-local-login](#system-local-login).

## kde-fingerprint
```kde-fingerprint
#%PAM-1.0
auth       required    pam_shells.so
auth       requisite   pam_nologin.so
auth       requisite   pam_faillock.so preauth
-auth      required    pam_fprintd.so
auth       optional    pam_permit.so
auth       required    pam_env.so

account    include     system-local-login
password   required    pam_deny.so
session    include     system-local-login
```
- Kontroluje povolené shelly
- Kontroluje /etc/nologin
- Implementuje ochranu proti útokům (faillock)
- Vyžaduje ověření otiskem prstu
- Nastavuje prostředí
- Zakazuje změnu hesla (pam_deny.so)

## kde-smartcard
```kde-smartcard
#%PAM-1.0
auth       requisite   pam_nologin.so
auth       requisite   pam_faillock.so preauth
-auth      required    pam_pkcs11.so wait_for_card card_only
auth       required    pam_shells.so
auth       optional    pam_permit.so
auth       required    pam_env.so
```
- `pam_nologin.so`: Kontroluje zákaz přihlášení
- `pam_faillock.so`: Ochrana proti útokům hrubou silou
- `pam_pkcs11.so`: Vyžaduje čipovou kartu s parametry:
  - `wait_for_card`: Čeká na vložení karty
  - `card_only`: Povoluje pouze autentizaci kartou
- Kontroluje povolené shelly a nastavuje prostředí

## login
```
#%PAM-1.0
auth       requisite    pam_nologin.so
auth       include      system-local-login
account    include      system-local-login
session    include      system-local-login
password   include      system-local-login
```
- Nejprve kontroluje /etc/nologin
- Všechny ostatní kontroly deleguje na [system-local-login](#system-local-login)

## newusers
```
#%PAM-1.0
auth       sufficient  pam_rootok.so
account    required    pam_permit.so
password   include     system-auth
```
- Povoluje root přístup bez ověření
- Vždy povolí přístup k účtu
- Používá standardní správu hesel ze [system-auth](#system-auth)

## other
```
#%PAM-1.0
auth      required   pam_deny.so
auth      required   pam_warn.so
account   required   pam_deny.so
account   required   pam_warn.so
password  required   pam_deny.so
password  required   pam_warn.so
session   required   pam_deny.so
session   required   pam_warn.so
```
Bezpečnostní konfigurace pro nespecifikované služby:
- Odmítá všechny typy přístupu (`pam_deny.so`)
- Loguje všechny pokusy o přístup (`pam_warn.so`)

## passwd
```
#%PAM-1.0
auth     include     system-auth
account  include     system-auth
password include     system-auth
```
Kompletně deleguje autentizaci na [system-auth](#system-auth)

## remote
```
#%PAM-1.0
auth       required     pam_securetty.so
auth       requisite    pam_nologin.so
auth       include      system-remote-login
account    include      system-remote-login
session    include      system-remote-login
password   include      system-remote-login
```
- Kontroluje bezpečné TTY (`pam_securetty.so`)
- Kontroluje /etc/nologin
- Deleguje ostatní kontroly na [system-remote-login](#system-remote-login)

## runuser a runuser-l
```
#%PAM-1.0
auth    sufficient      pam_rootok.so
session include         system-login
```
- Povoluje přístup pouze root uživateli
- Používá standardní nastavení relace

## sddm
```
#%PAM-1.0
auth        include     system-login
-auth       optional    pam_gnome_keyring.so
-auth       optional    pam_kwallet5.so

account     include     system-login
password    include     system-login

session     optional    pam_keyinit.so force revoke
session     include     system-login
-session    optional    pam_gnome_keyring.so auto_start
-session    optional    pam_kwallet5.so auto_start
```
- Používá základní přihlášení ze [system-login](#system-login)
- Volitelná integrace s GNOME Keyring
- Volitelná integrace s KWallet5
- Správa kryptografických klíčů (`pam_keyinit.so`)

## sddm-autologin
```
#%PAM-1.0
auth        required    pam_env.so
auth        required    pam_faillock.so preauth
auth        required    pam_shells.so
auth        required    pam_nologin.so
auth        required    pam_permit.so
-auth       optional    pam_gnome_keyring.so
-auth       optional    pam_kwallet5.so
```
- Nastavuje prostředí
- Implementuje ochranu proti útokům
- Kontroluje povolené shelly
- Kontroluje /etc/nologin
- Volitelná integrace s GNOME Keyring a KWallet

## sddm-greeter
```
#%PAM-1.0
auth        required pam_env.so
auth        required pam_permit.so
account     required pam_permit.so
password    required pam_deny.so
session     required pam_unix.so
session     optional pam_systemd.so
```
- Načítá prostředí
- Povoluje spuštění greeter bez autentizace
- Zakazuje změnu hesla
- Základní Unix relace
- Integrace se systemd

## sshd
```
#%PAM-1.0
auth      include   system-remote-login
account   include   system-remote-login
password  include   system-remote-login
session   include   system-remote-login
```
Kompletně deleguje kontroly na [system-remote-login](#system-remote-login)

## su a su-l
```
#%PAM-1.0
auth            sufficient      pam_rootok.so
# Uncomment the following line to implicitly trust users in the "wheel" group.
#auth           sufficient      pam_wheel.so trust use_uid
# Uncomment the following line to require a user to be in the "wheel" group.
#auth           required        pam_wheel.so use_uid
auth            required        pam_unix.so
account         required        pam_unix.so
session         required        pam_unix.so
password        include         system-auth
```
- Root má přímý přístup
- Volitelná kontrola skupiny wheel
- Standardní Unix autentizace
- Používá hesla ze [system-auth](#system-auth)

## sudo
```
#%PAM-1.0
auth    [success=1 new_authtok_reqd=1 default=ignore]  pam_unix.so try_first_pass likeauth nullok
auth    sufficient  pam_fprintd.so
auth    include     system-auth
account include     system-auth
session include     system-auth
```
- Pokouší se nejprve o Unix autentizaci
- Umožňuje biometrickou autentizaci jako alternativu
- Používá [system-auth](#system-auth) pro další kontroly

## system-auth
```
#%PAM-1.0
auth       [success=2 default=ignore]   pam_fprintd.so
auth       sufficient                   pam_unix.so try_first_pass likeauth nullok
auth       required                     pam_faillock.so preauth
auth       [success=1 default=bad]      pam_unix.so try_first_pass nullok
auth       [default=die]                pam_faillock.so authfail
auth       optional                     pam_permit.so
auth       required                     pam_env.so
auth       required                     pam_faillock.so authsucc
```
Komplexní autentizační konfigurace:
- Biometrická autentizace
- Unix autentizace s více pokusy
- Ochrana proti útokům hrubou silou
- Nastavení prostředí
- Správa účtů a relací

## system-local-login
```
#%PAM-1.0
auth      include   system-login
account   include   system-login
password  include   system-login
session   include   system-login
```
Deleguje všechny kontroly na [system-login](#system-login)

## system-login
```
#%PAM-1.0
auth       required   pam_shells.so
auth       requisite  pam_nologin.so
auth       include    system-auth

account    required   pam_access.so
account    required   pam_nologin.so
account    include    system-auth

password   include    system-auth

session    optional   pam_loginuid.so
session    optional   pam_keyinit.so force revoke
session    include    system-auth
session    optional   pam_motd.so
session    optional   pam_mail.so dir=/var/spool/mail standard quiet
session    optional   pam_umask.so
-session   optional   pam_systemd.so
session    required   pam_env.so
```
- Kontrola shellů a /etc/nologin
- Kontrola přístupu pomocí /etc/security/access.conf
- Správa kryptografických klíčů
- Zobrazení MOTD
- Kontrola pošty
- Nastavení umask
- Integrace se systemd
- Nastavení prostředí

## system-remote-login
```
#%PAM-1.0
auth      include   system-login
account   include   system-login
password  include   system-login
session   include   system-login
```
Deleguje kontroly na [system-login](#system-login)

## system-services
```
#%PAM-1.0
auth      sufficient  pam_permit.so
account   include     system-auth
session   optional    pam_loginuid.so
session   required    pam_limits.so
session   required    pam_unix.so
session   optional    pam_permit.so
session   required    pam_env.so
```
- Minimální autentizace pro služby
- Standardní kontrola účtů
- Nastavení loginuid
- Aplikace limitů systémových zdrojů
- Základní Unix relace
- Nastavení prostředí

## systemd-user
```
account  include system-login
session  required pam_loginuid.so
session  include system-login
```
- Používá kontroly účtů z [system-login](#system-login)
- Nastavuje loginuid
- Používá relační nastavení z [system-login](#system-login)

## vlock
```
#%PAM-1.0
auth required pam_unix.so
account required pam_unix.so
password required pam_unix.so
session required pam_unix.so
```
Jednoduchá konfigurace pro zamykání virtuální konzole:
- Používá standardní Unix autentizaci pro všechny typy kontrol

