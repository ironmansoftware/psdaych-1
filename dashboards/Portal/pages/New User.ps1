New-UDPage -Url "/new-user" -Name "New User" -Content {
    New-UDForm -Script 'NewUser.ps1'
} -Icon @{
    id   = '831c6b2d-5c51-4c6d-8bce-5d7a4264ea60'
    type = 'icon'
}