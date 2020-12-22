#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys, os
sys.path.append('/srv/dev/lib/')
import bd, crypto
sys.path.append('/srv/dev/vo/')
import Pais

## CIFRAR CONTRASEÑA: clave = crypto.AESencrypt(server + username, password)
## OBTENER CONTRASEÑA: clave = crypto.AESdecrypt(configuration.getConfigParameter('BBDD', 'SERV') + configuration.getConfigParameter('BBDD', 'USER'), configuration.getConfigParameter('BBDD', 'PASS'))
## OBTENER SELECT * de una ENTIDAD CUALQUIERA: resultados = bd.findAll("pais", "nombre")
## OBTENER POR ID * de una ENTIDAD CUALQUIERA: resultados = bd.findById("pais", 2)
## SELECT CONCRETA: resultados = bd.find("SELECT nombre, pais FROM pais ORDER BY nombre DESC ")
## INSERT: bd.insert("""INSERT INTO pais (nombre, idioma, pais) VALUES('%s', '%s', '%s')""" % ("ESTADOS UNIDOS", "en", "US"))
## DELETE: bd.delete('pais', 4)
## ACTUALIZACION de una entidad cualquiera: bd.update('pais', 6, idioma='en', pais='US', nombre='ESTADOS UNIDOS')


resultados = Pais.listado()
#
for row in resultados:
	print row
#	id = row["id"]
#	nombre = row["nombre"]
#	cp = row["cp"]
#	idProvincia = row["idProvincia"]
#	
#	print "id=%d, nombre=%s, cp=%s, provincia=%s" % (id, nombre, cp, idProvinciaº)
