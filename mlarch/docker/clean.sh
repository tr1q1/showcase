#!/usr/bin/env bash

./down.sh
rm -rf data/es/*
rm -rf data/es2/*
rm -rf data/mongo/*
rm -rf data/zeppelin/logs/*
rm -rf data/zeppelin/notebook/*

exit 0
