#Lab3
#IP Configuration Report
get-ciminstance win32_networkadapterconfiguration |
where { $_.ipenabled -eq "true" } |
Format-Table Description, Index,
IPAddress, IPSubnet, DNSDomain, DNSServerSearchOrder