# add local only option

function Get-NetworkPorts {
    param($ComputerName)
    $raw_ports = netstat -ona | findstr LISTEN
    $raw_ports += netstat -ona | findstr UDP
    $ports = @()
    foreach ($raw_port in $raw_ports) {

        $values = $raw_port -split "\s+"
        $port = New-Object -TypeName PSObject
        Add-Member -InputObject $port -MemberType NoteProperty -Name Protocol -Value $values[1]
        Add-Member -InputObject $port -MemberType NoteProperty -Name LocalAddr -Value $($values[2] -split ':\d+$')[0]
        Add-Member -InputObject $port -MemberType NoteProperty -Name Port -Value $($values[2] -split ':')[-1]

        if ($port.Protocol -eq "UDP") {
            $pid_index = 4
        } else {
            $pid_index = 5
        }

        Add-Member -InputObject $port -MemberType NoteProperty -Name Pid -Value $values[$pid_index]
        Add-Member -InputObject $port -MemberType NoteProperty -Name ProcessName -Value $(Get-Process -Id $port.Pid).Name
        $ports += $port
    }
    $ports
}