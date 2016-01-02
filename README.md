This repo builds a couple docker containers used for kickstarting my openstack server using puppet's razor app.
- Run the below commands to prep your workstation to spin up the razor server container & backend database container
```bash
sudo sh -c " curl -L https://github.com/docker/compose/releases/download/1.5.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose"
sudo chmod +x /usr/local/bin/docker-compose
mkdir -p /data/razor /data/razor/pgsql
chmod 777 /data/razor/pgsql
chmod 775 /data/razor
chown root /data/razor
```

# Some troubleshooting steps


docker run -d --name razor_db -e POSTGRESQL_USER=razor -e POSTGRESQL_PASSWORD=mypass -e POSTGRESQL_DATABASE=razor_prd -v /data/razor/pgsql:/var/lib/pgsql/data centos/postgresql-94-centos

docker run -v /data/razor:/var/lib/razor -t -i --link razor_db centos
docker commit -m "centos + razor rpm" $(docker ps -lq) razor-test


sudo docker exec -i -t razor_db bash
docker logs razor_db
psql -h razor_db -p 5432 -d razor_prd -U razor
