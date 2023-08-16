#DEBUG
function Hello {
    Write-Host("Hola!")
} 

function biometricsStop {
    Stop-Service -Name "WbioSrvc"
}