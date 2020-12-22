#!/usr/bin/python
# -*- coding: utf-8 -*-

# dependencias de acceso al sistema
import sys
# dependencias para el acceso a MySQL
import MySQLdb
# dependencias para el sistema de envío por SMS
from urllib.parse import urlencode
from urllib.request import Request, urlopen
# dependencias para el sistema de envío de emails
from smtplib import SMTP
from email.mime.text import MIMEText

#######################################################################################################################################################################################################
#######################################################################################################################################################################################################
#######################################################################################################################################################################################################
## parámetros de configuración de los distintos sistemas
MYSQL_SERVER	= "192.168.56.11"
MYSQL_PORT		= 3306
MYSQL_USER		= "notiuser" ## usuario específico y con los mínimos permisos Alta/Modificación/Consulta
MYSQL_PASS		= "4welcome"
MYSQL_DB		= "notificaciones"

SMS_SERVER		= "172.17.50.94"
SMS_PORT		= "8766"
SMS_TOKEN		= "2GsJKOLK5R"

SMTP_SERVER		= "172.17.1.250"
SMTP_PORT		= "25"
SMTP_REMITENTE	= "nautilus@einsa.com"

EMAIL_INCIDENCIAS	= "constantino.pernas@experis-spain.com" ## cambiar a "nautilus@einsa.com" para que lo reciba todo el mundo asociado al buzón/lista de distribución

#######################################################################################################################################################################################################
#######################################################################################################################################################################################################
#######################################################################################################################################################################################################
## se remite vía email el mensaje a través del servidor Exchange corporativo
def sendEmail(to, subject, text):
	try:
		print("enviando INCIDENCIA")

		smtp_server = SMTP()
		smtp_server.connect(SMTP_SERVER, SMTP_PORT)
		print(text)
		mensaje = text
		mensaje['From'] = SMTP_REMITENTE
		mensaje['To'] = to
		mensaje['Subject'] = subject

		smtp_server.sendmail(SMTP_REMITENTE, to, mensaje.as_string())
		smtp_server.quit()
	except:
		e = sys.exc_info()[0]

		print("[ERROR] enviando la incidencia vía email")
		print(e.args)
		print(e)

		raise ## 

	return

#######################################################################################################################################################################################################
#######################################################################################################################################################################################################
#######################################################################################################################################################################################################
## se remite al telefono indicado el mensaje de alerta via el SMS Gateway instalado en algún teléfono android
def sendSMS(mensaje, telefono):
	url = 'http://' + SMS_SERVER + ':' + SMS_PORT # IP del móvil encargado del envío de los SMSs
	post_fields = {'number': telefono, 'message': mensaje, 'token': SMS_TOKEN}  # Set POST fields here

	request = Request(url, urlencode(post_fields).encode())

	json = urlopen(request).read().decode()
	print(json)

	return

#######################################################################################################################################################################################################
#######################################################################################################################################################################################################
#######################################################################################################################################################################################################
## proceso principal del script
def main():
	try:
		# Open database connection
		db = MySQLdb.connect(host = MYSQL_SERVER, port = MYSQL_PORT, user = MYSQL_USER, passwd = MYSQL_PASS, db = MYSQL_DB)

		# prepare a cursor object using cursor() method
		cursor = db.cursor(MySQLdb.cursors.DictCursor)

		# execute SQL query using execute() method.
		consulta_notificaciones = """SELECT A.id, A.maquina, A.app, A.mensaje, A.stacktrace, A.fecha, B.sistema, B.canal
									 FROM Notificacion AS A, TipoNotificacion AS B
									 WHERE A.estado = 'P'
									 AND B.id = A.idTipo
									 AND B.app LIKE CONCAT('%', A.app, '%')
									 ORDER BY A.fecha ASC, B.criticidad ASC, B.prioridad ASC """
	except:
		e = sys.exc_info()[0]

		sendEmail(
			EMAIL_INCIDENCIAS,
			"[ERROR] no se ha podido establecer la conexión con la BBDD de Notificaciones contra el servidor '" + MYSQL_SERVER + "'",
			e
		)

	try:
		cursor.execute(consulta_notificaciones)

	# Fetch a single row using fetchone() method.
		notificaciones = cursor.fetchall()
		if (notificaciones != None):
			for notificacion in notificaciones:
				print(notificacion)
				notificacionEnviada = False

				try:
					cursor.execute("SELECT nombre, telefono, aliasTelegram, aliasTwitter, email FROM Notificables WHERE (apps LIKE '%s' OR apps = 'ALL') AND activo = 1 " % ('%' + notificacion['app'] + '%'))
					notificables = cursor.fetchall()
					if (notificables != None):
						for notificable in notificables:
							print(notificable['telefono'] + ' - ' + notificable['email'])
							notificacionEnviada = False

							try: 
								if (notificacion['sistema'] == 'SMS'):
									print("Notificando vía SMS")

									# enviar notificacion por el sistema de SMSs
									sendSMS(notificacion['mensaje'], notificable['telefono'])
								elif (notificacion['sistema'] == 'TELEGRAM'):
									print("Notificando vía Telegram")

									# enviar notificacion por el sistema de Telegram
									## TODO...
								elif (notificacion['sistema'] == 'EMAIL'): ## nunca debería fallar
									print("Notificando vía EMail")

									# Enviando el correo
									sendEmail(
										notificable['email'],
										"[ALERTA] " + notificacion['mensaje'],
										notificacion['stacktrace']
									)

								notificacionEnviada = True
							except:
								e = sys.exc_info()[0]

								mensaje = "[ERROR] no se ha podido enviar vía '" + notificacion['sistema'] + "' el mensaje '" + notificacion['mensaje'] + "' a '" + notificable['nombre'] + "' - '"

								if (notificacion['sistema'] == 'EMAIL'):
									mensaje = mensaje + notificable['email'] + "'"
								elif (notificacion['sistema'] == 'SMS'):
									mensaje = mensaje + notificable['telefono'] + "'"
								elif (notificacion['sistema'] == 'TELEGRAM'):
									mensaje = mensaje + notificacion['canal'] + "'"

								sendEmail(
									EMAIL_INCIDENCIAS,
									mensaje,
									e
								)
				except:
					e = sys.exc_info()[0]

					sendEmail(
						EMAIL_INCIDENCIAS,
						"[ERROR] no se ha podido consultar la lista de NotificaBLES",
						e
					)

					raise

				if (notificacionEnviada == True):
					try:
						print(notificacionEnviada)

						## si se remitió, se marcará la notificacion como COMPLETADA = 'C'
						cursor.execute("UPDATE Notificacion SET estado = 'C' WHERE id = %s" % notificacion['id'])
						db.commit()
					except:
						e = sys.exc_info()[0]

						db.rollback()
						sendEmail(
							EMAIL_INCIDENCIAS,
							"[ERROR] no se ha podido actualizar el estado de la notificación '" + notificacion['id'] + "'",
							e
						)

						raise

			# disconnect from server
			db.close()
	except:
		e = sys.exc_info()[0]

		sendEmail(
			EMAIL_INCIDENCIAS,
			"[ERROR] no se ha podido consultar la lista de Notificaciones",
			e
		)

		raise

if (__name__ == '__main__'):
	main()