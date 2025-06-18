#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "$0 - Installing crond"
if [ "$centos_ver" -gt "5" ]
then
  pn="cronie"
else
  pn="vixie-cron"
fi

t_InstallPackage  $pn
t_ServiceControl crond cycle
