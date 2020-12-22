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
    coleccion = db["FOURSQUARE_TotalVisits_AGGREGATE_SUBWAY"]

    pipeline = [
        { "$limit": 100 },
        { "$group": { "_id": "$VenueID", "total": { "$sum": "$VisitasTotales" } } },
        { "$sort": { "total": -1 } }
    ]
    cursor = coleccion.aggregate(pipeline)
    datos = list(cursor)

    venues = list()
    visitas = list()
    for documento in datos:
        venues.append(documento['_id'])
        visitas.append(float(documento['total']))

    plt.plot(venues, visitas, 'ro-', markersize=8, lw=2)
    plt.grid(True)
    plt.show()


def loadData():
    plot_results_dataset()


if __name__ == '__main__':
    loadData()