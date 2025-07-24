# Enable network discovery
Get-NetFirewallRule -DisplayGroup "Network Discovery" -Enabled False | Set-Netfirewallrule -Enabled True

# https://learn.microsoft.com/en-us/powershell/module/smbshare/new-smbshare?view=windowsserver2025-ps#example-1-create-an-smb-share
New-SmbShare -Name "VMSFiles" -Path 'W:' -FullAccess $env:USERNAME -ReadAccess 'Everyone'
