$a = 'NFS ISO library'
$b = Get-XenSR -Name $a
foreach ($pbd in $b.PBDs)

{
    $x = Get-XenPBD -Ref $pbd 
   
    Invoke-XenPBD -PBD $x -XenAction Unplug -Verbose
     
}
Invoke-XenSR -SR $b -XenAction Forget