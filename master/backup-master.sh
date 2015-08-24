#/bin/bash
 
now=`date +%s`
archive="backup.master.$now.tar"
 
local=`pwd`
echo "Backing master up to $archive"
 
echo "Exporting data current cuadata container"
docker rm backup
docker run --name backup --volumes-from cuadata -v $local:/backup busybox tar cvf /backup/$archive var/jenkins_home nexus data/db sources
docker rm backup

echo "Done"
