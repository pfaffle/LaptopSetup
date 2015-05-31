@echo off
set POWERSHELL64=C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
set POWERSHELL32=C:\Windows\SYSWOW64\WindowsPowerShell\v1.0\powershell.exe
@REM === Laptop setup START
pushd %~dp0
set dir=%~dp0
if exist z: net use /del z:
net use z: \\localhost\%dir:~0,1%$\%dir:~3,-1%

%POWERSHELL64% -NoProfile Set-ExecutionPolicy Bypass -Force
%POWERSHELL32% -NoProfile Set-ExecutionPolicy Bypass -Force

@REM === Chocolatey setup START
@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))"
set ChocolateyInstall=%PROGRAMDATA%\Chocolatey
set ChocolateyPath=%ChocolateyInstall%\bin
echo %PATH% | findstr "%ChocolateyPath%" >nul 2>&1
if ERRORLEVEL 1 set PATH=%PATH%;%ChocolateyPath%
@REM === Chocolatey setup END

@REM === Puppet setup START
choco install puppet -y
set PuppetPath=%PROGRAMFILES%\Puppet Labs\Puppet\bin
echo %PATH% | findstr "%PuppetPath%" >nul 2>&1
if ERRORLEVEL 1 set PATH=%PATH%;%PuppetPath%
cmd /c puppet module install chocolatey-chocolatey
cmd /c puppet module install badgerious-windows_env
@REM === Puppet setup END

@REM === Setup packages and environment START
cmd /c puppet apply software.pp
cmd /c puppet apply env_config.pp
@powershell -NoProfile -Command "&{Import-Module PsGet; Install-Module -Global PSReadline}"
@REM === Setup packages and environment END

@REM === Set pinned taskbar items START
del /q "%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\*"
reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband /va /f
@REM this launches explorer as an administrator which makes all child processes run as admin as well
@REM taskkill /im explorer.exe /f
@REM start explorer.exe
cscript pinitem.vbs /item:"%PROGRAMFILES(x86)%\Google\Chrome\Application\chrome.exe" /taskbar
cscript pinitem.vbs /item:"%PROGRAMFILES(x86)%\Mozilla Firefox\firefox.exe" /taskbar
cscript pinitem.vbs /item:"%PROGRAMFILES%\ConEmu\ConEmu64.exe" /taskbar
cscript pinitem.vbs /item:"%PROGRAMFILES(x86)%\Mozilla Thunderbird\thunderbird.exe" /taskbar
@REM === Set pinned taskbar items END

net use z: /del
popd
@REM === Laptop setup END
