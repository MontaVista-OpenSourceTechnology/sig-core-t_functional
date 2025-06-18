#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

# Skip if after CentOS 9
if [ "$centos_ver" -gt "9" ]; then
  t_Log "spamassassin does not exist post-c9 => SKIP"
  exit 0
fi

t_InstallPackage  spamassassin

