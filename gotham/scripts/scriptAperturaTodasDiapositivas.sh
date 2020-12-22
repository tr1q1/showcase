#!/bin/bash


#RUTA=/mnt/EquipoSincroDiapo/*.pps

##cmdDiapoAbierta="lsof /mnt/EquipoSincroDiapo/DiapositivaInicio.pps > /dev/null";
#cmdDiapoAbierta="lsof | grep libreoffice > /dev/null";


#for f in $RUTA
#do
#	if [ -f $f ]
#	then	
#		if !(eval $cmdDiapoAbierta)
#		then
#			libreoffice --norestore --nologo $f &
#		fi
#	fi
#done


function abrirDiapositiva()
{
	RUTA=$1;

	cmdDiapoAbierta="lsof | grep libreoffice > /dev/null";	

	#Variables entre comillas para evitar problemas con espacios en nombres

	for f in "$RUTA"
	do
		if [ -f "$f" ]
		then	
			if !(eval $cmdDiapoAbierta)
			then
				libreoffice --norestore --nologo --show "$f" &
			fi
		fi
	done

}

RUTA_PPS=/mnt/EquipoSincroDiapo/*.pps

abrirDiapositiva $RUTA_PPS;

RUTA_PPSX=/mnt/EquipoSincroDiapo/*.ppsx

abrirDiapositiva $RUTA_PPSX;

RUTA_ODP=/mnt/EquipoSincroDiapo/*.odp

abrirDiapositiva $RUTA_ODP;



