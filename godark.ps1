#BYE BYE CHARLIE FREN
#DNS Client Sinkhole

Get-DnsClientNrptRule | Remove-DnsClientNrptRule -Force

$domainlist = Get-Content .\domains.txt

foreach($namespace in $domainlist){

Add-DnsClientNrptRule -Namespace $namespace -NameServers "127.0.0.2"

}

Get-DnsClientNrptRule
