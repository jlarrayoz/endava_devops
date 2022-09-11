#!/bin/bash

function usage {
   cat << EOF

Remplaza PALABRA_ORIGEN por PALABRA_DESTINO del archivo ./resources/textoRemplazo.txt y guarda el resultado en el archivo textoActualizado.txt

Uso: replaceWord.sh PALABRA_ORIGEN PALABRA_DESTINO

PALABRA_ORIGEN: Palabra a buscar
PALABRA_DESTINO: Palabra por la cual se remplazará PALABRA_ORIGEN

NOTA: Este script NO modifica el texto original. Para preservarlo guarda el resultado en el archivo ./resources/textoActualizado.txt

EOF
   exit 1
}

#Me fijo si la cantidad de params recibidas por el script es !=2
#Si es distinto, muestro a pantalla como usarlo y termino la ejecucion del script
if [ $# -ne 2 ]
then
    usage;
fi  

echo "Palabra origen: $1"
echo "Palabra destino: $2"

#Busca  PALABRA_ORIGEN y la reemplaza por PALABRA_DESTINO
#El resultado de reemplazar va a stdout y en este caso se redirecciona al archivo resources/textoActualizado.txt
#Esto se hace para no perder el archivo original
sed s/$1/$2/ ./resources/textoRemplazo.txt 1> ./resources/textoActualizado.txt