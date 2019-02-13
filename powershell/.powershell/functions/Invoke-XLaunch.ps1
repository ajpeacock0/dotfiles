function Invoke-XLaunch {
        xlaunch -run "${Env:UserProfile}\.xlaunch\config.xlaunch"
}

Set-Alias startx Invoke-XLaunch
