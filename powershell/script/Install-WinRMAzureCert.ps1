 
 
function InstallWinRMCert($serviceName, $vmname)
{
    $winRMCert = (Get-AzureVM -ServiceName $serviceName -Name $vmname | select -ExpandProperty vm).DefaultWinRMCertificateThumbprint
 
    $AzureX509cert = Get-AzureCertificate -ServiceName $serviceName -Thumbprint $winRMCert -ThumbprintAlgorithm sha1
 
    $certTempFile = [IO.Path]::GetTempFileName()
    $AzureX509cert.Data | Out-File $certTempFile
 
    # Target The Cert That Needs To Be Imported
    $CertToImport = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2 $certTempFile
 
    $store = New-Object System.Security.Cryptography.X509Certificates.X509Store "Root", "LocalMachine"
    $store.Certificates.Count
    $store.Open([System.Security.Cryptography.X509Certificates.OpenFlags]::ReadWrite)
    $store.Add($CertToImport)
    $store.Close()
 
    Remove-Item $certTempFile
}