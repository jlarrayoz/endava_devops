#!/usr/bin/env bash
 
#Ejecuto este comando en el nodo1 
ssh vagrant@192.168.56.100 -o StrictHostKeyChecking=no -- '/vagrant/config_nodos/post_provision_execute.sh'
