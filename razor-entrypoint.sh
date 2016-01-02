#!/bin/sh
sed -i 's/razor_prd/\/\/razor_db\/razor_prd/' /etc/razor/config.yaml
curl -SL http://links.puppetlabs.com/razor-microkernel-latest.tar \
     | tar -xC /var/lib/razor/repo-store/
razor-admin -e production migrate-database
/etc/razor/razor-server.sh start
