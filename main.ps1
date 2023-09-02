# Modules
Import-Module -Name '.\functions.ps1' -Force
Add-Type -Assembly System.Windows.Forms


#Background image
$file = (get-item '.\cuchau.jpg')
$img = [System.Drawing.Image]::Fromfile($file)
[System.Windows.Forms.Application]::EnableVisualStyles()
$pictureBox = new-object Windows.Forms.PictureBox
$pictureBox.Width =  $img.Size.Width;
$pictureBox.Height =  $img.Size.Height;
$pictureBox.Image = $img;


# Main GUI
$main_form = New-Object System.Windows.Forms.Form
$main_form.Text ='Dechoater 1.0'
$main_form.Width = $pictureBox.Width
$main_form.Height = $pictureBox.Height
$main_form.AutoSize = $true


# Buttons
$disableDefenderButton = New-Object System.Windows.Forms.Button
$disableDefenderButton.Text = "Disable Windows Defender"
$disableDefenderButton.Location  = New-Object System.Drawing.Point(270, 20)
$disableDefenderButton.AutoSize = $true
$disableDefenderButton.Add_Click({
    disableDefender
})

$enableDefenderButton = New-Object System.Windows.Forms.Button
$enableDefenderButton.Text = "Enable Windows Defender"
$enableDefenderButton.Location  = New-Object System.Drawing.Point(50, 20)
$enableDefenderButton.AutoSize = $true
$enableDefenderButton.Add_Click({
    enableDefender
})

$disableExplorerWebSearchButton = New-Object System.Windows.Forms.Button
$disableExplorerWebSearchButton.Text = "Disable Explorer Web Search"
$disableExplorerWebSearchButton.Location  = New-Object System.Drawing.Point(270, 60)
$disableExplorerWebSearchButton.AutoSize = $true
$disableExplorerWebSearchButton.Add_Click({
    disableExplorerWebSearch
})

$enableExplorerWebSearchButton = New-Object System.Windows.Forms.Button
$enableExplorerWebSearchButton.Text = "Enable Explorer Web Search"
$enableExplorerWebSearchButton.Location  = New-Object System.Drawing.Point(50, 60)
$enableExplorerWebSearchButton.AutoSize = $true
$enableExplorerWebSearchButton.Add_Click({
    enableExplorerWebSearch
})


# Icon
$formIcon = New-Object system.drawing.icon(get-item '.\favicon.ico')
$main_form.Icon = $formIcon


# GUI adding & drawing
$main_form.Controls.Add($disableDefenderButton)
$main_form.Controls.Add($enableDefenderButton)
$main_form.Controls.Add($disableExplorerWebSearchButton)
$main_form.Controls.Add($enableExplorerWebSearchButton)
$main_form.Controls.Add($pictureBox)
$main_form.ShowDialog()