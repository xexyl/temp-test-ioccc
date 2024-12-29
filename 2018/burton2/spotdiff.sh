#!/usr/bin/env bash

# filename is 17
# 1=cl 2=cw 3=cc 4=ci 5=ts 6=kw 7=kws
# 9    10   11   12   13   14   15
awk '{
	printf "cl %d cw %d cc %d ci %d ts %d kw %d ks %d %s %s\n",
		$9-$1, $10-$2, $11-$3, $12-$4, $13-$5, $14-$6, $15-$7, $17, $18
}'
