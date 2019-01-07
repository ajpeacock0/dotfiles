$scriptDirectory = (Split-Path -parent $MyInvocation.MyCommand.Definition)

# TODO: Execute all `*.ps1` scripts in $scriptDirectory\functions
. $scriptDirectory\functions\Show-Colors.ps1
. $scriptDirectory\functions\Export-Variable.ps1
. $scriptDirectory\functions\Make-Link.ps1