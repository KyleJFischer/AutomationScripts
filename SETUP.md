# Audio Switcher - Quick Setup Guide

This guide will help you set up the audio device switcher with keyboard hotkey support.

## Quick Start (5 minutes)

### Step 1: Install PowerShell Module
```powershell
# Open PowerShell as Administrator
Install-Module -Name AudioDeviceCmdlets -Scope CurrentUser
```

### Step 2: Install AutoHotkey
1. Download AutoHotkey v2.0 from [autohotkey.com](https://www.autohotkey.com/)
2. Run the installer (accept default settings)

### Step 3: Test PowerShell Script
```powershell
# Navigate to the AutomationScripts folder
cd path\to\AutomationScripts

# Run the script manually to test
.\AudioSwitcher.ps1
```

Your audio device should switch! If not, see Troubleshooting below.

### Step 4: Enable Hotkey
1. Double-click `AudioSwitcher.ahk`
2. You'll see a notification: "Audio Switcher Active"
3. Press `Ctrl+Shift+Alt+;` to toggle audio devices

### Step 5: Add to Startup (Optional)
1. Press `Win+R`
2. Type `shell:startup` and press Enter
3. Right-click in the folder → New → Shortcut
4. Browse to `AudioSwitcher.ahk` and create the shortcut

Done! Your hotkey will now work every time Windows starts.

## Alternative Methods

### Method 1: Using Batch File
- Double-click `AudioSwitcher.bat` to manually switch devices
- Useful for testing or if you prefer a different hotkey tool

### Method 2: Using Windows Keyboard Shortcuts
1. Right-click `AudioSwitcher.bat`
2. Create Shortcut
3. Right-click the shortcut → Properties
4. Click in "Shortcut key" field
5. Press your desired hotkey combination
6. Click OK

## File Overview

| File | Purpose |
|------|---------|
| `AudioSwitcher.ps1` | Core script that switches audio devices |
| `AudioSwitcher.ahk` | AutoHotkey script for MEHKey+; hotkey |
| `AudioSwitcher.bat` | Batch launcher for manual/alternative use |
| `README.md` | Detailed documentation |
| `SETUP.md` | This quick setup guide |

## Troubleshooting

### "Get-AudioDevice: The term 'Get-AudioDevice' is not recognized"
**Solution:** Install AudioDeviceCmdlets module
```powershell
Install-Module -Name AudioDeviceCmdlets -Scope CurrentUser
```

### "Execution policy" error
**Solution:** Allow script execution
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Audio device not found
**Solution:** Check your device names
```powershell
Get-AudioDevice -List | Format-Table Name, Type, Default
```
Then edit `AudioSwitcher.ps1` and update the device name patterns.

### Hotkey doesn't work
**Checklist:**
- [ ] AutoHotkey v2.0 is installed (not v1.x)
- [ ] `AudioSwitcher.ahk` is running (check system tray)
- [ ] No other application is using `Ctrl+Shift+Alt+;`
- [ ] PowerShell script works when run manually

### Script runs but audio doesn't switch
**Checklist:**
- [ ] Both audio devices are connected and enabled
- [ ] Device names match those in `AudioSwitcher.ps1`
- [ ] Devices are configured as Playback devices (not Recording)

## Customization

### Change Hotkey
Edit `AudioSwitcher.ahk`, line 19:
```ahk
^+!;::    ; Change this line
```

Examples:
- `^+!a::` → Ctrl+Shift+Alt+A
- `^!s::` → Ctrl+Alt+S
- `#s::` → Win+S

### Change Audio Devices
Edit `AudioSwitcher.ps1` and modify the device matching patterns:
- Line 15: Current device detection pattern
- Lines 25-29: Headphones pattern
- Lines 40-43: Speakers pattern

## Support

For more detailed information, see `README.md`.

For AutoHotkey documentation, visit [autohotkey.com/docs](https://www.autohotkey.com/docs/v2/)

For AudioDeviceCmdlets help:
```powershell
Get-Help Get-AudioDevice -Full
Get-Help Set-AudioDevice -Full
```
