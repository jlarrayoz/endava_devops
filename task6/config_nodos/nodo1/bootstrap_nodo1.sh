#!/usr/bin/env bash

#Instalacion de ansible en ubuntu 18.04
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt update
sudo apt install -y ansible

#Generar clave publica del Ansible Master para luego copiar a los diferentes nodos
ssh-keygen -b 2048 -t rsa -f /home/vagrant/.ssh/id_rsa -q -N ""

#Copio la clave generada al host para luego ser copiada a los otros nodos (para que ansible pueda acceder a ellos por ssh)
cp /home/vagrant/.ssh/id_rsa.pub /vagrant/config_nodos/nodo1/ssh_key/

#Copio el contenido de ansible para que el nodo lo pueda utilizar (copio inventory y playbooks)
cp -rp /vagrant/ansible /home/vagrant