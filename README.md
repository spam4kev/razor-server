This repo builds a couple docker containers used for kickstarting my openstack server using puppet's razor app.
It expects your host already has a large storage space mounted at /data to be shared into the two containers.

- Run the below commands to prep your workstation to spin up the razor server container & backend database container
```bash
sudo sh -c "curl -L https://github.com/docker/compose/releases/download/1.5.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose"
sudo chmod +x /usr/local/bin/docker-compose
mkdir -p /data/razor /data/razor/pgsql
chmod 777 /data/razor/pgsql
chmod 775 /data/razor
chown root /data/razor
git clone https://github.com/spam4kev/razor-server.git
cd ~
docker-compose up
#cleanup
docker-compose rm
docker rmi razorserver_razorserver
sudo rm -rf /data/razor/pgsql/userdata/ /data/razor/repo-store/* /data/razor/razor-server.sh
```

-  UPDATE: compose feature is broke currently. do this until it is fixed.

```bash
git clone  https://github.com/spam4kev/razor-server.git
cd razor-server
docker build -t razor .
```

# Some troubleshooting steps

```bash
docker run -d --name razorserver_razordb -e POSTGRESQL_USER=razor -e POSTGRESQL_PASSWORD=mypass -e POSTGRESQL_DATABASE=razor_prd -v /data/razor/pg centos/postgresql-94-centos7

docker run -v /data/razor:/var/lib/razor -t -i --link razorserver_razordb --name razorserver_razorserver_1 centos sh
docker commit -m "centos + razor rpm" $(docker ps -lq) razor-test

docker run -t -i --name razorserver_razorserver_1 spam4kev/razor-server sh
docker exec -i -t razorserver_razorserver_1  bash
docker logs razorserver_razordb
psql -h razor_db -p 5432 -d razorserver_razordb -U razor
```


-  The below manual build steps have proven to work if all else fails

```bash

sed -i 's/razor_prd/\/\/razorserver_razordb_1\/razor_prd/' /etc/razor/config.yaml
curl -SL http://links.puppetlabs.com/razor-microkernel-latest.tar      | tar -xC /var/lib/razor/repo-store/
razor-admin -e production migrate-database
/etc/razor/razor-server.sh start
# CTRL-P + CTRL-Q to disconnect
```  
