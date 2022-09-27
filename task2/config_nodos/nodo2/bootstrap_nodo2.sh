#!/usr/bin/env bash

#Update de los packetes de la VM
apt-get update

#Instalo docker
apt-get install -y docker.io

#Instalar git (ya viene en la imagen utilizada)
sudo apt-get install -y git

#Se instala apache para prueba de la VM y se copia un archivo html de ejemplo
apt-get install -y apache2

if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant/config_nodos/nodo2/content /var/www
fi

#Copio el shell script de prueba al home de la VM
cp /vagrant/config_nodos/nodo2/testNode.sh /home/vagrant
chmod +x /home/vagrant/testNode.sh