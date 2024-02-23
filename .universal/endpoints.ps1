New-PSUEndpoint -Url "/request/{id}/{status}" -Method @('GET') -Endpoint {
    param(
        [int]$Id, 
        [int]$Status
    )

    Invoke-PSUScript -Name "UpdateServiceRequest.ps1" -Parameters @{
        Id     = $Id 
        Status = $Status
    }
} -Authentication