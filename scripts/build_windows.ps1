# Description: Build Windows release and copy to portable program folder
Write-Output "Building Windows release"
flutter build windows --release
Write-Output "Copying to portable program folder"
Copy-Item -Recurse -Force -Path '.\build\windows\runner\Release\' -Destination 'C:\Users\hhandika\Documents\PortableProgram\nahpu'
Start-Process 'C:\Users\hhandika\Documents\PortableProgram\nahpu\nahpu.exe'
