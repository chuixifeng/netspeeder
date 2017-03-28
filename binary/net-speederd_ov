#!/bin/bash
#
# chkconfig: - 98 02
# description: Starts and stops the your_prog_name daemon.

. /etc/init.d/functions

prog_name="net_speeder64"
prog_path="/usr/shell/${prog_name}"


start(){
  echo  $"Starting ${prog_name}: "
  ${prog_path} venet0 "ip" > /tmp/net-speeder.log  &
  return $?
}

stop(){
  echo  $"Stopping ${prog_name}: "
  kill -9 $(pidof ${prog_path} )
  return $?
}

case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  restart)
    stop
    sleep 1
    start
    ;;
  status)
        echo -n $"pid $(pidof ${prog_path} )"
    ;;
  *)
    echo $"Usage: $0 {start|stop|restart|status}"
    exit 2
esac
exit $?
