#!/usr/bin/env bash

#Copio la clave publica del nodo1 para que este se pueda conecar por ssh
sudo bash -c 'cat /vagrant/config_nodos/nodo1/ssh_key/id_rsa.pub  >> /home/vagrant/.ssh/authorized_keys'