New-PSUEndpoint -Url "/request/:id" -Method @('POST') -Endpoint {
    param(
        [int]$Id, 
        [int]$Status = 1
    )

    Invoke-PSUScript -Name "UpdateServiceRequest.ps1" -Parameters @{
        RequestId = $Id 
        Status    = $Status
    } | Out-Null
} -PersistentLog