function Write-Menu {
  [int]$x = Read-Host "`nLanguage #"
  if ($null -ne $x) { $Script:SELECTED_LANG = $LanguageObjectList[$x] }
  $res = (Get-WinUserLanguageList | Where-Object { $_.LanguageTag -eq $Script:SELECTED_LANG.LanguageCode })
  
  switch ($res) {
    $false {
      Write-Host "`"$($Script:SELECTED_LANG.Name)`" is already installed. Please select another language." -ForegroundColor Yellow
      Write-Menu
    }
    $true {
      if ($res -gt $LanguageObjectList.Length) {
        Write-Host "Not an option. Please select a language from the list." -ForegroundColor Red
        Write-Menu
      }
    }
    default {
      Write-Host "Not an option. Please select a language from the list." -ForegroundColor Red
      Write-Menu
    }
  } 
}
