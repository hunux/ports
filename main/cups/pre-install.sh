#!/bin/sh

getent group lpadmin >/dev/null || groupadd -g 19 lpadmin
getent passwd lp >/dev/null || useradd -c "Print Service User" -d /var/spool/cups -g lp -s /bin/false -u 9 lp
