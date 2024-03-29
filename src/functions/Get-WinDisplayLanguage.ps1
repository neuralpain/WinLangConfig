$LANGUAGE_REG_PATH = "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Nls\Language"
$LANGUAGE_REG_KEY_DEFAULT = "Default"
$LANGUAGE_REG_KEY_INSTALL = "InstallLanguage"

# get user's initial language
$Script:ORIGINAL_LANG = (Get-ItemProperty -Path $LANGUAGE_REG_PATH -Name $LANGUAGE_REG_KEY_DEFAULT).$LANGUAGE_REG_KEY_DEFAULT
foreach ($lang in $LanguageObjectList) {
  if ($lang.HexValue -eq $Script:ORIGINAL_LANG) {
    $Script:ORIGINAL_LANG = $lang
  }
}

function Edit-Registry {
  param($Language = $Script:SELECTED_LANG)
  Set-ItemProperty -Path $LANGUAGE_REG_PATH -Name $LANGUAGE_REG_KEY_DEFAULT -Value $Language.HexValue
  Set-ItemProperty -Path $LANGUAGE_REG_PATH -Name $LANGUAGE_REG_KEY_INSTALL -Value $Language.HexValue
  Write-Host "WLC: Updated registry" -ForegroundColor White
}

function Restore-PreviousLanguageAfterDownloadFailure {
  Edit-Registry -Language $Script:ORIGINAL_LANG
  Write-Host "WLC: Reverted to previous display language" -ForegroundColor Yellow
}

function Get-LanguagePack {
  if (-not(Test-Connection "www.google.com" -Quiet)) {
    Write-Host "No internet."
    Pause; return
  }
  
  $DownloadJob = Install-Language -Language $Script:SELECTED_LANG.LanguageCode -CopyToSettings -ExcludeFeatures -AsJob

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
    'Failed' {
      Write-Host "`n:: Download encountered an error." -ForegroundColor Red 
      Restore-PreviousLanguageAfterDownloadFailure; exit
    }
    'Stopped' {
      Write-Host "`n:: Download was manually stopped." -ForegroundColor Red 
      Restore-PreviousLanguageAfterDownloadFailure; exit
    }
  }
}

function Update-LanguageList {
  $LanguageList = Get-WinUserLanguageList
  $LanguageList.Insert(0, $Script:SELECTED_LANG.LanguageCode)
  Set-WinUserLanguageList $LanguageList -Force
  Write-Host "WLC: Reordered system language list" -ForegroundColor White
}

function Set-SystemUILanguage {
  # -- RPC_E_CHANGED_MODE (0x80010106)
  # https://github.com/jchv/go-webview2/issues/13
  Set-WinSystemLocale $Script:SELECTED_LANG.LanguageCode
  Write-Host "WLC: System locale updated" -ForegroundColor White  
  # Set-WinUILanguageOverride -Language $Script:SELECTED_LANG.LanguageCode
  # Write-Host "WLC: UI Language Override ON" -ForegroundColor White
  Set-SystemPreferredUILanguage -Language $Script:SELECTED_LANG.LanguageCode >$null 2>&1
  # Set-Language -Language $Script:SELECTED_LANG.LanguageCode
  Write-Host "WLC: UI language set to $($Script:SELECTED_LANG.LanguageCode)" -ForegroundColor Cyan
}
