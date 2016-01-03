#!/bin/sh
sed -i 's/\:razor_prd/\:\/\/razorserver_razordb_1\/razor_prd/' /etc/razor/config.yaml
curl -SL http://links.puppetlabs.com/razor-microkernel-latest.tar | tar -xC /var/lib/razor/repo-store/ 
razor-admin -e production migrate-database

exec >&"/var/log/razor-server/console.log" "/opt/razor-torquebox/jboss/bin/standalone.sh" \
       "-Djboss.server.log.dir=/var/log/razor-server" \
       "-b" "0.0.0.0" "-Dhttp.port=8150" \
       "-Dhttps.port=#{RAZOR_HTTPS_PORT}"

