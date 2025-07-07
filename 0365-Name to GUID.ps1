# Get all mailboxes in the tenant (use a filter if necessary, like specific organizational units)
$mailboxes = Get-Mailbox -ResultSize Unlimited

# Path to the CSV file where the results will be logged
$csvPath = "C:\temp\output_log.csv"

# Prepare an array to hold the results
$logResults = @()

# Loop through each mailbox
foreach ($mailbox in $mailboxes) {
    $existingGuid = $mailbox.Guid
    $oldName = $mailbox.Name

    # Set the new name to only be the GUID (no prefix)
    $newName = $existingGuid.ToString()

    # Only update the mailbox if the current name doesn't match the GUID
    if ($oldName -ne $newName) {
        # Update the profile name for each mailbox
        Set-Mailbox -Identity $mailbox.Identity -Name $newName

        # Log the result to the array
        $logResults += [pscustomobject]@{
            EmailAddress = $mailbox.UserPrincipalName
            OldName      = $oldName
            NewName      = $newName
            GUID         = $existingGuid
            Status       = "Updated"
            Timestamp    = (Get-Date)
        }

        # Log the action in the console
        Write-Host "Updated mailbox: $($mailbox.UserPrincipalName) to $newName"
    } else {
        # Log if no update was needed
        $logResults += [pscustomobject]@{
            EmailAddress = $mailbox.UserPrincipalName
            OldName      = $oldName
            NewName      = $newName
            GUID         = $existingGuid
            Status       = "No Change"
            Timestamp    = (Get-Date)
        }

        Write-Host "No update needed for: $($mailbox.UserPrincipalName)"
    }
}

# Export the results to CSV
$logResults | Export-Csv -Path $csvPath -NoTypeInformation

Write-Host "Log has been saved to $csvPath"
