#!/bin/bash

function usage {
   cat << EOF

Muestra las ultimas X lineas de un archivo

Uso: getLastLines.sh ARCHIVO CANTIDAD_LINEAS

EOF
   exit 1
}

if [ $# -ne 2 ]
then
   usage;
fi  

tail -$2 $1
