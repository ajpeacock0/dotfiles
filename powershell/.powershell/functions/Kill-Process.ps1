Function Kill-Process {
    <#
    .SYNOPSIS
    Finds all processes with matching names and stop them
    #>
    Param (
        [parameter(Mandatory=$True, ValueFromPipeline=$True, Position=0)]
        [String[]]$ProcessName
    )

    If ([string]::IsNullOrEmpty($ProcessName)) {
        Throw "Variable name or export expression is required."
    }

    Write-Host "Killing the following processes: "
    Get-Process | Where-Object {$_.ProcessName -like "*${ProcessName}*"}
    Get-Process | Where-Object {$_.ProcessName -like "*${ProcessName}*"} | Stop-Process
}

Set-Alias kill-ps Kill-Process
