#!/bin/bash

server="http://rockandcode.ir"
logfile="/home/$USER/logs"

if [ -n "$1" ]; then
  if [ "$1" = "save" ]; then
    if test -f "$logfile"; then
      curl $server/logsaver -H "Content-type: multipart/form-data" -F file=@$logfile
    else
      echo "$logfile doesn't exist."
    fi
  elif [ "$1" = "show" ]; then
    curl $server/logsaver
  fi
else
  while true; 
  do
    seed=$(((RANDOM%10)+1))
    if [ $(($seed%2)) -eq 0 ]; then
      res=$(curl -I $server/first | tr '\r\n' ' ' | tr '\r,' ' ')
    else
      res=$(curl -I $server/second | tr '\r\n' ' ' | tr '\r,' ' ')
    fi

    timestamp=$(date +%s)
    log=""
    if [[ "$res" =~ .*"200 OK".* ]]; then
      log+="OK,$timestamp,$res"
    else
      log+="ERR,$timestamp,$res"
    fi

    echo $log >> ~/logs
  done
fi