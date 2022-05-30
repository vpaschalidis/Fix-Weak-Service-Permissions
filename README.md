# Fix-Weak-Service-Permissions

This script identifies and fixes weak permissions on Windows services. 
It finds services that the BUILTIN\\Users and NT AUTHORITY\\Authenticated Users group have FullControl,ChangePermissions, SetValue or TakeOwnership rights and removes them.

In order to run the script just execute the below in an elevated powershell:

.\Fix-Weak-Service-Permissions.ps1
