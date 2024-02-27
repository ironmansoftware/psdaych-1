New-UDPage -Url "/home" -Name "Home" -Content {
$Services = @(
    @{
        Title   = "Onboard New User"
        Content = New-UDCard -Title "Onboard New User" -Content {
            New-UDTypography "Create a new user"
        } -OnClick {
            Invoke-UDRedirect "/new-user"
        }
    }
    @{
        Title   = "Request Virtual Machine"
        Content = New-UDCard -Title "Request Virtual Machine" -Content {
            New-UDTypography "Request a new virtual machine"
        } -OnClick {
            Invoke-UDRedirect "/request-virtual-machine"
        }
    }
    @{
        Title   = "View Cost Analysis"
        Content = Protect-UDSection -Role "Administrator" -Content {
            New-UDCard -Title "View Cost Analysis" -Content {
                New-UDTypography "View the latest cost analysis report."
            } -OnClick {
                Invoke-UDRedirect "/cost-analysis"
            }
        }
    }
)

New-UDStack -FullWidth -Direction column -Children {
    New-UDTextbox -Label Search -OnEnter {
        $Page:Search = $EventData
        Sync-UDElement -Id 'results'
    } -FullWidth

    New-UDDivider

    New-UDDynamic -Id 'results' -Content {
        New-UDLayout -Columns 4 -Content {
            $Services | Where-Object { $Page:Search -eq $null -or $_.Title.Contains($Page:Search) } | ForEach-Object {
                $_.Content
            }
        }
    }
}
} -Icon @{
		id = 'd5545845-0b72-42f8-bba7-56e435e757a8'
		type = 'icon'
	}