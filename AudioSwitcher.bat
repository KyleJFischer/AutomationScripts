@echo off
REM Audio Device Switcher - Batch File Launcher
REM This batch file can be used as an alternative to the AutoHotkey script
REM Useful for manual execution or custom keyboard shortcut tools

REM Get the directory where this batch file is located
set "SCRIPT_DIR=%~dp0"

REM Path to the PowerShell script
set "PS_SCRIPT=%SCRIPT_DIR%AudioSwitcher.ps1"

REM Check if the PowerShell script exists
if not exist "%PS_SCRIPT%" (
    echo Error: AudioSwitcher.ps1 not found at: %PS_SCRIPT%
    pause
    exit /b 1
)

REM Execute the PowerShell script
echo Switching audio device...
powershell.exe -ExecutionPolicy Bypass -NoProfile -File "%PS_SCRIPT%"

REM Check if the script executed successfully
if %ERRORLEVEL% EQU 0 (
    echo Audio device switched successfully!
) else (
    echo Error: Failed to switch audio device. Error code: %ERRORLEVEL%
    pause
)

exit /b %ERRORLEVEL%
