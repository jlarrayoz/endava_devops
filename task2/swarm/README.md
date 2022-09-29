## Punto 6 - Cluster docker swarm

Para este punto vamos a utilizar las 2 VM creadas previamente con vagrant.

A continuación el paso a paso de como levantar el cluster

### 1 - Levantar las 2 vm con vagrant

Parados en el directorio donde se encuentra el archivo Vagrantfile ejecutar el siguiente comando:

```bash
vagrant up
```

A continuación se levantarán las 2 vm que van a ser utilizadas para el cluster

### 2 - Crear los nodos del cluster

El cluster estará compuesto por 2 nodos, uno de ellos identificado como master.

Utilizaremos la vm "nodo1" como master y se deben ejecutar los siguientes comandos:

```bash
vagrant ssh nodo1
sudo docker swarm init --advertise-addr 192.168.56.100
```

Primero accedemos al nodo1 por ssh y damos inicio al cluster de swarm definiendo este nodo como master.

Al ejecutar el comando swarm init este nos devolverá por consola un comando a ejecutar en los demás nodos que van a ser parte del cluster. Ejemplo:

```bash
sudo docker swarm join --token TOKEN_DEL_PASO_ANTERIOR 192.168.56.100:2377
```

En otra consola vamos a acceder al nodo2 y ejecutar el comando anterior:

```bash
vagrant ssh nodo2
sudo docker swarm join --token TOKEN_DEL_PASO_ANTERIOR 192.168.56.100:2377
```

*Recordar que se debe cambiar TOKEN_DEL _PASO_ANTERIOR por el devuelto al iniciar el cluster en el nodo1*

Finalizado este paso, tenemos armado un cluster de swarm con nodo1 y nodo2, nodo1 como master y ambos como workers.

### 3 - Clonar repo git (Si no existe)

Una vez este el cluster armado vamos a comenzar con el deploy del stack de servicios.

Para eso necesitamos el repo git donde se encuentra el codigo de las app a desplegar.

En el nodo1, vamos a dirigirnos al home del usuario (ejecutar comando cd) y vamos a verificar que exista la carpeta:

```bash
/home/vagrant/endava_devops
```

Si existe esta carpeta es porque en el proceso de aprovisionamiento del nodo1 ya se clono el repo. En caso de que no exista se debe ejecutar el siguiente comando:

```bash
git clone https://github.com/jlarrayoz/endava_devops.git
```

Finalmente nos vamos a parar en la siguiente carpeta:

```bash
/home/vagrant/endava_devops/task2
```

### 4 - Generar las imagenes de la app

Una vez nos encontremos en el directorio del paso anterior debemos ejecutar el siguiente comando:

```bash
sudo sh generarImagenes.sh
```

Este comando deberá generar en el nodo1 las imagenes:

* backend:1.0.0
* frontend:1.0.0


### 5 - Habilitar registry local

Swarm necesita de un registry par poder distribuir la imagenes a todos los nodos.
En nuestro caso vamos a utilizar un contenedor docker dentro del swarm que se utilizara como registry. Vamos a ejecutar el siguiente comando:

```bash
sudo docker service create --name registry --publish published=5000,target=5000 registry:2
```

Si queremos verificar que el registry esta funcionando correctamente podemos ejecutar el siguiente comando:

```bash
curl http://localhost:5000/v2/
```

*El resultado del comando anterior deberá ser "{}".*

### 6 - Subir las imagenes de la app al registry local

Para que las imagenes generadas anteriormente sean accesibles para swarm hay que subirlas al registry local. Para eso debemos ejecutar los siguientes comandos:

```bash
#Primero las tagueamos
sudo docker tag backend:1.0.0 127.0.0.1:5000/backend:1.0.0 && sudo docker tag frontend:1.0.0 127.0.0.1:5000/frontend:1.0.0

#Luego las pusheamos
sudo docker push 127.0.0.1:5000/backend:1.0.0 && sudo docker push 127.0.0.1:5000/frontend:1.0.0
```

### 7 - Deploy del stack de la app

Finalmente vamos a hacer del deploy del stack. Para esto dentro del directorio swarm (/home/vagrant/endava_devops/task2/swarm) debemos ejecutar el siguiente comando:

```bash
sudo docker stack deploy --compose-file docker-compose.yml stackdemo
```

Para entender que es lo que se va a deployar al cluster es conveniente ver el contenido del archivo ['docker-compose.yml'][1] dentro de la carpeta swarm.

El archivo posee comentarios que facilitan su comprensión

Para ver el estado de stack deployado podemos ejecutar el siguiente comando:

```bash
sudo docker stack services stackdemo
```

### 8 - Probar la app

Para probar que la app este funcioando correctamente en la maquina host acceder en el navegador a la siguiente URL:

```html
http://localhost:8080
```

[1]: docker-compose.yml