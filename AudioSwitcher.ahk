; Audio Device Switcher - AutoHotkey Script
; Toggles between headphones and speakers using MEHKey+; (Ctrl+Shift+Alt+;)
;
; Requirements:
; - AutoHotkey v2.0 or later installed
; - AudioDeviceCmdlets PowerShell module installed
; - AudioSwitcher.ps1 in the same directory
;
; Installation:
; 1. Install AutoHotkey from https://www.autohotkey.com/
; 2. Install AudioDeviceCmdlets: Install-Module -Name AudioDeviceCmdlets
; 3. Run this script or add it to Windows startup

#Requires AutoHotkey v2.0

; MEHKey+; (Ctrl+Shift+Alt+;) to toggle audio device
^+!;::
{
    ; Get the directory where this script is located
    ScriptDir := A_ScriptDir

    ; Path to the PowerShell script
    PSScriptPath := ScriptDir . "\AudioSwitcher.ps1"

    ; Check if the PowerShell script exists
    if !FileExist(PSScriptPath)
    {
        MsgBox("Error: AudioSwitcher.ps1 not found at:`n" . PSScriptPath, "Audio Switcher Error", "Icon!")
        return
    }

    ; Show a tooltip notification
    ToolTip("Switching audio device...")

    ; Execute the PowerShell script
    ; Using -ExecutionPolicy Bypass to avoid execution policy issues
    ; Using -WindowStyle Hidden to run without showing a window
    try
    {
        RunWait('powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -NoProfile -File "' . PSScriptPath . '"', , "Hide")

        ; Show success notification
        ToolTip("Audio device switched!")
        SetTimer(() => ToolTip(), -2000)  ; Hide tooltip after 2 seconds
    }
    catch as err
    {
        ; Show error message if something goes wrong
        MsgBox("Error executing PowerShell script:`n" . err.Message, "Audio Switcher Error", "Icon!")
        ToolTip()  ; Clear tooltip
    }
}

; Optional: Display a tray tip when the script starts
TrayTip("Audio Switcher Active", "Press Ctrl+Shift+Alt+; to toggle audio devices", "Iconi Mute")
SetTimer(() => TrayTip(), -5000)  ; Hide tray tip after 5 seconds
