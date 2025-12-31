# Test Audio Devices Script
# This script helps diagnose and list all available audio devices
# Useful for troubleshooting and identifying device names

Write-Host "======================================" -ForegroundColor Cyan
Write-Host "  Audio Device Diagnostic Tool" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""

# Check if AudioDeviceCmdlets module is installed
Write-Host "Checking AudioDeviceCmdlets module..." -ForegroundColor Yellow

try {
    Import-Module AudioDeviceCmdlets -ErrorAction Stop
    Write-Host "[OK] AudioDeviceCmdlets module is installed" -ForegroundColor Green
    Write-Host ""
} catch {
    Write-Host "[ERROR] AudioDeviceCmdlets module is not installed!" -ForegroundColor Red
    Write-Host "Please install it using: Install-Module -Name AudioDeviceCmdlets -Force -Scope CurrentUser" -ForegroundColor Yellow
    Write-Host ""
    exit 1
}

# Get current playback device
Write-Host "Current Playback Device:" -ForegroundColor Yellow
Write-Host "------------------------" -ForegroundColor Yellow

try {
    $currentDevice = Get-AudioDevice -Playback
    if ($currentDevice) {
        Write-Host "  Name: $($currentDevice.Name)" -ForegroundColor Green
        Write-Host "  Index: $($currentDevice.Index)" -ForegroundColor Green
        Write-Host "  Type: $($currentDevice.Type)" -ForegroundColor Green
        Write-Host "  Default: $($currentDevice.Default)" -ForegroundColor Green
    } else {
        Write-Host "  [WARNING] No current playback device detected" -ForegroundColor Red
    }
} catch {
    Write-Host "  [ERROR] Failed to get current device: $_" -ForegroundColor Red
}

Write-Host ""

# List all audio devices
Write-Host "All Available Audio Devices:" -ForegroundColor Yellow
Write-Host "----------------------------" -ForegroundColor Yellow

try {
    $allDevices = Get-AudioDevice -List

    if ($allDevices) {
        $playbackDevices = $allDevices | Where-Object { $_.Type -eq "Playback" }
        $recordingDevices = $allDevices | Where-Object { $_.Type -eq "Recording" }

        Write-Host ""
        Write-Host "Playback Devices:" -ForegroundColor Cyan
        foreach ($device in $playbackDevices) {
            $defaultMarker = if ($device.Default) { " [CURRENT]" } else { "" }
            Write-Host "  [$($device.Index)] $($device.Name)$defaultMarker" -ForegroundColor White

            # Check for device name patterns used in AudioSwitcher.ps1
            if ($device.Name -match "Realtek") {
                Write-Host "    -> Matches 'Realtek' (Speakers)" -ForegroundColor Magenta
            }
            if ($device.Name -match "HD 4.50BTNC Stereo" -and $device.Name -notmatch "2-") {
                Write-Host "    -> Matches 'HD 4.50BTNC Stereo' (Headphones)" -ForegroundColor Magenta
            }
        }

        Write-Host ""
        Write-Host "Recording Devices:" -ForegroundColor Cyan
        foreach ($device in $recordingDevices) {
            $defaultMarker = if ($device.Default) { " [CURRENT]" } else { "" }
            Write-Host "  [$($device.Index)] $($device.Name)$defaultMarker" -ForegroundColor White
        }

        Write-Host ""
        Write-Host "Total Devices Found: $($allDevices.Count)" -ForegroundColor Green
        Write-Host "  - Playback: $($playbackDevices.Count)" -ForegroundColor Green
        Write-Host "  - Recording: $($recordingDevices.Count)" -ForegroundColor Green
    } else {
        Write-Host "  [WARNING] No audio devices found!" -ForegroundColor Red
    }
} catch {
    Write-Host "  [ERROR] Failed to list devices: $_" -ForegroundColor Red
}

Write-Host ""
Write-Host "======================================" -ForegroundColor Cyan
Write-Host "  Diagnostic Complete" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""

# Check if the expected devices exist
Write-Host "Device Configuration Check:" -ForegroundColor Yellow
Write-Host "--------------------------" -ForegroundColor Yellow

$allDevices = Get-AudioDevice -List

$speakersFound = $allDevices | Where-Object { $_.Name -match "Realtek" -and $_.Type -eq "Playback" }
$headphonesFound = $allDevices | Where-Object { $_.Name -match "HD 4.50BTNC Stereo" -and $_.Name -notmatch "2-" -and $_.Type -eq "Playback" }

if ($speakersFound) {
    Write-Host "[OK] Speakers (Realtek) found" -ForegroundColor Green
} else {
    Write-Host "[WARNING] Speakers (Realtek) NOT found - Update device pattern in AudioSwitcher.ps1" -ForegroundColor Red
}

if ($headphonesFound) {
    Write-Host "[OK] Headphones (HD 4.50BTNC Stereo) found" -ForegroundColor Green
} else {
    Write-Host "[WARNING] Headphones (HD 4.50BTNC Stereo) NOT found - Update device pattern in AudioSwitcher.ps1" -ForegroundColor Red
}

Write-Host ""
Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
