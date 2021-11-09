#!/bin/bash



(/usr/bin/find ./tests/$1/ -type f -perm /u=x|sort -t'/' )
