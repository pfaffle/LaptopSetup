@echo off
@REM === Laptop setup START
pushd %~dp0

powershell Set-ExecutionPolicy Bypass -Force

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
@REM === Setup packages and environment END

popd
@REM === Laptop setup END