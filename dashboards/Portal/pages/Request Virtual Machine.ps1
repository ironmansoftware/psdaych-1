New-UDPage -Url "/request-virtual-machine" -Name "Request Virtual Machine" -Content {
New-UDForm -Content {
        New-UDSelect -Option {
            New-UDSelectOption -Name 'Small'
            New-UDSelectOption -Name 'Medium'
            New-UDSelectOption -Name 'Large'
        } -Label 'Size'
    } -OnSubmit {
        Invoke-PSUScript -Name 'NewServiceRequest.ps1' -Parameters @{
            Type = "Request Machine"
            Size = $Size 
            User = $User
        }
    }
} -Icon @{
		id = 'a3082d9f-b1c9-4dfc-8c77-8c0b3b53e1a2'
		type = 'icon'
	}