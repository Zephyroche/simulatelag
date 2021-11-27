#!/bin/bash

TC=/sbin/tc #Default path to tc
IF=eth #Interface name
DST_CIDR=ip #Address to apply lag on

LOSS="0%" #Default loss value
CORRUPT="0%" #Default corrupt value

if [ "$2" ]; then
   LOSS="$2%"
   echo "LOSS : $LOSS"
fi

if [ "$3" ]; then
   CORRUPT="$3"
   echo "CORRUPT : $LOSS"
fi

do_start() {

modprobe sch_netem

for ETH in $IF; do
$TC qdisc add dev $ETH root handle 1: prio
$TC qdisc add dev $ETH parent 1:3 netem loss $LOSS corrupt $CORRUPT
$TC filter add dev $ETH protocol ip parent 1:0 prio 3 u32 match ip dst $DST_CIDR flowid 1:3
done;

}

do_stop() {

for ETH in $IF; do
$TC qdisc del dev $ETH root handle 1:
done;

modprobe -r sch_netem

}

do_status() {

for ETH in $IF; do
$TC qdisc show dev $ETH
done;

}

case "$1" in
 start)
  do_start
   ;;
 stop)
  do_stop
   ;;
 status)
  do_status
   ;;
 *)
   echo "Usage : simulatelag.sh start|stop [ \$CORRUPT [ \$LOSS ] ]"
   echo " LOSS in %"
   echo " CORRUPT in %"
   ;;
esac
