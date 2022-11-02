# **Task 7**

Solución a la tarea de Monitoring


<br/>

## Contenido
1. [Video de la tarea funcionando](https://drive.google.com/file/d/1bV5Pd-JhDsA7QVtoDwDGGrPnHxJL3kVZ/view?usp=sharing)
2. [Creación de las VM con Vagrant](#vagrant)
3. [Cambios en el compose del target server](#target_server)
4. [Cambios en el compose del prometheus_server](#prom_server)
5. [Ejecutar la tarea](#ejecutar)

<div id='vagrant'>

<br/>

## Creación de las VM con Vagrant

Acorde al lo que se pide en la tarea se utilizó vagrant para ejecutar las 2 VM necesarias.

Se relizaron algunos cambios al archivo  **_['Vagrantfile'][1]_**  para sortear errores que se dieron al tratar de levantar el proyecto con el archivo original.

Alguno de los cambios fueron:

1. Se definio el adaptador por defecto para la public_network definida (En mi pc hay varios adaptadores y se configuró uno por defecto)
2. Se cambio las IPs de los 2 nodos para que estuvieran dentro del rango permitido (192.168.56.???)

**Los cambios realizados fueron comentados en el archivo, además se pueden apreciar las lineas originales.**

También se realizaron algunos cambios en los archivos de aprovisionamiento.

provision.sh

```bash
...

#Seteamos el timezone correspondiente para evitar problemas con prometheus
sudo timedatectl set-timezone America/Argentina/Buenos_Aires
```

Se agrego la ultima linea para setear el timezone idem a la maquina host, para evitar errores que se dieron por diferencias entre la hora del host y de las VM que hacía que grafana y prometheus no reportaran las metricas.

Se agrego el script **_['provision_target.sh'][2]_**. Este script copia la parte del report correspondiente al server target.

También se modifico el script **_['provision_prome.sh'][3]_**, se agrego una última linea para copiar la parte del repo correspondiente al server de prometheus.

</div>

<div id='target_server'>

<br/>

## Cambios en el compose de target_server

A continuación se muestran los cambios realizados en el archivo **_['docker-compose.yml'][4]_**:

```yaml
...
  #Servicio de bd postgres
  postgres:
    image: postgres:14.5
    ports:
      - "5432:5432"
    restart: always
    environment:
      POSTGRES_PASSWORD: password
    logging:
      driver: "json-file"
      options:
        max-size: "50m"
  #Servicio para el exporter de postgres
  psexporter:
    image: quay.io/prometheuscommunity/postgres-exporter
    ports:
      - "9187:9187"
    depends_on:
      - postgres
    environment:
      DATA_SOURCE_NAME: "postgresql://postgres:password@localhost:5432/postgres?sslmode=disable"
    logging:
      driver: "json-file"
      options:
        max-size: "50m"

```

</div>

<div id='prom_server'>

<br/>

## Cambios en el compose de prometheus_server

A continuación se muestran los cambios realizados en el archivo **_['prometheus.yml'][5]_**:

```yaml
scrape_configs:

...

 - job_name: postgres_exporter
    metrics_path: /metrics
    scheme: http
    static_configs:
    - targets:
      - 192.168.56.103:9187
      labels:
        component: database


```

También se actualizo la IP de la VM target por la nueva IP (192.168.56.103).

</div>

<div id='ejecutar'>

<br/>

## Ejecutar la tarea

Para ejecutar la tarea y ver todo lo mencionado anteriormente funcionando debemos ejecutar los siguientes pasos:

### Levantar vagrant
Parados en el directorio donde se encuentra el archivo Vagrantfile ejecutar:

```bash
vagrant up
```

### Acceder por ssh al server target

Para acceder por ssh al server target:

```bash
ssh root@192.168.56.103
```

El password es 'vagrant'

### Levantar el compose

Para levantar el compose vamos a ejecutar los siguientes comandos:

```bash
cd /home/vagrant/target_server
bash run_compose.sh
```

### Verificar métricas de postgres

Para ver si las métricas de posgres se están exponiendo correctamente vamos a ejecutar:

```bash
curl http://192.168.56.103:9187/metrics
```

Deberíamos ver en la consola las métricas disponibles.

### Acceder por ssh al server prometheus

Primero debemos salir del server target:

```bash
exit
```

Luego nos conectamos por shh:

```bash
ssh root@192.168.56.104
```

El password es 'vagrant'

### Levantar el compose

Para levantar el compose vamos a ejecutar los siguientes comandos:

```bash
cd /home/vagrant/prometheus_server
bash run_compose.sh
```

### Verificar que este arriba prometheus

Podemos verificar si prometheus esta funcionando accediendo desde el navegador web del host a la siguiente url:

[http://192.168.56.104:9090](http://192.168.56.104:9090)

### Configurar GRAFANA

Para acceder a GRAFANA debemos abrir el navegador y acceder a la siguiente url:

[http://192.168.56.104:9090](http://192.168.56.104:3000)

Luego debemos:

1. Crear el datasource de prometheus (URL:http://192.168.56.104:9090)
2. Importar el dashboard 9628
3. Verificar que se estén colectando las métricas

Para este último paso se recomienda ver el video [Tarea funcionando](https://drive.google.com/file/d/1bV5Pd-JhDsA7QVtoDwDGGrPnHxJL3kVZ/view?usp=sharing).


<div/>

[1]: Vagrantfile
[2]: provision/provision_target.sh
[3]: provision/provision_prome.sh
[4]: monitoring-workshop/target_server/docker-compose.yml
[5]: monitoring-workshop/prometheus_server/prometheus/prometheus.yml
