#!/bin/bash

xset -q | grep Monitor > antes.log
xset dpms force off

xset -q | grep Monitor > despues.log
xset dpms force on
