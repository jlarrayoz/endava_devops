# **Task 4 - Cloud AWS**

<br/>

## Contenido
1. [QwikLabs I](#lab1)
    1. [Conclusión](#lab1_1)
2. [QwikLabs II](#lab2)
    1. [Conclusión](#lab2_1)


<div id='lab1'/>

<br/>

## QwikLabs "Cloud I" 

**Objetivo:** Build VPC, S3, EC2 and RDS Products with AWS Service Catalog

**Descripción:** El laboratorio consta de 9 tareas. A continuación se muestra captura con las tareas que lo componenen:

![Lista tareas](images/lab01/listaTareas.png)

<br/>

#### **Task 1**

![Task 1 finalizada](images/lab01/finTask1.png)

<br/>

#### **Task 2**

![Task 2 finalizada](images/lab01/finTask2.png)

<br/>

#### **Task 3**

![Task 3 finalizada](images/lab01/finTask3.png)

<br/>

#### **Task 4**

![Task 4 finalizada](images/lab01/finTask4.png)

<br/>

#### **Task 5**

![Task 5 finalizada](images/lab01/finTask5.png)

<br/>

#### **Task 6**

![Task 6 finalizada](images/lab01/finTask6.png)

<br/>

#### **Task 7**

![Task 7 finalizada](images/lab01/finTask7.png)

<br/>

#### **Task 8**

![Task 8 finalizada](images/lab01/finTask8.png)

<br/>

#### **Task 9**

![Task 9 EC2](images/lab01/task9EC2-2.png)

![Task 9 RDS2](images/lab01/Task9RDS-2.png)


<br/>

#### **Lab terminado**

![Lab terminado](images/lab01/labTerminado.png)

<br/>

_Constancia de avance_

![Lab finish](images/lab01/lab1Completado.png)

<br/>

<div id='lab1_1'/>

#### **Conclusión**

<div style="text-align: justify">

El contenido del laboratorio es correcto, la explicación paso a paso de AWS es detallada y si se sigue al pie de la letra se puede completar el lab sin mayores problemas.

Al ser contrareloj, no te permite profundizar mientras haces el labs en diferentes conceptos que se van presentando y no tenía claros.

Al levantar la configuración por ejemplo de la VPC de un template, se desconoce en detalle todo lo que ya viene configurado por defecto, y como dije anteriormente, el tiempo no te permite profundizar en detalle en la configuración por miedo a que no te de para terminar en tiempo y forma.

Me quede con varios conceptos que se tocan en el taller anotados para profundizarlos, sobre todo lo que tiene que ver con IAM, ya que la parte de seguirdad la vimos muy por arriba en el curso.

En resumen, buen lab, que muestra como aplicar varios de los conceptos básicos vistos en el curso.

</div>

<br/>

<div id='lab2'/>

## QwikLabs "Cloud II"

**Objetivo:** Maintaining High Availability with Auto Scaling

**Descripción:** El laboratorio consta de varios pasos (no están separados en tareas como el lab I) A continuación se muestra captura de los pasos que lo componenen:

![Lista tareas](images/lab02/listaTareas.png)

<br/>

#### **Connect to EC2 and Configure AWS CLI**

![Login exitoso](images/lab02/loginExitoso.png)

<br/>

#### **Create Launch Configuration and Auto Scaling Group**

_Creación por consola de "Launch Configuration"_

![Launch configuration](images/lab02/launchConfig.png)

_Creación por consola de "Auto Scaling Group"_

![Scaling Group](images/lab02/scalingGroup.png)

_Validación de las instancias_

![Validando instancias](images/lab02/verificacionInstancias.png)

_Server funcionando_

![Validando instancias](images/lab02/verificandoInstancias2.png)


A continuación terminamos instanicas y verificamos que se volvieran a crear. También lo hicimos parando instancias.

![Estado instancias](images/lab02/estadoInstancias.png)


<br/>

#### **Create Auto Scaling Notifications**

Primero creamos una topic utilizando el servicio SNS, luego creamos un subscriber y lo configuramos para que nos notificara por mail.

![Subscriber creado](images/lab02/subscriberCreado.png)

![Subscriber confirmado](images/lab02/subscriberMensajeConfirmado.png)

<br/>

#### **Create Policies and alarms**

Se crean 2 policies:
1. Scale up policiy: Cuando el % de consumo de CPU >= 40 se suma una instancia
2. Scale down policy: Cuando el % de consumo de CPU baja de 20% se resta una instancia

_Scale UP Policy_

![Scale UP](images/lab02/scaleUP.png)

_Scale DOWN Policy_

![Scale DOWN](images/lab02/scaleDown.png)

Se crean 2 alarmas asociadas a las policies definidas anteriormente:

_Alarm High CPU usage_

![Alarm High](images/lab02/alarmHighCPU.png)

_Alarm Low CPU usage_

![Alarm Low](images/lab02/alarmLowCPU.png)


<br/>

#### **Test auto scaling**

Para probar todo lo creado anteriormente, entramos desde el browser a a la URL del loadbalancer y le pedimos que generara carga:

![Generar carga](images/lab02/generarCarga.png)

Se pudo apreciar el siguiente camdio de estado en las alarmas:

![Cambio Alarmas](images/lab02/cambioAlarmas.png)

En la captura se puede apreciar que al generar carga se dispara la alarma de HIGH CPU y su estado cambia a "In alarm".

En la siguiente captura podemos apreciar como se creo una instancia y luego cuando la carga bajo del 20% esa instancia fue "terminada"

![Cambio instancias](images/lab02/cambioInstancias.png)


Acorde a lo configurado, al mail llegaron las siguientes notificaciones:

![Cambio instancias](images/lab02/alarmasMail.png)

<br/>

#### **Lab terminado**

![Lab terminado](images/lab02/labTerminado.png)

<br/>

_Constancia de avance_

![Lab terminado](images/lab02/comprobanteLab.png)

<div id='lab2_1'/>


#### **Conclusión**

<div style="text-align: justify">

El contenido del laboratorio es correcto, la explicación paso a paso de AWS es detallada y si se sigue al pie de la letra se puede completar el lab sin mayores problemas.

Al ser contrareloj, no te permite profundizar mientras haces el labs en diferentes conceptos que se van presentando y no tenía claros.

Los comandos que terminé ejecutando por consola, si bien son entendibles una vez que se los analiza en detalle, a priori parecen "magia negra" :)

Me reslultó muy interesante el tema, he trabajando con balanceo de carga sobre Kubernetes y docker (utilizando Nginx por ejemplo), AWS lo tiene muy bien resuelto.

En resumen, buen lab, que muestra como aplicar varios de los conceptos básicos vistos en el curso.

</div>