### Levantar las 2 vm con vagrant
vagrant up

### Inicializar el swarm con el nodo manager (nodo1)
sudo docker swarm init --advertise-addr 192.168.56.100

### Para agregar un worker al swarm, ejecutar el comando que te devuelve el paso anerior. En este caso (nodo2):

sudo docker swarm join --token TOKEN_DEL_PASO_ANTERIOR 192.168.56.100:2377

### Para ver el estado del swarm en el nodo1:

sudo docker info

### Para ver el estado de los nodos etc. (nodo1):

sudo docker node ls


Una vez esta el swarm armado, en el nodo manager vamos a clonar el repo donde estan los proyectos de front y back
git clone https://github.com/jlarrayoz/endava_devops.git

Luego vamos al directorio de task2 y ejecutamos el shell script:

```bash
sudo sh generarImagenes.sh
```

Swarm necesita de un registry par poder distribuir la imagenes a todos los nodos.
En nuestro caso vamos a utilizar un contenedor docker dentro del swarm que se utilizara como registry

sudo docker service create --name registry --publish published=5000,target=5000 registry:2

Luego que subir la imagenes que al registry local. Primeto tenemos que taguearlas:

sudo docker tag backend:1.0.0 127.0.0.1:5000/backend:1.0.0 && sudo docker tag frontend:1.0.0 127.0.0.1:5000/frontend:1.0.0

Luego las pusheamos:

sudo docker push 127.0.0.1:5000/backend:1.0.0 && sudo docker push 127.0.0.1:5000/frontend:1.0.0

por ultimo subimos el stack al swarm (dentro de la carpeta swarm):

sudo docker stack deploy --compose-file docker-compose.yml stackdemo
