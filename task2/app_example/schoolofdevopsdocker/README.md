# App de ejemplo para aprender a utilizar docker y docker-compose

Esta app esta compuesta por 2 partes:
 - **rampupBackend:** Backend de la app
 - **rampupFrontend:** Frontend de la app

## App rampupBackend

Para crear la imagen de docker asociada a la app (Se tiene que estar parado dentro del dir de la App, al mismo nivel que el archivo Dockerfile):

```bash
docker build -t frontend:1.0.0 .
```

El comando anterior construye la imagen de docker **frontend:1.0.0**

Si queremos probar el frontend (NO ES NECESARIO TENER LEVANTADO EL BACKEND) podemos ejecutar el siguiente comando en consola:

```bash
docker run -it --rm --env-file .env -p 8080:3000 frontend:1.0.0
```

