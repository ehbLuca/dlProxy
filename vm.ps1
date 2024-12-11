# Define variables
[string]$VMName = "DebSquid"
[string]$VMPath = "C:\Hyper-V\$VMName"
[string]$VHDPath = "$VMPath\$VMName.vhdx"
[string]$SwitchName = "DebSquidSWitch"
[int64]$MemoryStartupBytes = 2GB
[int64]$VHDSize = 20GB
# this should be provided as an argument or from an external known location.
# mabye automatically download the iso and specify the path like that.
[string]$ISOPath = "$VMPath\debian.iso"

New-Item -ItemType Directory -Path $VMPath -Force

# The following command must be run as an administrator

New-VHD -Path $VHDPath -SizeBytes $VHDSize -Dynamic
New-VMSwitch -Name $SwitchName -NetAdapterName "Ethernet" -SwitchType External

New-VM -Name $VMName -MemoryStartupBytes $MemoryStartupBytes -BootDevice VHD -Path $VMPath -SwitchName $SwitchName

Add-VMHardDiskDrive -VMName $VMName -Path $VHDPath
Set-VMProcessor -VMName $VMName -Count 2
Add-VMDvdDrive -VMName $VMName -Path $ISOPath
