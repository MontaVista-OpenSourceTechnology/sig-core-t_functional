#!/bin/bash

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
#set -e

# exit on undefined variables
#set -u


# process our test scripts
if [ $# -gt 0 ]; then
  t_Process <(/usr/bin/find $1 -type f|sort -t'/' )
fi

exit 0