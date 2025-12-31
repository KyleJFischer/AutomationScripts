# Quick Start Guide - Audio Device Toggle

Get up and running in 5 minutes!

## Step 1: Install AutoHotkey (2 minutes)

1. Go to https://www.autohotkey.com/
2. Download and install AutoHotkey v1.1
3. Follow the installer prompts (use default settings)

## Step 2: Install AudioDeviceCmdlets (2 minutes)

1. Open PowerShell as Administrator:
   - Press `Win + X`
   - Select "Windows PowerShell (Admin)"

2. Run this command:
   ```powershell
   Install-Module -Name AudioDeviceCmdlets -Force -Scope CurrentUser
   ```

3. Type `Y` if prompted about untrusted repository

## Step 3: Start the Hotkey Script (30 seconds)

1. Navigate to the AutomationScripts folder
2. Double-click `AudioToggleHotkey.ahk`
3. Look for the AutoHotkey icon in your system tray (✓ means it's running)

## Step 4: Test It! (30 seconds)

Press: **Ctrl + Shift + Alt + ;** (semicolon)

You should see a tooltip and hear your audio switch devices!

---

## Troubleshooting

### Not working?

1. **Run the test script**:
   - Right-click `TestAudioDevices.ps1`
   - Select "Run with PowerShell"
   - Check if your devices are detected

2. **Check device names**:
   - If your devices have different names, edit `AudioSwitcher.ps1`
   - Update the device name patterns (search for "Realtek" and "HD 4.50BTNC Stereo")

3. **PowerShell execution error**:
   ```powershell
   Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

---

## Optional: Auto-start on Windows Boot

1. Press `Win + R`
2. Type: `shell:startup`
3. Create a shortcut to `AudioToggleHotkey.ahk` in that folder

---

## Hotkeys

- **Ctrl + Shift + Alt + ;** - Toggle audio device
- **Ctrl + Shift + Alt + Esc** - Exit the hotkey script

---

For more details, see [SETUP.md](SETUP.md)
