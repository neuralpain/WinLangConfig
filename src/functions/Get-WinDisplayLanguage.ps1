$LANGUAGE_REG_PATH = "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Nls\Language"
$LANGUAGE_REG_KEY_DEFAULT = "Default"
$LANGUAGE_REG_KEY_INSTALL = "InstallLanguage"

function Edit-Registry($Lang) {
  Set-ItemProperty -Path $LANGUAGE_REG_PATH `
                   -Name $LANGUAGE_REG_KEY_DEFAULT `
                   -Value $Lang.HexValue
  Set-ItemProperty -Path $LANGUAGE_REG_PATH `
                   -Name $LANGUAGE_REG_KEY_INSTALL `
                   -Value $Lang.HexValue
}

function Get-LanguagePack($Lang) {
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

  switch ($DownloadJob.State) {
    'Completed' {
      Wait-Job $DownloadJob >$null 2>&1
      Remove-Job $DownloadJob
      Write-Host "`rInstalled $($Lang.Name)" -ForegroundColor Green
    }
    'Failed' { Write-Host "`r:: Download encountered an error.`n" -ForegroundColor DarkYellow; Pause }
    'Stopped' { Write-Host "`r:: Download was manually stopped.`n" -ForegroundColor DarkYellow; Pause }
  }
}

function Update-LanguageList($Lang) {
  $LangList = Get-WinUserLanguageList
  $LangList.Insert(0, $Lang.LanguageCode)
  Set-WinUserLanguageList $LangList
  # Set-WinUserLanguageList -LanguageList $Lang.LanguageCode -Force
}

function Set-SystemUILanguage($Lang) {
  Set-WinSystemLocale $Lang.LanguageCode
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
    # $LangList = Get-WinUserLanguageList
    # $LangList.Add($SelectedLanguage.LanguageCode)
    # Set-WinUserLanguageList -LanguageList $LangList
  }
}
#>