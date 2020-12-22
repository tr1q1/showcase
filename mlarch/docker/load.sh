#!/usr/bin/env bash

## NOTA: si hay memoria suficiente, en caso de trabajar totalmente en local, se pueden lanzar juntos

## mover el FATJAR de la carpeta donde lo genera el IDE a la carpeta de DATA del docker de SPARK
mv ../target/*-jar-with-dependencies.jar ./data/
echo FATJAR copiado a la carpeta compartida con el servidor de Spark

## convertir los ficheros CSV a HDFS para Spark
#### **** docker exec -it spark_master hdfs dfs -put /tmp/data/MAPIT-dataset_TSMC2014_NYC_00.txt /tmp/data/MAPIT-dataset_TSMC2014_NYC_00
#### **** echo Fichero de datos transformado a HDFS MAPIT-dataset_TSMC2014_NYC_00
## Cargar en ElasticSearch (iniciado desde 0) los datasets que se deseen
## lanzar el JOB con los parametros necesarios al SPARK
#### **** docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.load.es.FromFileToES /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 FILE=/tmp/data/MAPIT-dataset_TSMC2014_NYC_00 SCHEMA="UserID,VenueID,VenueCategoryID,VenueCategoryName,Latitude,Longitude,Timezone,UTCTime,Action" SCHEMA_TYPES="string,string,string,string,dec,dec,int,date,string" DATE_PATTERN="EEE MMM dd HH:mm:ss Z yyyy" DATE_LOCALE=en_US APP=REDEGAL_CLUSTERING RESOURCE=redegal/CLUSTERING SEPARATOR=$'\t' > salida_load.log
#### **** date ; date +%s
## revisar el log de salida de la ejecución del JOB
## cat salida_load.log | more

#### **** docker exec -it spark_master hdfs dfs -put /tmp/data/MAPIT-dataset_TSMC2014_NYC_01.txt /tmp/data/MAPIT-dataset_TSMC2014_NYC_01
#### **** echo Fichero de datos transformado a HDFS MAPIT-dataset_TSMC2014_NYC_01
## Cargar en ElasticSearch (iniciado desde 0) los datasets que se deseen
## lanzar el JOB con los parametros necesarios al SPARK
#### **** docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.load.es.FromFileToES /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 FILE=/tmp/data/MAPIT-dataset_TSMC2014_NYC_01 SCHEMA="UserID,VenueID,VenueCategoryID,VenueCategoryName,Latitude,Longitude,Timezone,UTCTime,Action" SCHEMA_TYPES="string,string,string,string,dec,dec,int,date,string" DATE_PATTERN="EEE MMM dd HH:mm:ss Z yyyy" DATE_LOCALE=en_US APP=REDEGAL_CLUSTERING RESOURCE=redegal/CLUSTERING SEPARATOR=$'\t' > salida_load.log
#### **** date ; date +%s
## revisar el log de salida de la ejecución del JOB
## cat salida_load.log | more

#### **** docker exec -it spark_master hdfs dfs -put /tmp/data/MAPIT-dataset_TSMC2014_NYC_02.txt /tmp/data/MAPIT-dataset_TSMC2014_NYC_02
#### **** echo Fichero de datos transformado a HDFS MAPIT-dataset_TSMC2014_NYC_02
## Cargar en ElasticSearch (iniciado desde 0) los datasets que se deseen
## lanzar el JOB con los parametros necesarios al SPARK
#### **** docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.load.es.FromFileToES /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 FILE=/tmp/data/MAPIT-dataset_TSMC2014_NYC_02 SCHEMA="UserID,VenueID,VenueCategoryID,VenueCategoryName,Latitude,Longitude,Timezone,UTCTime,Action" SCHEMA_TYPES="string,string,string,string,dec,dec,int,date,string" DATE_PATTERN="EEE MMM dd HH:mm:ss Z yyyy" DATE_LOCALE=en_US APP=REDEGAL_CLUSTERING RESOURCE=redegal/CLUSTERING SEPARATOR=$'\t' > salida_load.log
#### **** date ; date +%s
## revisar el log de salida de la ejecución del JOB
## cat salida_load.log | more

## convertir los ficheros CSV a HDFS para Spark
#### **** docker exec -it spark_master hdfs dfs -put /tmp/data/MAPIT-dataset_TSMC2014_TKY_00_00.txt /tmp/data/MAPIT-dataset_TSMC2014_TKY_00_00
#### **** echo Fichero de datos transformado a HDFS MAPIT-dataset_TSMC2014_TKY_00_00
## lanzar el JOB con los parametros necesarios al SPARK
#### **** docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.load.es.FromFileToES /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 FILE=/tmp/data/MAPIT-dataset_TSMC2014_TKY_00_00 SCHEMA="UserID,VenueID,VenueCategoryID,VenueCategoryName,Latitude,Longitude,Timezone,UTCTime,Action" SCHEMA_TYPES="string,string,string,string,dec,dec,int,date,string" DATE_PATTERN="EEE MMM dd HH:mm:ss Z yyyy" DATE_LOCALE=en_US APP=REDEGAL_CLUSTERING RESOURCE=redegal/CLUSTERING SEPARATOR=$'\t' > salida_load.log
#### **** date ; date +%s
## revisar el log de salida de la ejecución del JOB
## cat salida_load.log | more

## convertir los ficheros CSV a HDFS para Spark
#### **** docker exec -it spark_master hdfs dfs -put /tmp/data/MAPIT-dataset_TSMC2014_TKY_00_01.txt /tmp/data/MAPIT-dataset_TSMC2014_TKY_00_01
#### **** echo Fichero de datos transformado a HDFS MAPIT-dataset_TSMC2014_TKY_00_01
## lanzar el JOB con los parametros necesarios al SPARK
#### **** docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.load.es.FromFileToES /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 FILE=/tmp/data/MAPIT-dataset_TSMC2014_TKY_00_01 SCHEMA="UserID,VenueID,VenueCategoryID,VenueCategoryName,Latitude,Longitude,Timezone,UTCTime,Action" SCHEMA_TYPES="string,string,string,string,dec,dec,int,date,string" DATE_PATTERN="EEE MMM dd HH:mm:ss Z yyyy" DATE_LOCALE=en_US APP=REDEGAL_CLUSTERING RESOURCE=redegal/CLUSTERING SEPARATOR=$'\t' > salida_load.log
#### **** date ; date +%s
## revisar el log de salida de la ejecución del JOB
## cat salida_load.log | more

## convertir los ficheros CSV a HDFS para Spark
#### **** docker exec -it spark_master hdfs dfs -put /tmp/data/MAPIT-dataset_TSMC2014_TKY_01_00.txt /tmp/data/MAPIT-dataset_TSMC2014_TKY_01_00
#### **** echo Fichero de datos transformado a HDFS MAPIT-dataset_TSMC2014_TKY_01_00
## lanzar el JOB con los parametros necesarios al SPARK
#### **** docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.load.es.FromFileToES /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 FILE=/tmp/data/MAPIT-dataset_TSMC2014_TKY_01_00 SCHEMA="UserID,VenueID,VenueCategoryID,VenueCategoryName,Latitude,Longitude,Timezone,UTCTime,Action" SCHEMA_TYPES="string,string,string,string,dec,dec,int,date,string" DATE_PATTERN="EEE MMM dd HH:mm:ss Z yyyy" DATE_LOCALE=en_US APP=REDEGAL_CLUSTERING RESOURCE=redegal/CLUSTERING SEPARATOR=$'\t' > salida_load.log
#### **** date ; date +%s
## revisar el log de salida de la ejecución del JOB
## cat salida_load.log | more

## convertir los ficheros CSV a HDFS para Spark
#### **** docker exec -it spark_master hdfs dfs -put /tmp/data/MAPIT-dataset_TSMC2014_TKY_01_01.txt /tmp/data/MAPIT-dataset_TSMC2014_TKY_01_01
#### **** echo Fichero de datos transformado a HDFS MAPIT-dataset_TSMC2014_TKY_01_01
## lanzar el JOB con los parametros necesarios al SPARK
#### **** docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.load.es.FromFileToES /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 FILE=/tmp/data/MAPIT-dataset_TSMC2014_TKY_01_01 SCHEMA="UserID,VenueID,VenueCategoryID,VenueCategoryName,Latitude,Longitude,Timezone,UTCTime,Action" SCHEMA_TYPES="string,string,string,string,dec,dec,int,date,string" DATE_PATTERN="EEE MMM dd HH:mm:ss Z yyyy" DATE_LOCALE=en_US APP=REDEGAL_CLUSTERING RESOURCE=redegal/CLUSTERING SEPARATOR=$'\t' > salida_load.log
#### **** date ; date +%s
## revisar el log de salida de la ejecución del JOB
## cat salida_load.log | more

## convertir los ficheros CSV a HDFS para Spark
#### **** docker exec -it spark_master hdfs dfs -put /tmp/data/MAPIT-dataset_TSMC2014_TKY_02_00.txt /tmp/data/MAPIT-dataset_TSMC2014_TKY_02_00
#### **** echo Fichero de datos transformado a HDFS MAPIT-dataset_TSMC2014_TKY_02_00
## lanzar el JOB con los parametros necesarios al SPARK
#### **** docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.load.es.FromFileToES /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 FILE=/tmp/data/MAPIT-dataset_TSMC2014_TKY_02_00 SCHEMA="UserID,VenueID,VenueCategoryID,VenueCategoryName,Latitude,Longitude,Timezone,UTCTime,Action" SCHEMA_TYPES="string,string,string,string,dec,dec,int,date,string" DATE_PATTERN="EEE MMM dd HH:mm:ss Z yyyy" DATE_LOCALE=en_US APP=REDEGAL_CLUSTERING RESOURCE=redegal/CLUSTERING SEPARATOR=$'\t' > salida_load.log
#### **** date ; date +%s
## revisar el log de salida de la ejecución del JOB
## cat salida_load.log | more

## convertir los ficheros CSV a HDFS para Spark
#### **** docker exec -it spark_master hdfs dfs -put /tmp/data/MAPIT-dataset_TSMC2014_TKY_02_01.txt /tmp/data/MAPIT-dataset_TSMC2014_TKY_02_01
#### **** echo Fichero de datos transformado a HDFS MAPIT-dataset_TSMC2014_TKY_02_01
## lanzar el JOB con los parametros necesarios al SPARK
#### **** docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.load.es.FromFileToES /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 FILE=/tmp/data/MAPIT-dataset_TSMC2014_TKY_02_01 SCHEMA="UserID,VenueID,VenueCategoryID,VenueCategoryName,Latitude,Longitude,Timezone,UTCTime,Action" SCHEMA_TYPES="string,string,string,string,dec,dec,int,date,string" DATE_PATTERN="EEE MMM dd HH:mm:ss Z yyyy" DATE_LOCALE=en_US APP=REDEGAL_CLUSTERING RESOURCE=redegal/CLUSTERING SEPARATOR=$'\t' > salida_load.log
#### **** date ; date +%s
## revisar el log de salida de la ejecución del JOB
## cat salida_load.log | more

## convertir los ficheros CSV a HDFS para Spark
#### **** docker exec -it spark_master hdfs dfs -put /tmp/data/dataset_UbiComp2016_UserProfile_NYC.txt /tmp/data/dataset_UbiComp2016_UserProfile_NYC
#### **** echo Fichero de datos transformado a HDFS MAPIT-dataset_UbiComp2016_UserProfile_NYC
## lanzar el JOB con los parametros necesarios al SPARK
#### **** docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.load.es.FromFileToES /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 FILE=/tmp/data/MAPIT-dataset_TSMC2014_TKY_02_01 SCHEMA="UserID,VenueID,VenueCategoryID,VenueCategoryName,Latitude,Longitude,Timezone,UTCTime,Action" SCHEMA_TYPES="string,string,string,string,dec,dec,int,date,string" DATE_PATTERN="EEE MMM dd HH:mm:ss Z yyyy" DATE_LOCALE=en_US APP=REDEGAL_CLUSTERING RESOURCE=redegal/CLUSTERING SEPARATOR=$'\t' > salida_load.log
#### **** date ; date +%s
## revisar el log de salida de la ejecución del JOB
## cat salida_load.log | more

## convertir los ficheros CSV a HDFS para Spark
#### **** docker exec -it spark_master hdfs dfs -put /tmp/data/dataset_UbiComp2016_UserProfile_TKY.txt /tmp/data/dataset_UbiComp2016_UserProfile_TKY
#### **** echo Fichero de datos transformado a HDFS MAPIT-dataset_UbiComp2016_UserProfile_TKY
## lanzar el JOB con los parametros necesarios al SPARK
#### **** docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.load.es.FromFileToES /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 FILE=/tmp/data/MAPIT-dataset_TSMC2014_TKY_02_01 SCHEMA="UserID,VenueID,VenueCategoryID,VenueCategoryName,Latitude,Longitude,Timezone,UTCTime,Action" SCHEMA_TYPES="string,string,string,string,dec,dec,int,date,string" DATE_PATTERN="EEE MMM dd HH:mm:ss Z yyyy" DATE_LOCALE=en_US APP=REDEGAL_CLUSTERING RESOURCE=redegal/CLUSTERING SEPARATOR=$'\t' > salida_load.log
#### **** date ; date +%s

## convertir los ficheros CSV a HDFS para Spark
#### **** docker exec -it spark_master hdfs dfs -put /tmp/data/MAPIT-dataset_TSMC2014_NYC.txt /tmp/data/MAPIT-dataset_TSMC2014_NYC
#### **** echo Fichero de datos transformado a HDFS MAPIT-dataset_TSMC2014_NYC
## lanzar el JOB con los parametros necesarios al SPARK
#### **** docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.load.es.FromFileToES /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 FILE=/tmp/data/MAPIT-dataset_TSMC2014_TKY_02_01 SCHEMA="UserID,VenueID,VenueCategoryID,VenueCategoryName,Latitude,Longitude,Timezone,UTCTime,Action" SCHEMA_TYPES="string,string,string,string,dec,dec,int,date,string" DATE_PATTERN="EEE MMM dd HH:mm:ss Z yyyy" DATE_LOCALE=en_US APP=REDEGAL_CLUSTERING RESOURCE=redegal/CLUSTERING SEPARATOR=$'\t' > salida_load.log
#### **** date ; date +%s

## convertir los ficheros CSV a HDFS para Spark
#### **** docker exec -it spark_master hdfs dfs -put /tmp/data/MAPIT-dataset_TSMC2014_TKY.txt /tmp/data/MAPIT-dataset_TSMC2014_TKY
#### **** echo Fichero de datos transformado a HDFS MAPIT-dataset_TSMC2014_TKY
## lanzar el JOB con los parametros necesarios al SPARK
#### **** docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.load.es.FromFileToES /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 FILE=/tmp/data/MAPIT-dataset_TSMC2014_TKY_02_01 SCHEMA="UserID,VenueID,VenueCategoryID,VenueCategoryName,Latitude,Longitude,Timezone,UTCTime,Action" SCHEMA_TYPES="string,string,string,string,dec,dec,int,date,string" DATE_PATTERN="EEE MMM dd HH:mm:ss Z yyyy" DATE_LOCALE=en_US APP=REDEGAL_CLUSTERING RESOURCE=redegal/CLUSTERING SEPARATOR=$'\t' > salida_load.log
#### **** date ; date +%s

docker exec -it spark_master spark-submit \
        --class com.redegal.ml.mapit.load.es.TwoFileJoinToES \
        /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar \
        -v \
        ES_SERVER=elasticsearch ES_PORT=9200 \
        EVENT_FILE=/tmp/data/MAPIT-dataset_TSMC2014_NYC \
        SCHEMA="UserID,VenueID,VenueCategoryID,VenueCategoryName,Latitude,Longitude,Timezone,UTCTime,Action" \
        SCHEMA_TYPES="lon,string,string,string,dec,dec,int,time,string" \
        DATA_FILE=/tmp/data/dataset_UbiComp2016_UserProfile_NYC \
        SCHEMA_DATA="User_ID,Gender,TwitterFriends,TwitterFollowers" \
        SCHEMA_DATA_TYPES="lon,string,lon,lon" \
        DATE_PATTERN="EEE MMM dd HH:mm:ss Z yyyy" \
        DATE_LOCALE=en_US \
        APP=REDEGAL_CLUSTERING \
        RESOURCE=redegal/CLUSTERING \
        SEPARATOR=$'\t' > salida_load.log
date ; date +%s

## revisar el log de salida de la ejecución del JOB
#### **** cat salida_load.log | more


exit 0
