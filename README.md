# Urso DB – Docker Compose Setup

This project provides a **PostgreSQL 16** container built from a custom Dockerfile and managed with **Docker Compose**. This custom Postgres image has `pg_parquuet` extension installed, which allows manipulating Parquet files locally and from storage services like S3, Google Cloud Storage, Azure Blob Storage etc.
Also, files can be shared from and to this container through `exports` folder.

---

## Prerequisites

* Docker 20+
* Docker Compose 2+

---

## Project structure

* `Dockerfile`
* `docker-compose.yml`
* `init.sql` (optional, database initialization)

---

## Build the image

```bash
docker compose build
```

---

## Start the database

```bash
docker compose up -d
```

---

## Connect to PostgreSQL

Using `psql`:

```bash
docker exec -it postgres-urso psql -U postgres -d urso-db
```

Using a SQL client (e.g. DBeaver) (also these values are suggestions and can be modified at `.env` file):

* Host: `localhost`
* Port: `5431`
* User: `postgres`
* Password: `123`
* Database: `urso-db`

---

## Stop the environment

```bash
docker compose down
```

If you wish wiping the database as well, type:

```
docker compose down -v
```

---

## Notes

* Any SQL script mounted into `/docker-entrypoint-initdb.d/` is executed automatically on first startup
* Data persistence depends on Docker volumes defined in `docker-compose.yml`

---

