@ECHO OFF
CLS

:: check if the script is run in elevated mode by trying to redirect output to null and errors to stdout
net session >nul 2>&1
if %errorlevel% == 0 ( goto init ) else ( goto admin_fail )


:init
echo /////////////////////////////////////
echo ///    Running as administrator   ///
echo /////////////////////////////////////
bcdedit /enum {current}

if [%~1] == [] ( goto help ) else ( goto main )

:main
if %1 == on ( bcdedit /set hypervisorlaunchtype Auto ) else ( goto case2 ) 
goto end

:case2
if %1 == off ( bcdedit /set hypervisorlaunchtype Off ) else ( echo nop )
goto end


:help
echo This script turns hyper-v virtualization on or off using bcdedit
echo If the parameter is on, hyper-v, docker and the like can be used
echo If the parameter is off, VMWare can be used, but docker will not run
echo This script requires elevated privileges
echo Enter a parameter on to turn hypervisor on/off
echo Enter off to turn hypervisor off

:admin_fail
echo Elevation required

:end
echo /////////////////////////////////////
echo /////       Script ends         /////
echo /////////////////////////////////////
if [%~2] == [] ( shutdown -r -t 0 )

