function errorMessage { # Print on console the error in case there is one
    Write-Host "Una poronga este script, no anda nada, el error es:`n $error" -ForegroundColor Red
}

# Windows Defender
function disableDefender { # Disable Windows Defender through a registry key
    Try {
        New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -Value 1 -PropertyType "DWord" -ErrorAction Stop
    }
    Catch {
        errorMessage
    }
}

function enableDefender { # Delete the registry key previously created
    Try {
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -ErrorAction Stop
        # ErrorAction Stop makes Non-terminating errors trigger the catch condition
    }
    Catch {
        errorMessage
    }
}

# Start Menu Web Search

function disableStartMenuWebSearch { # Disable Bing web search on Start Menu through registry keys, if Registry Keys exist, change their values so web search is disabled
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
    }
    Catch {
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -Value 1
    }
}

function enableStartMenuWebSearch { #Reenable and delete previous changes
    Try {
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Value 1
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "CortanaConsent" -Value 1
        Remove-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions"
    }
    Catch {
        errorMessage
    }
}