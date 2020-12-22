# -*- coding: utf-8 -*-
__author__ = 'tinopf@gmail.com'

import matplotlib.pyplot as plt
import pymongo as mg

# Constants
SERVER = "mongodb://localhost:27017/"

def plot_results_dataset():
    """
    Read data MongoDB Collection with a set of points and return a list of objects Point
    :param dir_dataset:
    """
    mongoClient = mg.MongoClient(SERVER)

    db = mongoClient["CLUSTERING"]
    coleccion = db["FOURSQUARE_TotalVisits_AGGREGATE_SUBWAY_20190204040615862"]

    ## db.FOURSQUARE_TotalVisits_COMPLETO_20190203042633493.aggregate([{ $group: { _id: "$cluster", usuarios: { $sum: 1 }, visitas: { $sum: "$VisitasTotales" } } }, { $sort: { visitas: -1 } }], {explain: false});
    pipeline = [
##        { "$match": { "VenueID" : "4b19f917f964a520abe623e3" } },
##        { "$match": { "VenueCategoryID" : "4bf58dd8d48988d129951735" } }, ## TRAIN_STATION
##        { "$match": { "VenueCategoryID" : "4bf58dd8d48988d1ff931735" } }, ## CONVENTION_CENTER
##        { "$match": { "VenueCategoryID" : "4bf58dd8d48988d122951735" } }, ## ELECTRONICS_STORE
        { "$group": { "_id": "$cluster", "visitas": { "$sum": "$VisitasTotales" }, "usuarios": { "$sum": 1 } } },
        { "$sort": { "total": -1 } }
    ]
    cursor = coleccion.aggregate(pipeline)
    datos = list(cursor)

    cluster = list()
    visitas = list()
    usuarios = list()
    totalVisitas = 0
    totalUsuarios = 0
    for documento in datos:
        cluster.append(documento['_id'])
        visitas.append(int(documento['visitas']))
        usuarios.append(int(documento['usuarios']))
        totalVisitas += int(documento['visitas'])
        totalUsuarios += int(documento['usuarios'])

    mediaVisitasPorCluster = list()
    porcentajeUsuariosPorCluster = list()
    for i in range(len(cluster)):
        mediaVisitasPorCluster.append(visitas[i] / usuarios[i])
        porcentajeUsuariosPorCluster.append((usuarios[i] * 100) / totalUsuarios)

    plt.figure(1)
    plt.grid(True)

    plt.subplot(111)
    plt.bar(cluster, usuarios)
    plt.xlabel('cluster')
    plt.ylabel('Total Usuarios/VenueIDs por cluster')

    plt.figure(2)
    plt.grid(True)

    plt.subplot(111)
    plt.bar(cluster, porcentajeUsuariosPorCluster)
    plt.xlabel('cluster')
    plt.ylabel('% Usuarios/VenueIDs por cluster')

    plt.figure(3)
    plt.grid(True)

    plt.subplot(111)
    plt.bar(cluster, visitas)
    plt.xlabel('cluster')
    plt.ylabel('Total Visitas')

    plt.figure(4)
    plt.grid(True)

    plt.subplot(111)
    plt.bar(cluster, mediaVisitasPorCluster)
    plt.xlabel('cluster')
    plt.ylabel('Media Visitas')

    plt.show()


def loadData():
    plot_results_dataset()


if __name__ == '__main__':
    loadData()
