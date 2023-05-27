Function Touch-File {
    <#
    .SYNOPSIS
    For the argument file, if it exists then update the file timestamp, else,
    create it. Attempt to recreate unix `touch` command on Windows.
    #>
    Param (
        [Parameter(Position=0)]
        [string]$FileName
    )

    If ([string]::IsNullOrEmpty($FileName)) {
        Throw "No file name given."
    }

    # Test if the item exists
    If ((Test-Path -Path $FileName)) {
        (Get-ChildItem $FileName).LastWriteTime = Get-Date
    } else {
        echo $null > $FileName
    }
}

Set-Alias touch Touch-File -Option AllScope
