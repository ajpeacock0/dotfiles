Export-Variable 'PYTHONIOENCODING' 'utf-8'
Export-Variable 'FZF_DEFAULT_OPTS' '--height=30%'

# Source local PowerShell environment if one exists
$LocalPowerShellEnv = "${Env:UserProfile}\.config\powershell\local_environment.ps1"
If (Test-Path $LocalPowerShellEnv) {
    . $LocalPowerShellEnv
}
