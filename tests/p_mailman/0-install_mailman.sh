#!/bin/bash
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

t_Log "$0 - Installing mailman"
t_InstallPackage  mailman

