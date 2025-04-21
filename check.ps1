# Set the path to the file to monitor
$fileToMonitor = "C:\acpp\practice\donut\x64\Debug\donut.exe"

# Get the last write time of the file
$lastWriteTime = (Get-Item $fileToMonitor).LastWriteTime

# Monitor the file for changes in an infinite loop
while ($true) {
    Start-Sleep -Seconds 1  # Wait for a second before checking again
    $currentWriteTime = (Get-Item $fileToMonitor).LastWriteTime

    # If the last write time has changed, execute the donut.exe
    if ($currentWriteTime -ne $lastWriteTime) {
        Write-Host "File changed. Executing donut.exe..."
        & $fileToMonitor  # Run donut.exe directly to show output in the console
        $lastWriteTime = $currentWriteTime  # Update the last write time
    }
}
