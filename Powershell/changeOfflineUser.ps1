#First we kill the minecraft process
$javaProcesses = Get-Process javaw
Foreach ($i in $javaProcesses) {
  if (($i.MainWindowTitle.ToLower() -like "*minecraft*") -and (-Not ($i.MainWindowTitle.ToLower() -like "*server*"))) {
    Stop-Process $i.Id
  }
}

#Give the technic launcher time to appear
Start-Sleep -m 1500

#Now kill the technic launcher
$javaProcesses = Get-Process javaw
Foreach ($i in $javaProcesses) {
  if (($i.MainWindowTitle.ToLower() -like "*technic*") -and (-Not ($i.MainWindowTitle.ToLower() -like "*server*"))) {
    Stop-Process $i.Id
  }
}

#Loop through the network adapters and disable them (also store them so we can renable them later)
$adapters = get-wmiobject win32_networkadapter -filter "netconnectionstatus = 2"
Foreach ($i in $adapters) {
  $i.Disable()
}

#Get the username
[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic') | Out-Null
$username = [Microsoft.VisualBasic.Interaction]::InputBox("Enter a username", "Username", "$env:computername")

#Now edit the user.json file to change our name based on user input
$path = $env:APPDATA + "\.technic\users.json"
(Get-Content $path) -replace '"displayName":.*', ('"displayName": "' + $username + '",') | Set-Content $path
(Get-Content $path) -replace '"name":.*', ('"name": "' + $username + '",') | Set-Content $path

#Start Technic launcher
$path = $env:APPDATA + "\.technic\temp.exe"
Start-Process $path

#Renable network adapters
Foreach ($i in $adapters) {
  $i.Enable()
}
