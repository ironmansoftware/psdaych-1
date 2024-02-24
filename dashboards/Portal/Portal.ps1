New-UDApp -Title 'PowerShell Universal' -Pages @(
    Get-UDPage -Name "Home"
    Get-UDPage -Name 'New User'
    Get-UDPage -Name 'Request Virtual Machine'
    Get-UDPage -Name 'My Requests'
) -Navigation @(
    New-UDListItem -Label "Home" -Href '/home'
    New-UDListItem -Label "My Requests" -Href '/my-requests'
)