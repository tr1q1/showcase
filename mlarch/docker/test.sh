#!/usr/bin/env bash

## PREREQUISITO: los dockers de ElastichSearch (2), Spark (2) y MongoDB en ejecución y accesibles entre ellos

clear
## mover el FATJAR de la carpeta donde lo genera el IDE a la carpeta de DATA del docker de SPARK
mv ../target/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar ./data/
echo FATJAR copiado a la carpeta compartida con el servidor de Spark

## lanzar el JOB con los parametros necesarios al SPARK
## echo Ejecutando SimpleAggregate
## docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.aggregate.SimpleAggregate /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 APP=TEST_FOURSQUARE_CLUSTERING RESOURCE=clustering/FOURSQUARE MONGO_SERVER=mongodb MONGO_PORT=27017 MONGO_DB=CLUSTERING MONGO_COLL=FOURSQUARE DATE_FIELD=UTCTime DATE_FROM=2013-01-01 DATE_TO=2013-01-02 NUM_RESULTS=100 > salida_ejecucion.log
## echo Ejecutando LastVisitAggregate
## docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.aggregate.LastVisitAggregate /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 APP=TEST_FOURSQUARE_CLUSTERING RESOURCE=clustering/FOURSQUARE MONGO_SERVER=mongodb MONGO_PORT=27017 MONGO_DB=CLUSTERING MONGO_COLL=FOURSQUARE_LastVisit DATE_FIELD=UTCTime DATE_FROM=2013-01-01 DATE_TO=2013-01-02 NUM_RESULTS=100 > salida_ejecucion.log
## echo Ejecutando TotalVisitsAggregate
## docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.aggregate.TotalVisitsAggregate /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 APP=FOURSQUARE_CLUSTERING_AGGREGATE RESOURCE=clustering/FOURSQUARE MONGO_SERVER=mongodb MONGO_PORT=27017 MONGO_DB=CLUSTERING MONGO_COLL=FOURSQUARE_TotalVisits_AGGREGATE DATE_FIELD=UTCTime DATE_FROM=2000-01-01 DATE_TO=2021-01-02 NUM_RESULTS=10 > salida_ejecucion.log
## echo Ejecutando TotalVisitsLastVisitAggregate
## docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.aggregate.TotalVisitsLastVisitAggregate /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 APP=FOURSQUARE_CLUSTERING_AGGREGATE RESOURCE=clustering/FOURSQUARE MONGO_SERVER=mongodb MONGO_PORT=27017 MONGO_DB=CLUSTERING MONGO_COLL=FOURSQUARE_2FEATURES_AGGREGATE DATE_FIELD=UTCTime DATE_FROM=2000-01-01 DATE_TO=2021-01-02 NUM_RESULTS=10 > salida_ejecucion.log
## echo Ejecutando ThreeFeaturesAggregate
## docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.aggregate.ThreeFeaturesAggregate /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 APP=REDEGAL_CLUSTERING_AGGREGATE RESOURCE=redegal/CLUSTERING MONGO_SERVER=mongodb MONGO_PORT=27017 MONGO_DB=REDEGAL MONGO_COLL=CLUSTERING_3FEATURES_AGGREGATE DATE_FIELD=UTCTime DATE_FROM=2000-01-01 DATE_TO=2021-01-02 NUM_RESULTS=10 > salida_ejecucion.log
## echo Ejecutando ThreeFeaturesByTypeAggregate
## docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.aggregate.ThreeFeaturesByTypeAggregate /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 APP=REDEGAL_CLUSTERING_AGGREGATE RESOURCE=redegal/CLUSTERING MONGO_SERVER=mongodb MONGO_PORT=27017 MONGO_DB=REDEGAL MONGO_COLL=THREE_FEATURES_AGGREGATE DATE_FIELD=UTCTime DATE_FROM=2000-01-01 DATE_TO=2021-01-02 NUM_RESULTS=10 > salida_ejecucion.log
#### **** echo Ejecutando MAPITThreeFeaturesByTypeAggregate
#### **** docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.aggregate.MAPITThreeFeaturesByTypeAggregate /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 APP=REDEGAL_CLUSTERING_AGGREGATE RESOURCE=redegal/CLUSTERING MONGO_SERVER=mongodb MONGO_PORT=27017 MONGO_DB=REDEGAL MONGO_COLL=THREE_FEATURES_AGGREGATE DATE_FIELD=UTCTime DATE_FROM=2000-01-01 DATE_TO=2021-01-02 NUM_RESULTS=10 > salida_ejecucion.log
#### **** echo Ejecutando PersonalDataByTypeAggregate
#### **** docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.aggregate.PersonalDataByTypeAggregate /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 APP=REDEGAL_CLUSTERING_AGGREGATE RESOURCE=redegal/CLUSTERING MONGO_SERVER=mongodb MONGO_PORT=27017 MONGO_DB=REDEGAL MONGO_COLL=THREE_FEATURES_AGGREGATE DATE_FIELD=UTCTime DATE_FROM=2000-01-01 DATE_TO=2021-01-02 NUM_RESULTS=10 > salida_ejecucion.log
## echo Ejecutando TotalVisitsVenueCategoryAggregate
## docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.aggregate.TotalVisitsVenueCategoryAggregate /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 APP=FOURSQUARE_CLUSTERING_AGGREGATE RESOURCE=clustering/FOURSQUARE MONGO_SERVER=mongodb MONGO_PORT=27017 MONGO_DB=CLUSTERING MONGO_COLL=FOURSQUARE_TotalVisits_AGGREGATE_VenueCategory DATE_FIELD=UTCTime DATE_FROM=2000-01-01 DATE_TO=2021-01-02 NUM_RESULTS=10 > salida_ejecucion.log
## echo Ejecutando OptimalKElbowMethod
## docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.clustering.OptimalKElbowMethod /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 APP=FOURSQUARE_CLUSTERING_OPTIMALK RESOURCE=clustering/FOURSQUARE MONGO_SERVER=mongodb MONGO_PORT=27017 MONGO_DB=CLUSTERING MONGO_COLL=FOURSQUARE_TotalVisits_AGGREGATE_SUBWAY LOOPS=43 ITERATIONS=200 > salida_ejecucion.log
## echo Ejecutando OptimalKElbowMethod2Features
## docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.clustering.OptimalKElbowMethod2Features /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 APP=FOURSQUARE_CLUSTERING_OPTIMALK RESOURCE=clustering/FOURSQUARE MONGO_SERVER=mongodb MONGO_PORT=27017 MONGO_DB=CLUSTERING MONGO_COLL=FOURSQUARE_2FEATURES_AGGREGATE_COFFEE_SHOP LOOPS=43 ITERATIONS=200 > salida_ejecucion.log
## echo Ejecutando OptimalBisectingKElbowMethod2Features
## docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.clustering.OptimalBisectingKElbowMethod2Features /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 APP=FOURSQUARE_CLUSTERING_OPTIMALK RESOURCE=clustering/FOURSQUARE MONGO_SERVER=mongodb MONGO_PORT=27017 MONGO_DB=CLUSTERING MONGO_COLL=FOURSQUARE_2FEATURES_AGGREGATE_COFFEE_SHOP LOOPS=43 ITERATIONS=200 > salida_ejecucion.log
## echo Ejecutando OptimalBisectingKElbowMethod3Features
## docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.clustering.OptimalBisectingKElbowMethod3Features /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 APP=REDEGAL_CLUSTERING_OPTIMALK RESOURCE=redegal/CLUSTERING MONGO_SERVER=mongodb MONGO_PORT=27017 MONGO_DB=REDEGAL MONGO_COLL=THREE_FEATURES_AGGREGATE_SUBWAY LOOPS=43 ITERATIONS=200 > salida_ejecucion.log
#### **** echo Ejecutando OptimalBisectingKElbowMethod3UserFeatures
#### **** docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.clustering.OptimalBisectingKElbowMethod3UserFeatures /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 APP=REDEGAL_CLUSTERING_OPTIMALK RESOURCE=redegal/CLUSTERING MONGO_SERVER=mongodb MONGO_PORT=27017 MONGO_DB=REDEGAL MONGO_COLL=MAPIT_DATA LOOPS=43 ITERATIONS=200 VENUECATEGORYID=4bf58dd8d48988d129951735 > salida_ejecucion.log
## echo Ejecutando OptimalKElbowMethodVenueCategory
## docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.clustering.OptimalKElbowMethodVenueCategory /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 APP=FOURSQUARE_CLUSTERING_OPTIMALK RESOURCE=clustering/FOURSQUARE MONGO_SERVER=mongodb MONGO_PORT=27017 MONGO_DB=CLUSTERING MONGO_COLL=FOURSQUARE_TotalVisits_AGGREGATE_VenueCategory LOOPS=43 ITERATIONS=200 > salida_ejecucion.log
## echo Ejecutando TrainModelOptimalK
## docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.clustering.TrainModelOptimalK /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 APP=FOURSQUARE_CLUSTERING_OPTIMALK_TRAIN RESOURCE=clustering/FOURSQUARE MONGO_SERVER=mongodb MONGO_PORT=27017 MONGO_DB=CLUSTERING MONGO_COLL=FOURSQUARE_2FEATURES_AGGREGATE_COFFEE_SHOP K=8 ITERATIONS=200 SAVE_RESULTS_FILE=S FIELD_IDS=VenueID IDS=4df8690581304987d7fadc27,4a8a998af964a5202b0a20e3,49e3a2b3f964a520a6621fe3 > salida_ejecucion.log
## echo Ejecutando TrainModelOptimalK2Features
## docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.clustering.TrainModelOptimalK2Features /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 APP=FOURSQUARE_CLUSTERING_OPTIMALK_TRAIN RESOURCE=clustering/FOURSQUARE MONGO_SERVER=mongodb MONGO_PORT=27017 MONGO_DB=CLUSTERING MONGO_COLL=FOURSQUARE_2FEATURES_AGGREGATE_COFFEE_SHOP K=7 ITERATIONS=200 SAVE_RESULTS_FILE=S FIELD_IDS=VenueID IDS=4df8690581304987d7fadc27,4a8a998af964a5202b0a20e3,49e3a2b3f964a520a6621fe3 > salida_ejecucion.log
## echo Ejecutando TrainModelOptimalBisectingK2Features
## docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.clustering.TrainModelOptimalBisectingK2Features /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 APP=FOURSQUARE_CLUSTERING_OPTIMALK_TRAIN RESOURCE=clustering/FOURSQUARE MONGO_SERVER=mongodb MONGO_PORT=27017 MONGO_DB=CLUSTERING MONGO_COLL=FOURSQUARE_2FEATURES_AGGREGATE_COFFEE_SHOP K=7 ITERATIONS=200 SAVE_RESULTS_FILE=S FIELD_IDS=VenueID IDS=4df8690581304987d7fadc27,4a8a998af964a5202b0a20e3,49e3a2b3f964a520a6621fe3 > salida_ejecucion.log
## echo Ejecutando TrainModelOptimalBisectingK3Features
## docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.clustering.TrainModelOptimalBisectingK3Features /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 APP=REDEGAL_CLUSTERING_OPTIMALK_TRAIN RESOURCE=redegal/CLUSTERING MONGO_SERVER=mongodb MONGO_PORT=27017 MONGO_DB=REDEGAL MONGO_COLL=THREE_FEATURES_AGGREGATE_SUBWAY K=7 ITERATIONS=200 SAVE_RESULTS_FILE=S > salida_ejecucion.log
## docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.clustering.TrainModelOptimalBisectingK3Features /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 APP=REDEGAL_CLUSTERING_OPTIMALK_TRAIN RESOURCE=redegal/CLUSTERING MONGO_SERVER=mongodb MONGO_PORT=27017 MONGO_DB=REDEGAL MONGO_COLL=THREE_FEATURES_AGGREGATE_SUBWAY K=7 ITERATIONS=200 SAVE_RESULTS_FILE=S FIELD_IDS=UserID IDS=1326,820,1722,90,808 > salida_ejecucion.log
#### **** echo Ejecutando TrainModelOptimalBisectingK3UserFeatures
#### **** docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.clustering.TrainModelOptimalBisectingK3UserFeatures /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 APP=REDEGAL_CLUSTERING_OPTIMALK_TRAIN RESOURCE=redegal/CLUSTERING MONGO_SERVER=mongodb MONGO_PORT=27017 MONGO_DB=REDEGAL MONGO_COLL=MAPIT_DATA K=7 ITERATIONS=200 SAVE_RESULTS_FILE=S FIELD_IDS=VenueCategoryID IDS=4bf58dd8d48988d114951735,4bf58dd8d48988d16e941735,4bf58dd8d48988d130941735,4bf58dd8d48988d1fe931735,4bf58dd8d48988d1df941735 > salida_ejecucion.log
## echo Ejecutando TrainModelOptimalKVenueCategory
## docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.clustering.TrainModelOptimalKVenueCategory /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 APP=FOURSQUARE_CLUSTERING_OPTIMALK_TRAIN RESOURCE=clustering/FOURSQUARE MONGO_SERVER=mongodb MONGO_PORT=27017 MONGO_DB=CLUSTERING MONGO_COLL=FOURSQUARE_TotalVisits_AGGREGATE_VenueCategory K=10 ITERATIONS=200 SAVE_RESULTS_FILE=S > salida_ejecucion.log
## echo Ejecutando LastVisitKMeans
## docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.clustering.LastVisitKMeans /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 APP=TEST_FOURSQUARE_CLUSTERING RESOURCE=clustering/FOURSQUARE MONGO_SERVER=mongodb MONGO_PORT=27017 MONGO_DB=CLUSTERING MONGO_COLL=FOURSQUARE_LastVisit > salida_ejecucion.log
## echo Ejecutando TotalVisitsKMeans
## docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.clustering.TotalVisitsKMeans /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 APP=FOURSQUARE_CLUSTERING_KMEANS RESOURCE=clustering/FOURSQUARE MONGO_SERVER=mongodb MONGO_PORT=27017 MONGO_DB=CLUSTERING MONGO_COLL=FOURSQUARE_2FEATURES_AGGREGATE_COFFEE_SHOP K=8 ITERATIONS=200 MODEL=FOURSQUARE_2FEATURES_AGGREGATE_COFFEE_SHOP_MODELO > salida_ejecucion.log
## echo Ejecutando TotalVisitsLastVisitKMeans
## docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.clustering.TotalVisitsLastVisitKMeans /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 APP=FOURSQUARE_CLUSTERING_KMEANS RESOURCE=clustering/FOURSQUARE MONGO_SERVER=mongodb MONGO_PORT=27017 MONGO_DB=CLUSTERING MONGO_COLL=FOURSQUARE_2FEATURES_AGGREGATE_COFFEE_SHOP K=8 ITERATIONS=200 MODEL=FOURSQUARE_2FEATURES_AGGREGATE_COFFEE_SHOP_MODELO > salida_ejecucion.log
## echo Ejecutando TotalVisitsLastVisitBisectingKMeans
## docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.clustering.TotalVisitsLastVisitBisectingKMeans /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 APP=FOURSQUARE_CLUSTERING_KMEANS RESOURCE=clustering/FOURSQUARE MONGO_SERVER=mongodb MONGO_PORT=27017 MONGO_DB=CLUSTERING MONGO_COLL=FOURSQUARE_2FEATURES_AGGREGATE_COFFEE_SHOP K=7 ITERATIONS=200 MODEL=FOURSQUARE_2FEATURES_AGGREGATE_COFFEE_SHOP_MODELO_BISECTINGKMEANS > salida_ejecucion.log
## echo Ejecutando ThreeFeaturesBisectingKMeans
## docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.clustering.ThreeFeaturesBisectingKMeans /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 APP=REDEGAL_CLUSTERING_BISECTINGKMEANS RESOURCE=redegal/CLUSTERING MONGO_SERVER=mongodb MONGO_PORT=27017 MONGO_DB=REDEGAL MONGO_COLL=CLUSTERING_3FEATURES_AGGREGATE_SUBWAY K=8 ITERATIONS=200 MODEL=CLUSTERING_3FEATURES_AGGREGATE_SUBWAY_MODELO_BISECTINGKMEANS > salida_ejecucion.log
echo Ejecutando ThreeUserFeaturesByTypeBisectingKMeans
docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.clustering.ThreeUserFeaturesByTypeBisectingKMeans /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 APP=REDEGAL_CLUSTERING_BISECTINGKMEANS RESOURCE=redegal/CLUSTERING MONGO_SERVER=mongodb MONGO_PORT=27017 MONGO_DB=REDEGAL MONGO_COLL=MAPIT_DATA K=7 ITERATIONS=200 MODEL=MAPIT_DATA_MODELO_BISECTINGKMEANS > salida_ejecucion.log
## echo Ejecutando TotalVisitsVenueCategoryKMeans
## docker exec -it spark_master spark-submit --class com.redegal.ml.mapit.clustering.TotalVisitsVenueCategoryKMeans /tmp/data/mapit-clustering-1.0.0-SNAPSHOT-jar-with-dependencies.jar -v ES_SERVER=elasticsearch ES_PORT=9200 APP=FOURSQUARE_CLUSTERING_KMEANS_VenueCategory RESOURCE=clustering/FOURSQUARE MONGO_SERVER=mongodb MONGO_PORT=27017 MONGO_DB=CLUSTERING MONGO_COLL=FOURSQUARE_TotalVisits_AGGREGATE_VenueCategory K=10 ITERATIONS=200 MODEL=FOURSQUARE_TotalVisits_AGGREGATE_VenueCategory_MODELO > salida_ejecucion.log
date ; date +%s

## revisar el log de salida de la ejecución del JOB
cat salida_ejecucion.log | more