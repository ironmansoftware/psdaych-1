New-UDPage -Url "/my-requests" -Name "My Requests" -Content {
New-UDDynamic -Id 'grid' -Content {
Import-Module "$Repository\Modules\ServiceCatalog\1.0.0\ServiceCatalog.psd1"
$Connection = Connect-Database

try 
{
    $queryParameters = @{
        Requester = $User
    }

    $Results = Invoke-DbaQuery -Query "SELECT * FROM dbo.ServiceRequests WHERE Requester = @Requester" -SqlInstance $Connection  -SqlParameter $queryParameters
}
finally 
{
    $Connection | Disconnect-DbaInstance
}

New-UDTable -Columns @(
    New-UDTableColumn -Property Id 
    New-UDTableColumn -Property Requester
    New-UDTableColumn -Property Status -OnRender {
        if ($EventData.Status -eq 0) {
            New-UDAlert -Dense -Severity warning -Text "Requested"
        } elseif ($EventData.Status -eq 1) {
            New-UDAlert -Dense -Severity success -Text "Approved"
        } elseif ($EventData.Status -eq 2) {
            New-UDAlert -Dense -Severity failed -Text "Rejected"
        } elseif ($EventData.Status -eq 3) {
            New-UDAlert -Dense -Severity warning -Text "Cancelled"
        }
    }
    New-UDTableColumn -Property UpdateStatus -OnRender {
        if ($EventData.Status -eq 0) {
            New-UDButton -Text "Cancel" -Icon (New-UDIcon -Icon Cancel) -OnClick {
                Invoke-PSUScript -Name 'UpdateServiceRequest.ps1' -Parameters @{
                    RequestId = $EventData.Id 
                    Status = 3
                } -Wait | Out-Null 
                Sync-UDElement -Id 'grid'
            } -ShowLoading
        }
    }
) -Data $Results
} -LoadingComponent {
    New-UDProgress -Label "Loading..."
}
} -Icon @{
		id = '462bb4cf-96e5-4bc0-b284-d10c237e25cd'
		type = 'icon'
	}