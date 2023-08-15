Add-Type -assembly System.Windows.Forms

# Ventana principal
$main_form = New-Object System.Windows.Forms.Form
$main_form.Text ='El Dechoater'
$main_form.Width = 550
$main_form.Height = 200
$main_form.AutoSize = $true


# Ejecucion de GUI
$main_form.ShowDialog()