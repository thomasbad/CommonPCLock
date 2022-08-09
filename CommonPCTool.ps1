# This tool require administrator right, please allow it to start the tool correctly

if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  
{  
  $arguments = "& '" +$myinvocation.mycommand.definition + "'"
  Start-Process powershell -Verb runAs -ArgumentList $arguments
  Break
}
$host.UI.RawUI.WindowTitle = "Common PC Lock Tool"

function Display-Menu {
    Clear-Host
    Write-Host @'
    
   ___                                        ___  ___  _____            _ 
  / __\___  _ __ ___  _ __ ___   ___  _ __   / _ \/ __\/__   \___   ___ | |
 / /  / _ \| '_ ` _ \| '_ ` _ \ / _ \| '_ \ / /_)/ /     / /\/ _ \ / _ \| |
/ /__| (_) | | | | | | | | | | | (_) | | | / ___/ /___  / / | (_) | (_) | |
\____/\___/|_| |_| |_|_| |_| |_|\___/|_| |_\/   \____/  \/   \___/ \___/|_|
                                                                           

---------------------------------------------------------------------------------

Press 1 - Enable Common PC Group Policy
Press 2 - Disable Common PC Group Policy
Press 3 - Enable Lock Computer button removal
Press 4 - Diable Lock Computer button removal
Press 5 - Enable Common PC Group Policy and remove lock computer button
Press 6 - Disable Common PC Group Policy and add back lock computer button
Press 0 - Exit the tool

---------------------------------------------------------------------------------


'@
Choice-Forward
}

function Choice-Forward {
    $Choice = Read-Host -Prompt 'Input your selection'
    switch -Exact ($Choice)
    {
        '1' {
            Clear-Host
            Enable-CGP
            '===================COMPLETED==================='
            '-----------------------------------------------'
            '         Common PC Group Policy enabled        '
            '   Please reboot the PC to activate the change '
            '-----------------------------------------------'
            ' =============PRESS ANY KEY TO EXIT============'
            Exit
            }
        '2' {
            Clear-Host
            Disable-CGP
            '===================COMPLETED==================='
            '-----------------------------------------------'
            '         Common PC Group Policy disabled       '
            '   Please reboot the PC to activate the change '
            '-----------------------------------------------'
            ' =============PRESS ANY KEY TO EXIT============'
            Exit
            }
        '3' {
            Clear-Host
            Enable-LockButton-Removal
            '===================COMPLETED==================='
            '-----------------------------------------------'
            '          Lock Computer button removed         '
            '   Please reboot the PC to activate the change '
            '-----------------------------------------------'
            ' =============PRESS ANY KEY TO EXIT============'
            Exit
            }
        '4' {
            Clear-Host
            Disable-LockButton-Removal
            '===================COMPLETED==================='
            '-----------------------------------------------'
            '           Lock Computer button Added          '
            '   Please reboot the PC to activate the change '
            '-----------------------------------------------'
            ' =============PRESS ANY KEY TO EXIT============'
            Exit
            }
        '5' {
            Clear-Host
            Enable-CGP
            Enable-LockButton-Removal
            '======================COMPLETED========================'
            '-------------------------------------------------------'
            ' Common PC Group Policy enabled and Lock button removed'
            '       Please reboot the PC to activate the change '
            '-------------------------------------------------------'
            ' =================PRESS ANY KEY TO EXIT================'
            Exit
            }
        '6' {
            Clear-Host
            Disable-CGP
            Disable-LockButton-Removal
            '======================COMPLETED========================'
            '-------------------------------------------------------'
            ' Common PC Group Policy disabled and Lock button added '
            '       Please reboot the PC to activate the change '
            '-------------------------------------------------------'
            ' =================PRESS ANY KEY TO EXIT================'
            Exit
            }
         '0' {
              Exit
             }
        default {
                 Write-Warning '============INVALID INPUT============'
                 Write-Warning '-------------------------------------'
                 Write-Warning 'Please select a number from the Main'
                 Write-Warning 'Menu [1 - 6], or select [0] to quit.'
                 Write-Warning '-------------------------------------'
                 Write-Warning '======PRESS ANY KEY TO CONTINUE======'
                 Read-Host
                 Clear-host
                 Display-Menu
                }
    }
}

function Enable-CGP {
    #Settings App Visibility setting
    New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "SettingsPageVisibility" -PropertyType String -Value "showonly:sound;about;printers;network-status;yourinfo;workplace;regionlanguage;privacy-webcam;privacy-microphone;windowsupdate" -Force
    #Restrict access to Windows Store without blocking update
    New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsStore" -Name "RemoveWindowsStore" -PropertyType DWord -Value "1" -Force
    #Restrict access to Control Panel and Settings Apps
    New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoControlPanel" -PropertyType DWord -Value "1" -Force
}

function Disable-CGP {
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "SettingsPageVisibility" -Force
    New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsStore" -Name "RemoveWindowsStore" -PropertyType DWord -Value "1" -Force
    New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoControlPanel" -PropertyType DWord -Value "1" -Force
}

function Enable-LockButton-Removal {
    New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name "DisableLockWorkstation" -PropertyType DWord -Value "1" -Force
}

function Disable-LockButton-Removal {
    New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name "DisableLockWorkstation" -PropertyType DWord -Value "0" -Force
}

Display-Menu
