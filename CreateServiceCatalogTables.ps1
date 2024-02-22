Import-Module "$Repository\Modules\ServiceCatalog\1.0.0\ServiceCatalog.psd1"

$Connection = Connect-Database

try 
{
    Invoke-DbaQuery -Query 'SELECT 1 FROM dbo.Job' -SqlInstance $Connection
}
finally 
{
    $Connection | Disconnect-DbaInstance
}