#!/bin/bash
# Author: Christoph Galuschka <tigalch@tigalch.org>
#         Rene Diepstraten <rene@renediepstraten.nl>

# Skip if after CentOS 8
if [ "$centos_ver" -gt "8" ]; then
  t_Log "arpwatch does not exist post-c8 => SKIP"
  exit 0
fi

# Install requirements
t_InstallPackage arpwatch psmisc net-tools

