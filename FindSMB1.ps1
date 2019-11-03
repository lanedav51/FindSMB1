$TxtPath = "InsertPathHere"
$File = Import-Csv $TxtPath
$Computers = $File.Computers
$i = 0

foreach($Computer in $Computers)
{
    Enter-PSSession -ComputerName $Computer
    $SMB1 = (Get-SmbServerConfiguration).EnableSMB1Protocol
    $obj = new-object psobject -Property @{
        ComputerName = $Computer
    }
    if($SMB1 -eq "True" -AND $i -eq 0)
    {
        $obj | Export-Csv -Path "SMB1Enabled$(get-date -f yyyy-MM-dd).csv"
        $i++
    }
    elseif ($SMB1 -eq "True" -AND $i -ge 1) 
    {
        $obj | Export-Csv -Append -Path "SMB1Enabled$(get-date -f yyyy-MM-dd).csv"
        $i++
    }
    Exit-PSSession
}