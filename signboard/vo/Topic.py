#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
from flask.ext.restful import fields
sys.path.append('/srv/dev/lib/')
import bd, util

ENTITY = 'topic'

FIELDS = {
    'id': fields.Integer,
    'nombre': fields.String,
    'descripcion': fields.String
}

def listado(id = 0):
	if (id > 0):
		return bd.findById(ENTITY, id)
	else:
		return bd.findAll(ENTITY, "nombre")


def alta(nombre, descripcion):
	bd.insert("INSERT INTO %s (nombre, descripcion) VALUES('%s', '%s')" % (ENTITY, nombre, descripcion))


# def baja(id):
# 	bd.delete(ENTITY, id)


# def actualiza(id, nombreP, cpP, idProvinciaP):
# 	bd.update(ENTITY, id, nombre=nombreP, cp=cpP, idProvincia=idProvinciaP)
