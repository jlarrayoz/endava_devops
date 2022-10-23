#!/usr/bin/env bash

#Muestro mensaje
echo "********* Ejecutando post provision en el nodo1"

#Agergo el nodo2 al know_hosts 
ssh-keyscan -H 192.168.56.101 >> ~/.ssh/known_hosts
#Agergo el nodo3 al know_hosts
ssh-keyscan -H 192.168.56.102 >> ~/.ssh/known_hosts
