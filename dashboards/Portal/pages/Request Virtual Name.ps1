New-UDPage -Url "/request-virtual-name" -Name "Request Virtual Name" -Content {
    New-UDForm -Content {
        New-UDSelect -Option {
            New-UDSelectOption -Name 'Small'
            New-UDSelectOption -Name 'Medium'
            New-UDSelectOption -Name 'Large'
        } -Label 'Size'
    } -OnSubmit {
        Invoke-PSUScript -Name 'NewServiceRequest.ps1' -Parameters @{
            Type = "VirtualMachine"
        }
    }
} -Icon @{
    id   = 'a51aaa33-1c30-4135-a9df-5d3b8479384a'
    type = 'icon'
}