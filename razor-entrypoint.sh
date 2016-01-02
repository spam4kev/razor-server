#!/bin/sh
sed -i 's/razor_prd/\/\/razor_db\/razor_prd/' /etc/razor/config.yaml
[[ ! -f ./razor-microkernel-latest.tar ]] && wget http://links.puppetlabs.com/razor-microkernel-latest.tar
tar -xf razor-microkernel-latest.tar
razor-admin -e production migrate-database
/tmp/razor-server.sh start
