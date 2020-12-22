#!/usr/bin/env python
# -*- coding: utf-8 -*-

from flask import Flask, jsonify, abort, request, make_response, url_for
from flask.views import MethodView
from flask.ext.restful import Api, Resource, reqparse, fields, marshal
from flask.ext.httpauth import HTTPBasicAuth
import sys
sys.path.append('/srv/dev/lib/')
import configuration
sys.path.append('/srv/dev/vo/')
import Ciudad, Provincia, Pais, Topic, User, Anuncio

## constantes
CONF_SECC_APP = 'APP'
CONF_SECC_DE = 'DEBUG'
CONF_SECC_HO = 'HOST'
CONF_SECC_PO = 'PORT'

## inicialización estática
app = Flask(__name__, static_url_path = "")
api = Api(app)
auth = HTTPBasicAuth()

######################################################################################################################################
######################################################################################################################################
######################################################################################################################################
## Métodos para las Ciudades
######################################################################################################################################
######################################################################################################################################
######################################################################################################################################
class GetListadoCiudades(Resource):
    decorators = [auth.login_required]
    
    def __init__(self):
        self.reqparse = reqparse.RequestParser()
        
        self.reqparse.add_argument('id', type = int, location = 'json')
        self.reqparse.add_argument('nombre', type = str, location = 'json')
        self.reqparse.add_argument('cp', type = int, location = 'json')
        self.reqparse.add_argument('idProvincia', type = int, location = 'json')

        super(GetListadoCiudades, self).__init__()


    def get(self):
       	resultados = Ciudad.listado()

        if (len(resultados) == 0):
            abort(404)
        else:
        	return { 'ciudad': marshal(resultados, Ciudad.FIELDS) }


class GetCiudadesPorProvincia(Resource):
##    decorators = [auth.login_required]
    
    def __init__(self):
        self.reqparse = reqparse.RequestParser()
        
        self.reqparse.add_argument('id', type = int, location = 'json')
        self.reqparse.add_argument('nombre', type = str, location = 'json')
        self.reqparse.add_argument('cp', type = int, location = 'json')
        self.reqparse.add_argument('idProvincia', type = int, location = 'json')

        super(GetCiudadesPorProvincia, self).__init__()


    def get(self, idProvincia):
       	resultados = Ciudad.listado(0, idProvincia)

        if (len(resultados) == 0):
            abort(404)
        else:
        	return { 'ciudad': marshal(resultados, Ciudad.FIELDS) }


class GetCiudad(Resource):
##    decorators = [auth.login_required]
    
    def __init__(self):
        self.reqparse = reqparse.RequestParser()
        
        self.reqparse.add_argument('id', type = int, location = 'json')
        self.reqparse.add_argument('nombre', type = str, location = 'json')
        self.reqparse.add_argument('cp', type = int, location = 'json')
        self.reqparse.add_argument('idProvincia', type = int, location = 'json')

        super(GetCiudad, self).__init__()


    def get(self, id):
       	resultados = Ciudad.listado(id)

        if (len(resultados) == 0):
            abort(404)
        else:
        	return { 'ciudad': marshal(resultados, Ciudad.FIELDS) }


api.add_resource(GetListadoCiudades, '/signboard/GetListadoCiudades', endpoint = 'GetListadoCiudades')
api.add_resource(GetCiudadesPorProvincia, '/signboard/GetCiudadesPorProvincia/<int:idProvincia>', endpoint = 'GetCiudadesPorProvincia')
api.add_resource(GetCiudad, '/signboard/GetCiudad/<int:id>', endpoint = 'GetCiudad')


######################################################################################################################################
######################################################################################################################################
######################################################################################################################################
## Métodos para las Provincias
######################################################################################################################################
######################################################################################################################################
######################################################################################################################################
class GetListadoProvincias(Resource):
##    decorators = [auth.login_required]
    
    def __init__(self):
        self.reqparse = reqparse.RequestParser()
        
        self.reqparse.add_argument('id', type = int, location = 'json')
        self.reqparse.add_argument('nombre', type = str, location = 'json')
        self.reqparse.add_argument('idPais', type = int, location = 'json')

        super(GetListadoProvincias, self).__init__()


    def get(self):
       	resultados = Provincia.listado()

        if (len(resultados) == 0):
            abort(404)
        else:
        	return { 'provincia': marshal(resultados, Provincia.FIELDS) }


class GetProvinciasPorPais(Resource):
##    decorators = [auth.login_required]
    
    def __init__(self):
        self.reqparse = reqparse.RequestParser()
        
        self.reqparse.add_argument('id', type = int, location = 'json')
        self.reqparse.add_argument('nombre', type = str, location = 'json')
        self.reqparse.add_argument('idPais', type = int, location = 'json')

        super(GetProvinciasPorPais, self).__init__()


    def get(self, idPais):
       	resultados = Provincia.listado(0, idPais)

        if (len(resultados) == 0):
            abort(404)
        else:
        	return { 'provincia': marshal(resultados, Provincia.FIELDS) }


class GetProvincia(Resource):
##    decorators = [auth.login_required]
    
    def __init__(self):
        self.reqparse = reqparse.RequestParser()
        
        self.reqparse.add_argument('id', type = int, location = 'json')
        self.reqparse.add_argument('nombre', type = str, location = 'json')
        self.reqparse.add_argument('idPais', type = int, location = 'json')

        super(GetProvincia, self).__init__()


    def get(self, id):
       	resultados = Provincia.listado(id)

        if (len(resultados) == 0):
            abort(404)
        else:
        	return { 'provincia': marshal(resultados, Provincia.FIELDS) }


api.add_resource(GetListadoProvincias, '/signboard/GetListadoProvincias', endpoint = 'GetListadoProvincias')
api.add_resource(GetProvinciasPorPais, '/signboard/GetProvinciasPorPais/<int:idPais>', endpoint = 'GetProvinciasPorPais')
api.add_resource(GetProvincia, '/signboard/GetProvincia/<int:id>', endpoint = 'GetProvincia')


######################################################################################################################################
######################################################################################################################################
######################################################################################################################################
## Métodos para las Pais
######################################################################################################################################
######################################################################################################################################
######################################################################################################################################
class GetListadoPaises(Resource):
##    decorators = [auth.login_required]
    
    def __init__(self):
        self.reqparse = reqparse.RequestParser()
        
        self.reqparse.add_argument('id', type = int, location = 'json')
        self.reqparse.add_argument('nombre', type = str, location = 'json')
        self.reqparse.add_argument('idioma', type = str, location = 'json')
        self.reqparse.add_argument('pais', type = str, location = 'json')

        super(GetListadoPaises, self).__init__()


    def get(self):
       	resultados = Pais.listado()

        if (len(resultados) == 0):
            abort(404)
        else:
        	return { 'pais': marshal(resultados, Pais.FIELDS) }


class GetPais(Resource):
##    decorators = [auth.login_required]
    
    def __init__(self):
        self.reqparse = reqparse.RequestParser()
        
        self.reqparse.add_argument('id', type = int, location = 'json')
        self.reqparse.add_argument('nombre', type = str, location = 'json')
        self.reqparse.add_argument('idioma', type = str, location = 'json')
        self.reqparse.add_argument('pais', type = str, location = 'json')

        super(GetPais, self).__init__()


    def get(self, id):
       	resultados = Pais.listado(id)

        if (len(resultados) == 0):
            abort(404)
        else:
        	return { 'pais': marshal(resultados, Pais.FIELDS) }


api.add_resource(GetListadoPaises, '/signboard/GetListadoPaises', endpoint = 'GetListadoPaises')
api.add_resource(GetPais, '/signboard/GetPais/<int:id>', endpoint = 'GetPais')


######################################################################################################################################
######################################################################################################################################
######################################################################################################################################
## Métodos para las Topic
######################################################################################################################################
######################################################################################################################################
######################################################################################################################################
class GetListadoTopics(Resource):
##    decorators = [auth.login_required]
    
    def __init__(self):
        self.reqparse = reqparse.RequestParser()
        
        self.reqparse.add_argument('id', type = int, location = 'json')
        self.reqparse.add_argument('nombre', type = str, location = 'json')
        self.reqparse.add_argument('descripcion', type = str, location = 'json')

        super(GetListadoTopics, self).__init__()


    def get(self):
       	resultados = Topic.listado()

        if (len(resultados) == 0):
            abort(404)
        else:
        	return { 'topic': marshal(resultados, Topic.FIELDS) }


class GetTopic(Resource):
##    decorators = [auth.login_required]
    
    def __init__(self):
        self.reqparse = reqparse.RequestParser()
        
        self.reqparse.add_argument('id', type = int, location = 'json')
        self.reqparse.add_argument('nombre', type = str, location = 'json')
        self.reqparse.add_argument('descripcion', type = str, location = 'json')

        super(GetTopic, self).__init__()


    def get(self, id):
       	resultados = Topic.listado(id)

        if (len(resultados) == 0):
            abort(404)
        else:
        	return { 'topic': marshal(resultados, Topic.FIELDS) }


api.add_resource(GetListadoTopics, '/signboard/GetListadoTopics', endpoint = 'GetListadoTopics')
api.add_resource(GetTopic, '/signboard/GetTopic/<int:id>', endpoint = 'GetTopic')


######################################################################################################################################
######################################################################################################################################
######################################################################################################################################
## Métodos para las User
######################################################################################################################################
######################################################################################################################################
######################################################################################################################################
class GetUser(Resource):
##    decorators = [auth.login_required]
    
    def __init__(self):
        self.reqparse = reqparse.RequestParser()
        
        self.reqparse.add_argument('id', type = int, location = 'json')
        self.reqparse.add_argument('nombre', type = str, location = 'json')
        self.reqparse.add_argument('alias', type = str, location = 'json')
        self.reqparse.add_argument('pass', type = str, location = 'json')
        self.reqparse.add_argument('email', type = str, location = 'json')
        self.reqparse.add_argument('tlf', type = str, location = 'json')
        self.reqparse.add_argument('hasWhatsapp', type = int, location = 'json')

        super(GetTopic, self).__init__()


    def get(self, id):
       	resultados = User.listado(id)

        if (len(resultados) == 0):
            abort(404)
        else:
        	return { 'user': marshal(resultados, User.FIELDS) }


api.add_resource(GetUser, '/signboard/GetUser/<int:id>', endpoint = 'GetUser')


######################################################################################################################################
######################################################################################################################################
######################################################################################################################################
## Métodos para las Anuncio
######################################################################################################################################
######################################################################################################################################
######################################################################################################################################
class GetAnuncio(Resource):
##    decorators = [auth.login_required]
    
    def __init__(self):
        self.reqparse = reqparse.RequestParser()

        self.reqparse.add_argument('id', type = int, location = 'json')
        self.reqparse.add_argument('asunto', type = str, location = 'json')
        self.reqparse.add_argument('descripcion', type = str, location = 'json')
        self.reqparse.add_argument('fechaAlta', type = str, location = 'json')
        self.reqparse.add_argument('idUser', type = int, location = 'json')
        self.reqparse.add_argument('urlFoto', type = str, location = 'json')
        self.reqparse.add_argument('idTopic', type = int, location = 'json')
        self.reqparse.add_argument('idCiudad', type = int, location = 'json')

        super(GetAnuncio, self).__init__()


    def get(self, id):
       	resultados = Anuncio.listado(id)

        if (len(resultados) == 0):
            abort(404)
        else:
        	return { 'anuncio': marshal(resultados, Anuncio.FIELDS) }


class GetAnunciosPorAsunto(Resource):
##    decorators = [auth.login_required]
    
    def __init__(self):
        self.reqparse = reqparse.RequestParser()

        self.reqparse.add_argument('id', type = int, location = 'json')
        self.reqparse.add_argument('asunto', type = str, location = 'json')
        self.reqparse.add_argument('descripcion', type = str, location = 'json')
        self.reqparse.add_argument('fechaAlta', type = str, location = 'json')
        self.reqparse.add_argument('idUser', type = int, location = 'json')
        self.reqparse.add_argument('urlFoto', type = str, location = 'json')
        self.reqparse.add_argument('idTopic', type = int, location = 'json')
        self.reqparse.add_argument('idCiudad', type = int, location = 'json')

        super(GetAnunciosPorAsunto, self).__init__()


    def get(self, asunto):
       	resultados = Anuncio.listado(0, asunto)

        if (len(resultados) == 0):
            abort(404)
        else:
        	return { 'anuncio': marshal(resultados, Anuncio.FIELDS) }


class GetAnunciosPorTopic(Resource):
##    decorators = [auth.login_required]
    
    def __init__(self):
        self.reqparse = reqparse.RequestParser()

        self.reqparse.add_argument('id', type = int, location = 'json')
        self.reqparse.add_argument('asunto', type = str, location = 'json')
        self.reqparse.add_argument('descripcion', type = str, location = 'json')
        self.reqparse.add_argument('fechaAlta', type = str, location = 'json')
        self.reqparse.add_argument('idUser', type = int, location = 'json')
        self.reqparse.add_argument('urlFoto', type = str, location = 'json')
        self.reqparse.add_argument('idTopic', type = int, location = 'json')
        self.reqparse.add_argument('idCiudad', type = int, location = 'json')

        super(GetAnunciosPorTopic, self).__init__()


    def get(self, idTopic):
       	resultados = Anuncio.listado(0, "", idTopic)

        if (len(resultados) == 0):
            abort(404)
        else:
        	return { 'anuncio': marshal(resultados, Anuncio.FIELDS) }

@app.route('/signboard/anuncio/')
@limit(requests=100, interval=3600, by="ip")
class GetAnunciosPorCiudad(Resource):
##    decorators = [auth.login_required]
    
    def __init__(self):
        self.reqparse = reqparse.RequestParser()

        self.reqparse.add_argument('id', type = int, location = 'json')
        self.reqparse.add_argument('asunto', type = str, location = 'json')
        self.reqparse.add_argument('descripcion', type = str, location = 'json')
        self.reqparse.add_argument('fechaAlta', type = str, location = 'json')
        self.reqparse.add_argument('idUser', type = int, location = 'json')
        self.reqparse.add_argument('urlFoto', type = str, location = 'json')
        self.reqparse.add_argument('idTopic', type = int, location = 'json')
        self.reqparse.add_argument('idCiudad', type = int, location = 'json')

        print 

        super(GetAnunciosPorCiudad, self).__init__()


    def get(self, idCiudad):
       	resultados = Anuncio.listado(0, "", 0, idCiudad)

        if (len(resultados) == 0):
            abort(404)
        else:
        	return { 'anuncio': marshal(resultados, Anuncio.FIELDS) }


api.add_resource(GetAnuncio, '/signboard/GetAnuncio/<int:id>', endpoint = 'GetAnuncio')
api.add_resource(GetAnunciosPorTopic, '/signboard/GetAnunciosPorTopic/<int:idTopic>', endpoint = 'GetAnunciosPorTopic')
api.add_resource(GetAnunciosPorCiudad, '/signboard/GetAnunciosPorCiudad/<int:idCiudad>', endpoint = 'GetAnunciosPorCiudad')
api.add_resource(GetAnunciosPorAsunto, '/signboard/GetAnunciosPorAsunto/<asunto>', endpoint = 'GetAnunciosPorAsunto')


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

@auth.get_password
def get_password(username):
    if username == 'signboard':
        return 'pass'
    return None
 
@auth.error_handler
def unauthorized():
    # return 403 instead of 401 to prevent browsers from displaying the default auth dialog
    return make_response(jsonify( { 'message': 'Unauthorized access' } ), 403)

