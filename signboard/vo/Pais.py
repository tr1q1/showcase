#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
from flask.ext.restful import fields
sys.path.append('/srv/dev/lib/')
import bd

ENTITY = 'pais'

FIELDS = {
    'id': fields.Integer,
    'nombre': fields.String,
    'idioma': fields.String,
    'pais': fields.String
}

def listado(id = 0):
	if (id > 0):
		return bd.findById(ENTITY, id)
	else:
		return bd.findAll(ENTITY, "nombre")


def alta(nombre, idioma, pais):
	bd.insert("""INSERT INTO pais (nombre, idioma, pais) VALUES('%s', '%s', '%s')""" % (nombre, idioma, pais))


#def baja(id):
#	bd.delete(ENTITY, id)


#def actualiza(id, nombreP, idiomaP, paisP):
#	bd.update(ENTITY, id, nombre=nombreP, idioma=idiomaP, pais=paisP)
