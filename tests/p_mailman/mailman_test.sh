#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

if [ "$CONTAINERTEST" -eq "1" ]; then
    t_Log "Running in container -> SKIP"
    exit 0
fi

# Skip if after CentOS 8
if [ "$centos_ver" -gt "8" ]; then
  t_Log "mailman does not exist post-c8 => SKIP"
  t_CheckExitStatus 0
  exit $PASS
fi

t_Log "Running $0 - mailman test."

# Add mailman list
/usr/lib/mailman/bin/newlist -q mailman root@localhost.localdomain password > /dev/null 2>&1

# Restart httpd (started in other tests) and start mailman 
t_ServiceControl httpd restart
t_ServiceControl mailman start

curl -s http://localhost/mailman/listinfo | grep -q 'localhost Mailing Lists'
t_CheckExitStatus $?

t_ServiceControl httpd stop
t_ServiceControl mailman stop
