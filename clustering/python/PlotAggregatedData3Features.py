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

    db = mongoClient["REDEGAL"]
    coleccion = db["THREE_FEATURES_AGGREGATE_SUBWAY"]

    pipeline = [
        { "$limit": 100 },
        { "$group": {
##            "_id": "$VenueID",
            "_id": "$UserID",
            "totalUsuarios": { "$sum": 1 },
            "totalVisitas": { "$sum": "$VisitasTotales" },
            "diasDesdeUltimaVisita": { "$avg": "$DiasDesdeUltimaVisita" },
            "mediaDuracionVisita": { "$avg": "$MediaDuracionVisita" }
            }
        },
        { "$sort": { "totalUsuarios": -1, "diasDesdeUltimaVisita": 1 } }
    ]
    cursor = coleccion.aggregate(pipeline)
    datos = list(cursor)

    venues = list()
    usuarios = list()
    visitas = list()
    diasDesdeUltimaVisita = list()
    mediaDuracionVisita = list()
    for documento in datos:
        venues.append(documento['_id'])
        usuarios.append(float(documento['totalUsuarios']))
        visitas.append(float(documento['totalVisitas']))
        diasDesdeUltimaVisita.append(float(documento['diasDesdeUltimaVisita']))
        mediaDuracionVisita.append(float(documento['mediaDuracionVisita']))

    fig, axs = plt.subplots(4, 1)
    plt.grid(True)

    axs[0].plot(venues, usuarios, 'ro-')
    axs[0].grid(True)
    axs[0].set_title('Usuarios totales')
    axs[1].plot(venues, visitas, 'bo-')
    axs[1].grid(True)
    axs[1].set_title('Visitas totales')
    axs[2].plot(venues, diasDesdeUltimaVisita, 'go-')
    axs[2].grid(True)
    axs[2].set_title('Media de numero de dias desde la ultima visita')
    axs[3].plot(venues, mediaDuracionVisita, 'ro-')
    axs[3].grid(True)
    axs[3].set_title('Media duracion visita')
    fig.suptitle('Tendencia de los datos agregados (limitado a 100 elementos)')

    plt.show()


def loadData():
    plot_results_dataset()


if __name__ == '__main__':
    loadData()