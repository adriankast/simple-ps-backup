# Simple Powershell Backup Script

A simple Powershell backup script to keep 5 encrypted backups of your document folder (Using 7-Zip and VeraCrypt).

## Setup:
* Install VeraCrypt and 7-Zip
* Replace YourUsername in this script
* Replace YourBackupLocation in this script
* Replace YourSuperSafePassword in this script
* Create five folders named: 1, 2, 3, 4, 5 at your Backup Location 
  (You can use for example an automatically synced cloud folder (e.g. Dropbox, Onedrive, GDrive) if you want to make sure the backup will be available on hardware loss/damage)

## Usage
Now you can run the script to create a new zipped, encrypted backup of your documents folder (or any other location if you change it).
Once the script created the 5th backup, it will start to remove the oldest backup on the creation of a new one.
You can add the script to a cronjob/scheduled execution, if you want, e.g., to create a backup every week.
