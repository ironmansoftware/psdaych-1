New-UDPage -Url "/home" -Name "Home" -Content {
New-UDLayout -Columns 4 -Content {
    New-UDCard -Title "Onboard New User" -Content {
        New-UDTypography "Create a new user"
    } -OnClick {
        Invoke-UDRedirect "/new-user"
    }
    New-UDCard -Title "Request Virtual Machine" -Content {
        New-UDTypography "Request a new virtual machine"
    } -OnClick {
        Invoke-UDRedirect "/request-virtual-machine"
    }
    New-UDCard -Title "View Cost Analysis" -Content {
        New-UDTypography "View the latest cost analysis report."
    } -OnClick {
        Invoke-UDRedirect "/cost-analysis"
    }
}
} -Icon @{
		id = 'd5545845-0b72-42f8-bba7-56e435e757a8'
		type = 'icon'
	}