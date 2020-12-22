#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
from flask.ext.restful import fields
sys.path.append('/srv/dev/lib/')
import bd, util

ENTITY = 'user'

FIELDS = {
    'id': fields.Integer,
    'nombre': fields.String,
    'alias': fields.String,
    'pass': fields.String,
    'email': fields.String,
    'tlf': fields.String,
    'hasWhatsapp': fields.Integer
}

def listado(id = 0, alias = "", password = "", email = ""):
	if (id > 0):
		return bd.findById(ENTITY, id)
	else:
		query = "SELECT * FROM %s WHERE asunto LIKE '%s' AND pass LIKE '%s' AND email LIKE '%s' " % (ENTITY, "%" + asunto + "%", "%" + password + "%", "%" + email + "%")
		query += " ORDER BY nombre DESC "
		return bd.find(query)


def alta(nombre, alias, password, email, tlf = "", hasWhatsapp = 0):
	existe = listado(0, "", "", email)
	if (not existe):
		bd.insert("INSERT INTO %s (nombre, alias, pass, email, tlf, hasWhatsapp) VALUES('%s', '%s', '%s', '%s', '%s', '%d')" % (ENTITY, nombre, alias, password, email, tlf, hasWhatsapp))


# def baja(id):
# 	bd.delete(ENTITY, id)


# def actualiza(id, nombreP, cpP, idProvinciaP):
# 	bd.update(ENTITY, id, nombre=nombreP, cp=cpP, idProvincia=idProvinciaP)
