#!/bin/sh
#
# this script will be execute by hunux-installer to do some stuffs
# after hunux is installed
#

VIROOTFS=${VIROOTFS:-/run/initramfs/medium/virootfs/}
HUNUXROOTFS=${HUNUXROOTFS:-/tmp/hunuxinstall}

# copy over all customs configs and customization except some unnecessary files
for i in $(find $VIROOTFS -type f | sed "s,$VIROOTFS,,"); do
    case $i in
        *hunux-installer*|*custom_script.sh|*fstab|*issue|*hunuxinstaller.desktop|*post-install.sh) continue;;
    esac
    install -D $VIROOTFS/$i $HUNUXROOTFS/$i
done

# change slim theme
sed 's/current_theme.*/current_theme typogin/' -i $HUNUXROOTFS/etc/slim.conf

# remove install hunux entry from ob menu
sed '/Install Hunux/d' -i $HUNUXROOTFS/etc/skel/.config/obmenu-generator/schema.pl

# remove welcome message entry from autostart
sed '/xterm/d' -i $HUNUXROOTFS/etc/skel/.config/openbox/autostart

exit 0
