#Controlo que se le pasen 2 params al script
if ( $args.count -ne 2) {
    Write-Output "Uso: replaceWord.ps1 PALABRA_ORIGEN PALABRA_DESTINO"
    return
}
#Se imprimen los params
Write-Output "Palabra buscada: $($args[0])"
Write-Output "Palabra remplazo: $($args[1])"

#Se remplaza palabra en el archivo textoEjemplo.txt (del dir resoruces) y se guarda el resultado en textoActualizadoPS.txt
#Se hace esto para no modificar el archivo origen.
(Get-Content ../resources/textoEjemplo.txt).replace($($args[0]), $($args[1])) | Set-Content ../resources/textoActualizadoPS.txt