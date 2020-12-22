#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
sys.path.append('/srv/dev/lib/')
import bd, util

ENTITY = 'batch'

def listado(id = 0, nombre = ""):
	if (id > 0):
		return bd.findById(ENTITY, id)
	elif (not util.isBlank(nombre)):
		return bd.find("SELECT * FROM %s WHERE nombre LIKE '%s' ORDER BY nombre ASC " % (ENTITY, "%" + nombre + "%"))
	else:
		return bd.findAll(ENTITY, "nombre")


def alta(nombre, proceso, activo = 0, cadaMediaHora = 0, cadaHora = 0, cada12Horas = 0, cadaDia = 0, cadaSemana = 0, cada15Dias = 0, cadaMes = 0):
	bd.insert(
		"INSERT INTO %s (nombre, proceso, activo, cadaMediaHora, cadaHora, cada12Horas, cadaDia, cadaSemana, cada15Dias, cadaMes) VALUES('%s', '%s', '%d', '%d', '%d', '%d', '%d', '%d', '%d', '%d')" %
		(ENTITY, nombre, proceso, activo, cadaMediaHora, cadaHora, cada12Horas, cadaDia, cadaSemana, cada15Dias, cadaMes)
	)


# def baja(id):
# 	bd.delete(ENTITY, id)


# def actualiza(id, nombreP, cpP, idProvinciaP):
# 	bd.update(ENTITY, id, nombre=nombreP, cp=cpP, idProvincia=idProvinciaP)
