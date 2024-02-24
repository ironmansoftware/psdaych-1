New-UDPage -Url "/my-requests" -Name "My Requests" -Content {
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
        } else {
            New-UDAlert -Dense -Severity failed -Text "Rejected"
        }
    }
) -Data $Results
} -Icon @{
		id = '462bb4cf-96e5-4bc0-b284-d10c237e25cd'
		type = 'icon'
	}