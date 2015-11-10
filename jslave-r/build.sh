#!/bin/bash
docker build --no-cache -t="bryantrobbins/jslave-r" .
if [ $? -eq 0 ]
	then
		docker save -o jslave.tar bryantrobbins/jslave-r
fi

exit $?
