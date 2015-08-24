#/bin/bash

master_host=$1
master_user=$2
master_pass=$3
nslave=$4

# Start some slaves
for i in `seq 1 $nslave`;
do
  echo $i
  docker run -d --dns 128.8.127.50 --volumes-from cuadata -P --name slave-$i -e SWARM_MASTER=$master_host -e SWARM_USER=$master_user -e SWARM_PASSWORD=$master_pass bryantrobbins/jslave
  sleep 15
done
