Function Remove-Directory {
    <#
    .SYNOPSIS
    Deletes a directory recursivley and with force
    #>
    Param (
        [parameter(Mandatory=$True, ValueFromPipeline=$True, Position=0)]
        [String[]]$Directory
    )

    If ([string]::IsNullOrEmpty($Directory)) {
        Throw "Variable name or export expression is required."
    }

    Remove-Item -Recurse -Force $Directory
}

Set-Alias rm Remove-Directory
