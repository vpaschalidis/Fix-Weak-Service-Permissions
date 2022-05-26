$services = @(get-acl HKLM:\SYSTEM\CurrentControlSet\Services\* | Where-Object {($_.AccessToString -match "(BUILTIN\\Users|NT AUTHORITY\\Authenticated Users) Allow  [A-Za-z,\ ]{0,10}(FullControl|ChangePermissions|SetValue|TakeOwnership)[A-Za-z,\ ]{0,10}\n")})
foreach ($service in $services)
{
    $acl = $service
    Write-Host "======== Current Status ========"
    Write-Host ""
    Write-Host "Service" $acl.PSChildName "is vulnerable in" $acl.PSPath
    Write-Host ""
    Write-Host "====== Current Permissions ======"
    Write-Host ""
    Write-Host $acl.AccessToString
        Write-Host ""
    $rules = $acl.access | Where-Object { 
        (-not $_.IsInherited) 
    }
    ForEach($rule in $rules) {
        $acl.RemoveAccessRule($rule) | Out-Null
    }
        Set-ACL $acl.PSPath -AclObject $acl 
        Write-Host "======== Updated Status ========"
        Write-Host ""
        Write-Host "Service" $acl.PSChildName "is fixed"
        Write-Host ""
        Write-Host "====== Updated Permissions ======"
        Write-Host ""
        Write-Host $acl.AccessToString
        Write-Host ""
}
