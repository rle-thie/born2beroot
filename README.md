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

# ---- monitoring.sh ---

1 / Ajouter monitoring.sh a "usr/local/bin/"
  
2 / $>sudo crontab -u root -e
  
3 / ajouter a la fin du file "*/10 * * * * bash /usr/local/bin/monitoring.sh"
  
4 / $>sudo reboot

# ---- monitoring.sh 2---

sudo apt-get install cron /#/ installe cron
sudo vim /etc/crontab /#/ ouvre le fichier crontab
cp /home/lleveque/monitoring.sh /etc/init.d/ /#/ copie monitoring.sh dans le dossier que l'on veut
*/* 10 * * * root bash /etc/init.d/monitoring.sh /#/ execute bash monitoring.sh toutes les 10 min

# ---- ERREUR ---
  
si y'a une erreur au lancement, reglage de la vm > display > graphic controller > VBoxVGA
source:https://github.com/lleveque42/42cursus_Born2beroot
  
  
	groupadd <new group> (create group)
	groupdel <group> (delete group)
	useradd <username> (create user)
	userdel <username> (delete user)
	passwd <username> (create password)
	adduser <username> <group> (add user to group)
	deluser <username> <group> (remove user from a group)
	groups <username> (get groups that user are in)
	hostnamectl set-hostname <new hostname>
	service ssh status
	ufw enable
	ufw allow <port>
	ufw status
	ufw status numbered
	ufw delete <number>
	chage -M 30 <username>
	chage -m 2 <username>
	chage -W 7 <username>
	chage -l <username>
	crontab -l
	crontab -u root -e
	lsblk
	ss -tunlp
	ifconfig
	sudo vim /etc/login.defs /#/ ouvre le fichier pour set les days limites mdp
	PASS_MAX_DAYS	30 /#/ set l'expiration du mdp a 30 jours
	PASS_MIN_DAYS	2 /#/ set le temps de maj a 2 jours
	PASS_WARN_AGE	7 /#/ set le warn d'expiration a 7 jours avant

	sudo vim /etc/security/pwquality.conf /#/ ouvre le fichier pour set les limites de caracteres
	minlen = 10 /#/ min de caracteres
	dcredit = -1 /#/ min de chiffre
	ucredit = -1 /#/ min de majuscule
	difok = 7 /#/ nb de caracteres differents de l'ancien
	maxrepeat = 3 /#/ max de repetitions consecutives d'un meme caractere
	usercheck = 1 /#/ check si le user est dans le password
	enforce_for_root /#/ impose le pwquality au root
	/etc/init.d/crond stop
	
	SELinux rule sets are incredibly complex but with this complexity you have more control over how processes are isolated. Generating these policies 		can be automated. A strike against this security system is that its very difficult to independently verify.

	AppArmor (and SMACK) is very straight forward. The profiles can be hand written by humans, or generated using aa-logprof. AppArmor uses path based 		control, making the system more transparent so it can be independently verified.
	
	aptitude est un gestionnaire de paquets avec une interface en mode texte
	De l'avis général, aptitude gère mieux les dépendances que apt-get. Par exemple, aptitude supprimera les paquets inutiles lors de la désinstallation d'un paquet
