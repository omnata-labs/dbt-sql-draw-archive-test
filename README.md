# dbt-sql-draw-archive-test

# Local development

## Prerequisites
- python 3
- dbt
- docker (for running postgres)

## Creating a database

Spin up a local postgres container in docker:
```
docker run --name postgres-dbt-local -e POSTGRES_PASSWORD=my_password -p 5432:5432 -d postgres:13.2-alpine
```

Configure your `~/.dbt/profiles.yml` to contain:

```
dbt_sql_draw:
  target: localpostgres
  outputs:
    localpostgres:
      type: postgres
      host: localhost
      user: postgres
      pass: my_password
      port: 5432
      dbname: postgres
      schema: sql_draw
```

## Build the models
Install dbt, then:
```
dbt run --target localpostgres
```
## Generate images

```
pip3 install -r requirements.txt
export POSTGRES_DB_NAME=postgres
export POSTGRES_USERNAME=postgres
export POSTGRES_PASSWORD=my_password
export POSTGRES_HOSTNAME=localhost
export POSTGRES_SCHEMA_NAME='sql_draw'

python3 ci/render_images_from_db.py
```

Now check the images/ directory

## When finished
Remove local postgres container:
```
docker rm postgres-dbt-local
```



