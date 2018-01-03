#!/bin/bash

mc()
{
	echo '#Include path:'
	make -Bik 2>&1 | grep -o '\-I[[:space:]]*[^[:space:]]\+' | \
		sed 's/\-I[[:space:]]*//' | sort -u | sed 's/\(.*\)/\1 \\/'

	echo '#Library path:'
	make -Bik 2>&1 | grep -o '\-L[[:space:]]*[^[:space:]]\+' | \
		sed 's/\-L[[:space:]]*//' | sort -u | sed 's/\(.*\)/\1 \\/'

	echo '#Library list:'
	make -Bik 2>&1 | grep -o '\-l[[:space:]]*[^[:space:]]\+' | \
		sed 's/\-l[[:space:]]*//' | sort -u | sed 's/\(.*\)/\1 \\/'
}
