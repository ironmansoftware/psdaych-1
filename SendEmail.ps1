Connect-MgGraph -Identity


$MailFrom = "adam@ironmansoftware.com"
$MailTo = "adam.r.driscoll@gmail.com"
$msgBody = “This is <br> test <br> Graph API mailer <br>”
$Message = @{
   Subject = "Hello World from GraphAPI"
   Body = @{
      ContentType = "HTML"
      Content = $msgBody
      }
   ToRecipients = @(
      @{
         EmailAddress = @{
         Address = $MailTo
         }
       }
    )
}

Send-MgUserMail -UserId $MailFrom -Message $Message