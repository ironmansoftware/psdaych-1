Import-Module "$Repository\Modules\ServiceCatalog\1.0.0\ServiceCatalog.psd1"
$Connection = Connect-Database

Invoke-DbaQuery -Query "DELETE FROM dbo.ServiceRequests" -SqlInstance $Connection 