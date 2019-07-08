#! /bin/sh

# example metabase migration from H2 to postgres script
# see: https://www.metabase.com/docs/latest/operations-guide/running-metabase-on-docker.html

METABASE_VERSION="v0.32.9"
METABASE_COMPOSE_DOCKER_NETWORK_NAME="metabase_default"
METABASE_DOCKER_H2_VOLUME_NAME="metabase"

docker run --rm --name metabase-migration \
    -v ${METABASE_DOCKER_H2_VOLUME_NAME}:/metabase-data \
    -e "MB_DB_FILE=/metabase-data/metabase.db" \
    -e "MB_DB_TYPE=postgres" \
    -e "MB_DB_DBNAME=metabase" \
    -e "MB_DB_PORT=5432" \
    -e "MB_DB_USER=metabase" \
    -e "MB_DB_PASS=metabase" \
    -e "MB_DB_HOST=database" \
	--network ${METABASE_COMPOSE_DOCKER_NETWORK_NAME} \
    "metabase/metabase:${METABASE_VERSION}" load-from-h2
