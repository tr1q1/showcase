#!/bin/bash

## este script debe ejecutarse con el usuario loggeado en XUbuntu (por defecto, usuariopantalla),
## sino no se dispondrá de acceso al dispositivo HDMI1
## por ello se configurará en el cron del usuario usuariopantalla para que se ejecute cada 30 minutos

SEMAFORO=/tmp/.estadoPantallaON
TIMEOUT_TV=10 # en segundos
FORMATO_TIMESTAMP='%Y-%m-%d %T'
CONEXION_TV="HDMI1"
RESOLUCION_TV="1920x1080"
## configuracion de la pantalla de la entrada
## CONEXION_TV="VGA1"
## RESOLUCION_TV="1024x768"

## en algunas pantallas hay que dar acceso al DISPLAY explicitamente
export DISPLAY=:0.0

## echo =`xrandr --prop | grep HDMI1`
if [ -f $SEMAFORO ]; 
then
        timestamp=$(date +"$FORMATO_TIMESTAMP")
        echo $timestamp ' - Tarea ya en ejecución.'
else
        # semaforo
##      timestamp=$(date +"$FORMATO_TIMESTAMP")
##      echo $timestamp ' - Se activa el semaforo'
        touch $SEMAFORO

	if [[ ! `DISPLAY=:0.0 ; xrandr --prop | grep $CONEXION_TV` == *"$CONEXION_TV connected $RESOLUCION_TV"* ]]
        then
                timestamp=$(date +"$FORMATO_TIMESTAMP")
                echo $timestamp ' - La pantalla ha sido apagada'

                ## mandar aviso
                ## /opt/scripts/notificar.sh 5 10 PANTALLA 'TV de pant3 apagada, se requiere intervención humana.'
                timestamp=$(date +"$FORMATO_TIMESTAMP")
                echo $timestamp ' - Se trata de reactivar la pantalla'
                DISPLAY=:0.0 ; xrandr --output $CONEXION_TV --off ; sleep $TIMEOUT_TV ; xrandr --output $CONEXION_TV --mode $RESOLUCION_TV

		if [[ ! `DISPLAY=:0.0 ; xrandr --prop | grep $CONEXION_TV` == *"$CONEXION_TV connected $RESOLUCION_TV"* ]]
                then
	                timestamp=$(date +"$FORMATO_TIMESTAMP")
        	        echo $timestamp ' - No se ha conseguido reactivar la pantalla'
		fi
        else
                if [[ `DISPLAY=:0.0 ; xrandr --prop | grep $CONEXION_TV` == *"$CONEXION_TV connected $RESOLUCION_TV"* ]]
                then
                        timestamp=$(date +"$FORMATO_TIMESTAMP")
#                       echo $timestamp ' - Pantalla encendida'
                else
                        timestamp=$(date +"$FORMATO_TIMESTAMP")
                        echo `DISPLAY=:0.0 ; xrandr --prop | grep $CONEXION_TV`
                        echo $timestamp ' - Imposible verificar el estado de la pantalla'
                fi
        fi

##      timestamp=$(date +"$FORMATO_TIMESTAMP")
##      echo $timestamp ' - Se DESactiva el semaforo'
        rm $SEMAFORO
fi

exit 0
