This repo builds a couple docker containers used for kickstarting my openstack server using puppet's razor app.
- Run the below command to spin up the razor backend database container
```bash
docker run -d --name razor_db -e POSTGRESQL_USER=razor -e POSTGRESQL_PASSWORD=$1 -e POSTGRESQL_DATABASE=razor_prd -p 5432:5432 -v /data/pgsql:/var/lib/pgsql/data centos/postgresql-94-centos7
# Some troubleshooting steps
sudo docker exec -i -t razor_db bash
docker logs razor_db
psql -h localhost -p 5432 -d razor -U razor
```
