flutter build windows --release

# Build path
$buildExe = "build\windows\runner\Release\nahpu.exe"
$buildPath = "build\windows\runner\Release"
$releasePath = "$env:USERPROFILE\Documents\nahpu"
$exePath = "$env:USERPROFILE\Documents\nahpu\Release\nahpu.exe"
# Check build file exists
if (Test-Path -Path $buildExe) {
    Write-Host "Build succeeded"
    # Copy relese files to user document folder
    
    if (Test-Path -Path $releasePath) {
        Remove-Item -Path $releasePath -Recurse -Force
    }
    New-Item -Path $releasePath -ItemType Directory
    Copy-Item -Path $buildPath -Destination $releasePath -Recurse
    Write-Host "Release files copied to $releasePath"
    Start $exePath
} else {
    Write-Host "Build failed"
    exit 1
}