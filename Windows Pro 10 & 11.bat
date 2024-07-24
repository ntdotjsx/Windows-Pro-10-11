@setlocal DisableDelayedExpansion
@set ntver=0.1
@echo off

set "PATH=%SystemRoot%\System32;%SystemRoot%\System32\wbem;%SystemRoot%\System32\WindowsPowerShell\v1.0\"
if exist "%SystemRoot%\Sysnative\reg.exe" (
set "PATH=%SystemRoot%\Sysnative;%SystemRoot%\Sysnative\wbem;%SystemRoot%\Sysnative\WindowsPowerShell\v1.0\;%PATH%"
)

set "_cmdf=%~f0"
for %%# in (%*) do (
if /i "%%#"=="r1" set r1=1
if /i "%%#"=="r2" set r2=1
if /i "%%#"=="-qedit" (
reg add HKCU\Console /v QuickEdit /t REG_DWORD /d "1" /f 1>nul
)
)

if exist %SystemRoot%\Sysnative\cmd.exe if not defined r1 (
setlocal EnableDelayedExpansion
start %SystemRoot%\Sysnative\cmd.exe /c ""!_cmdf!" %* r1"
exit /b
)

if exist %SystemRoot%\SysArm32\cmd.exe if %PROCESSOR_ARCHITECTURE%==AMD64 if not defined r2 (
setlocal EnableDelayedExpansion
start %SystemRoot%\SysArm32\cmd.exe /c ""!_cmdf!" %* r2"
exit /b
)

title  Windows_Home_to_Pro_Scripts %ntver%

:MainMenu

cls
color 07
title  Windows %blank%Home %blank%to %blank%Pro %blank%Scripts%ntver%
mode 76, 30

echo:
echo:                Windows Proooooooo Scripts
echo:                __________________________
echo:
echo:                     [1] Windows11
echo:                     [2] Windows10
echo:
echo:                   [Ctrl + C to Exit]
echo:                __________________________
echo:
echo:       script by Nutto.jsx https://github.com/ntdotjsx
echo:
echo:
choice /C:120 /N /M "Choose an option: "
set _erl=%errorlevel%

if %_erl%==1 setlocal & call :Confirm Win11    & cls & endlocal & goto :MainMenu
if %_erl%==2 setlocal & call :Confirm Win10   & cls & endlocal & goto :MainMenu
goto :MainMenu

:Confirm
cls
echo:
echo:       You have chosen %1.
echo:       Are you sure you want to continue? (Y/N)
echo:
echo:
choice /C YN /N /M "Choose an option: "
set _confirm=%errorlevel%

if %_confirm%==2 goto :MainMenu
if %1==Win11 goto :Win11
if %1==Win10 goto :Win10

:Win11
@setlocal DisableDelayedExpansion
@echo off

slmgr/upk
slmgr/cpky
sc config LicenseManager start=auto & net start LicenseManager
sc config wuauserv start=auto & net start wuauserv
changepk.exe/productkey VK7JG-NPHTM-C97JM-9MPGT-3V66T

goto :MainMenu

:Win10
@setlocal DisableDelayedExpansion
@echo off

dism /Online /Get-TargetEditions
sc config LicenseManager start= auto & net start LicenseManager
sc config wuauserv start= auto & net start wuauserv
changepk.exe /productkey VK7JG-NPHTM-C97JM-9MPGT-3V66T

echo 10
goto :MainMenu

@REM Script by เด็กฝึกงาน