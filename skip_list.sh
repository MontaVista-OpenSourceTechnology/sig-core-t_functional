#!/bin/bash

# Author: Steve Barnes (steve@echo.id.au)
# Description: this script sources our library functions and starts a test run.





host repo.centos.qa > /dev/null
export SKIP_QA_HARNESS=$?

LIB_FUNCTIONS='./tests/0_lib/functions.sh'

# Human friendly symbols
export readonly PASS=0
export readonly FAIL=1
# set debug level of yum install in t_InstallPackage
export YUMDEBUG=0

[ -f $LIB_FUNCTIONS ] && source $LIB_FUNCTIONS || { echo -e "\n[+] `date` -> Unable to source functions library. Cannot continue\n"; exit $FAIL; }

# case insensitive filename matching
shopt -s nocasematch

# exit as soon as any script returns a non-zero exit status
set -e

# exit on undefined variables
set -u

# Searching for tests to disable

if [ -e skipped-tests.list ] ;then
  egrep ^${centos_ver} skipped-tests.list | while read line; 
    do (echo $line|cut -f 2 -d '|')
  done
fi


# t_Log "QA t_functional tests finished."
exit 0