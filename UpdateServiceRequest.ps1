param(
    [Parameter(Mandatory)]
    [int]$RequestId, 
    [Parameter(Mandatory)]
    [int]$Status
)

Import-Module "$Repository\Modules\ServiceCatalog\1.0.0\ServiceCatalog.psd1"

$Connection = Connect-Database

try 
{
    $queryParameters = @{
        Id = $RequestId 
        Status = $Status 
        Description = $Description
    }

    Invoke-DbaQuery -Query "UPDATE dbo.ServiceRequests SET Status = @Status, Description = @Description WHERE Id = @Id" -SqlInstance $Connection  -SqlParameter $queryParameters
}
finally 
{
    $Connection | Disconnect-DbaInstance
}

$StatusName = "approved"
if ($Status -eq 2)
{
    $StatusName = "denied"
}

Invoke-RestMethod -Method post -ContentType 'Application/Json' -Body "{`"text`":`"Service request $Id has been $StatusName.`"}" -Uri $Secret:TeamsWebHook