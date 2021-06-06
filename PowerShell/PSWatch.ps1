$folder = "."
$filter = "*.txt"
$script = "echobot.cmd"

$getlock = $true
$logging = $false
$recurse = $false

$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $folder
$watcher.Filter = $filter
$watcher.IncludeSubdirectories = $recurse
$watcher.EnableRaisingEvents = $true

function IsLocked($file) {

    try { [IO.File]::OpenWrite($file).Close(); $false } catch { $true }
}

$action = {

    $name = $Event.SourceEventArgs.Name
    $path = $Event.SourceEventArgs.FullPath
    $type = $Event.SourceEventArgs.ChangeType

    if ($logging) { Add-Content "$folder\PSWatch.log" -Value "$(Get-Date), $type, $name" }

    if ($getlock) { while ( IsLocked($path) ) { sleep 1 } }

    iex "start ""$script"" ""$path"""
}

  Register-ObjectEvent $watcher "Created" -Action $action
# Register-ObjectEvent $watcher "Changed" -Action $action
# Register-ObjectEvent $watcher "Deleted" -Action $action
# Register-ObjectEvent $watcher "Renamed" -Action $action

if ($logging) { Add-Content "$folder\PSWatch.log" -Value "$(Get-Date), Start, $folder\$filter => $script" }

try {

    while ($true) { sleep 3 }

} finally {

    $watcher.Dispose()

    if ($logging) { Add-Content "$folder\PSWatch.log" -Value "$(Get-Date), Stop, Bye" }
}
