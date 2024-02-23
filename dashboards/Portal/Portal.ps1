New-UDApp -Title 'PowerShell Universal' -Pages @(
    Get-UDPage -Name "Home"
    Get-UDPage -Name 'New User'
    Get-UDPage -Name 'Request Virtual Name'
)