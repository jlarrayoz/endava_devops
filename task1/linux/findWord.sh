#!/bin/bash

function usage {
   cat << EOF

Busca la palabra PALABRA_A_BUSCAR en el archivo ./resources/textoEjemplo.txt y muestra en stdout la cantidad de veces que aparece esa palabra.

Uso: findWord.sh PALABRA_A_BUSCAR

EOF
   exit 1
}


#Me fijo si la cantidad de params recibidas por el script es !=1
#Si es distinto, muestro a pantalla como usarlo y termino la ejecucion del script
if [ $# -ne 1 ]
then
   usage;
fi  

echo "Palabra a buscar: $1"

#Utilizo grep para buscar la palabra recibida por param en el archivo de ejemplo
#El param -o para que solo se quede con la parte de la linea que machea
#el comando wc se utiliza para contar la cantidad de palabras del output obtenido del grep
#Guardo la cantidad de palabras encontradas en la variable cantidad 
cantidad=($(grep -o $1  ./resources/textoEjemplo.txt | wc -w))

#Si encontre la palabra muestro a pantalla la cantidad de veces que aparece
if [ $cantidad -gt 0 ]
then
    echo "La palabra $1 se encontro $cantidad vez/veces"
else
    echo "No se encontro la palabra $1 en el archivo"
fi