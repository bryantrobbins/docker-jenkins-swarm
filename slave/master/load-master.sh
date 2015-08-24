#/bin/bash
 
archive=$1
 
if [ -z "$archive" ]; then
  echo "No archive provided."
  echo "Usage: $0 archive.tar"
  exit
fi
 
echo "Loading from $archive"
 
# Clean up any old stuff here
docker rm cuadata
 
# Start new data container
echo "Starting new  cuadata container"
docker run -d --name cuadata -v /sources -v /var/jenkins_home -v /nexus -v /data/db busybox true
 
# Copy in files from old data container
echo "Restoring old files into new cuadata"
docker rm restore
docker run --name restore --volumes-from cuadata -v $(pwd):/backup busybox tar xvf /backup/$archive
docker rm restore
