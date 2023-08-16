# Modulos
Import-Module -Name '.\functions.ps1' -Force

Add-Type -Assembly System.Windows.Forms

# Ventana principal
$main_form = New-Object System.Windows.Forms.Form
$main_form.Text ='El Dechoater'
$main_form.Width = 550
$main_form.Height = 200
$main_form.AutoSize = $true

# DEBUG
biometricsStop

# Ejecucion de GUI
# $main_form.ShowDialog()