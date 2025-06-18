#!/bin/sh
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - attempting to install gzip."
t_InstallPackage gzip zip diffutils less util-linux-ng expect

# Skip if after CentOS 8
if [ "$centos_ver" -gt "8" ]; then
then
  t_Log "Ncompress unavailable post-c8 => SKIP"
else
  t_InstallPackage ncompress 
fi

