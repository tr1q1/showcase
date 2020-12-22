### Clustering con ES - Spark - MongoDB

Teniendo ya disponibles los datos en ES y cargándolos en las estructuras JavaRDD, optimizadas para el trabajo distribuido
entre los workers que se decidan en paralelo, aplicar e identificar la validez de los resultados de alguno de los métodos disponibles desde la librería Java de MLLib sólo dependerá de decidir matemáticamente su adecuación o no a los objetivos a buscar.

Los métodos de clustering que Spark a través de su librería Java MLLib proporciona son los siguientes (https://spark.apache.org/docs/latest/mllib-clustering.html):
* K-means
* Gaussian mixture
* Power iteration clustering (PIC)
* Latent Dirichlet allocation (LDA)
* Bisecting k-means
* Streaming k-means

Todos los métodos de clustering se aplican sobre datos numéricos, en caso de querer aplicarlo sobre datos caracter (caso
de FourSquare), según la documentación y casos de ejemplo consultados se recomienda aplicarles una transformación
Term Frecuency-Inverse Document Frecuency (TF-IDF), es una manera sencilla de generar vectores de caraterísticas a partir
de documentos de texto.
TF-IDF permite calcular, por un lado, la frecuencia de aparición de un término en un documento (Term Frecuency) y, por otro
lado, cómo de in-frecuentemente aparece un término en un documento. El producto de estos 2 valores (TF x IDF) muestra la relevancia de los términos en un documento específico.

Por un lado se utiliza el objeto HashingTF para calcular un Vector de frecuencias de cada término en un documento, en el
caso de los datos de FourSquare el término se ha considerado el par "VenueID" + " " + "UserID", con esta transformación 
nos dará la frecuencia de acceso de un usuario a un local dentro del conjunto de datos.
Este objeto toma el código hash de cada palabra módulo un determinado tamaño de Vector S y entonces mapea cada término a
un número entre 0 y S-1. De este modo se garantiza un Vector de un determinado tamaño y, según la propia documentación de
Spark, el método es muy robustoa pesar de que múltiples términos se mapeen con el mismo código hash.

Una vez que ya disponemos procesados los datos de ES en un Vector de datos JavaRDD basta con aplicar el método de Clustering
que se desee en función de los objetivos a alcanzar, y siempre teniendo en cuenta la validez Matemática o no de los resultados
obtenidos. 


**Referencias**
* https://www.tutorialkart.com/apache-spark/kmeans-classification-using-spark-mllib-in-java/
* https://github.molgen.mpg.de/mpi-inf-hadoop/spark-example/blob/master/src/main/java/com/ambiverse/example/mllib/ClusteringExamples.java
* https://programtalk.com/java-api-usage-examples/org.apache.spark.mllib.feature.HashingTF/
* http://useof.org/java-open-source/org.apache.spark.mllib.feature.HashingTF




**NOTA**

A las máquinas docker necesarias para realizar las pruebas (cluster ES, cluster Spark, MongoDB) se añaden 2 máquinas nuevas:
* Kibana
* Zookeeper 




**Exportar una colección completa de MongoDB a un fichero CSV sin programación**
mongoexport -h localhost --db CLUSTERING --collection FOURSQUARE_TotalVisits_COMPLETO --type=csv --fields VenueID,UserID, VisitasTotales --q '{ "VenueID": "4b19f917f964a520abe623e3" }' --out FOURSQUARE_TotalVisits_COMPLETO_4b19f917f964a520abe623e3.csv

**01 Agregacion**
    TotalVisitsAggregate
    PlotAggregatedData
    
    
**02 OptimalK**
    OptimalKElbowMethod
    PlotResultsDataOptimalK
    
    
**03 CrearModelo**
    TrainModelOptimalK
    
    
**04Clusterizar**
    TotalVisitsKMeans
    
    
**05 Resultados**
    PlotResumenIndicadores
    
    
**06 Exportar_Datos**

    // Datos agregados provenientes de ES
    mongoexport -h localhost --db CLUSTERING --collection FOURSQUARE_2FEATURES_AGGREGATE_COFFEE_SHOP --type=csv --forceTableScan --fields VenueID,UserID,VisitasTotales,DiasDesdeUltimaVisita --out FOURSQUARE_2FEATURES_AGGREGATE_COFFEE_SHOP.csv
    
    // Datos comparativos del resultado del entrenamiento mediante KMeans con distintos valores de K
    mongoexport -h localhost --db CLUSTERING --collection FOURSQUARE_2FEATURES_AGGREGATE_COFFEE_SHOP_OptimalK_43_200 --type=csv --forceTableScan --fields k,it,bestOf,model,ComputeCost,TrainingCost,DistanceMeasure,FormatVersion,numClusters,duration,timestamp,countData --out FOURSQUARE_2FEATURES_AGGREGATE_COFFEE_SHOP_OptimalK_43_200.csv
    
    // Datos del entrenamiento mediante KMeans del modelo que se usará para clusterizar el conjunto total de datos
    mongoexport -h localhost --db CLUSTERING --collection FOURSQUARE_2FEATURES_AGGREGATE_COFFEE_SHOP_MODELO_BISECTINGKMEANS --type=csv --forceTableScan --fields k,it,bestOf,model,ComputeCost,TrainingCost,DistanceMeasure,FormatVersion,numClusters,duration,timestamp,countData --out FOURSQUARE_2FEATURES_AGGREGATE_COFFEE_SHOP_MODELO_BISECTINGKMEANS.csv
    tar cvzf FOURSQUARE_2FEATURES_AGGREGATE_COFFEE_SHOP_MODELO_BISECTINGKMEANS.tgz ./data/model/FOURSQUARE_2FEATURES_AGGREGATE_COFFEE_SHOP_MODELO_BISECTINGKMEANS/
    
    // Datos agregados clusterizados a partir del MODELO entrenado antes
    mongoexport -h localhost --db CLUSTERING --collection FOURSQUARE_2FEATURES_AGGREGATE_COFFEE_SHOP_BISECTINGKMEANS_20190207104712837 --type=csv --forceTableScan --fields VenueID,UserID,VisitasTotales,DiasDesdeUltimaVisita,cluster,timestamp --out FOURSQUARE_2FEATURES_AGGREGATE_COFFEE_SHOP_BISECTINGKMEANS_20190207104712837.csv
    

**TESTING**
db.FOURSQUARE_2FEATURES_AGGREGATE_COFFEE_SHOP.aggregate([{ $group: { _id: "$VenueID", usuarios: { $sum: 1 }, visitas: { $sum: "$VisitasTotales" }, diasDesdeUltimaVisita: { $min: "$DiasDesdeUltimaVisita" } } }, { $sort: { visitas: -1 } }], {explain: false});
{ "_id" : "4df8690581304987d7fadc27", "usuarios" : 11, "visitas" : NumberLong(148), "diasDesdeUltimaVisita" : 2183 }
{ "_id" : "4a8a998af964a5202b0a20e3", "usuarios" : 3, "visitas" : NumberLong(119), "diasDesdeUltimaVisita" : 2183 }
{ "_id" : "49e3a2b3f964a520a6621fe3", "usuarios" : 9, "visitas" : NumberLong(108), "diasDesdeUltimaVisita" : 2184 }
{ "_id" : "4b68bc65f964a520ff892be3", "usuarios" : 13, "visitas" : NumberLong(98), "diasDesdeUltimaVisita" : 2184 }
{ "_id" : "4b20ed51f964a5206c3524e3", "usuarios" : 1, "visitas" : NumberLong(96), "diasDesdeUltimaVisita" : 2184 }
{ "_id" : "4ce5d291f1912d4373d5bf09", "usuarios" : 63, "visitas" : NumberLong(91), "diasDesdeUltimaVisita" : 2192 }
{ "_id" : "4b4fbac7f964a520ea1227e3", "usuarios" : 4, "visitas" : NumberLong(80), "diasDesdeUltimaVisita" : 2185 }
{ "_id" : "4b3febc4f964a52019b225e3", "usuarios" : 5, "visitas" : NumberLong(79), "diasDesdeUltimaVisita" : 2183 }
{ "_id" : "4b5be088f964a520301b29e3", "usuarios" : 9, "visitas" : NumberLong(78), "diasDesdeUltimaVisita" : 2185 }
{ "_id" : "4b1be8cef964a520defe23e3", "usuarios" : 4, "visitas" : NumberLong(74), "diasDesdeUltimaVisita" : 2184 }
{ "_id" : "4dcf5197d4c065592f967a26", "usuarios" : 1, "visitas" : NumberLong(71), "diasDesdeUltimaVisita" : 2184 }
{ "_id" : "4f5e82dae4b01989c438cbb6", "usuarios" : 10, "visitas" : NumberLong(70), "diasDesdeUltimaVisita" : 2190 }
{ "_id" : "4b6535fff964a52015e92ae3", "usuarios" : 34, "visitas" : NumberLong(67), "diasDesdeUltimaVisita" : 2192 }
{ "_id" : "4b0c09cbf964a520ff3523e3", "usuarios" : 4, "visitas" : NumberLong(66), "diasDesdeUltimaVisita" : 2184 }
{ "_id" : "4bf5fbf694b2a59343cfacee", "usuarios" : 2, "visitas" : NumberLong(66), "diasDesdeUltimaVisita" : 2184 }
{ "_id" : "4b5e8743f964a520c39129e3", "usuarios" : 51, "visitas" : NumberLong(65), "diasDesdeUltimaVisita" : 2183 }
{ "_id" : "4b1cae6df964a520020924e3", "usuarios" : 26, "visitas" : NumberLong(65), "diasDesdeUltimaVisita" : 2184 }
{ "_id" : "4d93c45f45ae5481af21f6eb", "usuarios" : 2, "visitas" : NumberLong(64), "diasDesdeUltimaVisita" : 2184 }
{ "_id" : "4ada106af964a520ed1d21e3", "usuarios" : 8, "visitas" : NumberLong(60), "diasDesdeUltimaVisita" : 2317 }
{ "_id" : "4b63a34df964a520e4882ae3", "usuarios" : 38, "visitas" : NumberLong(59), "diasDesdeUltimaVisita" : 2194 }