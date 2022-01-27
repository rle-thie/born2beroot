ARCHI=`uname -a`
CPU_PHYSICAL=`grep -c ^processor /proc/cpuinfo`
vCPU=`lscpu | grep "Thread(s)" | awk '{print $4}'`
MEM_PERC=`free -m | grep "Mem" | awk '{print $3/$2*100}'`
MEM_USE=`free -m | grep "Mem" | awk '{print $3"/"$2}'`
DISK_USE=`df -m | awk '{sum+=$3}; END {print sum}'`
DISK_TOTAL=`df -m | awk '{sum+=$2}; END {print sum}'`
DISK_PERC=`df -m | awk '{sum+=$3}; {sum2+=$2}; END {print sum/sum2*100}'`
CPU_PERC=`mpstat | grep "all" | awk '{print $4}'`
LAST_BOOT=`uptime -s`
WC_LVM=`lsblk | grep lvm | wc -l`
LVM_USE=`if [ $WC_LVM -eq 0 ]; then echo no; else echo yes; fi`
TCP_USE=`ss -s | grep TCP: | awk '{print ($4)+0}'`
USER_LOG=`who | wc -l`
IPv4=`hostname -I | awk '{print $1}'`
MAC=`ip a | grep link/ether | awk '{print $2}'`
SUDO_NB=`cat /var/log/sudo/sudo.log | grep COMMAND | wc -l`

wall "#Architeture : $ARCHI
#CPU Physical : $CPU_PHYSICAL
#vCPU : $vCPU
#Memory Usage : $MEM_USE MB (${MEM_PERC:00:4}%)
#Disk Usage : $DISK_USE/$DISK_TOTAL MB (${DISK_PERC:0:4}%)
#CPU Load : $CPU_PERC%
#Last Boot : $LAST_BOOT
#LVM Use : $LVM_USE
#Connexions TCP : $TCP_USE ESTABLISHED
#User log : $USER_LOG
#Network : IP $IPv4 ($MAC)
#Sudo : $SUDO_NB cmd"
