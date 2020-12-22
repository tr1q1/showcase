#!/usr/bin/env python
# -*- coding: utf-8 -*-

import ConfigParser

CONF_FILE = "/srv/dev/conf/init.cfg"

def getConfigParameter(section, parameter):
	result = ""

	cfg = ConfigParser.ConfigParser()
	if (not cfg.read([CONF_FILE])):
		result = "ERROR: fichero de configuracion inexistente y/o innaccesible."
	else:
		if (cfg.has_option(section, parameter)):
			result = cfg.get(section, parameter)
		else:
			result = "ERROR: el parametro '" + parameter + "' de la seccion '" + parameter + "' no existe."

	return result
