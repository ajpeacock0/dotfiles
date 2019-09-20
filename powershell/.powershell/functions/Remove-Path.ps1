Function Remove-Path {
    <#
    .SYNOPSIS
    Removes the given folder path to the path environment variable for that user.
    #>
    Param (
        [parameter(Mandatory=$True, ValueFromPipeline=$True, Position=0)]
        [String[]]$RemovedFolder
    )

    # Get the Current Search Path from the environment keys in the registry
    $NewPath = [Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::User)

    # Find the value to remove, replace it with $NULL. If it's not found, nothing will change.
    $NewPath=$NewPath.replace($RemovedFolder, $NULL)

    # If the ";" was not included in the path, clean it up
    $NewPath=$NewPath.replace(";;", ";")

    # Set the path to the newPath for the current user.
    [Environment]::SetEnvironmentVariable("PATH", $NewPath, [System.EnvironmentVariableTarget]::User)

    # Also make the variable available immediately in the current session.
    Invoke-Expression "`$Env:PATH='$NewPath'"
}

Set-Alias removepath Remove-Path
