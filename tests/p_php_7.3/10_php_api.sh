#!/bin/bash

# Skip if after CentOS 8
if [ "$centos_ver" -gt "8" ]; then
  t_Log "PHP 7.3 does not exist post-c8 => SKIP"
  t_CheckExitStatus 0
  exit $PASS
fi

t_Log "Running $0 - verify PHP API in phpinfo()"
t_SkipReleaseLessThan 8 'no modularity'

t_EnableModuleStream php:7.3
t_InstallPackage php-cli

t_Log "Executing phpinfo()"
output=$(php -d 'date.timezone=UTC' -r 'phpinfo();')
t_CheckExitStatus $?

API='20180731'

t_Log "Verifying PHP API matches $API"
grep -q "PHP API => $API" <<< $output
t_CheckExitStatus $?

t_RemovePackage php-cli
t_ResetModule php httpd nginx
