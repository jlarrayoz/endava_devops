#!/usr/bin/env bash

#Instalo docker
#No instalo la version que viene por defecto con Ubuntu 18.04.
#Agrego el repo e instalo la ultima disponible para la version del S.O
apt-get install -y curl apt-transport-https ca-certificates software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - 
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" 

#Update de los packetes de la VM
apt-get update

#Me aseguro que se instale la version del repo agregado previamente
apt-cache policy docker-ce

#Instalo docker y sus accesorios
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

#Instalo links para poder navegar web desde consola (necesario para el punto 6 de la tarea)
sudo apt-get install -y links

#Instalar git (ya viene en la imagen utilizada)
sudo apt-get install -y git

#Clono el repo donde esta el codigo de la tarea
git clone https://github.com/jlarrayoz/endava_devops.git


#Se instala apache para prueba de la VM y se copia un archivo html de ejemplo
apt-get install -y apache2

if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant/config_nodos/nodo1/content /var/www
fi

#Copio el shell script de prueba al home de la VM
cp /vagrant/config_nodos/nodo1/testNode.sh /home/vagrant
chmod +x /home/vagrant/testNode.sh
