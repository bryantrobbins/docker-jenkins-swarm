#!/bin/bash

# Args
image=$1

# Stop existing slaves
docker ps -a | awk '{print $1,$2}' | grep ${image} | awk '{print $1}' | xargs docker stop
docker ps -a | awk '{print $1,$2}' | grep ${image} | awk '{print $1}' | xargs docker rm

exit 0
