## Scripts PowerShell ##


1. El script **getDate.ps1** muestra la fecha del sistema en formato yyyy-MM-dd
2. El script **findWord.ps1** busca una palabra en un archivo. Ambos datos (palabra y ruta archivo se reciben por param)
3. El script **replaceWord.ps1** busca una palabra y la remplaza por otra (Ambas recibidas por param)
4. El script **getLastLines.ps1** muestra las X últimas lineas de un archivo


**PARA SABER COMO UTILIZAR LOS SCRIPTS se deben de ejecutar sin pasarle params**

### Ejemplos de uso ###

Script 1:

```bash
./getDate.ps1

Resultado:

La fecha del sistema es: 2022-09-11
```

Script 2:

```bash

./findWord.ps1 ../resources/textoEjemplo.txt Tarara

Resultado:

La palabra Tarara aparece 7 vez/veces
```

_Se recibe por param el path del archivo a utilizar y la palabra a buscar

**NOTA:** La búsqueda es key sensitive por lo que la palabra Tarara se considera distinta a tarara.

Script 3:

```bash
./replaceWord.ps1 Tarara FOO

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

_Este script NO modifica el archivo original (../resources/textoEjemplo.txt), el resultado del reemplazo lo guarda en un nuevo archivo (../resources/textoActualizadoPS.txt)._

Script 4:

```bash
./getLastLines.ps1 ../resources/textoEjemplo.txt 4

Resultado:

Ay, Tarara loca.
Mueve, la cintura
para los muchachos
de las aceitunas.

```

_Este ejemplo muestra las ultimas 4 lineas del archivo ../resources/textoEjemplo.txt. Ambos datos son recibidos por params._
