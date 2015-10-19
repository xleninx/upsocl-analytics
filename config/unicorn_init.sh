#!/bin/sh
### BEGIN INIT INFO
# Provides:          unicorn
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Manage unicorn server
# Description:       Start, stop, restart unicorn server for a specific application.
### END INIT INFO
set -e

# Feel free to change any of the following variables for your app:
TIMEOUT=${TIMEOUT-60}
APP_ROOT=/home/upsocl/app/upsocl-analytics
PID=$APP_ROOT/tmp/pids/unicorn.pid
CMD="cd $APP_ROOT; bundle exec unicorn -D -c $APP_ROOT/config/unicorn.rb -E production"
AS_USER=deployer
set -u

OLD_PIN="$PID.oldbin"

sig () {
  test -s "$PID" &amp;&amp; kill -$1 `cat $PID`
}

oldsig () {
  test -s $OLD_PIN &amp;&amp; kill -$1 `cat $OLD_PIN`
}

run () {
  if [ "$(id -un)" = "$AS_USER" ]; then
    eval $1
  else
    su -c "$1" - $AS_USER
  fi
}

case "$1" in
start)
  sig 0 &amp;&amp; echo &gt;&amp;2 "Already running" &amp;&amp; exit 0
  run "$CMD"
  ;;
stop)
  sig QUIT &amp;&amp; exit 0
  echo &gt;&amp;2 "Not running"
  ;;
force-stop)
  sig TERM &amp;&amp; exit 0
  echo &gt;&amp;2 "Not running"
  ;;
restart|reload)
  sig HUP &amp;&amp; echo reloaded OK &amp;&amp; exit 0
  echo &gt;&amp;2 "Couldn't reload, starting '$CMD' instead"
  run "$CMD"
  ;;
upgrade)
  if sig USR2 &amp;&amp; sleep 2 &amp;&amp; sig 0 &amp;&amp; oldsig QUIT
  then
    n=$TIMEOUT
    while test -s $OLD_PIN &amp;&amp; test $n -ge 0
    do
      printf '.' &amp;&amp; sleep 1 &amp;&amp; n=$(( $n - 1 ))
    done
    echo

    if test $n -lt 0 &amp;&amp; test -s $OLD_PIN
    then
      echo &gt;&amp;2 "$OLD_PIN still exists after $TIMEOUT seconds"
      exit 1
    fi
    exit 0
  fi
  echo &gt;&amp;2 "Couldn't upgrade, starting '$CMD' instead"
  run "$CMD"
  ;;
reopen-logs)
  sig USR1
  ;;
*)
  echo &gt;&amp;2 "Usage: $0 &lt;start|stop|restart|upgrade|force-stop|reopen-logs&gt;"
  exit 1
  ;;
esac
