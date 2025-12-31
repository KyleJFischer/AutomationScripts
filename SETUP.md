# Audio Device Toggle - Setup Guide

This guide will help you set up the audio device toggle hotkey on your Windows system.

## Prerequisites

1. **Windows Operating System** (Windows 7 or later)
2. **AutoHotkey** - For hotkey binding
3. **AudioDeviceCmdlets PowerShell Module** - For audio device control
4. **PowerShell 5.1 or later** (comes with Windows 10/11)

## Installation Steps

### Step 1: Install AutoHotkey

1. Download AutoHotkey from the official website:
   - Visit: https://www.autohotkey.com/
   - Download the latest version (AutoHotkey v1.1 recommended)
   - Run the installer and follow the installation wizard

2. Verify installation:
   - Open Command Prompt
   - Type: `autohotkey --version` (if available in PATH)
   - Or check if AutoHotkey is installed in `C:\Program Files\AutoHotkey\`

### Step 2: Install AudioDeviceCmdlets PowerShell Module

1. Open PowerShell as Administrator:
   - Press `Win + X`
   - Select "Windows PowerShell (Admin)" or "Terminal (Admin)"

2. Install the AudioDeviceCmdlets module:
   ```powershell
   Install-Module -Name AudioDeviceCmdlets -Force -Scope CurrentUser
   ```

3. If prompted about untrusted repository, type `Y` and press Enter

4. Verify installation:
   ```powershell
   Get-Module -ListAvailable AudioDeviceCmdlets
   ```

### Step 3: Configure Audio Device Names

1. List your audio devices to get the exact names:
   ```powershell
   Import-Module AudioDeviceCmdlets
   Get-AudioDevice -List
   ```

2. Identify your devices:
   - Look for your **Speakers** (e.g., "Realtek")
   - Look for your **Headphones** (e.g., "HD 4.50BTNC Stereo")

3. If your device names differ from the defaults, edit `AudioSwitcher.ps1`:
   - Open the file in a text editor
   - Update the device name patterns:
     ```powershell
     # Line 17: Change "Realtek" to your speaker name
     $listeningThruSpeakers = ($curSpeaker.Name -Match "YourSpeakerName")

     # Line 34: Change the headphone name pattern
     $_.Name -Match "(YourHeadphoneName)"

     # Line 48: Change the speaker name pattern
     $_.Name -Match "YourSpeakerName"
     ```

### Step 4: Run the Hotkey Script

#### Option A: Run Manually (for testing)

1. Navigate to the AutomationScripts folder
2. Double-click `AudioToggleHotkey.ahk`
3. The script will start running (you'll see an AutoHotkey icon in the system tray)

#### Option B: Run at Windows Startup (recommended)

1. Press `Win + R` to open the Run dialog
2. Type: `shell:startup` and press Enter
3. This opens the Startup folder
4. Create a shortcut to `AudioToggleHotkey.ahk` in this folder:
   - Right-click in the Startup folder
   - Select "New" → "Shortcut"
   - Browse to `AudioToggleHotkey.ahk`
   - Click "Next" and "Finish"

## Usage

### Hotkey

- **MEHKey + ;** (Ctrl + Shift + Alt + Semicolon)
  - Press all four keys simultaneously to toggle audio devices
  - A tooltip will appear briefly showing "Toggling audio device..."

### Exit the Script

- **MEHKey + Esc** (Ctrl + Shift + Alt + Escape)
  - This will prompt you to exit the hotkey script
  - Useful for stopping the script without accessing the system tray

## Troubleshooting

### Issue: Hotkey doesn't work

**Solution:**
- Check if AutoHotkey script is running (look for icon in system tray)
- Try restarting the script
- Verify no other application is using the same hotkey

### Issue: Audio doesn't switch

**Solution:**
- Run `AudioSwitcher.ps1` manually in PowerShell to see error messages
- Verify AudioDeviceCmdlets module is installed: `Get-Module -ListAvailable AudioDeviceCmdlets`
- Check device names match your actual devices using `Get-AudioDevice -List`

### Issue: PowerShell execution policy error

**Solution:**
- Open PowerShell as Administrator
- Run: `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser`
- Confirm with `Y`

### Issue: Access denied or permission errors

**Solution:**
- Run PowerShell as Administrator
- Ensure AudioDeviceCmdlets is installed for the current user

### Issue: Devices not found

**Solution:**
- List all audio devices: `Get-AudioDevice -List`
- Update device name patterns in `AudioSwitcher.ps1`
- Ensure devices are properly connected and recognized by Windows

## Advanced Configuration

### Changing the Hotkey

To change the hotkey combination, edit `AudioToggleHotkey.ahk`:

1. Open the file in a text editor
2. Find the line: `^+!SC027::`
3. Replace with your desired combination:
   - `^` = Ctrl
   - `+` = Shift
   - `!` = Alt
   - `#` = Win key
   - For letters: Just use the letter (e.g., `p` for P key)
   - For special keys: Use scan codes or key names

Examples:
- `^+!p::` = Ctrl+Shift+Alt+P
- `^!a::` = Ctrl+Alt+A
- `#a::` = Win+A

### Adding Notification Sound

To add audio feedback when switching, add this to the PowerShell script:
```powershell
[console]::beep(800, 200)  # Frequency 800Hz, Duration 200ms
```

### Logging

To enable logging, modify the PowerShell script to write to a log file:
```powershell
$logFile = "$PSScriptRoot\AudioToggle.log"
Add-Content -Path $logFile -Value "$(Get-Date): Switched to $($newSpeaker.Name)"
```

## File Structure

```
AutomationScripts/
├── AudioSwitcher.ps1          # PowerShell script that performs the audio switch
├── AudioToggleHotkey.ahk      # AutoHotkey script that listens for the hotkey
├── README.md                  # Project overview
├── SETUP.md                   # This setup guide
└── TestAudioDevices.ps1       # Utility script to list audio devices
```

## Support

For issues or questions:
1. Check Windows Sound Settings to verify devices are recognized
2. Run `TestAudioDevices.ps1` to diagnose device detection
3. Review PowerShell error messages when running manually
4. Check AutoHotkey documentation: https://www.autohotkey.com/docs/

## License

This project is provided as-is for personal use.
