#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - check that spamassassin can detect spam."

# Skip if after CentOS 9
if [ "$centos_ver" -gt "9" ]; then
  t_Log "spamassassin does not exist post-c9 => SKIP"
  exit 0
fi

if [ "$centos_ver" -lt 8 ] ; then
VERSION=-`t_GetPkgVer spamassassin`
fi
spamassassin --lint &&\
spamassassin < /usr/share/doc/spamassassin${VERSION}/sample-spam.txt | grep -q 'X-Spam-Flag: YES'

t_CheckExitStatus $?
