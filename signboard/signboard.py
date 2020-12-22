#!/usr/bin/env python
# -*- coding: utf-8 -*-

from flask import Flask, abort, jsonify, request, json, Response
from flask_limiter import Limiter
from flask.ext.restful import fields, marshal
from flask.ext.httpauth import HTTPBasicAuth
from flask.ext.cors import CORS, cross_origin
from werkzeug import secure_filename
import gdata.photos, gdata.photos.service
import sys, os, datetime
sys.path.append('/srv/dev/lib/')
import configuration
sys.path.append('/srv/dev/vo/')
import Ciudad, Provincia, Pais, Topic, User, Anuncio

## constantes
CONF_SECC_APP = 'APP'
CONF_SECC_DE = 'DEBUG'
CONF_SECC_HO = 'HOST'
CONF_SECC_PO = 'PORT'
CONF_SECC_UP = 'UPLO'
ALLOWED_EXTENSIONS = set(['jpg', 'jpeg']) ## set(['png', 'jpg', 'jpeg', 'gif', 'bmp'])
CONF_SECC_PI = 'PICA'

## inicialización estática
app = Flask(__name__, static_url_path = "")
app.config['MAX_CONTENT_LENGTH'] = 16 * 1024 * 1024
app.config['UPLOAD_FOLDER'] = configuration.getConfigParameter(CONF_SECC_APP, CONF_SECC_UP)
app.config['CORS_HEADERS'] = "Content-Type"
app.config['CORS_RESOURCES'] = { r"/signboard/*" : { "origins" : "*" } }

cors = CORS(app)
limiter = Limiter(app)
auth = HTTPBasicAuth()


@auth.get_password
def get_password(username):
    if (username == 'signboard'):
        return 'pass'
    return None
 
@auth.error_handler
def unauthorized():
    # return 403 instead of 401 to prevent browsers from displaying the default auth dialog
    return make_response(jsonify( { 'message': 'Unauthorized access' } ), 403)


def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1] in ALLOWED_EXTENSIONS

######################################################################################################################################
######################################################################################################################################
######################################################################################################################################
## Métodos para las Ciudades
######################################################################################################################################
######################################################################################################################################
######################################################################################################################################
@app.route('/signboard/ciudad', methods=['GET'])
@limiter.limit("50/minute")
def getCiudad():
    if ('i' in request.args):
        resultados = Ciudad.listado(int(request.args['i']))
    elif ('p' in request.args):
        resultados = Ciudad.listado(0, int(request.args['p']))
    else:
        resultados = Ciudad.listado()

    if (len(resultados) == 0):
        abort(404)
    else:
        return jsonify({ 'ciudad': marshal(resultados, Ciudad.FIELDS) })


######################################################################################################################################
######################################################################################################################################
######################################################################################################################################
## Métodos para las Provincias
######################################################################################################################################
######################################################################################################################################
######################################################################################################################################
@app.route('/signboard/provincia', methods=['GET'])
@limiter.limit("50/minute")
def getProvincia():
    if ('i' in request.args):
        resultados = Provincia.listado(int(request.args['i']))
    elif ('p' in request.args):
        resultados = Provincia.listado(0, int(request.args['p']))
    else:
        resultados = Provincia.listado()

    if (len(resultados) == 0):
        abort(404)
    else:
        return jsonify({ 'provincia': marshal(resultados, Provincia.FIELDS) })


######################################################################################################################################
######################################################################################################################################
######################################################################################################################################
## Métodos para las Pais
######################################################################################################################################
######################################################################################################################################
######################################################################################################################################
@app.route('/signboard/pais', methods=['GET'])
@limiter.limit("50/minute")
def getPais():
    if ('i' in request.args):
        resultados = Pais.listado(int(request.args['i']))
    else:
        resultados = Pais.listado()

    if (len(resultados) == 0):
        abort(404)
    else:
        return jsonify({ 'pais': marshal(resultados, Pais.FIELDS) })


######################################################################################################################################
######################################################################################################################################
######################################################################################################################################
## Métodos para las Topic
######################################################################################################################################
######################################################################################################################################
######################################################################################################################################
@app.route('/signboard/topic', methods=['GET'])
@limiter.limit("50/minute")
def getTopic():
    if ('i' in request.args):
        resultados = Topic.listado(int(request.args['i']))
    else:
        resultados = Topic.listado()

    if (len(resultados) == 0):
        abort(404)
    else:
        return jsonify({ 'topic': marshal(resultados, Topic.FIELDS) })


######################################################################################################################################
######################################################################################################################################
######################################################################################################################################
## Métodos para las User
######################################################################################################################################
######################################################################################################################################
######################################################################################################################################
@app.route('/signboard/user', methods=['GET'])
@limiter.limit("50/minute")
@auth.login_required
def getUsers():
    if ('i' in request.args):
        resultados = User.listado(int(request.args['i']))
    elif ('a' in request.args):
        resultados = User.listado(0, request.args['a'])

    if (len(resultados) == 0):
        abort(404)
    else:
        return jsonify({ 'user': marshal(resultados, User.FIELDS) })


@app.route('/signboard/user', methods=['POST'])
@limiter.limit("50/minute")
@auth.login_required
def createUser():
    if (
        (not request.json) or
        (not 'nombre' in request.json) or
        (not 'alias' in request.json) or
        (not 'pass' in request.json) or
        (not 'email' in request.json)
    ):
        abort(400)
    else:
        User.alta(
            request.json['nombre'],
            request.json['alias'],
            request.json['pass'],
            request.json['email'],
            request.json.get('tlf', ""),
            request.json.get('hasWhatsapp', 0)
        )

        return jsonify({'user'}), 201


######################################################################################################################################
######################################################################################################################################
######################################################################################################################################
## Métodos para las Anuncio
######################################################################################################################################
######################################################################################################################################
######################################################################################################################################
@app.route('/signboard/anuncio', methods=['GET'])
@limiter.limit("50/minute")
def getAnuncios():
    if ('i' in request.args):
        resultados = Anuncio.listado(int(request.args['i']))
    elif ('a' in request.args):
        resultados = Anuncio.listado(0, request.args['a'])
    elif ('t' in request.args):
        resultados = Anuncio.listado(0, "", int(request.args['t']))
    elif ('c' in request.args):
        resultados = Anuncio.listado(0, "", 0, int(request.args['c']))
    else:
        resultados = Anuncio.listado()

    if (len(resultados) == 0):
        abort(404)
    else:
        return jsonify({ 'anuncio': marshal(resultados, Anuncio.FIELDS) })


@app.route('/signboard/anuncio', methods=['POST'])
@limiter.limit("50/minute")
@auth.login_required
def createAnuncio():
    if (
        (not request.json) or
        (not 'asunto' in request.json) or
        (not 'idUser' in request.json) or
        (not 'idTopic' in request.json) or
        (not 'idCiudad' in request.json)
    ):
        abort(400)
    else:
## 1. descargar desde el cliente la foto añadida y guardarla en una ruta local
## 2. subir el fichero a Picassa
## 3. guardar la URL de acceso a Picassa de la foto
        url = ""
        if ('foto' in request.json):
            file = request.files['foto']
            if (file and allowed_file(file.filename)):
                filename = secure_filename(file.filename)
                file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))

                username = 'signboardapp@gmail.com'
                password = '4Welcome!_?'

                picasaClient = gdata.photos.service.PhotosService()
                picasaClient.ClientLogin(username, password)

                photo = picasaClient.InsertPhotoSimple(configuration.getConfigParameter(CONF_SECC_APP, CONF_SECC_PI), filename, request.json['nombre'], os.path.join(app.config['UPLOAD_FOLDER'], filename), content_type='image/jpeg')
                url = photo.GetMediaURL()

        Anuncio.alta(
            request.json['nombre'],
            request.json.get('descripcion', ""),
            request.json['idUser'],
            url,
            request.json['idTopic'],
            request.json['idCiudad']
        )

        return jsonify({'anuncio'}), 201


@app.route('/signboard/anuncio', methods=['DELETE'])
@limiter.limit("50/minute")
@auth.login_required
def deleteAnuncio(id):
    if (
        (not request.json) or
        (not 'alias' in request.json) or
        (not 'pass' in request.json)
    ):
        abort(400)
    else:
        usuario = User.listado(0, request.json['alias'], request.json['pass'])

        if (
            (not usuario) or
            (len(usuario) < 1)
        ):
            anuncio = Anuncio.listado(id)

            if (anuncio['idUser'] == usuario['id']):
                Anuncio.baja(id)
                return jsonify({'result': True})
            else:
                return jsonify({'result': False})
        else:
            return make_response(jsonify( { 'message': 'User invalid' } ), 403)


######################################################################################################################################
######################################################################################################################################
######################################################################################################################################
## Métodos para las Alertas
######################################################################################################################################
######################################################################################################################################
######################################################################################################################################
@app.route('/signboard/alerta', methods=['POST'])
@limiter.limit("50/minute")
@auth.login_required
def createAlert():
    if (
        (not request.json) or
        (not 'id' in request.json) or ## idUser
        (not 'alias' in request.json) or
        (not 'pass' in request.json)
#        (not 'idTopic' in request.json) or
#        (not 'idPais' in request.json) or
#        (not 'idProvincia' in request.json) or
#        (not 'idCiudad' in request.json)
    ):
        abort(400)
    else:
        Alertas.alta(request.json['idTopic'], request.json['idPais'], request.json['idProvincia'], request.json['idCiudad'], request.json['id'])

        return jsonify({'alert'}), 201


######################################################################################################################################
######################################################################################################################################
######################################################################################################################################
## Inicialización del WS REST
######################################################################################################################################
######################################################################################################################################
######################################################################################################################################
if __name__ == '__main__':
    app.run(
        debug = configuration.getConfigParameter(CONF_SECC_APP, CONF_SECC_DE),  ## deshabilitar en producción
        host = configuration.getConfigParameter(CONF_SECC_APP, CONF_SECC_HO),   ## como las conexiones se van a realizar desde el web-server local, se establecerá a '127.0.0.1', así se añadirá 2 niveles más de seguridad: firewall y el propio flask
        port = int(configuration.getConfigParameter(CONF_SECC_APP, CONF_SECC_PO))    ## puede ser el mismo tanto en desarrollo como en producción
    )
