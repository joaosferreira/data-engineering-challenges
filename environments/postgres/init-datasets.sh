#!/usr/bin/env bash
# The official PostgreSQL entrypoint sources non-executable .sh files on first
# initialization. Only datasets with an init.sql are registered.
set -e

for init_file in /datasets/*/init.sql; do
  [[ -f "$init_file" ]] || continue

  dataset_name="$(basename "$(dirname "$init_file")")"
  if [[ ! "$dataset_name" =~ ^[a-z][a-z0-9_]*$ || ${#dataset_name} -gt 63 ]]; then
    echo "Invalid dataset directory name: $dataset_name" >&2
    exit 1
  fi

  echo "Initializing dataset: $dataset_name"
  psql --set=ON_ERROR_STOP=1 --set="dataset_schema=$dataset_name" \
    --username="$POSTGRES_USER" --dbname="$POSTGRES_DB" --file="$init_file"
done
