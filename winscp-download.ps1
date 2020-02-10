function get-file-qmft{
    Set-Location D:\obsecure\bin\WinSCP-5.15.3-Automation\ #winscp files location
    try
    {
        # Load WinSCP .NET assembly
        Add-Type -Path "WinSCPnet.dll"
     
        # Setup session options
        $sessionOptions = New-Object WinSCP.SessionOptions -Property @{
            Protocol = [WinSCP.Protocol]::Sftp
            HostName = "Please enter you sftp endpoint here"
            UserName = "please enter the username here"
            Password = "plewase enter the password here"
            SshHostKeyFingerprint = "copy paste the ssh-rsa fingerprint here"
        }
     
        $session = New-Object WinSCP.Session
     
        try
        {
            # Connect
            $session.Open($sessionOptions)
     
            # Download files
            $transferOptions = New-Object WinSCP.TransferOptions
            $transferOptions.TransferMode = [WinSCP.TransferMode]::Binary
     
            $transferResult =
                $session.GetFiles("please enter the directory location on the server", "enter the local location here", $False, $transferOptions)
     
            # Throw on any error
            $transferResult.Check()
     
            # Print results
            foreach ($transfer in $transferResult.Transfers)
            {
                Write-Host "Download of $($transfer.FileName) succeeded"
            }
        }
        finally
        {
            # Disconnect, clean up
            $session.Dispose()
        }
    }
    catch
    {
        Write-Host "Error: $($_.Exception.Message)"
    
    }
}