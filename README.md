# Installation

```sh
git clone git@github.com:C5rogers/postgress.git
cd postgress
docker-compose up -d
```

# Connecting to Database

```sh
psql -h localhost -U databaseuser -d database
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
