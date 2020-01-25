# KeePass CSV to 1Password CVS
[CmdletBinding()]
param (
    # Where to retrieve the KeePass exported CSV. Expecting a file.
    [Parameter(Mandatory = $true)]
    [ValidateScript( {
            IF ((Test-Path -Path $_ -PathType Leaf) -eq $false) {
                throw "[!] Failed parameter validation on KeePassCSVPath. Path [$_] does not exist, can't be reached, or a folder was passed when a file was expected."
            }
            ELSE {
                $true
            }
        })]
    [string]
    $KeePassCSVPath,
    # Where to save the csv. Expecting a folder.
    [Parameter(Mandatory = $true)]
    [ValidateScript( {
            IF ((Test-Path -Path $_ -PathType Container) -eq $false) {
                throw "[!] Failed parameter validation on 1PasswordCSVSavePath. Path [$_] does not exist, can't be reached, or a file was passed when a folder was expected."
            }
            ELSE {
                $true
            }
        })]
    [string]
    $1PasswordCSVSavePath
)
process {
    $kpCsv = Import-Csv -Path $KeePassCSVPath -Delimiter ',' -Header @('Title', 'Username', 'Password', 'Website', 'Notes')

    $1PasswordCSVSavePath = [System.IO.Path]::Combine($1PasswordCSVSavePath, "1pwReady.csv")

    foreach ($entry in $kpCsv) {
        [PSCustomObject]@{
            Title            = $entry.Title | Out-String
            Website          = $entry.Website | Out-String
            Username         = $entry.Username | Out-String
            Password         = $entry.Password | Out-String
            Notes            = $entry.Notes | Out-String
            'Member Number'  = $null
            'Recovery Codes' = $null
        } | Export-Csv -Path $1PasswordCSVSavePath -NoTypeInformation -Delimiter ',' -Append
    }

    Write-Output "[*] Finished. Converted CSV is here: [$1PasswordCSVSavePath]"
}