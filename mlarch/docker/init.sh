#!/usr/bin/env bash
if [ -z "$1" ]; then
    docker-compose -f docker-compose.yml up -d
else
    docker-compose -f $1 up -d
fi

## Iniciar los dockers de ElasticSearch, Spark, Mongo, ActiveMQ
docker-compose ps

exit 0
