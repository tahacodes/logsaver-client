while true; 
do
  seed=$(((RANDOM%10)+1))
  if [ $(($seed%2)) -eq 0 ]
  then
    res=$(curl -I rockandcode.ir/first | tr '\r\n' ' ' | tr '\r,' ' ')
  else
    res=$(curl -I rockandcode.ir/second | tr '\r\n' ' ' | tr '\r,' ' ')
  fi

  timestamp=$(date +%s)
  log=""
  if [[ "$res" =~ .*"200 OK".* ]];
  then
    log+="OK,$timestamp,$res"
  else
    log+="ERR,$timestamp,$res"
  fi

  echo $log >> ~/logs
done