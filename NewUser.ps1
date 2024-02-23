param(
  $DisplayName,
  $UserName
)

Connect-MgGraph -Identity

$PasswordProfile = @{
  Password = 'Helo123!'
}

New-MgUser -DisplayName $DisplayName -PasswordProfile $PasswordProfile -AccountEnabled -MailNickName $UserName -UserPrincipalName "$UserName@ironmansoftware.onmicrosoft.com"