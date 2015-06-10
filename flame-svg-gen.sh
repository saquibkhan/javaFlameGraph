#!/bin/sh
echo "wait generating report..."

TMPSTACKS=$TMPDIR/flamegraph-stacks-collapsed.txt
TMPPALETTE=$TMPDIR/flamegraph-palette.map

perl ./FlameGraph/stackcollapse-jstack.pl $1 > $TMPSTACKS
 
# 1st run - hot: default
if [ "$2" == "" ]
then 
	perl ./FlameGraph/flamegraph.pl --cp $TMPSTACKS > stacks.html
else
	grep $2 $TMPSTACKS | perl ./FlameGraph/flamegraph.pl --cp > stacks.html
fi

 
# 2nd run - blue: I/O
mv palette.map $TMPPALETTE
cat $TMPPALETTE | grep -v '\.read' | grep -v '\.write' | grep -v 'socketRead' | grep -v 'socketWrite' | grep -v 'socketAccept' > palette.map

if [ "$2" == "" ]
then 
	perl ./FlameGraph/flamegraph.pl --cp --colors=io $TMPSTACKS > flame.html
else
	grep $2 $TMPSTACKS | perl ./FlameGraph/flamegraph.pl --cp --colors=io > flame.html
fi

#echo "done!"
open ./flame.html
