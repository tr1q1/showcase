#!/bin/bash

## Parametros
##   maquina    --> calculado
##   servidor	--> de entrada  
##   app        --> de entrada (de entre una lista de valores determinados)
##   idTipo     --> de entrada (de entre una lista de valores determinados)
##   mensaje    --> de entrada (texto libre)
##   stackTrace --> de entrada (texto libre), opcional

## validacion de parametros
if [ $# -lt 3 ]; then
    echo "Faltan parametros"
    echo "Uso: $0 <SERVIDOR_NOTIFICACIONES> <ID_APP> <ID_TIPO_NOTIFICACION> <MENSAJE_A_ENVIAR> <TRAZA_ERROR_A_ENVIAR_POR_EMAIL>"
    
    exit -1
else
	maquina=`echo $HOSTNAME`

    if [ -z $maquina ]; then
    	maquina=`ip route get 8.8.8.8 | awk 'NR==1 {print $NF}'`
    fi

##	echo "$maquina"
##	echo "{\"maquina\":\"$maquina\",\"app\":\"$1\",\"idTipo\":$2,\"mensaje\":\"$3\",\"stackTrace\":\"$4\"}"
##	echo wget --no-proxy -O /dev/null -nv --header="Accept-Charset: ISO-8859-1" --header="Content-Type: application/json" --post-data "{\"maquina\":\"$maquina\",\"app\":\"$2\",\"idTipo\":$3,\"mensaje\":\"$4\",\"stackTrace\":\"$5\"}" http://$1:8080/gotham/notificacion/
	
	wget --no-proxy -O /dev/null -nv --header="Accept-Charset: ISO-8859-1" --header="Content-Type: application/json" --post-data "{\"maquina\":\"$maquina\",\"app\":\"$2\",\"idTipo\":$3,\"mensaje\":\"$4\",\"stackTrace\":\"$5\"}" http://$1:8080/gotham/notificacion/
	
	exit 0
fi

