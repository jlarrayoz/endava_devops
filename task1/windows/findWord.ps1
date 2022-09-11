
if ( $args.count -ne 2) {
    Write-Output "Uso: findWord.ps1 ARCHIVO PALABRA"
    return
}

$count = (get-content $args[0] | select-string -CaseSensitive -pattern "$($args[1])").length

Write-Output "La palabra Tarara aparece $count vez/veces"