#!/usr/bin/env bash

## Iniciar los dockers de ElasticSearch, Spark y Mongo
docker-compose -f docker-compose.yml up -d
docker-compose ps

exit 0
