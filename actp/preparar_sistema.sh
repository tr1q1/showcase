#!/bin/bash

if [ "$(whoami)" = "root" ]; then
	mkdir /usr/local/lib/actp
	mv actp /usr/local/lib/actp/
	ln -s /usr/local/bin/actp /usr/local/lib/actp/actp
else
	if $(ls ~/bin > /dev/null); then
		echo "Ya existe el directorio bin/ en el directorio local del usuario $(whoami)."
	else
		mkdir ~/bin/
	fi
	mv actp ~/bin/
fi
if $(ls /tmp/.actp > /dev/null); then
		echo "Ya existe el directorio para los ficheros de configuracion del A.C.T.P. /tmp/.actp"
else
	mkdir /tmp/.actp
fi
if ! [ -f "/tmp/.actp/last.actp" ]; then
	touch /tmp/.actp/last.actp
fi
if ! [ -f "/tmp/.actp/mode.actp" ]; then
	touch /tmp/.actp/mode.actp
	echo "1" > /tmp/.actp/mode.actp
fi
if ! [ -f "/tmp/.actp/mode_base.actp" ]; then
	touch /tmp/.actp/mode_base.actp
	echo "d" > /tmp/.actp/mode_base.actp
fi
 
