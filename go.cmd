@echo off
if exist "C:\Windows\Sysnative" (
  set POWERSHELL_NATIVE=C:\Windows\Sysnative\WindowsPowerShell\v1.0\powershell.exe
  set CMD_NATIVE=C:\Windows\Sysnative\cmd.exe
) else (
  set POWERSHELL_NATIVE=C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
  set CMD_NATIVE=C:\Windows\System32\cmd.exe
)
if exist "C:\Windows\SysWOW64" (
  set POWERSHELL_SYSWOW=C:\Windows\SysWOW64\WindowsPowerShell\v1.0\powershell.exe
  set CMD_SYSWOW=C:\Windows\SysWOW64\cmd.exe
) else (
  set POWERSHELL_SYSWOW=C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
  set CMD_SYSWOW=C:\Windows\System32\cmd.exe
)

@REM === Laptop setup START
pushd %~dp0
set dir=%~dp0
if exist z: net use /del z:
echo Pushing \\localhost\%dir:~0,1%$\%dir:~3,-1%
net use z: \\localhost\%dir:~0,1%$\%dir:~3,-1%

%POWERSHELL_NATIVE% -NoProfile Set-ExecutionPolicy Bypass -Force
%POWERSHELL_SYSWOW% -NoProfile Set-ExecutionPolicy Bypass -Force

@REM === Chocolatey setup START
%POWERSHELL_NATIVE% -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))"
set ChocolateyInstall=%PROGRAMDATA%\Chocolatey
set ChocolateyPath=%ChocolateyInstall%\bin
echo %PATH% | findstr "%ChocolateyPath%" >nul 2>&1
if ERRORLEVEL 1 set PATH=%PATH%;%ChocolateyPath%
@REM === Chocolatey setup END

@REM === Puppet setup START
%CMD_NATIVE% /c choco install puppet -y
set PuppetPath=C:\Program Files\Puppet Labs\Puppet\bin
echo %PATH% | findstr "%PuppetPath%" >nul 2>&1
if ERRORLEVEL 1 set PATH=%PATH%;%PuppetPath%
%CMD_NATIVE% /c puppet module install chocolatey-chocolatey
%CMD_NATIVE% /c puppet module install badgerious-windows_env
@REM === Puppet setup END

@REM === Setup packages and environment START
%CMD_NATIVE% /c puppet apply software.pp
%CMD_NATIVE% /c puppet apply env_config.pp
%POWERSHELL_NATIVE% -NoProfile -Command "&{Import-Module PsGet; Install-Module -Global PSReadline}"
%CMD_NATIVE% /c reg import "Z:\profile\KiTTY\Hostkeys.reg"
%CMD_NATIVE% /c reg import "Z:\profile\KiTTY\Sessions.reg"
@REM === Setup packages and environment END

@REM === Set pinned taskbar items START
%CMD_NATIVE% /c del /q "%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\*"
%CMD_NATIVE% /c reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband /va /f
%CMD_NATIVE% /c copy /y "Z:\profile\Taskbar\*.lnk" "%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\"
%CMD_NATIVE% /c reg import "Z:\profile\Taskbar\Taskbar.reg"
@REM === Set pinned taskbar items END

net use z: /del
popd
@REM === Laptop setup END
