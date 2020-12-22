#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
from flask.ext.restful import fields
sys.path.append('/srv/dev/lib/')
import bd

ENTITY = 'provincia'

FIELDS = {
    'id': fields.Integer,
    'nombre': fields.String,
    'idPais': fields.Integer
}

def listado(id = 0, idPais = 0):
	if (id > 0):
		return bd.findById(ENTITY, id)
	elif (idPais > 0):
		return bd.find("SELECT * FROM %s WHERE idPais = %d ORDER BY nombre DESC " % (ENTITY, idPais))
	else:
		return bd.findAll(ENTITY, "nombre")


def alta(nombre, idPais):
	bd.insert("""INSERT INTO provincia (nombre, idPais) VALUES('%s', '%d')""" % (nombre, idPais))


#def baja(id):
#	bd.delete(ENTITY, id)


#def actualiza(id, nombreP, idPaisP):
#	bd.update(ENTITY, id, nombre=nombreP, idPais=idPaisP)
