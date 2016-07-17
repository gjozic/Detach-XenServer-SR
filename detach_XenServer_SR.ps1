<#
This script will detach Storage Repository from XenServer Farm.
it is extremely manual process, (although it could be automated)
you will need to enter Pool Master name, credentials to connect and name of SR. IT will fail if SR is being used.
#>

#requires -module XenServerPSModule


$master = Read-Host "Enter Pool Master name"
$prompt = Get-Credential
$xenserver_password = $prompt.Password
$xenserver_username = $prompt.UserName
$xenserver_credential = New-Object -Typename System.Management.Automation.PSCredential -ArgumentList $xenserver_username, $xenserver_password
Connect-XenServer -Server $master -Creds $xenserver_credential -SetDefaultSession -NoWarnCertificates


$a = Read-Host "Enter the name of SR"
$b = Get-XenSR -Name $a
foreach ($pbd in $b.PBDs)

{
    $x = Get-XenPBD -Ref $pbd 
   
    Invoke-XenPBD -PBD $x -XenAction Unplug -Verbose
     
}
Invoke-XenSR -SR $b -XenAction Forget