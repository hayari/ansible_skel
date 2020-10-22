rem allow ping to the host
netsh advfirewall firewall add rule name="ICMP Allow incoming V4 echo request" protocol=icmpv4:8,any dir=in action=allow

rem enable RDP connection to the host
rem enable terminalserver service
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
rem remove NLA authentification
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v SecurityLayer /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication /t REG_DWORD /d 0 /f
rem install chocolatey package manager

@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

rem can use also method in https://docs.ansible.com/ansible/latest/user_guide/windows_setup.html
rem upgrade .Net
rem choco upgrade dotnetfx
rem upgrade powershell
rem choco upgrade powershell
rem install python 
rem choco install -y python --override --installarguments "'/quiet  InstallAllUsers=1 TargetDir=c:\Python'"
rem setx /M path "%PATH%;C:\Python"


