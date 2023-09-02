 # Print on console the error in case there is one
function errorMessage {
    Write-Host "Una poronga este script, no anda nada, el error es:`n $error" -ForegroundColor Red
}

 # Show a success window popup in case nothing goes wrong
function successPopup { 
    $NewForm = New-Object Windows.Forms.Form
    $NewForm.Size = New-Object Drawing.Size @(400,100)
    $NewForm.StartPosition = "CenterScreen"
    $Label = New-Object System.Windows.Forms.Label
    $Label.Text = "Costo pero se pudo"
    $Label.Location  = New-Object System.Drawing.Point(20,20)
    $LabeL.AutoSize = $true
    $NewForm.Controls.Add($Label)
    $NewForm.ShowDialog()
}

# Show an error window pop up in case something goes wrong
function errorPopup {
    $NewForm = New-Object Windows.Forms.Form
    $NewForm.Size = New-Object Drawing.Size @(500,200)
    $NewForm.StartPosition = "CenterScreen"
    $Label = New-Object System.Windows.Forms.Label
    $Label.Text = "Una poronga este script, el error es:`n $error"
    $Label.Location  = New-Object System.Drawing.Point(20,20)
    $Label.AutoSize = $true
    $NewForm.Controls.Add($Label)
    $NewForm.ShowDialog()
}

# Windows Defender
function disableDefender { # Disable Windows Defender through a registry key
    Try {
        New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -Value 1 -PropertyType "DWord" -ErrorAction Stop
        successPopup

    }
    Catch {
        errorMessage
        errorPopup
        $error.Clear()
    }
}

function enableDefender { # Delete the registry key previously created
    Try {
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -ErrorAction Stop
        # ErrorAction Stop makes Non-terminating errors trigger the catch condition
        successPopup
    }
    Catch {
        errorMessage
        errorPopup
        $error.Clear()
    }
}

# Start Menu Web Search
function disableExplorerWebSearch { # Disable Bing web search on Start Menu through registry keys, if Registry Keys exist, change their values so web search is disabled
    Try {
        New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Value 0 -PropertyType "DWord" -ErrorAction Stop # For W10 ver.1909 or older
    }
    Catch {
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Value 0
    }
    Try {
        New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "CortanaConsent" -Value 0 -PropertyType "DWord" -ErrorAction Stop
    }
    Catch {
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "CortanaConsent" -Value 0
    }
    Try {
        New-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -Value 1 -PropertyType "DWord" -ErrorAction Stop # For newer W10 versions
        successPopup
    }
    Catch {
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -Value 1
        errorMessage
        errorPopup
        $error.Clear()
    }
}

function enableExplorerWebSearch { #Reenable and delete previous changes
    Try {
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Value 1
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "CortanaConsent" -Value 1
        Remove-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions"
        successPopup
    }
    Catch {
        errorMessage
        errorPopup
        $error.Clear()
    }
}