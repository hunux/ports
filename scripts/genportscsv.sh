#!/bin/sh

PORTSDIR="$(dirname $(dirname $(realpath $0)))"
SCRIPTDIR="$(dirname $(realpath $0))"

repo="main multilib nonfree"
portscsv="$SCRIPTDIR/ports.csv"

echo > $portscsv

for r in $repo; do
	for p in $PORTSDIR/$r/*; do
		[ -f $p/hpkgbuild ] || continue
		. $p/hpkgbuild
		homepage=$(grep "^# homepage[[:blank:]]*:" $p/hpkgbuild | sed 's/^# homepage[[:blank:]]*:[[:blank:]]*//')
		description=$(grep "^# description[[:blank:]]*:" $p/hpkgbuild | sed 's/^# description[[:blank:]]*:[[:blank:]]*//')
		echo "$name,$version-$release,$r,$homepage,\"$description\"" >> $portscsv
	done
done

echo "NAME,VERSION,REPO,HOMEPAGE,DESCRIPTION" > $portscsv.tmp
sort $portscsv >> $portscsv.tmp
mv $portscsv.tmp $portscsv

exit 0
