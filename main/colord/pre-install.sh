#!/bin/sh

getent group colord >/dev/null || groupadd -g 71 colord
getent passwd colord >/dev/null || useradd -c "Color Daemon Owner" -d /var/lib/colord -u 71 -g colord -s /bin/false colord
