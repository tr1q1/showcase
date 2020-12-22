#!/bin/bash

SEMAFORO=/tmp/.procesandoNotificacionesON
FORMATO_TIMESTAMP='%Y-%m-%d %T'

if [ -f $SEMAFORO ]; 
then
        timestamp=$(date +"$FORMATO_TIMESTAMP")
        echo $timestamp ' - Tarea ya en ejecución.'
else
        # semaforo
##        timestamp=$(date +"$FORMATO_TIMESTAMP")
##        echo $timestamp ' - Se activa el semaforo'
        touch $SEMAFORO

	java -jar /opt/scripts/gotham-cl-procesar.jar 172.20.5.84 2>&1 /dev/null

##        timestamp=$(date +"$FORMATO_TIMESTAMP")
##        echo $timestamp ' - Se DESactiva el semaforo'
        rm $SEMAFORO
fi

exit 0
