## **Task 2**

Solución de la segunda homework asignada en el curso

### **Punto 1**

El archivo **_['Vagrantfile'][1]_** contiene el punto uno de la tarea.

La particularidad del archivo es que define la configuración para 2 VM:
- nodo1
- nodo2

A continuación podemos ver el contenido del archivo:

```yaml
# -*- mode: ruby -*-
# vi: set ft=ruby :

# Define la version del archivo que vamos a utilizar
# Esto generalmente no se toca
Vagrant.configure("2") do |config|

  # Se define la configuracion del nodo1
  config.vm.define "nodo1" do |nodo1|
    # Seleccionamos la imagen de la VM que queremos utilizar
    # En este caso corresponde a una imagen de Ubuntu 18.04 LTS
    # Mediante el tag config.vm.box_version tambien podemos definir una version especifica de la imagen
    # Por mas imagenes visitar https://vagrantcloud.com/search
    nodo1.vm.box = "ubuntu/bionic64"
    nodo1.vm.box_version = "20220916.0.0"

    #Se define un hostname para la VM
    nodo1.vm.hostname = "nodo1"

    #Configuracion del port forwarding entre host y guest
    nodo1.vm.network :forwarded_port, guest: 80, host: 4567

    #Defino una private_network y le asigno una ip al nodo1
    #La ip debe estar en el rango: Ranges: 192.168.56.0/21
    nodo1.vm.network :private_network, ip: "192.168.56.100"

    # Se define el script bootstrap.sh (en el mismo dir que el archivo de vagrant) para provisionar la VM
    nodo1.vm.provision :shell, path: "config_nodos/nodo1/bootstrap_nodo1.sh"

    # Configuracion especifica del provider. En nuestro caso, Virtualbox
    nodo1.vm.provider "virtualbox" do |v|
      # Definimos la memoria asignada a la VM (2GB en este caso)
      v.memory = "2048"
      v.name = "nodo1"
    end

  end

  # Se define la configuracion del nodo2
  config.vm.define "nodo2" do |nodo2|
    # Seleccionamos la imagen de la VM que queremos utilizar
    # En este caso corresponde a una imagen de Ubuntu 18.04 LTS
    # Mediante el tag config.vm.box_version tambien podemos definir una version especifica de la imagen
    # Por mas imagenes visitar https://vagrantcloud.com/search
    nodo2.vm.box = "ubuntu/bionic64"
    nodo2.vm.box_version = "20220916.0.0"

    #Se define un hostname para la VM
    nodo2.vm.hostname = "nodo2"

    #Configuracion del port forwarding entre host y guest
    nodo2.vm.network :forwarded_port, guest: 80, host: 4568

    #Defino una private_network y le asigno una ip al nodo2
    #La ip debe estar en el rango: Ranges: 192.168.56.0/21
    nodo2.vm.network :private_network, ip: "192.168.56.101"

    # Se define el script bootstrap.sh (en el mismo dir que el archivo de vagrant) para provisionar la VM
    nodo2.vm.provision :shell, path: "config_nodos/nodo2/bootstrap_nodo2.sh"

    # Configuracion especifica del provider. En nuestro caso, Virtualbox
    nodo2.vm.provider "virtualbox" do |v|
      # Definimos la memoria asignada a la VM (2GB en este caso)
      v.memory = "2048"
      v.name = "nodo2"
    end

  end
end

```

[1]: Vagrantfile
