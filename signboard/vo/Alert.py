#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
from flask.ext.restful import fields
sys.path.append('/srv/dev/lib/')
import bd

ENTITY = 'alert'

FIELDS = {
    'id': fields.Integer,
    'idTopic': fields.Integer,
    'idPais': fields.Integer,
    'idProvincia': fields.Integer,
    'idCiudad': fields.Integer,
    'idUser': fields.Integer
}

def listado(id = 0, idUser = 0):
	if (id > 0):
		return bd.findById(ENTITY, id)
	elif (idUser > 0):
		return bd.find("SELECT * FROM %s WHERE idUser = %d ORDER BY nombre DESC " % (ENTITY, idUser))
	else:
		return bd.findAll(ENTITY)


def alta(idTopic = -1, idPais = -1, idProvincia = -1, idCiudad = -1, idUser = -1):
	bd.insert("INSERT INTO %s (idTopic, idPais, idProvincia, idCiudad, idUser) VALUES('%d', '%d', '%d', '%d', '%d')" % (ENTITY, idTopic, idPais, idProvincia, idCiudad, idUser))


def baja(id):
	bd.delete(ENTITY, id)


#def actualiza(id, nombreP, cpP, idProvinciaP):
#	bd.update(ENTITY, id, nombre=nombreP, cp=cpP, idProvincia=idProvinciaP)
