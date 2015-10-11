#!/bin/bash
docker build -t="bryantrobbins/jslave-guitar" .
if [ $? -eq 0 ]
	then
		docker save -o jslave.tar bryantrobbins/jslave-guitar
	else
		exit -1
fi
