FROM postgres:16-alpine

# Ship the hook in the image so its permissions are reliable on Docker Desktop.
COPY --chmod=0644 init-datasets.sh /docker-entrypoint-initdb.d/10-init-datasets.sh
