#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
from flask.ext.restful import fields
sys.path.append('/srv/dev/lib/')
import bd

ENTITY = 'anuncio'

FIELDS = {
    'id': fields.Integer,
    'asunto': fields.String,
    'descripcion': fields.String,
    'fechaAlta': fields.DateTime,
    'idUser': fields.Integer,
    'urlFoto': fields.String,
    'idTopic': fields.Integer,
    'idCiudad': fields.Integer
}

def listado(id = 0, asunto = "", idTopic = 0, idCiudad = 0):
	if (id > 0):
		return bd.findById(ENTITY, id)
	else:
		query = "SELECT * FROM %s WHERE asunto LIKE '%s' " % (ENTITY, "%" + asunto + "%")
		if (idTopic):
			query += " AND idTopic = %d " % idTopic

		if (idCiudad):
			query += " AND idCiudad = %d " % idCiudad

		query += " ORDER BY fechaAlta DESC "
		return bd.find(query)


def alta(asunto, descripcion, idUser, urlFoto, idTopic, idCiudad):
	bd.insert(
		"INSERT INTO %s (asunto, descripcion, fechaAlta, idUser, urlFoto, idTopic, idCiudad) VALUES('%s', '%s', CURRENT_TIMESTAMP(), '%d', '%s', '%d', '%d')" %
		(ENTITY, asunto, descripcion, idUser, urlFoto, idTopic, idCiudad)
	)


def baja(id):
	bd.delete(ENTITY, id)


# def actualiza(id, nombreP, cpP, idProvinciaP):
# 	bd.update(ENTITY, id, nombre=nombreP, cp=cpP, idProvincia=idProvinciaP)
