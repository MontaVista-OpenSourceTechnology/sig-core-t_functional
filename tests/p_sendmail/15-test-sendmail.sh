#!/bin/bash
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - testing if /usr/sbin/sendmail for sendmail is sane."

# Skip if after CentOS 9
if [ "$centos_ver" -gt "9" ]; then
  t_Log "sendmail does not exist post-c9 => SKIP"
  exit 0
fi

mta=$(ls -H /usr/sbin/sendmail)

if [ $mta == '/usr/sbin/sendmail' ]
  then
  t_Log "link to sendmail seems to be sane"
  ret_val=0
else
  t_Log "link to sendmail seems to be wrong"
  ret_val=1
fi

t_CheckExitStatus $ret_val
