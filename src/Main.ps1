# show language packs info
Write-Host "`n--- CURRENT DISPLAY LANGUAGE ---" -ForegroundColor White
DISM /online /Get-Intl
Write-Host "`n--- END CURRENT DISPLAY LANGUAGE ---`n" -ForegroundColor White

Write-Host "TOTAL AVAILABLE LANGUAGES: $($LanguageObjectList.Length)`n"

$i = 0
foreach ($lang in $LanguageObjectList) {
  Write-Host $i $lang.Name; $i++
}

Write-Menu
# $Script:SELECTED_LANG = $Lang_Chinese
Edit-Registry
Get-LanguagePack
Update-LanguageList
Set-SystemUILanguage

# show language packs info
Write-Host "`n--- NEW DISPLAY LANGUAGE ---" -ForegroundColor White
DISM /online /Get-Intl
Write-Host "`n--- END NEW DISPLAY LANGUAGE ---`n" -ForegroundColor White

Write-Host "Please restart your Windows Operating System for the changes to take effect." -ForegroundColor Yellow

Pause
exit
