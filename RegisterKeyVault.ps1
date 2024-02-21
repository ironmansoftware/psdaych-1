$sub = 'affdf0d4-eed5-48a6-889c-599d482f55d8'
Connect-AzAccount -Id -Scope CurrentUser -SubscriptionId $sub

Register-SecretVault -ModuleName Az.KeyVault -Name AzureKeyVault -VaultParameters @{ 
    AZKVaultName = 'psudaych-1'
    SubscriptionId = $sub
} -AllowClobber