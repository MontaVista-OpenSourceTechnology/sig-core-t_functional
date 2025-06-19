#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - remove unused MTAs and install sendmail"

# Skip if after CentOS 9
if [ "$centos_ver" -gt "9" ]; then
  t_Log "sendmail does not exist post-c9 => SKIP"
  exit 0
fi

t_InstallPackage sendmail nc

# Remove other MTAs
t_ServiceControl postfix stop
t_ServiceControl exim stop
sleep 3
t_RemovePackage postfix exim

t_ServiceControl sendmail start
