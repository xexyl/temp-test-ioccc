#!/usr/bin/env bash

awk '
r==1 { r=0; if (/>=/){print ">>>="; next}
            if (/>/) {print ">>>";  next}
	    print ">>" }
r==3 { if (/\./){ r=4; next } r=0; print "." }
r==4 { if (/\./){ r=0; print "..."; next} print ".\n."}

# digraphs
r==2 { r=0; if (/>/){print "]"; next}
	    if (/:/){print "::"; next}
            print ":" }
r==5 { r=0; if (/:/){print "["; next}
            if (/%/){print "{"; next}
	    print "<" }
r==6 { r=0; if (/>/){print "}"; next}
            if (/:/){print "#"; next}
	    print "%" }

/^>>$/ {r=1;next}	# java
/^:$/  {r=2;next}	# c++, java classes, digraph
/^\.$/ {r=3;next}	# mea culpa - ellipsis
/^<$/  {r=5;next}	# digraph
/^%$/  {r=6;next}	# digraph

{ print $0 }' "$@"
