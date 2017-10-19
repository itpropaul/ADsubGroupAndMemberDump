Get-ADGroup -SearchBase "OU=child,OU=parent,DC=example,DC=com" -filter * |
foreach {
    $GroupName = $_.Name
    Get-ADGroupMember $_ |
    foreach {
        [pscustomobject]@{
            group_id = $GroupName
            user_id = $_.SamAccountName.ToUpper()
        }
    }
} |
sort group_id,user_id |
Export-Csv -NoTypeInformation subGroupAndMemberDUMP.csv
