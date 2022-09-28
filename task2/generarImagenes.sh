#!/bin/bash

#Generar la imagen del frotnend
echo "Generar imagen para el frontend"
docker build -t frontend:1.0.0 app_example/schoolofdevopsdocker/rampupFrontend
echo "Generar imagen para el backend"
docker build -t backend:1.0.0 app_example/schoolofdevopsdocker/rampupBackend