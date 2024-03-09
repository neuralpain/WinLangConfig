Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[Application]::EnableVisualStyles()

function Write-WinLangConfig($Col1, $Col2) {
  Clear-Host
  Write-Host "   ____ ____ ____ ____ ____ ____ ____ " -ForegroundColor $Col2
  Write-Host "  ||" -NoNewLine -ForegroundColor $Col2
  Write-Host "W "  -NoNewLine -ForegroundColor $Col1
  Write-Host "|||" -NoNewLine -ForegroundColor $Col2
  Write-Host "I "  -NoNewLine -ForegroundColor $Col1
  Write-Host "|||" -NoNewLine -ForegroundColor $Col2
  Write-Host "N "  -NoNewLine -ForegroundColor $Col1
  Write-Host "|||" -NoNewLine -ForegroundColor $Col2
  Write-Host "L "  -NoNewLine -ForegroundColor $Col1
  Write-Host "|||" -NoNewLine -ForegroundColor $Col2
  Write-Host "A "  -NoNewLine -ForegroundColor $Col1
  Write-Host "|||" -NoNewLine -ForegroundColor $Col2
  Write-Host "N "  -NoNewLine -ForegroundColor $Col1
  Write-Host "|||" -NoNewLine -ForegroundColor $Col2
  Write-Host "G "  -NoNewLine -ForegroundColor $Col1
  Write-Host "||`n" -NoNewLine -ForegroundColor $Col2
  Write-Host "  ||__|||__|||__|||__|||__|||__|||__||" -ForegroundColor $Col2
  Write-Host "  |/__\|/__\|/__\|/__\|/__\|/__\|/__\|" -ForegroundColor $Col2
  Write-Host "     ____ ____ ____ ____ ____ ____    " -ForegroundColor $Col2
  Write-Host "    ||" -NoNewline -ForegroundColor $Col2
  Write-Host "C " -NoNewline -ForegroundColor $Col1
  Write-Host "|||" -NoNewline -ForegroundColor $Col2
  Write-Host "O " -NoNewline -ForegroundColor $Col1
  Write-Host "|||" -NoNewline -ForegroundColor $Col2
  Write-Host "N " -NoNewline -ForegroundColor $Col1
  Write-Host "|||" -NoNewline -ForegroundColor $Col2
  Write-Host "F " -NoNewline -ForegroundColor $Col1
  Write-Host "|||" -NoNewline -ForegroundColor $Col2
  Write-Host "I " -NoNewline -ForegroundColor $Col1
  Write-Host "|||" -NoNewline -ForegroundColor $Col2
  Write-Host "G " -NoNewline -ForegroundColor $Col1
  Write-Host "||`n" -NoNewline -ForegroundColor $Col2
  Write-Host "    ||__|||__|||__|||__|||__|||__||   " -ForegroundColor $Col2
  Write-Host "    |/__\|/__\|/__\|/__\|/__\|/__\|   " -ForegroundColor $Col2
  Write-Host
  Write-Host "                 v1.1.0               " -ForegroundColor $Col2
  Write-Host
}

$Text_ComputerRequiresRestart = "Computer requires a restart to apply changes."
$Text_ConfirmRestart = "Restart to apply changes. Do you want to restart now?"
$Text_LanguageNotInstalled = "Language not installed. Please select an installed`n     language or install this language to use it."

$TITLE_BAR_HEIGHT = 40
$BUTTON_HEIGHT = 100
$BUTTON_HEIGHT_SMALL = 50
$WINDOW_WIDTH = 300
$WINDOW_HEIGHT = $TITLE_BAR_HEIGHT + ($BUTTON_HEIGHT * 1) + ($BUTTON_HEIGHT_SMALL * 3) + 300

$MainWindowForm = New-Object Form -Property @{
  StartPosition   = [FormStartPosition]::CenterScreen
  Topmost         = $true
  MaximizeBox     = $false
  FormBorderStyle = "FixedDialog"
  MinimumSize     = New-Object Drawing.Size $WINDOW_WIDTH, $WINDOW_HEIGHT
  MaximumSize     = New-Object Drawing.Size $WINDOW_WIDTH, $WINDOW_HEIGHT
  Text            = "WinLangConfig"
  Font            = New-Object Font("Segoe UI", 12)
}

$Button_LanguagePackInfo = New-Object Button -Property @{
  Height = $BUTTON_HEIGHT
  Dock   = 'Top'
  Text   = "INFO"
}

$Button_AddNewLanguage = New-Object Button -Property @{
  Height = $BUTTON_HEIGHT_SMALL
  Dock   = 'Bottom'
  Text   = "Install this Language"
  # DialogResult = [System.Windows.Forms.DialogResult]::OK
}

$Button_ExitApplication = New-Object Button -Property @{
  Height       = $BUTTON_HEIGHT_SMALL
  Width        = $BUTTON_HEIGHT_SMALL / 2
  Dock         = 'Bottom'
  Text         = "Exit"
  DialogResult = [System.Windows.Forms.DialogResult]::Cancel
}

$Button_SwitchDisplayLanguage = New-Object Button -Property @{
  Height = $BUTTON_HEIGHT_SMALL
  Dock   = 'Bottom'
  Text   = "Use this Language"
}

$ListBox_LanguageSelection = New-Object ListBox -Property @{
  Location = New-Object System.Drawing.Point(10, 40)
  Dock     = 'Fill'
  # Height   = $BUTTON_HEIGHT
}

$Label_NameTag = New-Object Label -Property @{
  Dock     = 'Bottom'
  AutoSize = $true
  Font     = New-Object Font("Consolas", 8)
  Text     = "https://github.com/neuralpain/WinLangConfig"
}

function Show-FirstWindowControls {
  # $MainWindowForm.Controls.Clear()
  $MainWindowForm.Controls.AddRange((
      $ListBox_LanguageSelection,
      $Button_LanguagePackInfo,
      $Label_NameTag,
      $Button_SwitchDisplayLanguage,
      $Button_AddNewLanguage,
      $Button_ExitApplication
    ))
}

foreach ($lang in $LanguageObjectList) {
  [void] $ListBox_LanguageSelection.Items.Add($lang.Name)
}

$Button_LanguagePackInfo.Add_Click({
    Write-Host "`n--- CURRENT DISPLAY LANGUAGE ---" -ForegroundColor Cyan
    DISM /online /Get-Intl | Out-String | Out-Host
    Write-Host "--- END CURRENT DISPLAY LANGUAGE ---`n" -ForegroundColor Cyan
    Write-Host "-----------------------------"
    Write-Host "TOTAL AVAILABLE LANGUAGES: $($LanguageObjectList.Length)"
    Write-Host "-----------------------------`n"
  })

$ListBox_LanguageSelection.Add_Click({
    foreach ($lang in $LanguageObjectList) {
      if ($lang.Name -eq $LanguageObjectList[$ListBox_LanguageSelection.SelectedIndex].Name) {
        if ($lang.Name -ne $Script:SELECTED_LANG.Name) {
          $Script:SELECTED_LANG = $lang
          Write-Host "${env:USERNAME}: Selected $($Script:SELECTED_LANG.Name)"
        }
        else {
          $Script:SELECTED_LANG = $null
          Write-Host "${env:USERNAME}: Unselected $($lang.Name)"
        }
      }
    }
  })

$Button_AddNewLanguage.Add_Click({
    if ($null -eq $Script:SELECTED_LANG) { 
      Write-Host "WLC: Please select a language."; return 
    }

    $userSelectedAlreadyInstalledLanguage = (Get-WinUserLanguageList | Where-Object { $_.LanguageTag -eq $Script:SELECTED_LANG.LanguageCode })
    if ($null -eq $userSelectedAlreadyInstalledLanguage) {
      $confirm = [MessageBox]::Show("Are you sure you want to install $($Script:SELECTED_LANG.Name)?", "Confirm Language Selection", [MessageBoxButtons]::YesNo)
      if ($confirm -eq "Y") {
        Edit-Registry
        Get-LanguagePack
        Update-LanguageList
        Set-SystemUILanguage
        Write-Host "WLC: $Text_ComputerRequiresRestart" -ForegroundColor Yellow
        $confirm = [MessageBox]::Show($Text_ConfirmRestart, "Confirm Resatrt", [MessageBoxButtons]::YesNo)
        if ($confirm -eq "Y") { Restart-Computer }
      }
    }
    else { 
      Write-Host "`"$($Script:SELECTED_LANG.Name)`" is already installed. Please select another language." -ForegroundColor Yellow
    }
  })
  
$Button_SwitchDisplayLanguage.Add_Click({
    if ($null -eq $Script:SELECTED_LANG) { 
      Write-Host "WLC: Please select a language."; return 
    }
    
    $currentDisplayLanguage = (Get-ItemProperty -Path "$LANGUAGE_REG_PATH" -Name $LANGUAGE_REG_KEY_DEFAULT).$LANGUAGE_REG_KEY_DEFAULT
    if ($currentDisplayLanguage -eq $Script:SELECTED_LANG.HexValue) {
      Write-Host "WLC: Already using $($Script:SELECTED_LANG.Name)."; return
    }
    
    $languageIsInstalled = (Get-WinUserLanguageList | Where-Object { $_.LanguageTag -eq $Script:SELECTED_LANG.LanguageCode })
    if ($null -eq $languageIsInstalled) {
      Write-Host "WLC: $Text_LanguageNotInstalled"  ; return
    }

    $confirm = [MessageBox]::Show("Are you sure you want to use $($Script:SELECTED_LANG.Name)?", "Confirm Language Selection", [MessageBoxButtons]::YesNo)
    if ($confirm -eq "Y") {
      Edit-Registry -DefaultLanguage
      Update-LanguageList
      Set-SystemUILanguage
      Write-Host "WLC: $Text_ComputerRequiresRestart" -ForegroundColor Yellow
    }
  })
  
Write-WinLangConfig "White" "Cyan"
Start-Transcript "C:\Windows\Logs\WinLangConfig_Log_$($(Get-Date).ToString('yyMMddHHmmss')).txt" >$null 2>&1
Show-FirstWindowControls
$result = $MainWindowForm.ShowDialog()
if ($result -eq [System.Windows.Forms.DialogResult]::Cancel) { exit }
exit
