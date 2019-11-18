#!/bin/bash
#
#  Copyright MontaVista Software 2019
#
#  Detect CentOS version and switch to appropriate test branch
#

# Determine current release version
RELEASE="$(cat /etc/centos-release | while read A B C D E; do echo $D; done)"
VERSION="$(cut -d '.' -f 1 <<< $RELEASE)"
SUBVERSION="$(cut -d '.' -f 2 <<< $RELEASE)"

# Checkout the appropriate montavista-<version> branch
MVBRANCHES=$(git branch -r | grep -v '\->' | grep montavista | sed 's/  origin\/montavista-//')
if [[ -z $MVBRANCHES ]]; then
	echo "No montavista-* branches exist"
else
	if echo "$MVBRANCHES" | grep -q "$VERSION.$SUBVERSION"; then
		BRANCH="montavista-$VERSION.$SUBVERSION"
	elif echo "$MVBRANCHES" | grep -q "$VERSION"; then
		BRANCH="montavista-$VERSION"
	fi
fi
if [[ -z $BRANCH ]]; then
	echo "No montavista-$VERSION branch found"
else
	git checkout $BRANCH
	git branch
fi

