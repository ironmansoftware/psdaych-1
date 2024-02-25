param(
    [Parameter(Mandatory)]
    [int]$RequestId, 
    [Parameter(Mandatory)]
    [int]$Status
)

Import-Module "$Repository\Modules\ServiceCatalog\1.0.0\ServiceCatalog.psd1"

$Connection = Connect-Database

<#
0 - Requested
1 - Approved
2 - Denied
3 - Canceled
#>

Write-Host "Status is $Status"

try 
{
    $queryParameters = @{
        Id = $RequestId 
        Status = $Status 
    }

    Invoke-DbaQuery -Query "UPDATE dbo.ServiceRequests SET Status = @Status WHERE Id = @Id" -SqlInstance $Connection  -SqlParameter $queryParameters | Out-Null
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

# Provisioning of the machine would happen

Invoke-RestMethod -Method post -ContentType 'Application/Json' -Body "{`"text`":`"Service request $Id has been $StatusName.`"}" -Uri $Secret:TeamsWebHook