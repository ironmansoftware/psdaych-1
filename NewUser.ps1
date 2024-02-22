Connect-MgGraph -Identity

$PasswordProfile = @{
  Password = 'Helo123!'
}

New-MgUser -DisplayName ‘New User’ -PasswordProfile $PasswordProfile -AccountEnabled -MailNickName ‘NewUser’ -UserPrincipalName 'newuser@ironmansoftware.onmicrosoft.com’