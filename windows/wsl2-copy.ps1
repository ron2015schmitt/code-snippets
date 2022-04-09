#script to backup files from WSL2 distros


$array = @("Ubuntu-20.04", "Debian")
for ($i = 0; $i -lt $array.length; $i++) {
    Write-Output ""
    
    $d = "{0:yyyy-MM-dd--HH-mm-ss}" -f (get-date)
    
    $distro = $array[$i]
    $source = ( "\\wsl.localhost\" + $distro + "\home\") 
    $newfolder = ( "WSL2-" + $distro + "--" + $d)
    $dest = ( "E:\WSL2 backups\" + $newfolder + "\")

    Write-Output "source = $source"
    Write-Output "destination = $dest"


    $exclude = @('.cache','.vscode-server', '*.o')
    Write-Output "exclude = $exclude"
    #Copy-Item -Path $source -Recurse -Destination $dest -Container
    Get-ChildItem $source -Recurse -Exclude $exclude | Copy-Item -Destination {Join-Path $dest $_.FullName.Substring($source.length)}

    Write-Output ""

}
