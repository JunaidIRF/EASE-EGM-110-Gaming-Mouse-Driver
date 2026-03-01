@echo off
:: Auto-elevate to admin
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)
setlocal enabledelayedexpansion
title Rapid Fire Configurator
echo.
echo   ========================================
echo     Rapid Fire Button Configurator
echo   ========================================
echo.
echo   Select which button to set as Rapid Fire:
echo.
echo     [1] Button 1
echo     [2] Button 2
echo     [3] Button 3
echo     [4] Button 4
echo     [5] Button 5
echo     [6] Button 6
echo     [7] Button 7
echo     [8] Button 8
echo.
echo     [0] Cancel
echo.
choice /c 012345678 /n /m "  Press a number: "
set /a btn=%errorlevel%-1
if !btn!==0 (
    echo   Cancelled.
    goto :end
)

set /a kidx=!btn!-1
set "cfg=%~dp0skins\config\config.ini"

if not exist "!cfg!" (
    echo.
    echo   ERROR: config.ini not found at:
    echo   !cfg!
    goto :end
)

echo.
echo   Setting Button !btn! to Rapid Fire...

powershell -NoProfile -Command "$f=$env:cfg;$k='K!kidx!';$l=Get-Content $f;for($i=0;$i -lt $l.Count;$i++){if($l[$i] -match ('^'+$k+'=\d')){$l[$i]=$k+'=14'}};$l|Set-Content $f"

echo.
echo   Done! Button !btn! is now set to Rapid Fire in all profiles.
echo   Restart the mouse software to apply changes.

:end
echo.
pause
endlocal
