Function Add-Path {
    <#
    .SYNOPSIS
    Adds the given folder path to the path environment variable for that user.
    The given folder path must be valid and will not be added if it
    already exists in the global or user path.
    #>
    Param (
        [parameter(Mandatory=$True, ValueFromPipeline=$True, Position=0)]
        [String[]]$AddedFolder
    )

    # See if a new folder has been supplied.
    If (!$AddedFolder) {
        Throw "No Folder Supplied. $ENV:PATH Unchanged"
    }

    # See if the new folder exists on the file system.
    If (!(Test-Path $AddedFolder)) {
        Throw "Folder Does not Exist, Cannot be added to $ENV:PATH"
    }

    # Get the current search path from the environment keys in the registry.
    $OldPath = [Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::User)

    # See if the new Folder is already in the path.
    If ($OldPath | Select-String -SimpleMatch $AddedFolder)
    {
        Return
    }

    # Set the New Path
    $NewPath=$OldPath+";"+$AddedFolder

    # Set the path to the newPath for the current user.
    [Environment]::SetEnvironmentVariable("PATH", $NewPath, [System.EnvironmentVariableTarget]::User)

    # Also make the variable available immediately in the current session.
    Invoke-Expression "`$Env:PATH='$NewPath'"
}

Set-Alias addpath Add-Path
