#!/bin/sh
sed -i 's/razor_prd/\/\/razor_db\/razor_prd/' /etc/razor/config.yaml
cd /var/lib/razor/repo-store
tar -xf /tmp/razor-microkernel-latest.tar .
razor-admin -e production migrate-database
/tmp/razor-server.sh start
