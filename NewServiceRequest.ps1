param(
    [ValidateSet("Request Machine")]
    [string]$Type
)

Import-Module "$Repository\Modules\ServiceCatalog\1.0.0\ServiceCatalog.psd1"

$Connection = Connect-Database

try 
{
    $queryParameters = @{
        Title = $Type
        Description = "Requesting a VM"
        Requester = $UAJob.Identity.Name
        Manager = "adam@ironmansoftware.onmicrosoft.com"
        Status = 0
    }

    Invoke-DbaQuery -Query "INSERT INTO dbo.ServiceRequests (Title, Description, Requester, Status, Manager) VALUES (@Title, @Description, @Requester, @Status, @Manager)" -SqlInstance $Connection  -SqlParameter $queryParameters
}
finally 
{
    $Connection | Disconnect-DbaInstance
}