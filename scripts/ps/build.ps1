flutter build windows --release

$buildPath = "build\windows\x64\runner\Release"
$buildExe = "$buildPath\nahpu.exe"
$destinationPath = "$env:USERPROFILE\Documents\nahpu-app"
$exePath = "$env:USERPROFILE\Documents\nahpu-app\nahpu.exe"
$archivePath = "$env:USERPROFILE\Documents\Releases\"
# Check build file exists
if (Test-Path -Path $buildExe) {
    Write-Host "Build succeeded"
    # Copy relese files to user document folder
    if (Test-Path -Path $destinationPath) {
        Remove-Item -Path $destinationPath -Recurse -Force
    }
    Copy-Item -Path $buildPath -Destination $destinationPath -Recurse
    Write-Host "Release files copied to $destinationPath"
    
    Start-Process $exePath
} else {
    Write-Host "Build failed"
    exit 1
}