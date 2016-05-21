#!/bin/bash
docker build --no-cache -t="bryantrobbins/jslave-latex" .
if [ $? -eq 0 ]
	then
		docker save -o jslave.tar bryantrobbins/jslave-guitar
	else
		exit -1
fi
