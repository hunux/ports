#!/bin/sh

if [ -f /lib/modules/KERNELVERSION ]; then
	kernver=$(cat /lib/modules/KERNELVERSION)
else
	kernver=$(uname -r)
fi
if [ $(command -v mkinitramfs) ]; then
	mkinitramfs -q -k $kernver -o /boot/initrd-hunux.img
fi
depmod $kernver
