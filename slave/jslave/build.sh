#!/bin/bash
docker build -t="bryantrobbins/jslave" .
if [ $? -eq 0 ]
	then
		docker save -o jslave.tar bryantrobbins/jslave
fi
