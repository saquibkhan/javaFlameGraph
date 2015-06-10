#!/bin/sh
 
TMPDIR=./tmp_flame

mkdir $TMPDIR 2> /dev/null

TMPSTACKS=$TMPDIR/flamegraph-stacks-collapsed.txt
TMPPALETTE=$TMPDIR/flamegraph-palette.map

perl ./FlameGraph/stackcollapse-jstack.pl $1 > $TMPSTACKS
 
# 1st run - hot: default
if [ "$2" == "" ]
then 
	perl ./FlameGraph/flamegraph.pl --cp $TMPSTACKS > stacks.svg
else
	grep $2 $TMPSTACKS | perl ./FlameGraph/flamegraph.pl --cp > stacks.svg
fi

 
# 2nd run - blue: I/O
mv palette.map $TMPPALETTE
cat $TMPPALETTE | grep -v '\.read' | grep -v '\.write' | grep -v 'socketRead' | grep -v 'socketWrite' | grep -v 'socketAccept' > palette.map

if [ "$2" == "" ]
then 
	perl ./FlameGraph/flamegraph.pl --cp --colors=io $TMPSTACKS > flame.svg
else
	grep $2 $TMPSTACKS | perl ./FlameGraph/flamegraph.pl --cp --colors=io > flame.svg
fi
