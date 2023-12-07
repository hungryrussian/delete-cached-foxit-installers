# hungryrussian
# 6/2023
# Recurse through rdsusersfolders and delete cached FoxIt Installers
# To test, run script as is
# To execute delete, uncomment last line

$rdsUsersFolders = Get-ChildItem -Path "S:\rdsusersfolders" -Directory
$foxitPath = "\AppData\Roaming\Foxit Software\Addon\Foxit Reader\Install"

foreach($folder in $rdsUsersFolders) {
    $userFoxitPath = "S:\rdsusersfolders\" + $folder.BaseName + $foxitPath
    $result = Test-Path $userFoxitPath
    if($result -eq $True) {
        Get-ChildItem -Path $userFoxitPath -Recurse | Remove-Item -Force -Recurse -Whatif
        $totalSize += (Get-ChildItem -Path $userFoxitPath).Length/1MB
        #Get-ChildItem -Path $userFoxitPath -Recurse | Remove-Item -Force -Recurse
    }
}
Write-Host "Total disk space used: $totalSize MB" -BackgroundColor DarkRed
