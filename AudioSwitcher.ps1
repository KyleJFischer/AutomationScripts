# Audio Device Switcher
# Toggles between headphones (HD 4.50BTNC Stereo) and speakers (Realtek)
# Requires: AudioDeviceCmdlets module (Install-Module -Name AudioDeviceCmdlets)

try {
    # Get current playback device
    $curSpeaker = Get-AudioDevice -Playback

    if ($null -eq $curSpeaker) {
        Write-Error "No active audio playback device found"
        exit 1
    }

    # Determine if currently listening through speakers
    $listeningThruSpeakers = ($curSpeaker.Name -Match "Realtek")

    # Get list of all audio devices
    $listOfDevices = Get-AudioDevice -List

    # Toggle between speakers and headphones
    if ($listeningThruSpeakers) {
        Write-Host "Switching to Headphones" -ForegroundColor Cyan

        # Find headphones (HD 4.50BTNC Stereo), excluding devices with "2-" in the name
        $newSpeaker = ($listOfDevices | Where-Object {
            $_.Name -Match "(HD 4.50BTNC Stereo)" -and
            $_.Name -notmatch "2-" -and
            $_.Type -eq "Playback"
        })[0]

        if ($null -eq $newSpeaker) {
            Write-Error "Headphones (HD 4.50BTNC Stereo) not found or not available"
            exit 1
        }
    }
    else {
        Write-Host "Switching to Speakers" -ForegroundColor Cyan

        # Find Realtek speakers
        $newSpeaker = ($listOfDevices | Where-Object {
            $_.Name -Match "Realtek" -and
            $_.Type -eq "Playback"
        })[0]

        if ($null -eq $newSpeaker) {
            Write-Error "Speakers (Realtek) not found or not available"
            exit 1
        }
    }

    # Set the new audio device
    Set-AudioDevice -Index $newSpeaker.Index

    Write-Host "Successfully switched to: $($newSpeaker.Name)" -ForegroundColor Green
    exit 0
}
catch {
    Write-Error "Error switching audio device: $_"
    exit 1
}
