Param(
   [Parameter(position=1)]
   [switch]$system ,
  
   [Parameter(Position=2)]
   [switch]$disk ,
 
   [Parameter(Position=3)]
   [switch]$network

)




if ($system -ne $true -and $disk -ne $true -and $network -ne $true) 
{
    welcome
    CPU-Info
    GPU-Info
    Adapter-Info
    
}

elseif ($disk -eq $true) {
    Disk-Info
}

elseif ($network -eq $true) {
    Adapter-Info
}

elseif ($system -eq $true) {
    CPU-Info
    GPU-Info
    OS-Info
    RAM-Info
}
