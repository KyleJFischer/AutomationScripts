@echo off
REM Quick Audio Toggle Batch Script
REM This allows you to toggle audio devices without using the hotkey
REM Useful for testing or manual toggling

echo ================================================
echo   Audio Device Toggle
echo ================================================
echo.
echo Toggling audio device...
echo.

REM Run the PowerShell script
powershell.exe -ExecutionPolicy Bypass -NoProfile -File "%~dp0AudioSwitcher.ps1"

echo.
echo ================================================
echo   Toggle Complete!
echo ================================================
echo.
echo Press any key to exit...
pause >nul
