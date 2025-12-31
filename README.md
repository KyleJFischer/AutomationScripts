# AutomationScripts

Bunch of scripts to help automate my life!

## Audio Device Toggle

A Windows automation script that allows you to quickly toggle between your headphones and speakers using a hotkey.

### Features

- **Hotkey-based toggle**: MEHKey+; (Ctrl+Shift+Alt+;)
- **Seamless switching**: Instantly switch between audio devices
- **Visual feedback**: Tooltip notification when switching
- **Error handling**: Robust error checking and informative messages
- **Automatic startup**: Can be configured to run at Windows startup

### Quick Start

1. **Install Prerequisites**:
   - AutoHotkey: https://www.autohotkey.com/
   - AudioDeviceCmdlets PowerShell module

2. **Run the hotkey script**:
   - Double-click `AudioToggleHotkey.ahk`

3. **Toggle audio devices**:
   - Press Ctrl+Shift+Alt+; (semicolon)

### Files

- **AudioSwitcher.ps1** - PowerShell script that performs the audio device switch
- **AudioToggleHotkey.ahk** - AutoHotkey script that binds the hotkey and triggers the PowerShell script
- **TestAudioDevices.ps1** - Diagnostic utility to list and verify audio devices
- **SETUP.md** - Detailed installation and configuration guide

### Audio Devices

- **Speakers**: Realtek audio device
- **Headphones**: HD 4.50BTNC Stereo (excludes 2- prefix devices for secondary headphone pairs)

### Documentation

For detailed setup instructions, troubleshooting, and configuration options, see [SETUP.md](SETUP.md)

### Requirements

- Windows 7 or later
- PowerShell 5.1 or later
- AutoHotkey v1.1+
- AudioDeviceCmdlets PowerShell module
