Function Join-Files {
    <#
    .SYNOPSIS
    Concatenates all files in the current directory into a joined file
    #>

    Get-ChildItem -File | % { echo $_.Name; cat $_.Name >> joined_files }
}
