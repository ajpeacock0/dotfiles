function Make-Link ($target, $link) {
    New-Item -Path $link -ItemType SymbolicLink -Value $target
}

Set-Alias ln Make-Link