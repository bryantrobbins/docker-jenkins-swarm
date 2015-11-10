#/bin/bash

master_host=$1
master_user=$2
master_pass=$3
image=$4
nslave=$5

# Clip the last letter of the image to serve as a prefix (avoids collisions in container names)
prefix="${str: -1}"

# Start some slaves
for i in `seq 1 $nslave`;
do
  echo $i
  docker run -d --dns 128.8.127.50 -P --name slave-$prefix-$i -e SWARM_MASTER=$master_host -e SWARM_USER=$master_user -e SWARM_PASSWORD=$master_pass ${image}
  sleep 10
done
