#!/bin/sh

getent group polkitd >/dev/null || groupadd -fg 27 polkitd
getent passwd polkitd >/dev/null || useradd -c "PolicyKit Daemon Owner" -d /etc/polkit-1 -u 27 -g polkitd -s /bin/false polkitd
