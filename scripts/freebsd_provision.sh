#!/usr/bin/env sh

set -xe

pkg install -y gsed curl wget py27-salt|| exit 1
cp -v /usr/local/etc/salt/minion.sample /usr/local/etc/salt/minion || exit 1
gsed -i 's/#master: salt/master: 192.168.50.10/' /usr/local/etc/salt/minion || exit 1
sysrc salt_minion_enable="YES" || exit 1
service salt_minion restart || exit 1
