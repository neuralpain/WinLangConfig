$LANGUAGE_REG_PATH = "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Nls\Language"
$LANGUAGE_REG_KEY_DEFAULT = "Default"
$LANGUAGE_REG_KEY_INSTALL = "InstallLanguage"

function Edit-Registry {
  Set-ItemProperty -Path $LANGUAGE_REG_PATH `
                   -Name $LANGUAGE_REG_KEY_DEFAULT `
                   -Value $Script:SELECTED_LANG.HexValue
  Set-ItemProperty -Path $LANGUAGE_REG_PATH `
                   -Name $LANGUAGE_REG_KEY_INSTALL `
                   -Value $Script:SELECTED_LANG.HexValue
}

function Get-LanguagePack {
  $DownloadJob = Install-Language -Language $Script:SELECTED_LANG.LanguageCode -CopyToSettings -AsJob

  while ($DownloadJob.State -eq 'Running') {
    Write-Host -NoNewLine "`rInstalling $($Script:SELECTED_LANG.Name) [.....] " -ForegroundColor Cyan
    Start-Sleep -Milliseconds 100
    Write-Host -NoNewLine "`rInstalling $($Script:SELECTED_LANG.Name) [*....] " -ForegroundColor Cyan
    Start-Sleep -Milliseconds 100
    Write-Host -NoNewLine "`rInstalling $($Script:SELECTED_LANG.Name) [.*...] " -ForegroundColor Cyan
    Start-Sleep -Milliseconds 100
    Write-Host -NoNewLine "`rInstalling $($Script:SELECTED_LANG.Name) [..*..] " -ForegroundColor Cyan
    Start-Sleep -Milliseconds 100
    Write-Host -NoNewLine "`rInstalling $($Script:SELECTED_LANG.Name) [...*.] " -ForegroundColor Cyan
    Start-Sleep -Milliseconds 100
    Write-Host -NoNewLine "`rInstalling $($Script:SELECTED_LANG.Name) [....*] " -ForegroundColor Cyan
    Start-Sleep -Milliseconds 100
    Write-Host -NoNewLine "`rInstalling $($Script:SELECTED_LANG.Name) [.....] " -ForegroundColor Cyan
    Start-Sleep -Milliseconds 100
  }

  switch ($DownloadJob.State) {
    'Completed' {
      Wait-Job $DownloadJob >$null 2>&1
      Remove-Job $DownloadJob
      Write-Host "`rInstalled $($Script:SELECTED_LANG.Name)" -ForegroundColor Green
    }
    'Failed' { Write-Host "`n:: Download encountered an error.`n" -ForegroundColor Yellow; Pause; exit }
    'Stopped' { Write-Host "`n:: Download was manually stopped.`n" -ForegroundColor Yellow; Pause; exit }
  }
}

function Update-LanguageList {
  $LanguageList = Get-WinUserLanguageList
  $LanguageList.Insert(0, $Script:SELECTED_LANG.LanguageCode)
  Set-WinUserLanguageList $LanguageList
  # Set-WinUserLanguageList -LanguageList $Script:SELECTED_LANG.LanguageCode -Force
}

function Set-SystemUILanguage {
  Set-WinSystemLocale $Script:SELECTED_LANG.LanguageCode
  Set-SystemPreferredUILanguage -Language $Script:SELECTED_LANG.LanguageCode
}
