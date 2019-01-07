# Set syntax highlighting colors for PowerShell

Set-PSReadLineOption -Colors @{"Comment" = [ConsoleColor]::DarkCyan}
Set-PSReadLineOption -Colors @{"Operator" = [ConsoleColor]::DarkMagenta}
Set-PSReadLineOption -Colors @{"Variable" = [ConsoleColor]::DarkGray}
Set-PSReadLineOption -Colors @{"Member" = [ConsoleColor]::DarkGray}
Set-PSReadLineOption -Colors @{"Number" = [ConsoleColor]::Blue}
Set-PSReadLineOption -Colors @{"Type" = [ConsoleColor]::Green}
Set-PSReadLineOption -Colors @{"String" = [ConsoleColor]::Cyan}
Set-PSReadLineOption -Colors @{"Parameter" = [ConsoleColor]::Red}
Set-PSReadLineOption -Colors @{"Keyword" = [ConsoleColor]::Yellow}

Set-PSReadLineOption -Colors @{"Command" = [ConsoleColor]::White}

Set-PSReadLineOption -Colors @{"None" = [ConsoleColor]::White}
