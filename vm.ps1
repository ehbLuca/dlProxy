# Define variables
[string]$VMName = "DebSquid"
[string]$VMPath = "C:\Hyper-V\$VMName"
[string]$VHDPath = "$VMPath\$VMName.vhdx"
[string]$SwitchName = "DebSquidSWitch"
[int64]$MemoryStartupBytes = 2GB
[int64]$VHDSize = 20GB
[string]$ISOPath = "$VMPath\debian.iso"

[string]$DebianURL = "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd"
# Path to ISO file from $DebianURL
[string]$ISODownloadFile = "debian-12.8.0-amd64-netinst.iso" 
# Path to checksum file from $DebianURL
[string]$ChecksumDownloadFile = "SHA512SUMS"

New-Item -ItemType Directory -Path $VMPath -Force

Write-Host "Downloading checksum."
Invoke-WebRequest -Uri "$DebianURL/$ChecksumDownloadFile" -Outfile $ISOSumPath

[string]$Line = Get-Content ./sha512sums | Select-String -Pattern $ISODownloadFile
[string]$Checksum = $Line.Split(' ')[0].ToUpper()

# If checksum matches with existing file we can skip the download
if (
    (Test-Path $ISOPath) -and
    ($Checksum -eq (Get-FileHash $ISOPath -Algorithm SHA512).Hash)
) {
    Write-Host "Iso already downloaded."
} else {
    Invoke-Webrequest -Uri "$DebianURL/$ISODownloadFile" -Outfile $ISOPath -UseBasicParsing
}

# The following commands must be run with administrator privileges
New-VHD -Path $VHDPath -SizeBytes $VHDSize -Dynamic
New-VMSwitch -Name $SwitchName -NetAdapterName "Ethernet" -SwitchType External

New-VM -Name $VMName -MemoryStartupBytes $MemoryStartupBytes -BootDevice VHD -Path $VMPath -SwitchName $SwitchName

Add-VMHardDiskDrive -VMName $VMName -Path $VHDPath
Set-VMProcessor -VMName $VMName -Count 2
Add-VMDvdDrive -VMName $VMName -Path $ISOPath
