#Defino la imagen de  node que voy a utilizar (En esta caso la ultima de node)
FROM node:latest

#Defino el workingdir dentro del contenedor
WORKDIR /usr/src/app

#Copio los archivos package.json y package-lock.josn al contenedor
COPY package*.json ./

#Instalo las dependencias de node
RUN npm install --only=production

#Copio el resto del contenido al contenedor (toma en cuenta el archivo .dockerignore)
COPY . .


#Comunico en que puerto hay algun servicio disponible en el container
#Se toma de una variable de entorno definida en el archivo .env
EXPOSE ${PORT}

#Ejecuto la app
#CMD [ "npm", "start" ]
CMD ["sh", "start.sh"]