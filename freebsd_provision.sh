#!/bin/sh
# Simple script to install and configure salt minion in freebsd

sudo pkg install -y py27-salt || exit 1
sudo cp -v /usr/local/etc/salt/minion.sample /usr/local/etc/salt/minion || exit 1
sudo sed 's/#master: salt/master: 192.168.50.10/' /usr/local/etc/salt/minion || exit 1
sudp sysrc salt_minion_enable="YES" || exit 1
sudo service salt_minion start || exit 1
