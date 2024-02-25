Import-Module "$Repository\Modules\ServiceCatalog\1.0.0\ServiceCatalog.psd1"

$Connection = Connect-Database

try 
{
    $queryParameters = @{
        Requester = $UAJob.Identity.Name
    }

    Invoke-DbaQuery -Query "SELECT * FROM dbo.ServiceRequests WHERE Requester = @Requester" -SqlInstance $Connection  -SqlParameter $queryParameters -As PSObject
}
finally 
{
    $Connection | Disconnect-DbaInstance | Out-Null
}