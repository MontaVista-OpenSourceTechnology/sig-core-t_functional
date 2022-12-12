#!/bin/sh
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - postfix can accept and deliver local email."

if [ "$CONTAINERTEST" -eq "1" ]; then
    t_Log "Running in container -> SKIP"
    exit 0
fi

ret_val=1

# send mail to localhost
mail=$(echo -e "helo localhost\nmail from: root@localhost\nrcpt to: root@localhost\ndata\nt_functional test\n.\nquit\n" | nc -w 5 127.0.0.1 25 | grep queued)
MTA_ACCEPT=$?
if [ $MTA_ACCEPT == 0 ]
  then
  t_Log 'Mail has been queued successfully'
fi

sleep 1

if [ "$centos_ver" -eq "8" ]; then
  t_Log "Dumping journalctl to /var/log/maillog"
  journalctl -u postfix >> /var/log/maillog
fi

regex='250\ 2\.0\.0\ Ok\:\ queued\ as\ ([0-9A-Z]*).*'
if [[ $mail =~ $regex ]]
  then
  grep -q "${BASH_REMATCH[1]}: removed" /var/log/maillog
  DELIVERED=$?
fi

if ([ $MTA_ACCEPT == 0  ] && [ $DELIVERED == 0 ])
  then
  ret_val=0
  t_Log 'Mail has been delivered and removed from queue.'
fi

t_CheckExitStatus $ret_val
