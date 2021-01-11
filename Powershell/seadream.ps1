$sourceRG = RG-PROD-EASTUS2
$sourceDiskName = PREMASTER-01-1o6u77p-0
$targetDiskName = vm-premaster-01-osdisk
$targetRG = rg-prod-norwayeast
$targetLocate = norwayeast
#Expected value for OS is either "Windows" or "Linux"
$targetOS = Windows
$sourceDisk = Get-AzDisk -ResourceGroupName $sourceRG -DiskName $sourceDiskName
# Adding the sizeInBytes with the 512 offset, and the -Upload flag
$targetDiskconfig = New-AzDiskConfig -SkuName 'Premium_LRS' -osType $targetOS -UploadSizeInBytes $($sourceDisk.DiskSizeBytes+512) -Location $targetLocate -CreateOption 'Upload'
$targetDisk = New-AzDisk -ResourceGroupName $targetRG -DiskName $targetDiskName -Disk $targetDiskconfig
$sourceDiskSas = Grant-AzDiskAccess -ResourceGroupName $sourceRG -DiskName $sourceDiskName -DurationInSecond 86400 -Access 'Read'
$targetDiskSas = Grant-AzDiskAccess -ResourceGroupName $targetRG -DiskName $targetDiskName -DurationInSecond 86400 -Access 'Write'
azcopy copy $sourceDiskSas.AccessSAS $targetDiskSas.AccessSAS --blob-type PageBlob
Revoke-AzDiskAccess -ResourceGroupName $sourceRG -DiskName $sourceDiskName
Revoke-AzDiskAccess -ResourceGroupName $targetRG -DiskName $targetDiskName