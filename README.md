# AutomationScripts

Bunch of scripts to help automate my life!

## Audio Switcher

Toggle between headphones (HD 4.50BTNC Stereo) and speakers (Realtek) using a keyboard hotkey.

### Features
- **Hotkey**: `Ctrl+Shift+Alt+;` (MEHKey+;)
- **Smart Detection**: Automatically detects current audio device and switches to the other
- **Device Filtering**: Excludes secondary headphones (devices with "2-" in name) to default to main pair
- **Visual Feedback**: Shows tooltips and tray notifications when switching

### Files
- `AudioSwitcher.ps1` - PowerShell script that performs the audio device switching
- `AudioSwitcher.ahk` - AutoHotkey script that binds the hotkey to execute the PowerShell script

### Prerequisites

1. **Windows Operating System**
2. **PowerShell 5.1 or later** (included with Windows 10/11)
3. **AudioDeviceCmdlets Module**
   ```powershell
   Install-Module -Name AudioDeviceCmdlets -Scope CurrentUser
   ```
4. **AutoHotkey v2.0** - Download from [autohotkey.com](https://www.autohotkey.com/)

### Installation

1. **Install AudioDeviceCmdlets Module**:
   ```powershell
   # Run PowerShell as Administrator
   Install-Module -Name AudioDeviceCmdlets -Scope CurrentUser
   ```

2. **Test the PowerShell Script**:
   ```powershell
   # Navigate to the script directory
   cd path\to\AutomationScripts

   # Run the script to verify it works
   .\AudioSwitcher.ps1
   ```

3. **Install AutoHotkey v2.0**:
   - Download from [https://www.autohotkey.com/](https://www.autohotkey.com/)
   - Run the installer and follow the prompts

4. **Run the AutoHotkey Script**:
   - Double-click `AudioSwitcher.ahk` to start the hotkey listener
   - You should see a notification that "Audio Switcher Active"

5. **Add to Startup (Optional)**:
   - Press `Win+R`, type `shell:startup`, and press Enter
   - Create a shortcut to `AudioSwitcher.ahk` in this folder
   - The script will now run automatically when Windows starts

### Usage

1. Press `Ctrl+Shift+Alt+;` to toggle between speakers and headphones
2. A tooltip will appear showing "Switching audio device..."
3. The audio device will switch, and a success notification will appear

### Troubleshooting

**Script doesn't switch audio devices:**
- Verify AudioDeviceCmdlets is installed: `Get-Module -ListAvailable AudioDeviceCmdlets`
- Check that your audio devices are named correctly:
  ```powershell
  Get-AudioDevice -List | Format-Table Name, Type, Default
  ```
- Update device names in `AudioSwitcher.ps1` if your devices have different names

**Hotkey doesn't work:**
- Ensure AutoHotkey v2.0 is installed (not v1.x)
- Check if another application is using the same hotkey combination
- Verify `AudioSwitcher.ahk` is running (check system tray)

**Permission errors:**
- Run PowerShell as Administrator when installing AudioDeviceCmdlets
- Set execution policy if needed: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`

### Customization

**Change the hotkey:**
Edit `AudioSwitcher.ahk` and modify the hotkey line:
```ahk
^+!;::    ; Current: Ctrl+Shift+Alt+;
```

Common modifiers:
- `^` = Ctrl
- `+` = Shift
- `!` = Alt
- `#` = Win

**Change audio device names:**
Edit `AudioSwitcher.ps1` and update the device name patterns in the `Where-Object` filters to match your specific audio devices.
