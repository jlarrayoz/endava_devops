#!/bin/bash

#Funcion que describe el uso del script
function usage {
   cat << EOF

Muestra las ultimas X lineas de un archivo

Uso: getLastLines.sh ARCHIVO CANTIDAD_LINEAS

EOF
   exit 1
}

#Si el script no recibe 2 params, llamo a la funcion usage para explicar como se debe usar
if [ $# -ne 2 ]
then
   usage;
fi  

#Utilizo tail para mostrar las N ($2) ultimas lineas del archivo ($1)
tail -$2 $1
