param($Message)

Invoke-RestMethod -Method post -ContentType 'Application/Json' -Body "{`"text`":`"$Message`"}" -Uri $Secret:TeamsWebHook