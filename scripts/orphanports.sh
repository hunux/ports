#!/bin/sh

PORTSDIR="$(dirname $(dirname $(realpath $0)))"
SCRIPTDIR="$(dirname $(realpath $0))"

repo="main multilib nonfree"

cd $PORTSDIR
rm -f scripts/.allports
rm -f scripts/.alldeps
rm -f scripts/.orphanports

for r in $repo; do
	for p in $r/*; do
		[ -f $p/hpkgbuild ] || continue
		echo ${p##*/} >> scripts/.allports
		deps=$(grep "^# depends[[:blank:]]*:" $p/hpkgbuild \
		| sed 's/^# depends[[:blank:]]*:[[:blank:]]*//' \
		| tr ' ' '\n' \
		| awk '!a[$0]++' \
		| sed 's/,//'\
		| tr '\n' ' ')
		[ "$deps" ] || continue
		for d in $deps; do
			echo $d >> scripts/.alldeps
		done
	done
done

sort scripts/.alldeps | uniq > scripts/.alldeps.tmp
mv scripts/.alldeps.tmp scripts/.alldeps
#grep -Fxv -f scripts/.alldeps scripts/.allports > scripts/.orphanports

for p in $(grep -Fxv -f scripts/.alldeps scripts/.allports); do
	for r in $repo; do
		[ -f $r/$p/hpkgbuild ] && {
			echo "$r/$p: $(grep "^# description[[:blank:]]*:" $r/$p/hpkgbuild | sed 's/^# description[[:blank:]]*:[[:blank:]]*//')" >> scripts/.orphanports
		}
	done
done

rm -f scripts/.allports
rm -f scripts/.alldeps

exit 0
