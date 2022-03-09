PID=./tmp/pids/puma.pid
PUMA_PID=`cat $PID`

evt=development
if [ -n "$2" ];then
    evt=$2
fi

action=$1
case $action in
start)
    RAILS_ENV=$evt bundle exec puma -C config/puma.rb
    echo '--start [OK]'
    ;;
stop)
    RAILS_ENV=$evt bundle exec pumactl -p $PUMA_PID stop
    echo '--stop [OK]'
    ;;
restart)
    RAILS_ENV=$evt bundle exec pumactl -p $PUMA_PID restart
    echo '--restart [OK]'
    ;;
upgrade)
    RAILS_ENV=$evt bundle exec pumactl -p $PUMA_PID phased-restart
    echo '--upgrade [OK]'
    ;;
esac