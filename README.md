# Installation

```sh
git clone git@github.com:C5rogers/postgress.git
cd postgress
docker-compose up -d
```

# Inspect the container to extract the connecting ip address

```sh

docker inspect <containerId> # and replace the connection string ip address form the inspect information provided
```

# Connecting to Database

```sh
psql -h <conatainerIpAddress> -U databaseuser -d database
```

# Creating New Database after connecting in sheel

```sh
CREATE ROLE postgres WITH SUPERUSER CREATEDB CREATEROLE LOGIN PASSWORD 'your_password';

# Or Altering pre-existed user role

ALTER USER postgres CREATEDB;

```

# Checking if the port is occupied

```sh
sudo netstat -tuln | grep 5432

# or

lsof -i:5432


# killing the process if the process is existed

sudo kill -9 <PID>

```

# Creating super user in the database

```sh
docker exec -it postgres_container psql -U postgres
```

# Additionally

```sh
#  go to localhost:5050 to get the databse
http://localhost:5050/

```

# Task commands

```sh
# to initialize the database
task compose -- up

# to initialize the database in debug mode
task compose -- up -d

# to see database logs
task log_pg
```

# To dump and backup the database u can use the following command after u setup the pg_dumb

```sh
e.g: pg_dump --dbname=postgresql://c5rogers:natiman@172.18.0.3:5432/hackaton_project \
--format=custom \
--file=hackaton_project.backup
```

# To restore the database u can use the following command after u setup the pg_restore command

```sh
pg_restore --dbname=postgresql://c5rogers:natiman@172.18.0.3:5432/hackaton_project\
--verbose \
--clean \
hackaton_project.backup
```

# To backup the database on production server

```sh
pg_dump -h <host> -U <user> -d <database> > <backup_file_name>.sql
e.g: pg_dump -h staging-restored.cqef577xwqhr.eu-central-1.rds.amazonaws.com -U postgres -d steep_meal > steep_meal_backup.sql
```

# To Dump specific schema of the database use the command like this

```sh
pg_dump -h <host> -U <user> -d <database> --schema=<schema_name> --data-only --file=<backup_file.sql>
```

# Another way to restore a db content

```sh
psql -h <host> -U <user> -d <database> -f <backup_file.sql>
```

# To save the database erd files to your local machine it is configured as the docker-compose.yml file but give permission for it like this

```sh
sudo chown -R 5050:5050 ./pgadmin_storage
sudo chown -R $USER:$USER ./pgadmin_storage
```

# this will give you the permissions to access the pgadmin_storage folder and save the erd files in it
