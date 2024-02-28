flutter build windows --release

# Build path
$target = "Release"
$buildExe = "build\windows\x64\runner\Release\nahpu.exe"
$buildPath = "build\windows\x64\runner\$target"
$releasePath = "$env:USERPROFILE\Documents\"
$exePath = "$env:USERPROFILE\Documents\nahpu\nahpu.exe"
$archivePath = "$env:USERPROFILE\Documents\Releases\"
$appName = "nahpu"
# Check build file exists
if (Test-Path -Path $buildExe) {
    Write-Host "Build succeeded"
    # Copy relese files to user document folder
    
    if (Test-Path -Path $releasePath\$appName) {
        Remove-Item -Path $releasePath\$appName -Recurse -Force
    }
    Copy-Item -Path $buildPath -Destination $releasePath -Recurse

    Write-Host "Rename $deployPath to $appName"
    Rename-Item  $releasePath\$target $appName

    Write-Host "Release files copied to $releasePath"
    New-Item -ItemType Directory -Path $archivePath -Force
    Compress-Archive -Path $releasePath\$appName -DestinationPath $archivePath\$appName-windows.zip -Force
    Start-Process $exePath
} else {
    Write-Host "Build failed"
    exit 1
}