#/bin/bash

archive=$1

if [ -z "$archive" ]; then
  echo "No archive provided."
  echo "Usage: $0 archive.tar numberOfSlaves"
  exit
fi

nslave=$2

if [ -z "$nslave" ]; then
  echo "Number of jenkins slaves not provided"
  echo "Usage: $0 archive.tar numberOfSlaves"
  exit
fi

./load-master.sh $archive

# Start nexus
docker stop nexus
docker rm nexus
docker run -d --name nexus -h nexus --volumes-from cuadata -p 8081:8081 conceptnotfound/sonatype-nexus

# Start mongo
docker stop mongo
docker rm mongo
docker run -d --name mongo --volumes-from cuadata -p 37017:27017 -p 38017:28017 dockerfile/mongodb mongod --rest --httpinterface
 
# Start jenkins
docker stop jenkins
docker rm jenkins
docker run -d --name jenkins --volumes-from cuadata --link nexus:nexus --link mongo:mongo -p 8080:8080 -p 50000:50000 -u root jenkins

# Stop any existing slaves
docker ps -a | awk '{print $1,$2}' | grep "bryantrobbins/jslave-linked" | awk '{print $1}' | xargs docker stop
docker ps -a | awk '{print $1,$2}' | grep "bryantrobbins/jslave-linked" | awk '{print $1}' | xargs docker rm

# Build slave-linked image
docker rmi bryantrobbins/jslave-linked
docker build -t="bryantrobbins/jslave-linked" ./slave-linked

# Start new slaves
for i in `seq 1 $nslave`;
do
  echo $i
  docker run -d --volumes-from cuadata -P --name slave-$i --link jenkins:jenkins bryantrobbins/jslave-linked
  sleep 15
done
