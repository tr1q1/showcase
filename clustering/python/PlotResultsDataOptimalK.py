# -*- coding: utf-8 -*-
__author__ = 'tinopf@gmail.com'

import numpy as np
import matplotlib.pyplot as plt
import pymongo as mg

# Constants
SERVER = "mongodb://localhost:27017/"


def dataset_to_list_points():
    """
    Read data MongoDB Collection with a set of points and return a list of objects Point
    :param dir_dataset:
    """
    mongoClient = mg.MongoClient(SERVER)

    db = mongoClient["REDEGAL"]
    coleccion = db["THREE_FEATURES_AGGREGATE_SUBWAY_OptimalK_43_200"]
    myquery = { "model": "K_MEANS_PARALLEL" } ## { "model": "RANDOM" }

    ## datos = coleccion.find(myquery).sort([("k", mg.ASCENDING), ("ComputeCost", mg.ASCENDING)])
    ## datos = coleccion.find(myquery).sort([("k", mg.ASCENDING), ("DistanceMeasure", mg.ASCENDING)])
    datos = coleccion.find().sort([("k", mg.ASCENDING), ("ComputeCost", mg.ASCENDING)])

    points = list()
    for documento in datos:
        coordenada = np.array([], dtype = np.float32)
        coordenada = np.append(coordenada, float(documento['k']))
        coordenada = np.append(coordenada, float(documento['ComputeCost']))
        ## coordenada = np.append(coordenada, float(documento['DistanceMeasure']))

        points.append(coordenada)

    return points


def plot_results(listaCoordenadas):
    x, y = zip(*[coordenada for coordenada in listaCoordenadas])
    plt.plot(x, y, 'ro-', markersize=8, lw=2)
    plt.grid(True)
    plt.xlabel('Num.Clusters')
    plt.ylabel('WSSSE')
    plt.show()


def loadData():
    # Read data set
    points = dataset_to_list_points()

    plot_results(points)


if __name__ == '__main__':
    loadData()