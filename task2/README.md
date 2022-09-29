## **Task 2**

Solución de la segunda homework asignada en el curso

## **Videos mostrando la solución**

[Punto 1 y 2 - Video levantar 2 vm Vagrant](https://drive.google.com/file/d/1CQI9PpELPi-armURDRi9zJUAj9EB2-_O/view?usp=sharing)

[Punto 3, 4 y 5 - Video Levantando el compose](https://drive.google.com/file/d/16ud5FN-dxjMh0uyHANhA7a7KYmRUJRvJ/view?usp=sharing)

[Punto 6 - Cluster docker swarm](https://drive.google.com/file/d/1zQujCCSbW7c9Tk4T5coOHulIZ7gxNKPw/view?usp=sharing)


# **SOLUCION DE LA TAREA**

### **Punto 1**

El archivo **_['Vagrantfile'][1]_** contiene el punto uno de la tarea.

La particularidad del archivo es que define la configuración para 2 VM:
- nodo1 (IP 192.168.56.100)
- nodo2 (IP 192.168.56.101)

_Se utiliza una private network para conectar los 2 nodos._

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

    #version de la imagen a utilizar
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

    #version de la imagen a utilizar
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

Cada nodo se aprovisiona con un script diferente que se encuentra en la carpeta config_nodos.

```yaml 
  nodo2.vm.provision :shell, path: "config_nodos/nodo2/bootstrap_nodo2.sh"
```

- El script contiene los siguientes comandos:

```bash
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
  ln -fs /vagrant/config_nodos/nodo1/content /var/www
fi

#Copio el shell script de prueba al home de la VM
cp /vagrant/config_nodos/nodo1/testNode.sh /home/vagrant
chmod +x /home/vagrant/testNode.sh

```

Los scripts de aprovisionamiento son practicamente iguales
- Instalan docker y git
- Se levanta un servidor web apache en cada VM para probar la conectividad entre ambos nodos.
- Para testear que un nodo se puede comunicar con la otra VM se deja en el HOME un shell script llamado testNode.sh, que hace lo siguiente:

```bash
#!/usr/bin/env bash

#Obtiene la pagina publicada en el nodo2
#Utilizo esto para ver la conectividad del nodo1 hacia el nodo2
wget -qO- 192.168.56.101
```

**Para probar las vm se debe ejecutar el siguiente comando parado en el mismo directorio que el archivo Vagrantfile**

```bash
vagrant up
```

Este comando levanta automáticamente las 2 VM (nodo1 y nodo2)

### **Punto 2**

Cuando configuramos mas de una VM en un único archivo Vagrantfile y queremos ejecutar comandos asociados a una de esas VM, se debe ejecutar el comando y además especificar el nombre de la VM.

Ejemplo:

```bash
vagrant ssh nodo1
```

En este caso nos vamos a conectar por ssh a la VM llamada nodo1.

Si queremos acceder por ssh al nodo2:

```bash
vagrant ssh nodo2
```

En el siguiente video se puede ver como se levantan las 2 VM y se prueba la conexión entre ambas:

[Video levantar 2 vm Vagrant](https://drive.google.com/file/d/1CQI9PpELPi-armURDRi9zJUAj9EB2-_O/view?usp=sharing)

### **Punto 3,4 y 5**

Para este punto se debe forkear el siguiene repo:

[https://gitlab.com/matiasnicolas.vargas/schoolofdevopsdocker](https://gitlab.com/matiasnicolas.vargas/schoolofdevopsdocker)

El fork se encuentra disponible en:

[https://gitlab.com/jlarrayoz/schoolofdevopsdocker](https://gitlab.com/jlarrayoz/schoolofdevopsdocker)

En nuestro caso para simplificar la tarea se copio el contenido del fork dentro de la carpeta ['app_example'][2]

Esta carpeta contiene 2 proyectos:

- rampupBackend: Backend del proyecto
- rampupFrontEnd: Frontend del proyecto

#### **FrontEnd**

Dentro del proyecto se agregaron los siguiente archivos:

- [Dockerfile][3]
- .env (Definición de variables de entorno) 

_El proyecto de frontend se mantuvo idem al que se forkeo, no se realizaron cambios_

#### **Backend**

Dentro del proyecto se agregaron los siguiente archivos:

- [Dockerfile][4]
- .env (Definición de variables de entorno) 

A este proyecto se le realizaron varios cambios. Se modificó el archivo package.json:

Se cambio esta linea:

```yaml
 "scripts": {
    "test": "mocha",
    "start": "SET NODE_ENV=dev && node server.js"
  },
```

```yaml
 "scripts": {
    "test": "mocha",
    "start": "node server.js"
  },
```
El comando SET no se estaba reconociendo al correr el contenedor por lo que se removio, analizando el código se vio que no era necesario que estuviera ahí.

También se modificó el archivo seeds.js para lograr que se ejecute la carga inicial de datos en el compose y además espere a que el container de mysql este levantado para ejecutar los scripts:

```yaml
function sleep(ms) {
  return new Promise((resolve) => {
    setTimeout(resolve, ms);
  });
}

async function main () {
  try {

    console.log("************ Wait for mysql init");
    await sleep(10000);
    console.log("************ Continue with execution");
```

Con este cambio se logra que al levantar el compose, se espere 10 segundos antes de ejecutar la carga inicial, asegurando de alguna forma que el container de mysql tuvo tiempo de levantar.

#### **DOCKER-COMPOSE**

Este es el compose que brinda solución al punto 5:

- [docker-compose.yml][5]

Para poder levantar el compose previamente se tiene que generar la imagen correspondiente a cada proyecto (backend y frontend).

Con tal propósito se puede ejecutar el script **generarImagenes.sh (sh generarImagenes.sh)**. Este script genera la imagen para ambos proyectos.

Para correr el compose se debe ejecutar el siguiente comando:

```bash
docker compose up
```

_El comando se debe ejecutar parado e
n la misma carpeta que contiene el archivo del compose._

Para acceder al frontend de la app debemos ingresar a la siguiente URL en el navegador:

[http://localhost:8080/](http://localhost:8080/)

En el siguiente link se puede ver video del compose funcionando:

[Video Levantando el compose](https://drive.google.com/file/d/16ud5FN-dxjMh0uyHANhA7a7KYmRUJRvJ/view?usp=sharing)


### **Punto 6**

La explicación en detalle del punto 6 se encuentra en el archivo ['README.md'][6] dentro de la carpeta swarm.

[1]: Vagrantfile
[2]: app_example
[3]: app_example/schoolofdevopsdocker/rampupFrontend/Dockerfile
[4]: app_example/schoolofdevopsdocker/rampupBackend/Dockerfile
[5]: docker-compose.yml
[6]: swarm/README.md