#Lab4

#generating Hardaware Information
function Hardware-Info
{
 Write-host "System Hardware Information"
 get-wmiobject -class Win32_ComputerSystem | fl Description
}

#Operatong System Information
function OS-Info
{
 Write-host "OS Information"
 get-wmiobject -class Win32_OperatingSystem | fl Name, Version
}

#CPU Information
function CPU-Info
{
 Write-host "System Processor Information"
 get-wmiobject -class win32_processor | select Description, CurrentClockSpeed, NumberOfCores, @{n="L1CacheSize";e={switch($_.L1CacheSize){$null{$empty="data unavailable"}};$empty}}, L2CacheSize, L3CacheSize
}

#RAM Information
function RAM-Info
{
Write-host "RAM Information"
$total = 0
get-wmiobject -class win32_physicalmemory |
  foreach { 
    New-Object -TypeName psObject -Property @{ 
      Vendor = $_.Manufacturer
      Description = $_.Description
      Size = $_.Capacity/1gb
      Bank = $_.BankLabel
      Slot = $_.DeviceLocator
      }
      $total += $_.capacity/1gb
      }|
ft Vendor, Description, Size, Speed, Bank, Slot
"Total RAM: ${total}GB"}

#Physical Disk Drive Information
function Disk-Info
{
write-host "Disk Information"
$diskdrives = Get-CimInstance -class CIM_diskdrive
 foreach ($disk in $diskdrives) {
     $partitions = $disk|get-cimassociatedinstance -resultclassname CIM_diskpartition
   foreach ($partition in $partitions) {
          $logicaldisks = $partition | get-cimassociatedinstance -resultclassname CIM_logicaldisk
          foreach ($logicaldisk in $logicaldisks) {
             new-object -typename psobject -property @{
               Vendor = $disk.Manufacturer
               Model = $disk.Model
               Drive = $logicaldisk.deviceid
               Size = $logicaldisk.size / 1gb -as [int]
              "Space(GB)" = $logicaldisk.freespace/1gb -as [int]
              "Space(%)" = ([string]((($logicalDisk.FreeSpace / $logicalDisk.Size) * 100) -as [int]) + '%')} | ft Drive, Vendor, Model, Size, "space(GB)", "Space(%)"
            }
      }
  }
}

# Lab3 Report
function Adapter-Info
{
Write-host "Network Adapter Informtion"
get-wmiobject -class win32_networkadapterconfiguration  |
Format-Table Description, Index,
IPAddress, IPSubnet, DNSDomain, DNSServerSearchOrder,
@{n="DNSDomain";e={switch($_.DNSDomain){$null{$empty="data unavailable";$empty}};if($null -ne $_.DNSDomain){$_.DNSDomain}}},
@{n="DNSServerSearchOrder";e={switch($_.DNSServerSearchOrder){$null{$empty="data unavailable";$empty}};if($null -ne $_.DNSServerSearchOrder){$_.DNSServerSearchOrder}}}
}

# Graphical Interface Information with Screen Resolution
function GPU-Info
{
  Write-host "Graphics Card Information"
  $horizontalpixels = (get-wmiobject -class Win32_videocontroller).CurrentHorizontalResolution -as [String]
  $verticalpixels = (gwmi -classNAME win32_videocontroller).CurrentVerticalresolution -as [string]
  $screenresolution = $horizontalpixels + " x " + $verticalpixels
  gwmi -classNAME win32_videocontroller| fl @{n = "Video Card Vendor"; e={$_.AdapterCompatibility}}, Description, @{n="Screen Resolution"; e={$screenresolution -as [string]}}
}

param (Select-Object GPU-Info, RAM-Info, CPU-Info, OS-Info )


