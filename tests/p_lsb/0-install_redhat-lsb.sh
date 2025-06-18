#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

# Skip if after CentOS 8
if [ "$centos_ver" -gt "8" ]; then
  t_Log "redhat-lsb does not exist post-c8 => SKIP"
  t_CheckExitStatus 0
  exit $PASS
fi


t_Log "$0 - Installing redhat-lsb"
t_InstallPackage  redhat-lsb
