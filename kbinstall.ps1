$srv_2004 = "http://download.windowsupdate.com/d/msdownload/update/software/updt/2021/03/windows10.0-kb5001567-x64_e3c7e1cb6fa3857b5b0c8cf487e7e16213b1ea83.msu"
$srv_20h2 = "http://download.windowsupdate.com/d/msdownload/update/software/updt/2021/03/windows10.0-kb5001567-x64_e3c7e1cb6fa3857b5b0c8cf487e7e16213b1ea83.msu"
$wks_2004 = "http://download.windowsupdate.com/d/msdownload/update/software/updt/2021/03/windows10.0-kb5001567-x64_e3c7e1cb6fa3857b5b0c8cf487e7e16213b1ea83.msu"
$wks_20h2 = "http://download.windowsupdate.com/d/msdownload/update/software/updt/2021/03/windows10.0-kb5001567-x64_e3c7e1cb6fa3857b5b0c8cf487e7e16213b1ea83.msu"

$tempdir = "c:\Temp-Wu"
if ((Test-Path $tempdir) -eq $false )

{
New-Item -ItemType 'directory' $tempdir
}



Import-Module BitsTransfer


$osver = Get-WmiObject win32_operatingsystem

function install($kb) {

Start-BitsTransfer $kb $tempdir

Set-Location $tempdir

expand -F:* .\* .\

$wuloc = Get-Item *x64*.cab

dism /online /add-package /packagepath:$($wuloc.FullName) /quiet /norestart 

Set-Location ..

Remove-Item -Recurse $tempdir

}

if ($osver.ProductType -eq "1")
{
    "Product is a Workstation"

    if ($osver.BuildNumber -eq "19042")


    {

      Write-Output  "Workstation is windows 10 version 20h2. Build number $($osver.BuildNumber). Proceeding to install KB..."
      $kb = $wks_20h2
      install -kb $kb
    

    }
    elseif ($osver.BuildNumber -eq "19041")
    {

      Write-Output  "Workstation is windows 10 version 2004. Build number $($osver.BuildNumber)"
    $kb = $wks_2004
    install -kb 
    }

    else 
    {Write-Output "Workstation is not compatible with the target update file. Please consult your manual! $($OSver.buildnumber)"}

 
}
elseif ($osver.ProductType -eq "3")

{
Write-Host "Product is a Server"
    
    if ($osver.BuildNumber -eq "19042")


    {

      Write-Output  "Server is windows 10 version 20h2. Build number $($osver.BuildNumber)"
      $kb = $srv_20h2
      install -kb $kb
    }
    elseif ($osver.BuildNumber -eq "19041")
    {

       Write-Output "Server is version 2004. Build number $($osver.BuildNumber)"
       $kb = $srv_2004
       install -kb $kb
    }

    else 
    {Write-Output "Server is not compatible with the target update file. Please consult your manual! Build Number $($OSver.buildnumber)"}

}
