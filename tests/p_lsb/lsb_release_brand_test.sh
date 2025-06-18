#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

# Skip if after CentOS 8
if [ "$centos_ver" -gt "8" ]; then
  t_Log "redhat-lsb does not exist post-c8 => SKIP"
  t_CheckExitStatus 0
  exit $PASS
fi

t_Log "Running $0 - LSB CentOS branding check."

lsb_release -i | grep -q "CentOS" && \
lsb_release -d | grep -q "CentOS"

t_CheckExitStatus $?
