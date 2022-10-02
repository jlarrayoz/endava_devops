#!/usr/bin/env bash

#Copio el shell script de prueba al home de la VM
cp /vagrant/installJenkins.sh /home/vagrant
chmod +x /home/vagrant/installJenkins.sh

#Copio el archivo de credentials
cp /vagrant/credentials /home/vagrant

#Copio el archivo de configuracion jcac
cp /vagrant/jenkins.yaml /home/vagrant

#Copio el directorio de jobs
cp -R /vagrant/pipeline/ /home/vagrant


### Colors ##
ESC=$(printf '\033') RED="${ESC}[31m"

### Color Functions ##
redprint() { printf "${RED}%s${RESET}\n" "$1"; }
greenprint() { printf "${GREEN}%s${RESET}\n" "$1"; }

echo ""
echo ""

greenprint '***************************************************************************'
greenprint '***************************************************************************'
redprint   '**************RECUERDE: dentro de la VM (vagrant ssh)**********************'
redprint   '***Ejecutar el script installJenkins.sh para comenzar con la instalación***'
greenprint '***************************************************************************'
greenprint '***************************************************************************'

echo ""
echo ""
