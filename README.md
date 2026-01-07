# PostgreSQL 16 – Docker Compose Setup

This project provides a **PostgreSQL 16** container built from a custom Dockerfile and managed with **Docker Compose**.

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

Using a SQL client (e.g. DBeaver):

* Host: `localhost`
* Port: `5432`
* User: `postgres`
* Password: `123`
* Database: `urso-db`

---

## Stop the environment

```bash
docker compose down
```

---

## Notes

* Any SQL script mounted into `/docker-entrypoint-initdb.d/` is executed automatically on first startup
* Data persistence depends on Docker volumes defined in `docker-compose.yml`

---

