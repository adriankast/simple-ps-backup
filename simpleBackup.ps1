### Backup Script ###

# Usage:
# * Install VeraCrypt and 7-Zip
# * Replace YourUsername in this script
# * Replace YourBackupLocation in this script
# * Replace YourSuperSafePassword in this script
# * Create five folders named: 1, 2, 3, 4, 5 at your Backup Location 
#   (You can use for example an automatically synced cloud folder (e.g. Dropbox, Onedrive, GDrive) if you want to make sure the backup will be available on hardware loss/damage)

# Now you can run the script to create a new zipped, encrypted backup of your documents folder (or any other location if you change it).
# Once the script created the 5th backup, it will start to remove the oldest backup on the creation of a new one.
# You can add the script to a cronjob/scheduled execution, if you want, e.g., to create a backup every week.

# Get a timestamp for the zip file name
$ak_backup_datestamp = Get-Date -UFormat "%Y-%m-%d_%T" | ForEach-Object {$_ -replace ":", "-"}

# Zip the documents directory
7z.exe a -tzip "C:\Users\YourUsername\Desktop\Documents_Backup_$ak_backup_datestamp.zip" "C:\Users\YourUsername\Documents\*"

Write-Host "Documents are zipped"

# Remove the oldest backup from slot 5
Remove-Item "C:\Users\YourUsername\YourBackupLocation\5\*"

# Move the stored backups one slot further
Move-Item -Path "C:\Users\YourUsername\YourBackupLocation\4\*" -Destination "C:\Users\YourUsername\YourBackupLocation\5"
Move-Item -Path "C:\Users\YourUsername\YourBackupLocation\3\*" -Destination "C:\Users\YourUsername\YourBackupLocation\4"
Move-Item -Path "C:\Users\YourUsername\YourBackupLocation\2\*" -Destination "C:\Users\YourUsername\YourBackupLocation\3"
Move-Item -Path "C:\Users\YourUsername\YourBackupLocation\1\*" -Destination "C:\Users\YourUsername\YourBackupLocation\2"

Write-Host "Folders are moved"

# Create a new Veracrypt Container in the first slot and open the created container as "X:"
Start-Process -FilePath "C:\Program Files\VeraCrypt\VeraCrypt Format.exe" -ArgumentList "/create `"C:\Users\YourUsername\YourBackupLocation\1\$ak_backup_datestamp.hc`" /password `"YourSuperSafePassword`" /hash sha512 /filesystem FAT /size 3G /dynamic /silent" -Wait
Start-Process -FilePath "C:\Program Files\VeraCrypt\VeraCrypt.exe" -ArgumentList "/q /v `"C:\Users\YourUsername\YourBackupLocation\1\$ak_backup_datestamp.hc`" /p `"YourSuperSafePassword`" /l x /hash sha512" -Wait

Write-Host "Container is build and opened"

# Move the created zip folder to the container and close the container
Move-Item -Path "C:\Users\YourUsername\Desktop\Documents_Backup_$ak_backup_datestamp.zip" -Destination X:\
VeraCrypt.exe /q /d x

Read-Host -Prompt “Finished Backup Name: $ak_backup_datestamp”
