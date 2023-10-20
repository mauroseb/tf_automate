<powershell>
## Set up WinRM
winrm quickconfig -q
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="1024"}'
winrm set winrm/config '@{MaxTimeoutms="1800000"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
netsh advfirewall firewall add rule name="WinRM 5985" protocol=TCP dir=in localport=5985 action=allow
netsh advfirewall firewall add rule name="WinRM 5986" protocol=TCP dir=in localport=5986 action=allow
net stop winrm
sc.exe config winrm start=auto
net start winrm

## Download the Chef Infra Client
$clientURL = "https://packages.chef.io/files/stable/chef/12.19.36/windows/2012/chef-client-<version-here>.msi"
$clientDestination = "C:\chef-client.msi"
Invoke-WebRequest $clientURL -OutFile $clientDestination

## Install the Chef Infra Client
Start-Process msiexec.exe -ArgumentList @('/qn', '/lv C:\Windows\Temp\chef-log.txt', '/i C:\chef-client.msi', 'ADDLOCAL="ChefClientFeature,ChefSchTaskFeature,ChefPSModuleFeature"') -Wait

## Create first-boot.json
$firstboot = @{
    "run_list" = @("role[base]")
}
Set-Content -Path c:\chef\first-boot.json -Value ($firstboot | ConvertTo-Json -Depth 10)
 
## Create client.rb
$nodeName = "win-{0}" -f (-join ((65..90) + (97..122) | Get-Random -Count 8 | % {[char]$_}))

$clientrb = @"
chef_server_url        'https://automate.${env_name}/organizations/testorg'
validation_client_name 'validator'
validation_key         'C:\chef\validator.pem'
node_name              '{0}'
"@ -f $nodeName
Set-Content -Path c:\chef\client.rb -Value $clientrb

## Run Chef
C:\opscode\chef\bin\chef-client.bat -j C:\chef\first-boot.json

</powershell>