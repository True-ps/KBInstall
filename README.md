# KBInstall
Installs KB5001567 on x64 Servers and Win 10 Workstations.

KB500156 was released for 2004 and 20H2 OS versions only. 19401, respectively 19402.

1. The script first detects the OS version, then if it is a Server or Workstation.
2. Downloads the appropriate patch from the Catalog
https://www.catalog.update.microsoft.com/Search.aspx?q=KB5001567
3. Extracts the required .cab file from the .msu package
4. Deploys the Patch using DISM /Online - note that the patch requires a reboot in order to complete and DISM was configured to run silently and not reboot.


