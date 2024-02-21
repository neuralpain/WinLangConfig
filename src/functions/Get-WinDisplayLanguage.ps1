$LANGUAGE_REG_PATH="Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Nls\Language"
$LANGUAGE_REG_KEY_DEFAULT="Default"
$LANGUAGE_REG_KEY_INSTALL="InstallLanguage"

function Update-LanguageList($Lang) {
  # $OldList = Get-WinUserLanguageList
  # $OldList.Add($Lang.LanguageCode)
  # Set-WinUserLanguageList $OldList
  Set-WinUserLanguageList -LanguageList $Lang.LanguageCode -Force
}

function Write-Registry($Lang) {
  Set-ItemProperty -Path $LANGUAGE_REG_PATH `
                   -Name $LANGUAGE_REG_KEY_DEFAULT `
                   -Value $Lang.HexValue
  Set-ItemProperty -Path $LANGUAGE_REG_PATH `
                   -Name $LANGUAGE_REG_KEY_INSTALL `
                   -Value $Lang.HexValue
}

function Add-Language($Lang) {
  $DownloadJob = Install-Language -Language $Lang.LanguageCode -CopyToSettings -AsJob

  while ($DownloadJob.State -eq 'Running') {
    Write-Host -NoNewLine "`rInstalling $($Lang.Name) *.... " -ForegroundColor Cyan
    Start-Sleep -Milliseconds 100
    Write-Host -NoNewLine "`rInstalling $($Lang.Name) .*... " -ForegroundColor Cyan
    Start-Sleep -Milliseconds 100
    Write-Host -NoNewLine "`rInstalling $($Lang.Name) ..*.. " -ForegroundColor Cyan
    Start-Sleep -Milliseconds 100
    Write-Host -NoNewLine "`rInstalling $($Lang.Name) ...*. " -ForegroundColor Cyan
    Start-Sleep -Milliseconds 100
    Write-Host -NoNewLine "`rInstalling $($Lang.Name) ....* " -ForegroundColor Cyan
    Start-Sleep -Milliseconds 100
  }

  Wait-Job $DownloadJob >$null 2>&1
  Remove-Job $DownloadJob
  Write-Host "`rInstalled $($Lang.Name)" -ForegroundColor Green
}

function Set-UiLang($Lang) {
  Set-WinSystemLocale $Lang.LanguageCode
  Update-LanguageList $Lang.LanguageCode
  Set-SystemPreferredUILanguage -Language $Lang.LanguageCode
}

# Uninstall-Language -Language $SelectedLanguage.LanguageCode

<#
Get-InstalledLanguage | ForEach-Object { 
  if ($_.Language -eq $SelectedLanguage.LanguageCode) {
    Write-Host $SelectedLanguage.Name is already installed.
  } else { 
    Set-ItemProperty -Path $LANGUAGE_REG_PATH -Name $LANGUAGE_REG_KEY -Value $SelectedLanguage.HexValue
    Write-Host Installed $SelectedLanguage.Name
    # Update language list
    # $OldList = Get-WinUserLanguageList
    # $OldList.Add($SelectedLanguage.LanguageCode)
    # Set-WinUserLanguageList -LanguageList $OldList
  }
}
#>

# use a boolean to check if the language is already in a list

# ForEach-Object { Where-Object { $_. -match $SelectedLanguage.LanguageCode {
#   return false
# } }
