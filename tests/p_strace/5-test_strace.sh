#!/bin/bash
# Author: Steve Barnes (steve@echo.id.au)

if [ "$CONTAINERTEST" -eq "1" ]; then
    t_Log "Running in container -> SKIP"
    exit 0
fi

t_Log "Running $0 - checking strace runs and returns non-zero exit status."

STRACE=`which strace`

[ "$STRACE" ] || { t_Log "Failed to find strace. Cannot continue."; exit $FAIL; }

$STRACE ls &>/dev/null

[ $? -eq 0 ] || { t_Log "Strace exited with non-zero status. That ain't good..."; exit $FAIL; }
