#Lab4 Updated


#Defining Parameters
Param(
   [Parameter(position=1)][switch]$system , [Parameter(Position=2)][switch]$disk , [Parameter(Position=3)][switch]$network
)

#Settling the parameters using if...else
if ($system -ne $true -and $disk -ne $true -and $network -ne $true) 
{
Hardware-Info  
OS-Info  
CPU-Info
GPU-Info
Adapter-Info
RAM-Info
get-mydisks
}

elseif ($disk -eq $true) 
{
get-mydisks
}

elseif ($network -eq $true) 
{
Adapter-Info
}

elseif ($system -eq $true)
{
CPU-Info
GPU-Info
OS-Info
RAM-Info
}
