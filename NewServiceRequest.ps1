param(
    [ValidateSet("Request Machine")]
    [string]$Type = "Request Machine",
    [ValidateSet("Small", "Medium", "Large")]
    [string]$Size = "Small",
    [string]$User
)

Import-Module "$Repository\Modules\ServiceCatalog\1.0.0\ServiceCatalog.psd1"
$Connection = Connect-Database

try 
{
    $queryParameters = @{
        Title = $Type
        Description = "Requesting a VM of size $size"
        Requester = $User
        Manager = "adam@ironmansoftware.onmicrosoft.com"
        Status = 0
    }

    Invoke-DbaQuery -Query "INSERT INTO dbo.ServiceRequests (Title, Description, Requester, Status, Manager) VALUES (@Title, @Description, @Requester, @Status, @Manager)" -SqlInstance $Connection  -SqlParameter $queryParameters | Out-Null

    $RequestId = Invoke-DbaQuery -Query "SELECT Id FROM dbo.ServiceRequests WHERE Requester = @Requester AND Status = 0" -SqlInstance $Connection  -SqlParameter $queryParameters | Select-Object -First 1
}
finally 
{
    $Connection | Disconnect-DbaInstance | Out-Null
}

$Message = @{
    summary = "$User is requesting a virtual machine of size $size."
    "@type" = "MessageCard"
    "@context" = "http://schema.org/extensions"
    "themeColor" = "0076D7"
    "sections" = @(
        @{
            "activityTitle" = "$User is request a virtual machine of size $size."
            "activitySubtitle" = "Do you approve?"
            "facts" = @(
                @{
                    "name" = "Requester"
                    "value" = $User
                }
                @{
                    "name" = "Size"
                    "value" = $Size
                }
            )
            "markdown" = $true
        }
    )
    "potentialAction" = @(
        @{
            "@type" = "ActionCard"
            "name" = "Approve"
            "inputs" = @(
                @{
                    "@type" = "MultichoiceInput"
                    "id" = "Status"
                    "title" = "Do you approve?"
                    "isMultiSelect" = "false"
                    "choices" = @(
                        @{
                            "display" = "Approved"
                            "value" = "1"
                        }
                        @{
                            "display" = "Denied"
                            "value" = "2"
                        }
                    )
                }
            )
            "actions" = @(
                @{
                    "@type" = "HttpPOST" 
                    "name" = "Update"
                    "target" = "https://psdaych-1.azurewebsites.net/request/$($RequestId.Id)"
                }
            )
        }
    )
} | ConvertTo-Json -Depth 10

Invoke-RestMethod -Method post -ContentType 'Application/Json' -Body $Message -Uri $Secret:TeamsWebHook
 