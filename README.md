# ---- Installation ---

1 / Choisir install

2 / English : langue de l'Installation

3 / France : Pays de notre VM

4 / USA - American english pour le keyboard

5 / Hostname : rle-thie42

6 / Configure Network : laisser blanc, pas de NDD à confgurer

7 / Root psw : MDP intra / Confirmer a nouveau ensuite

8 / Nom Complet : Robin Lethiec, pour un second user

9 / Login : rle-thie

10 / MDP intra / Confirmer ensuite le MDP

11 / Guided - use entire disk and setup encrypted LVM

12 / Next

13 / Separate home, pour partitionner ensuite

14 / Passphrase = MDP / Confirmer

15 / Ecrire max pour donner la full size du disque

16 / Finish partitioning

17 / Yes

18 / Scan extra installation media  / No

19 / Deb archive mirror config : France

20 / ded.debian.org

21 / Blank for proxy

22 / ? Message d'erreure ?

23 / Partagede donnees ? No

24 / System minimal blabla

25 / Installer Grub : Yes. Pour lancer l'OS au demarrage

26 / dev/sda pour installer le grub

27 / Continue

# ---- Setup Sudo ---

1 / $>su -

1 / $>apt-get update

1 / $>apt-get install vim

1 / $>apt install sudo

1 / Verifier si sudo est bien install $>dpkg -1 | grep sudo

# ---- Ajouter des users au group sudo ---

1 / $>adduser rle-thie sudo

1 / $>usermod -aG sudo rle-thie

1 / $>getent group sudo

1 / $>reboot

1 / login et mdp

1 / $>sudo -v

# ---- Config de sudo ---

1 / $>sudo vi /etc/sudoers.d/sudo_config

1 / Defaults     passwd_tries=3

1 / Defaults     badpass_message="c pas le bon mdp"

1 / Defaults     logfile="/var/log/sudo/sudo_log"

1 / Defaults     log_input,log_output

1 / Defaults     iolog_dir="/var/log/sudo"

1 / Defaults     requiretty

1 / Defaults     secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"

1 / $>sudo mkdir /var/log/sudo

1 / $>sudo reboot

# ---- installer et config ssh ---

