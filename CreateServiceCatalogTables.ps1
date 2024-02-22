Import-Module "$Repository\Modules\ServiceCatalog\1.0.0\ServiceCatalog.psd1"

$Connection = Connect-Database

try 
{
    Invoke-DbaQuery -Query "IF OBJECT_ID(N'dbo.ServiceRequests', N'U') IS NULL BEGIN   CREATE TABLE dbo.ServiceRequests (ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY, Title varchar(MAX) not null, Description varchar(MAX) not null,  Requester varchar(MAX) not null, Manager varchar(MAX) not null, Status int not null); END;" -SqlInstance $Connection
}
finally 
{
    $Connection | Disconnect-DbaInstance
}