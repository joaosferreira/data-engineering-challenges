# Data Engineering Interview Exercises

This repository is for reusable technical interview exercises for Data Engineering roles. Each exercise keeps the candidate assignment alongside the information an interviewer needs to administer and evaluate it. Exercises may share datasets and execution environments without requiring a fixed assessment or curriculum.

## Repository guide

- [`exercises/`](exercises/README.md) contains the exercise-authoring conventions and, as exercises are added, one directory per exercise.
- [`datasets/`](datasets/README.md) holds reusable data and initialization resources.
- [`environments/postgres/`](environments/postgres/compose.yaml) holds the reusable PostgreSQL runtime definition.
- [`SPECS.md`](SPECS.md) is the authoritative project specification.
- [`docs/ROADMAP.md`](docs/ROADMAP.md) records implementation milestones.

## For interviewers

Browse the exercise directories under `exercises/`. Each exercise's `README.md` is interviewer-facing; its `exercise.md` is the candidate-facing assignment. Keep reference solutions and evaluation guidance within the exercise directory, but do not share those interviewer-facing files as candidate instructions.

### PostgreSQL environment

Install Docker with Docker Compose **v2.20 or newer**, then run these commands from the repository root:

```sh
docker compose up -d               # Start PostgreSQL; initialize registered datasets on first run
docker compose ps                  # Check readiness (healthy)
docker compose exec postgres psql -U interviewer -d interviews  # Interactive SQL client
docker compose down                # Stop, retaining database data
docker compose down --volumes      # Reset: delete local database data
docker compose up -d               # Start again with fresh dataset initialization
```

Alternatively, connect from a local PostgreSQL client at `127.0.0.1:5432` with database `interviews`, user `interviewer`, and password `localdev` (for local development only). If port 5432 is in use, set `POSTGRES_PORT` when running Compose (for example, `POSTGRES_PORT=55432 docker compose up -d`) and connect to that port instead. The database is bound to localhost, not exposed on other network interfaces.

Only datasets with an `init.sql` file are loaded; see [`datasets/README.md`](datasets/README.md) for the registration and schema convention. A fresh deployment loads the e-commerce dataset into the `ecommerce` schema; see its [table documentation](datasets/ecommerce/README.md). `down` preserves data; **`down --volumes` permanently removes local database changes** and reloads datasets on the next `up`. Initialization does not require assessment packaging.

## For contributors

Read [`exercises/README.md`](exercises/README.md) before adding an exercise. Use a unique, stable integer ID, keep all exercise-specific materials together, and distinguish candidate instructions from interviewer-only content. Consult [`SPECS.md`](SPECS.md) for the complete requirements.
