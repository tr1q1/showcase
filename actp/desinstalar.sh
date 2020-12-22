#!/bin/bash

if [ "$(whoami)" = "root" ]; then
	rm -rf /usr/local/lib/actp
	rm /usr/local/bin/actp
else
	rm ~/bin/actp
fi
rm -rf /tmp/.actp

