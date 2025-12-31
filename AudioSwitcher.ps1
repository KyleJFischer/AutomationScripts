# Audio Device Switcher Script
# Toggles between Speakers (Realtek) and Headphones (HD 4.50BTNC Stereo)

# Error handling
$ErrorActionPreference = "Stop"

try {
    # Get current playback device
    $curSpeaker = Get-AudioDevice -Playback

    if (-not $curSpeaker) {
        Write-Error "Unable to get current audio device"
        exit 1
    }

    # Determine if currently using speakers
    $listeningThruSpeakers = ($curSpeaker.Name -Match "Realtek")

    # Get list of all audio devices
    $listOfDevices = (Get-AudioDevice -List)

    if (-not $listOfDevices) {
        Write-Error "Unable to retrieve audio device list"
        exit 1
    }

    # Toggle between devices
    if ($listeningThruSpeakers) {
        Write-Host "Current: Speakers (Realtek)"
        Write-Host "Switching to Headphones..."

        # Find headphones (excluding 2- prefix devices)
        $newSpeaker = ($listOfDevices | Where-Object {
            $_.Name -Match "(HD 4.50BTNC Stereo)" -and
            $_.Name -notmatch "2-"
        })[0]

        if (-not $newSpeaker) {
            Write-Error "Headphones not found. Please check device name pattern."
            exit 1
        }
    } else {
        Write-Host "Current: Headphones"
        Write-Host "Switching to Speakers..."

        # Find speakers
        $newSpeaker = ($listOfDevices | Where-Object {
            $_.Name -Match "Realtek"
        })[0]

        if (-not $newSpeaker) {
            Write-Error "Speakers not found. Please check device name pattern."
            exit 1
        }
    }

    # Set the new audio device
    Set-AudioDevice -Index $newSpeaker.Index

    Write-Host "Successfully switched to: $($newSpeaker.Name)"
    Write-Host "Audio device toggle completed successfully!"

    exit 0

} catch {
    Write-Error "Error switching audio device: $_"
    Write-Host "Error Details: $($_.Exception.Message)"
    exit 1
}
