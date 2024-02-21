# show language packs info
Write-Host "`n--- CURRENT DISPLAY LANGUAGE ---" -ForegroundColor White
DISM /online /Get-Intl
Write-Host "`n--- END CURRENT DISPLAY LANGUAGE ---`n" -ForegroundColor White

$SelectedLanguage = $Lang_French
Write-Registry $SelectedLanguage
Add-Language $SelectedLanguage
Update-LanguageList $SelectedLanguage
Set-UiLang $SelectedLanguage

# show language packs info
Write-Host "`n--- NEW DISPLAY LANGUAGE ---" -ForegroundColor White
DISM /online /Get-Intl
Write-Host "`n--- END NEW DISPLAY LANGUAGE ---`n" -ForegroundColor White

Write-Host "Please restart your Windows Operating System for the changes to take effect." -ForegroundColor Yellow

Pause
