function Generate-Guid () {
    [guid]::NewGuid().ToString()
}

Set-Alias guid Generate-Guid
