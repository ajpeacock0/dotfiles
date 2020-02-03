Function Delete-Item {
    <#
    .SYNOPSIS
    Removes the given item path if it exists
    #>
    Param (
        [parameter(Mandatory=$True, ValueFromPipeline=$True, Position=0)]
        [String[]]$RemovedItem
    )

    # Test if the item exists and remove it if true
    if((Test-Path -Path $RemovedItem)){
        Remove-Item -Path $RemovedItem
    }
}

Set-Alias deleteitem Delete-Item
