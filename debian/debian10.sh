#!/usr/bin/env bash

export DEBIAN_FRONTEND="noninteractive"

sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
sed -i -e 's/# ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/' /etc/locale.gen
echo 'LANG="ru_RU.UTF-8"' | tee /etc/default/locale > /dev/null
dpkg-reconfigure --frontend=noninteractive locales
update-locale LANG=ru_RU.UTF-8
echo 'Europe/Moscow' | tee /etc/timezone > /dev/null
ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
dpkg-reconfigure -f noninteractive tzdata

sed -i 's/#FallbackNTP/FallbackNTP/' /etc/systemd/timesyncd.conf
systemctl enable systemd-timesyncd.service && systemctl start systemd-timesyncd.service

apt-get install -y software-properties-common build-essential debconf-utils git zip unzip curl screen figlet

sed -i -e '/#SystemMaxUse=/s/#SystemMaxUse=/SystemMaxUse=200M/g' /etc/systemd/journald.conf


cat <<EOF > /etc/sysctl.d/70-disable-ipv6.conf
net.ipv6.conf.all.disable_ipv6 = 1
EOF

sudo sysctl -p -f /etc/sysctl.d/70-disable-ipv6.conf


#python3-systemd