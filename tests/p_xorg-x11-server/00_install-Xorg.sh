#!/bin/bash
# Author: Athmane Madjoudj <athmane@fedoraproject.org>

t_Log "Running $0 - installing Xorg (base package)"
if [ "$centos_ver" -gt "9" ]; then
  t_Log "X11 relplaced with Wayland post-c9"
  t_InstallPackage xorg-x11-server-Xwayland
else
  t_InstallPackage xorg-x11-server-Xorg
fi

