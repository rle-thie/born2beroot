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

1 / Verifier si sudo est bien install $>dpkg -l | grep sudo

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

1 / $>sudo apt install openssh-server

1 / $>dpkg -l | grep ssh

1 / $>sudo vi /etc/ssh/sshd_config

1 / changer ligne15 "#Port 22" par "Port 4242"

1 / changer ligne34 "#PermitRootLogin prohibit-password" par "PermitRootLogin no"

1 / $>sudo service ssh restart

1 / $>sudo service ssh status OU $>systemctl status ssh

# ---- FIREWALL (ufw) ---

1 / $>sudo apt install ufw

1 / $>dpkg -l | grep ufw

1 / $>sudo ufw enable

1 / $>sudo ufw allow 4242

1 / $>sudo ufw status

# ---- CONNEXION SSH ---

1 / $>ifconfig -a OU $>ip addr

1 / $>ssh rle-thie@<ip-address> -p 4242

1 / $>mdp intra

1 / $>logout

1 / $>mdp intra OU $>exit

# ---- PASSWORD DE FOU FURIEUX ---  

1 / $>sudo vi /etc/login.defs

1 / changer ligne 160 "PASS_MAX_DAYS   99999" par "PASS_MAX_DAYS   30"

1 / changer ligne 161 "PASS_MIN_DAYS   0" par "PASS_MAX_DAYS   2"
  
1 / verifier que ligne 162 "PASS_WARN_AGE   7"
  
1 / $>sudo apt install libpam-pwquality
  
1 / $>dpkg -l | grep libpam-pwquality
  
1 / $>sudo vi /etc/pam.d/common-password

1 / ligne 25 "password      requisite     pam_pwquality.so retry=3 minlen=10 ucredit=-1 dcredit=-1 maxrepeat=3 reject_username difok=7 enforce_for_root"

# ---- creer un nouveau groupe ---
  
1 / $>sudo addgroup user42
  
1 / $>sudo adduser rle-thie user42
  
1 / $>sudo adduser rle-thie user42

# ---- creer un nouveau user ---
  
1 / $>sudo adduser new_username
  
1 / $>sudo usermod -aG user42 your_username

1 / $>getent group user42
