; Audio Device Toggle Hotkey Script
; Hotkey: MEHKey+; (Ctrl+Shift+Alt+;)
; Description: Toggles between headphones and speakers

#NoEnv
#SingleInstance Force
SetWorkingDir %A_ScriptDir%

; MEHKey+; hotkey binding
^+!SC027::  ; Ctrl+Shift+Alt+; (semicolon scancode is SC027)
{
    ; Get the directory where this script is located
    ScriptDir := A_ScriptDir

    ; Path to the PowerShell script
    PSScriptPath := ScriptDir . "\AudioSwitcher.ps1"

    ; Show tooltip notification
    ToolTip, Toggling audio device...
    SetTimer, RemoveToolTip, 2000

    ; Execute PowerShell script
    ; -ExecutionPolicy Bypass allows script execution without policy restrictions
    ; -NoProfile speeds up execution by not loading profile
    ; -WindowStyle Hidden runs the PowerShell window hidden
    RunWait, powershell.exe -ExecutionPolicy Bypass -NoProfile -WindowStyle Hidden -File "%PSScriptPath%", %ScriptDir%, Hide

    return
}

RemoveToolTip:
    SetTimer, RemoveToolTip, Off
    ToolTip
    return

; Exit hotkey (Ctrl+Shift+Alt+Esc) - for testing purposes
^+!Esc::
{
    MsgBox, 4, Audio Toggle Hotkey, Are you sure you want to exit the Audio Toggle Hotkey script?
    IfMsgBox Yes
        ExitApp
    return
}
