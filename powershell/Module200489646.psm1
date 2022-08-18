$env:PATH = "$env:PATH;C:\Users\DM\Documents\Modules\Module200489646";


function Welcome {
write-host "Welcome to planet $env:computername Overlord $env:username"
$now = get-date -format 'HH:MM tt on dddd'
write-host "It is $now."
}

new-item -path alias:np -value notepad | out-null

function get-cpuinfo {
get-ciminstance cim_processor
Get-WmiObject Win32_Processor |
Select-Object Manufacturer, NumberOfCores, NumberOfLogicalProcessors |
Format-List
}

function get-mydisks {
wmic diskdrive get Model,Manufacturer,SerialNumber,FirmwareRevision,Size
}

function Hardware-Info
{
 Write-host "System Hardware Information"
 get-wmiobject -class Win32_ComputerSystem | fl Description
}

function OS-Info
{
 Write-host "OS Information"
 get-wmiobject -class Win32_OperatingSystem | fl Name, Version
}

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


function Adapter-Info
{
Write-host "Network Adapter Informtion"
get-wmiobject -class win32_networkadapterconfiguration  |
Format-Table Description, Index,
IPAddress, IPSubnet, DNSDomain, DNSServerSearchOrder,
@{n="DNSDomain";e={switch($_.DNSDomain){$null{$empty="data unavailable";$empty}};if($null -ne $_.DNSDomain){$_.DNSDomain}}},
@{n="DNSServerSearchOrder";e={switch($_.DNSServerSearchOrder){$null{$empty="data unavailable";$empty}};if($null -ne $_.DNSServerSearchOrder){$_.DNSServerSearchOrder}}}
}


function GPU-Info
{
  Write-host "Graphics Card Information"
  $horizontalpixels = (get-wmiobject -class Win32_videocontroller).CurrentHorizontalResolution -as [String]
  $verticalpixels = (gwmi -classNAME win32_videocontroller).CurrentVerticalresolution -as [string]
  $screenresolution = $horizontalpixels + " x " + $verticalpixels
  gwmi -classNAME win32_videocontroller| fl @{n = "Video Card Vendor"; e={$_.AdapterCompatibility}}, Description, @{n="Screen Resolution"; e={$screenresolution -as [string]}}
}


Welcome
get-cpuinfo
get-mydisks