#Change le canal d'update de Office en Monthly


cd 'C:\Program Files\Common Files\microsoft shared\ClickToRun'

Start-Process -FilePath "C:\Program Files\Common Files\microsoft shared\ClickToRun\OfficeC2RClient.exe" -ArgumentList "/changesetting Channel=Monthly"

Start-Process -FilePath "C:\Program Files\Common Files\microsoft shared\ClickToRun\OfficeC2RClient.exe" -ArgumentList "/update user"
