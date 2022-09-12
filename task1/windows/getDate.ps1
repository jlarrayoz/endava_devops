#Obtengo la fecha del sistema en formato yyyy-mm-dd

#Guardo la fecha en una variable
$fecha = Get-Date -Format "yyyy-MM-dd"

#Imprimo la fecha a consola con un mensaje previo
Write-Output "La fecha del sistema es: $fecha"