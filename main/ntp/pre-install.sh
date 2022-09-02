#!/bin/sh

getent group ntp >/dev/null || groupadd -g 87 ntp
getent passwd ntp >/dev/null || useradd -c "Network Time Protocol" -d /var/lib/ntp -u 87 -g ntp -s /bin/false ntp
