#!/bin/sh

TMPTRACE=./tmp_flame/trace.txt
rm $TMPTRACE 2> /dev/null
pid=""
if [ "$1" == "" ]
then
  while [ "$pid" == "" ]
  do
      #For Windows with Cygwin uncomment it
  	#pid=`ps -W | grep java | grep -o [0-9]* | head -1`
      pid=`ps | grep java | grep -v grep | grep -o [0-9]* | head -1`
  	if [ "$pid" != "" ]
  	then
  		break
  	fi
  done
else
  pid=$1;
fi
echo "process id:" $pid
while true;
do
	jstack $pid >> $TMPTRACE && sleep 0.001 || break
done

sh ./flame-svg-gen.sh $TMPTRACE

#echo "Done! please check Flame.svg"