$curSpeaker = Get-AudioDevice -Playback

$listeningThruSpeakers = ($curSpeaker.Name -Match "Realtek")
$listOfDevices = (Get-AudioDevice -List)

if ($listeningThruSpeakers)
{
    echo "Switching to Headphones"
    $newSpeaker = ($listOfDevices | Where-Object { $_.Name -Match "(HD 4.50BTNC Stereo)" -and $_.Name -notmatch "2-" })[0]

} else {
    echo "Switching to Speakers"
    $newSpeaker = ($listOfDevices | Where-Object { $_.Name -Match "Realtek" })[0]
}


Set-AudioDevice -Index $newSpeaker.Index
