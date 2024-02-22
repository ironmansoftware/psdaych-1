param(
    [Parameter(Mandatory)]
    [int]$Id, 
    [Parameter(Mandatory)]
    [int]$Status,
    [Parameter(Mandatory)]
    [string]$Description
)

Import-Module "$Repository\Modules\ServiceCatalog\1.0.0\ServiceCatalog.psd1"

$Connection = Connect-Database

try 
{
    $queryParameters = @{
        Id = $Id 
        Status = $Status 
        Description = $Description
    }

    Invoke-DbaQuery -Query "UPDATE dbo.ServiceRequests SET Status = @Status, Description = @Description WHERE Id = @Id" -SqlInstance $Connection  -SqlParameter $queryParameters
}
finally 
{
    $Connection | Disconnect-DbaInstance
}