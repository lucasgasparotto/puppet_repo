#!/bin/bash

# Setup MOTD
echo "Setting MOTD..."
MOTD=$(cat <<EOF
Welcome to class!

You've logged into a Puppet Classroom Linux Server.
EOF
)
echo $MOTD > /etc/motd
echo "Completed setting MOTD!"

# Setup NTP
echo "Configuring NTP...."
yum install -y ntpdate ntp &> /dev/null
if [ $? -ne 0 ];then
  echo "FAILED to install ntp"
  exit 1
fi

NTP=$(cat <<EOF
driftfile /var/lib/ntp/drift
restrict default nomodify notrap nopeer noquery
restrict 127.0.0.1
restrict ::1
server pool.ntp.org iburst
includefile /etc/ntp/crypto/pw
keys /etc/ntp/keys
disable monitor
EOF
)
echo $NTP > /etc/ntp.conf
ntpdate pool.ntp.org &> /dev/null
service ntpd restart &> /dev/null
if [ $? -ne 0 ]; then
  echo "FAILED to restart ntp"
  exit 1
fi
echo "Configured NTP!"



# Inventory Report
NAME=$(hostname -f)
IP=$(ip addr show eth0 | egrep "inet.*eth0"|awk '{print $2}'|awk -F '/' '{print $1}')
OS=$(cat /etc/centos-release| awk '{print $1"-"$4}')
DISK=$(df -h /|grep \/|awk '{print $5}')

printf "\nInventory Report:\n\n"
(printf "Hostname IPAddress OSName DiskUsed\n"; echo "${NAME} ${IP} ${OS} ${DISK}")| column -t