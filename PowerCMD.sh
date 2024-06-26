#!/bin/bash

# PowerCMD.sh, Version 0.2.5
# Copyright (c) 2024, neuralpain
# https://github.com/neuralpain/PowerCMD
# A bundler to integrate PowerShell with CMD

v="0.2.5"
return="PowerCMD:"

# --- START CONFIGURATION --- #

# [ SCRIPT INFO ]
# edit script version in ./VERSION
version=$(<VERSION)
# change name of script
name="WinLangConfig"
# terminal window title
script_title="WinLangConfig"
# license information
license_year="2024"
license_owner="neuralpain"
# link to software website or oss repo
project_url="https://github.com/neuralpain/WinLangConfig"
# basic description of what this script does
script_description="Configure Windows display language"
# change to "true" if your script requires admin
with_admin=true

# [ DIRECTORIES ]
# source directory
src=./src
# other files directory
res=$src/res
# PowerShell functions/module directory
functions=$src/functions
# -- auto-generated -- #
buildfile=./build/$name
cmd_cache=./cache/cmd.build.cmd
pwsh_cache=./cache/pwsh.build.ps1
# -------------------- #

# [ FILES LIST ]
# add additional files here
additional_files=()
# files to exclude in *.min.zip
exclude_files=()
# declare a list of your PowerShell functions here
powershell_functions=(
  "$functions/Initialize-LanguageObjects.ps1"
  "$functions/New-ToastNotification.ps1"
  "$functions/Get-WinDisplayLanguage.ps1"
  "$src/Main.ps1"
)

# --- END CONFIGURATION --- #

complete_release=$name-$version.zip
lightweight_release=$name-$version.min.zip

# `using` statements
useAsmForms="using assembly System.Windows.Forms;"
useNameForms="using namespace System.Windows.Forms;"
useNameDrawing="using namespace System.Drawing;"
useNameWin32="using namespace Microsoft.Win32"

add_pwsh() {
  echo "set \"wdir=%~dp0\"" >> $cmd_cache # your working directory in batch
  echo "set \"pwsh=PowerShell -NoP -C\"" >> $cmd_cache
  echo "setlocal EnableExtensions DisableDelayedExpansion" >> $cmd_cache
  echo "set ARGS=%*" >> $cmd_cache
  echo "if defined ARGS set ARGS=%ARGS:\"=\\\"%" >> $cmd_cache
  echo "if defined ARGS set ARGS=%ARGS:'=''%" >> $cmd_cache
  echo >> $cmd_cache

  # using neuralpain/cmdUAC.cmd <https://gist.github.com/neuralpain/4bcc08065fe79e4597eb65ed707be90d>
  if [[ $with_admin == true ]]; then
    echo ":: check admin permissions" >> $cmd_cache
    echo "fsutil dirty query %systemdrive% >nul" >> $cmd_cache
    echo ":: if error, we do not have admin." >> $cmd_cache
    echo "if %ERRORLEVEL% NEQ 0 (" >> $cmd_cache
    echo "  cls & echo." >> $cmd_cache
    echo "  echo This script requires administrative privileges." >> $cmd_cache
    echo "  echo Attempting to elevate..." >> $cmd_cache
    echo "  goto UAC_Prompt" >> $cmd_cache
    echo ") else ( goto :init )" >> $cmd_cache
    echo >> $cmd_cache
    echo ":UAC_Prompt" >> $cmd_cache
    echo "set n=%0 %*" >> $cmd_cache
    echo "set n=%n:\"=\" ^& Chr(34) ^& \"%" >> $cmd_cache
    echo "echo Set objShell = CreateObject(\"Shell.Application\")>\"%tmp%\cmdUAC.vbs\"" >> $cmd_cache
    echo "echo objShell.ShellExecute \"cmd.exe\", \"/c start \" ^& Chr(34) ^& \".\" ^& Chr(34) ^& \" /d \" ^& Chr(34) ^& \"%CD%\" ^& Chr(34) ^& \" cmd /c %n%\", \"\", \"runas\", ^1>>\"%tmp%\cmdUAC.vbs\"" >> $cmd_cache
    echo "cscript \"%tmp%\cmdUAC.vbs\" //Nologo" >> $cmd_cache
    echo "del \"%tmp%\cmdUAC.vbs\"" >> $cmd_cache
    echo "goto :eof" >> $cmd_cache
    echo >> $cmd_cache
  fi

  echo ":init" >> $cmd_cache
  echo "cls & echo." >> $cmd_cache
  echo "echo Initializing. Please wait..." >> $cmd_cache
  echo "%pwsh% ^\"$useAsmForms $useNameForms $useNameDrawing Invoke-Expression ('^& {' + (Get-Content -Raw '%~f0') + '} %ARGS%')\"" >> $cmd_cache
}

bundle() {
  [[ ! -d "./cache" ]] && mkdir cache || rm -r ./cache/*;
  # using neuralpain/PwshBatch.cmd <https://gist.github.com/neuralpain/4ca8a6c9aca4f0a1af2440f474e92d05>
  echo "<# :# DO NOT REMOVE THIS LINE" > $cmd_cache
  echo >> $cmd_cache
  echo ":: $name.cmd, Version $version" >> $cmd_cache
  # add the copyright information, link to your project repository and
  # description of the script, or remove it entirely, whichever you choose
  echo ":: Copyright (c) $license_year, $license_owner" >> $cmd_cache
  echo ":: $project_url" >> $cmd_cache
  echo ":: $script_description" >> $cmd_cache
  echo >> $cmd_cache
  echo "@echo off" >> $cmd_cache
  echo "@title $script_title v$version" >> $cmd_cache
  add_pwsh
  echo >> $cmd_cache
  # -- add batch code -- #
  if [[ -f "$src/main.cmd" ]]; then 
    cat $src/main.cmd >> $cmd_cache
    echo >> $cmd_cache
  fi
  # -- end batch code -- #
  echo "# ---------- PowerShell Script ---------- #>" >> $cmd_cache

  # Loop through the powershell_functions
  for function in "${powershell_functions[@]}"; do
    # add a break between files:
    #   142: end of one file 
    echo >> $pwsh_cache # [break]
    #     1: start of next file
    cat $function >> $pwsh_cache
  done

  # final bundle
  cat $cmd_cache > $buildfile.cmd
  cat $pwsh_cache >> $buildfile.cmd
  echo "$return Bundling complete."

  # archive for stable release
  [[ $1 == "-a" || $1 == "--archive" ]] && compress
}

bundle_test() {
  build="$(date "+%y%m%d.%H%M%S")$1"
  # this one to become the file name
  buildfile="$buildfile-$version-beta-Build.$build"
  # this one for the script's head comment
  version="$version-beta [Build $build]"
  [[ ! -d "./build" ]] && mkdir build
  bundle
}

compress() {
  # add files to include in the release package
  cp ./LICENSE ./VERSION dist
  for file in "${additional_files[@]}"; do 
    cp $res/$file dist
  done

  cd dist
  # ensure that the 'zip' package should be installed
  zip -q $complete_release * || (echo -e "$return error: Failed to create archive." && return)
  # files to exclude in lightweight release
  # `*.zip` is mandatory, else it will include the normal release as well
  zip -q $lightweight_release * -x ${exclude_files[@]} *.zip || (echo -e "$return error: Failed to create archive." && return)

  # cleanup temporary files copied to /dist
  rm ./LICENSE ./VERSION
  for file in "${additional_files[@]}"; do
    rm $file
  done

  [[ -f $complete_release ]] && echo -e "$return Archived to \"/dist\""
}

printusage() {
  echo "Usage: PowerCMD [OPTION...]"
  echo -e "A bundler to integrate PowerShell with CMD\n"
  echo "  -s, --release      Build for stable release"
  echo "  -a, --archive      Archive stable release package"
  echo "  -t, --test [note]  Build unit tests"
  echo "  -C, --clear-all    Delete temporary files and folders"
  echo "  -c, --clear        Clear all unit test builds"
  echo "  -v, --version      Display version number and exit"
  echo "  -h, --help         Display this help message and exit"
  echo -e "\nFor more information, visit\033[0m"
  echo -e "\033[0;32mhttps://github.com/neuralpain/PowerCMD\033[0m"
}

printversion() {
  echo -e "Version $v"
}

case "$1" in
  -h|--help)
    printusage && exit;;
  -v|--verison)
    printversion && exit;;
  -c|--clear)
    rm -r ./build/* &>/dev/null && exit;;
  -C|--clear-all)
    rm -r ./build ./dist ./cache &>/dev/null && exit;;
  -s|--release)
    buildfile=./dist/$name-$version
    [[ ! -d "./dist" ]] && mkdir dist || rm -r ./dist/*;
    bundle $2;;
  -t|--test)
    # add a specific note in the file for the current iteration of the script test
    [[ $# -gt 1 ]] && note=$@ && note=${note/"-t "} && note=${note/"--test "} && note=${note//" "/-} && note="-$note"
    bundle_test $note;;
  *)
    if [[ $@ == "" ]]; then echo "$return Missing argument."
    else echo -e "$return Invalid option '$1'"; fi
    exit
esac
exit
