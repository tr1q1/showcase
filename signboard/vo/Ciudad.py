#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
from flask.ext.restful import fields
sys.path.append('/srv/dev/lib/')
import bd

ENTITY = 'ciudad'

FIELDS = {
    'id': fields.Integer,
    'nombre': fields.String,
    'cp': fields.Integer,
    'idProvincia': fields.Integer
}

def listado(id = 0, idProvincia = 0):
	if (id > 0):
		return bd.findById(ENTITY, id)
	elif (idProvincia > 0):
		return bd.find("SELECT * FROM %s WHERE idProvincia = %d ORDER BY nombre DESC " % (ENTITY, idProvincia))
	else:
		return bd.findAll(ENTITY, "nombre")


def alta(nombre, cp, idProvincia):
	bd.insert("""INSERT INTO ciudad (nombre, cp, idProvincia) VALUES('%s', '%d', '%d')""" % (nombre, cp, idProvincia))


#def baja(id):
#	bd.delete(ENTITY, id)


#def actualiza(id, nombreP, cpP, idProvinciaP):
#	bd.update(ENTITY, id, nombre=nombreP, cp=cpP, idProvincia=idProvinciaP)
