function Deux{
    foreach($service in Get-Content C:\Users\Antoine\Desktop\listservice.txt){
        if($service -match $regex){
            $servicecheck = Get-Service -Name $service
            foreach ($element in $machine){
                if(!(Test-Connection -ComputerName $element -Count 1 -Quiet)){
                    write-host "Server is offline"
                    $Subject2 = $element + " is offline" 
    				$Body2 = "Problem : " + $Date + " of the server is offline"
                    Send-MailMessage -From $From -to $To -Subject $Subject2 -Body $Body2 -SmtpServer $SMTPServer -Port $SMTPPort -UseSsl -Credential $cred
                }
                else{
                    if (Get-Service $service -ErrorAction SilentlyContinue -ComputerName $element){
                        if($servicecheck.status -eq "Stopped"){
                            write-host "Service not started"
                            $Subject = $element + " Service : " + $servicecheck + " is " + $servicecheck.status
    						$Body = "Problem : " + $Date + " of the service " + $service + "is" + $servicecheck.status
                            Send-MailMessage -From $From -to $To -Subject $Subject -Body $Body -SmtpServer $SMTPServer -Port $SMTPPort -UseSsl -Credential $cred
                        }
                    }
                    else{
                        write-host "$service not found"
                        $Subject3 = $element + " Service is not found"
    					$Body3 = "Problem : " + $Date + " of the service " + $service + " is not found"
                        Send-MailMessage -From $From -to $To -Subject $Subject3 -Body $Body3 -SmtpServer $SMTPServer -Port $SMTPPort -UseSsl -Credential $cred
                    }
                }
            }
        }
    }
}

$servicecheck = Get-Service -Name $service

$machine = @("192.168.0.25","192.168.0.35","192.168.0.40","192.168.0.41","192.168.0.42")

$From = "mail@mail.com"
$To = "mail@mail.com"
$username = "mail@mail.com"
$password = Get-Content "C:\Users\Antoine\Desktop\securestring.txt" | ConvertTo-SecureString -AsPlainText -Force
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username, $password
$SMTPServer = "outlook.office365.com"
$SMTPPort = "587"
$Date = get-date

Deux