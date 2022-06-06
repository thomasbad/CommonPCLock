ECHO OFF
CLS
Title COMMON PC Lock TOOL
Color 17

:MENU

type Logo.txt
ECHO .
ECHO ...............................................
ECHO PRESS 1, 2, 3 ... or 6 to select your task, or 7 to EXIT.
ECHO Please ensure the tool is run as admin to work.
ECHO ...............................................
ECHO .
ECHO 1 - Enable Common PC Group Policy
:: This will remove the Settings app, Control Panel, Windows Store, and put Hide most of the settings from Setting apps to prevent System apps expolit
ECHO 2 - Disable Common PC Group Policy
ECHO 3 - Enable Lock Computer button removal
ECHO 4 - Diable Lock Computer button removal
ECHO 5 - Enable Common PC Group Policy and remove lock computer button
ECHO 6 - Disable Common PC Group Policy and add back lock computer button
ECHO 7 - Exit the tool
ECHO.
SET INPUT=
SET /P INPUT=Please select a number then press ENTER:
IF /I '%INPUT%'=='1' GOTO ENCGP
IF /I '%INPUT%'=='2' GOTO DISCGP
IF /I '%INPUT%'=='3' GOTO ENLOCKRM
IF /I '%INPUT%'=='4' GOTO DISLOCKRM
IF /I '%INPUT%'=='5' GOTO ENCOMM
IF /I '%INPUT%'=='6' GOTO DISCOMM
IF /I '%INPUT%'=='7' GOTO QUIT

ECHO ============INVALID INPUT============
ECHO -------------------------------------
ECHO Please select a number from the Main
echo Menu [1-6] or select '7' to quit.
ECHO -------------------------------------
ECHO ======PRESS ANY KEY TO CONTINUE======

PAUSE > NUL
GOTO MENU

:ENCGP
CLS
:: Settings App Visibility setting
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V SettingsPageVisibility /T REG_SZ /F /D showonly:sound;about;printers;network-status;yourinfo;workplace;regionlanguage;privacy-webcam;privacy-microphone;windowsupdate
:: Restrict access to Windows Store without blocking update
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsStore" /V RemoveWindowsStore /T REG_DWORD /F /D 1
::Restrict access to Control Panel and Settings Apps
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V NoControlPanel /T REG_DWORD /F /D 1
ECHO ===================COMPLETED===================
ECHO -----------------------------------------------
ECHO Common PC Group Policy enabled
echo Please reboot the PC to activate the change
ECHO -----------------------------------------------
ECHO ===========PRESS ANY KEY TO CONTINUE===========
pause > NUL
cls
GOTO QUIT

:DISCGP
CLS
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V SettingsPageVisibility /F
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsStore" /V RemoveWindowsStore /T REG_DWORD /F /D 0
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V NoControlPanel /T REG_DWORD /F /D 0
ECHO ===================COMPLETED===================
ECHO -----------------------------------------------
ECHO Common PC Group Policy disabled
echo Please reboot the PC to activate the change
ECHO -----------------------------------------------
ECHO ===========PRESS ANY KEY TO CONTINUE===========
pause > NUL
cls
GOTO QUIT

:ENLOCKRM
CLS
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V DisableLockWorkstation /T REG_DWORD /F /D 1
ECHO ===================COMPLETED===================
ECHO -----------------------------------------------
ECHO Lock button have been removed
echo Please reboot the PC to activate the change
ECHO -----------------------------------------------
ECHO ===========PRESS ANY KEY TO CONTINUE===========
pause > NUL
cls
GOTO QUIT

:DISLOCKRM
CLS
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V DisableLockWorkstation /T REG_DWORD /F /D 0
ECHO ===================COMPLETED===================
ECHO -----------------------------------------------
ECHO Lock button have been added
echo Please reboot the PC to activate the change
ECHO -----------------------------------------------
ECHO ===========PRESS ANY KEY TO CONTINUE===========
pause > NUL
cls
GOTO QUIT

:ENCOMM
CLS
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V SettingsPageVisibility /T REG_SZ /F /D showonly:sound;about;printers;network-status;yourinfo;workplace;regionlanguage;privacy-webcam;privacy-microphone;windowsupdate
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsStore" /V RemoveWindowsStore /T REG_DWORD /F /D 1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V NoControlPanel /T REG_DWORD /F /D 1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V DisableLockWorkstation /T REG_DWORD /F /D 1
ECHO ===================COMPLETED===================
ECHO -----------------------------------------------
ECHO Common PC setting enabled
echo Please reboot the PC to activate the change
ECHO -----------------------------------------------
ECHO ===========PRESS ANY KEY TO CONTINUE===========
pause > NUL
cls
GOTO QUIT

:DISCOMM
CLS
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V SettingsPageVisibility /F
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsStore" /V RemoveWindowsStore /T REG_DWORD /F /D 0
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V NoControlPanel /T REG_DWORD /F /D 0
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V DisableLockWorkstation /T REG_DWORD /F /D 0
ECHO ===================COMPLETED===================
ECHO -----------------------------------------------
ECHO Common PC setting disabled
echo Please reboot the PC to activate the change
ECHO -----------------------------------------------
ECHO ===========PRESS ANY KEY TO CONTINUE===========
pause > NUL
cls
GOTO QUIT

:QUIT
EXIT
