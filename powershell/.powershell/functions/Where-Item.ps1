Function Where-Item {
    <#
    .SYNOPSIS
    Print where the known path[s] of a binary of that name exist
    #>
    Param (
            [parameter(Mandatory=$True, ValueFromPipeline=$True, Position=0)]
            [String[]]$ItemName
          )

    cmd /c where $ItemName
}

Set-Alias whereitem Where-Item
# Create a 2nd alias, overriding the read only, AllScope `where` command
Set-Alias -Force where Where-Item -Option AllScope
