## Scripts Linux ##


1. El script **getDate.sh** muestra la fecha del sistema en formato yyyy-MM-dd
2. El script **findWord.sh** busca una palabra recibida por param en el archivo ../resources/textoEjemplo.txt.
3. El script **replaceWord.sh** busca una palabra y la remplaza por otra (Ambas recibidas por param)
4. El script **getLastLines.sh** muestra las X últimas lineas de un archivo

**NOTA**

```text
para ejecutar los scripts primero se le debe dar permisos de ejecucion.
Ejemplo:
chmod +x getDate.sh
```

**PARA SABER COMO UTILIZAR LOS SCRIPTS se deben de ejecutar sin pasarle params**

### Ejemplos de uso ###

Script 1:

```bash
./getDate.sh

Resultado:

La fecha del sistema es: 2022-09-11
```

Script 2:

```bash

./findWord.sh Tarara

Resultado:

Palabra a buscar: Tarara
La palabra Tarara se encontro 7 vez/veces
```

_La palabra se busca en el archivo "textoEjemplo.txt" que se encuentra en la parpeta resources de la raiz del repo._
**NOTA:** La búsqueda es key sensitive por lo que la palabra Tarara se considera distinta a tarara.

Script 3:

```bash
./replaceWord.sh Tarara FOO

Resultado:

La FOO, sí;
la tarara, no;
la FOO, niña,
que la he visto yo.
Lleva la FOO
un vestido verde
lleno de volantes
y de cascabeles.
La FOO, sí;
la tarara, no;
la FOO, niña,
que la he visto yo.
Luce mi FOO
su cola de seda
sobre las retamas
y la hierbabuena.
Ay, FOO loca.
Mueve, la cintura
para los muchachos
de las aceitunas.

```

_Este script NO modifica el archivo original (../resources/textoEjemplo.txt), el resultado del reemplazo lo guarda en un nuevo archivo (../resources/textoActualizado.txt)._

Script 4:

```bash
./getLastLines.sh ../resources/textoEjemplo.txt 4

Resultado:

Ay, Tarara loca.
Mueve, la cintura
para los muchachos
de las aceitunas.

```

_Este ejemplo muestra las ultimas 4 lineas del archivo ../resources/textoEjemplo.txt. Ambos datos son recibidos por params._
