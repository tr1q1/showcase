#!/usr/bin/env python
# -*- coding: utf-8 -*-

import MySQLdb, MySQLdb.cursors, sys, cStringIO
sys.path.append('./')
import crypto, configuration

CONF_SECC_BD = 'BBDD'
CONF_SECC_SE = 'SERV'
CONF_SECC_US = 'USER'
CONF_SECC_PA = 'PASS'
CONF_SECC_IN = 'INST'

def connect():
	try:
		return MySQLdb.connect(
				host = configuration.getConfigParameter(CONF_SECC_BD, CONF_SECC_SE),
				user = configuration.getConfigParameter(CONF_SECC_BD, CONF_SECC_US),
				passwd = crypto.AESdecrypt(
							configuration.getConfigParameter(CONF_SECC_BD, CONF_SECC_SE) + configuration.getConfigParameter(CONF_SECC_BD, CONF_SECC_US),
							configuration.getConfigParameter(CONF_SECC_BD, CONF_SECC_PA)
						),
				db = configuration.getConfigParameter(CONF_SECC_BD, CONF_SECC_IN),
				charset = 'utf8',
				use_unicode = True
			)
	except MySQLdb.Error, e:
		print "ERROR %d: %s" % (e.args[0], e.args[1])
		pass


def disconnect(conn):
	try:
		conn.close()
	except MySQLdb.Error, e:
		print "ERROR %d: %s" % (e.args[0], e.args[1])
		pass


def findAll(entity, orderColumns = "id", tipoOrdenacion = "ASC"):
	try:
		conn = connect()

		cursor = conn.cursor(MySQLdb.cursors.DictCursor)
		cursor.execute("SELECT * FROM %s ORDER BY %s %s " % (entity, orderColumns, tipoOrdenacion))
		query_result = cursor.fetchall()

		return query_result
	except MySQLdb.Error, e:
		print "ERROR %d: %s" % (e.args[0], e.args[1])
		pass
	finally:
		if (cursor):
			cursor.close()
		disconnect(conn)


def findById(entity, id):
	try:
		conn = connect()

		cursor = conn.cursor(MySQLdb.cursors.DictCursor)
		cursor.execute("SELECT * FROM %s WHERE id = %d " % (entity, id))
		query_result = cursor.fetchall()

		return query_result
	except MySQLdb.Error, e:
		print "ERROR %d: %s" % (e.args[0], e.args[1])
		pass
	finally:
		if (cursor):
			cursor.close()
		disconnect(conn)


def find(query):
	try:
		conn = connect()

		cursor = conn.cursor(MySQLdb.cursors.DictCursor)
		cursor.execute(query)
		query_result = cursor.fetchall()

		return query_result
	except MySQLdb.Error, e:
		print "ERROR %d: %s" % (e.args[0], e.args[1])
		pass
	finally:
		if (cursor):
			cursor.close()
		disconnect(conn)


def insert(query):
	try:
		conn = connect()

		cursor = conn.cursor()
		cursor.execute(query)

		conn.commit()
	except MySQLdb.Error, e:
		print "ERROR %d: %s" % (e.args[0], e.args[1])
		conn.rollback()
		pass
	finally:
		if (cursor):
			cursor.close()
		disconnect(conn)


def delete(entity, id):
	try:
		conn = connect()

		cursor = conn.cursor(MySQLdb.cursors.DictCursor)
		cursor.execute("DELETE FROM %s WHERE id = %d " % (entity, id))

		conn.commit()
	except MySQLdb.Error, e:
		print "ERROR %d: %s" % (e.args[0], e.args[1])
		conn.rollback()
		pass
	finally:
		if (cursor):
			cursor.close()
		disconnect(conn)


def update(entity, id, **properties):
	try:
		conn = connect()

		cursor = conn.cursor(MySQLdb.cursors.DictCursor)
		parametros = ""
		for key in properties:
			if (len(parametros) > 0):
				parametros += ", "
			parametros += "%s = '%s'" % (key, properties[key])

		## print "UPDATE %s SET %s WHERE id = %d " % (entity, parametros, id)
		cursor.execute("UPDATE %s SET %s WHERE id = %d " % (entity, parametros, id))
		conn.commit()
	except MySQLdb.Error, e:
		print "ERROR %d: %s" % (e.args[0], e.args[1])
		conn.rollback()
		pass
	finally:
		if (cursor):
			cursor.close()
		disconnect(conn)
