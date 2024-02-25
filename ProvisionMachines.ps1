Import-Module "$Repository\Modules\ServiceCatalog\1.0.0\ServiceCatalog.psd1"

$Connection = Connect-Database

try 
{
    $Requests = Invoke-DbaQuery -Query "SELECT * FROM dbo.ServiceRequests WHERE Status = 1 AND Title = 'Request Machine'" -SqlInstance $Connection  -As PSObject

    $Requests | ForEach-Object {
        Write-Host "Provisioned machine!"

        $queryParameters = @{
            Id = $_.Id
        }


        Invoke-DbaQuery -Query "UPDATE dbo.ServiceRequests SET Status = 3 WHERE ID = @Id" -SqlInstance $Connection  -SqlParameter $queryParameters 
    }
}
finally 
{
    $Connection | Disconnect-DbaInstance | Out-Null
}