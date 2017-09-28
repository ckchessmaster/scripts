#Close minecraft and the technic launcher if either are still open
# -or ($i.MainWindowTitle.ToLower() -like "*minecraft*")) -and ($i.MainWindowTitle.ToLower() -like "*server*"))
$javaProcesses = Get-Process javaw
#First we kill the minecraft process
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
#$adapters = get-wmiobject win32_networkadapter -filter "netconnectionstatus = 2"
#Foreach ($i in $adapters) {
#  $i.Disable()
#}

#Now edit the user.json file to change our name based on user input
