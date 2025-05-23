$remoteComputer = "<SCADA_IP>"
$process = "calc.exe"
$username = "Administrator"
$password = "YourPassword"

# wmic /node:<computer> /user:<user> /password:<pass> process call create "calc.exe"
$wmicCmd = "wmic /node:$remoteComputer /user:$username /password:$password process call create `"$process`""
Invoke-Expression $wmicCmd
