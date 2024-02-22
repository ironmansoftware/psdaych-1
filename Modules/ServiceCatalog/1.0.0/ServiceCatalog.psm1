function Connect-Database {
    $Builder = New-DbaConnectionStringBuilder -ConnectionString $env:APPSETTING_Data__ConnectionString
    $Password = ConvertTo-SecureString -String $Builder.Password -AsPlainText
    $Credential = [PSCredential]::new($Builder.'User ID',$Password)

    Connect-DbaInstance -Database $Builder.'Initial Catalog' -SqlInstance $Builder.'Data Source' -SqlCredential $Credential
}