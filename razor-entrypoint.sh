#!/bin/sh
sed -i 's/\:razor_prd/\:\/\/razorserver_razordb_1\/razor_prd/' /etc/razor/config.yaml
curl -SL http://links.puppetlabs.com/razor-microkernel-latest.tar | tar -xC /var/lib/razor/repo-store/ 
razor-admin -e production migrate-database

#for (( count=0; count<30; count++ )); do
#   echo -n '.'
#    sleep 1
#done

/etc/razor/razor-server.sh start
