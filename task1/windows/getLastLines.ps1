#Controlo que se le pasen 2 params al script
if ( $args.count -ne 2) {
    Write-Output "Uso: getLastLines.ps1 ARCHIVO CANTIDAD_LINEAS"
    return
}

#Obtieneo las ultimas X lineas del archivo recibido por param
Get-Content $args[0]  -tail $args[1]