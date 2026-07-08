@echo off
::==============================================================================
:: VERITAS
:: Variable Extraction & Reliable Inspection Tool for Android Systems
::------------------------------------------------------------------------------
:: File      : Engine\utilities.cmd
:: Purpose   : Common utility library
:: Author    : OTiDO2010
:: Revision  : 3
:: Status    : REVIEW
::==============================================================================

if "%~1"=="" exit /b 1

set "VT_ACTION=%~1"
shift

if /I "%VT_ACTION%"=="VERSION"            goto :VT_VERSION
if /I "%VT_ACTION%"=="FILEEXISTS"         goto :VT_FILEEXISTS
if /I "%VT_ACTION%"=="DIRECTORYEXISTS"    goto :VT_DIRECTORYEXISTS
if /I "%VT_ACTION%"=="CREATEDIRECTORY"    goto :VT_CREATEDIRECTORY
if /I "%VT_ACTION%"=="NORMALIZEPATH"      goto :VT_NORMALIZEPATH
if /I "%VT_ACTION%"=="GETROOTPATH"        goto :VT_GETROOTPATH
if /I "%VT_ACTION%"=="GETFILESIZE"        goto :VT_GETFILESIZE
if /I "%VT_ACTION%"=="GETDATE"            goto :VT_GETDATE
if /I "%VT_ACTION%"=="GETTIME"            goto :VT_GETTIME
if /I "%VT_ACTION%"=="GETTIMESTAMP"       goto :VT_GETTIMESTAMP
if /I "%VT_ACTION%"=="GENERATELOGNAME"    goto :VT_GENERATELOGNAME
if /I "%VT_ACTION%"=="TRIM"               goto :VT_TRIM
if /I "%VT_ACTION%"=="STRLEN"             goto :VT_STRLEN
if /I "%VT_ACTION%"=="REPEATCHAR"         goto :VT_REPEATCHAR
if /I "%VT_ACTION%"=="CENTERTEXT"         goto :VT_CENTERTEXT
if /I "%VT_ACTION%"=="UPPER"              goto :VT_UPPER
if /I "%VT_ACTION%"=="LOWER"              goto :VT_LOWER
if /I "%VT_ACTION%"=="ISADMIN"            goto :VT_ISADMIN
if /I "%VT_ACTION%"=="GETARCH"            goto :VT_GETARCH
if /I "%VT_ACTION%"=="GETWINDOWSVERSION"  goto :VT_GETWINDOWSVERSION
if /I "%VT_ACTION%"=="ISANSIAVAILABLE"    goto :VT_ISANSIAVAILABLE

exit /b 1

::==============================================================================
:VT_VERSION

echo VERITAS Utilities API 1.0

exit /b 0

::==============================================================================
:VT_FILEEXISTS
::
:: %1 File
:: %2 Return Variable
::

if "%~2"=="" exit /b 10

if exist "%~1" (
    set "%~2=True"
    exit /b 0
)

set "%~2=False"
exit /b 1

::==============================================================================
:VT_DIRECTORYEXISTS
::
:: %1 Directory
:: %2 Return Variable
::

if "%~2"=="" exit /b 10

if exist "%~1\" (
    set "%~2=True"
    exit /b 0
)

set "%~2=False"
exit /b 1

::==============================================================================
:VT_CREATEDIRECTORY
::
:: %1 Directory
::

if "%~1"=="" exit /b 10

if not exist "%~1\" md "%~1" >nul 2>&1

if exist "%~1\" exit /b 0

exit /b 1

::==============================================================================
:VT_NORMALIZEPATH
::
:: %1 Path
:: %2 Return Variable
::

if "%~2"=="" exit /b 10

for %%I in ("%~1") do set "%~2=%%~fI"

exit /b 0

::==============================================================================
:VT_GETROOTPATH
::
:: %1 Return Variable
::

if "%~1"=="" exit /b 10

for %%I in ("%~dp0\..") do set "%~1=%%~fI"

exit /b 0

::==============================================================================
:VT_GETFILESIZE
::
:: %1 File
:: %2 Return Variable
::

if "%~2"=="" exit /b 10

if not exist "%~1" exit /b 1

for %%I in ("%~1") do set "%~2=%%~zI"

exit /b 0

::==============================================================================
:VT_GETDATE
::
:: %1 Return Variable
::

if "%~1"=="" exit /b 10

for /f %%I in ('
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -Command ^
"(Get-Date).ToString('yyyy-MM-dd')"
') do (
    set "%~1=%%I"
)

exit /b 0
::==============================================================================
:VT_GETTIME
::
:: %1 Return Variable
::

if "%~1"=="" exit /b 10

for /f %%I in ('
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -Command ^
"(Get-Date).ToString('HH-mm-ss')"
') do (
    set "%~1=%%I"
)

exit /b 0

::==============================================================================
:VT_GETTIMESTAMP
::
:: %1 Return Variable
::

if "%~1"=="" exit /b 10

for /f %%I in ('
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -Command ^
"(Get-Date).ToString('yyyy-MM-dd_HH-mm-ss')"
') do (
    set "%~1=%%I"
)

exit /b 0

::==============================================================================
:VT_GENERATELOGNAME
::
:: %1 Model
:: %2 IMEI
:: %3 Return Variable
::

if "%~3"=="" exit /b 10

setlocal EnableDelayedExpansion

set "_Model=%~1"
set "_IMEI=%~2"

if not defined _Model set "_Model=UnknownModel"
if not defined _IMEI  set "_IMEI=UnknownIMEI"

for /f %%I in ('
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -Command ^
"(Get-Date).ToString('yyyy-MM-dd_HH-mm-ss')"
') do (
    set "_Stamp=%%I"
)

set "_Name=%_Model%_%_IMEI%_%_Stamp%.log"

for %%C in (\ / : * ? ^< ^> ^| ") do (
    set "_Name=!_Name:%%~C=_!"
)

endlocal & set "%~3=%_Name%"

exit /b 0

::==============================================================================
:VT_TRIM
::
:: %1 String
:: %2 Return Variable
::

if "%~2"=="" exit /b 10

setlocal EnableDelayedExpansion

set "_Text=%~1"

:VT_TRIM_LEFT

if defined _Text (
    if "!_Text:~0,1!"==" " (
        set "_Text=!_Text:~1!"
        goto :VT_TRIM_LEFT
    )
)

:VT_TRIM_RIGHT

if defined _Text (
    if "!_Text:~-1!"==" " (
        set "_Text=!_Text:~0,-1!"
        goto :VT_TRIM_RIGHT
    )
)

endlocal & set "%~2=%_Text%"

exit /b 0

::==============================================================================
:VT_STRLEN
::
:: %1 String
:: %2 Return Variable
::

if "%~2"=="" exit /b 10

setlocal EnableDelayedExpansion

set "_Text=%~1"
set /a "_Len=0"

:VT_STRLEN_LOOP

if defined _Text (
    set "_Text=!_Text:~1!"
    set /a "_Len+=1"
    goto :VT_STRLEN_LOOP
)

endlocal & set "%~2=%_Len%"

exit /b 0
::==============================================================================
:VT_REPEATCHAR
::
:: %1 Character
:: %2 Count
:: %3 Return Variable
::

if "%~3"=="" exit /b 10

setlocal EnableDelayedExpansion

set "_Char=%~1"
set "_Count=%~2"

if not defined _Char set "_Char=-"
if not defined _Count set "_Count=1"

set "_Result="

for /L %%I in (1,1,%_Count%) do (
    set "_Result=!_Result!!_Char!"
)

endlocal & set "%~3=%_Result%"

exit /b 0

::==============================================================================
:VT_CENTERTEXT
::
:: %1 Width
:: %2 Text
:: %3 Return Variable
::

if "%~3"=="" exit /b 10

setlocal EnableDelayedExpansion

set "_Width=%~1"
set "_Text=%~2"

if not defined _Width set "_Width=80"

call :VT_STRLEN "%_Text%" _Length

set /a "_Padding=(%_Width%-_Length)/2"

if %_Padding% LSS 0 set "_Padding=0"

call :VT_REPEATCHAR " " %_Padding% _Spaces

set "_Result=!_Spaces!!_Text!"

endlocal & set "%~3=%_Result%"

exit /b 0

::==============================================================================
:VT_UPPER
::
:: %1 String
:: %2 Return Variable
::

if "%~2"=="" exit /b 10

setlocal EnableDelayedExpansion

set "_Text=%~1"

for %%A in (
a=A b=B c=C d=D e=E f=F g=G h=H i=I j=J
k=K l=L m=M n=N o=O p=P q=Q r=R s=S t=T
u=U v=V w=W x=X y=Y z=Z
) do (
    for /f "tokens=1,2 delims==" %%B in ("%%A") do (
        set "_Text=!_Text:%%B=%%C!"
    )
)

endlocal & set "%~2=%_Text%"

exit /b 0

::==============================================================================
:VT_LOWER
::
:: %1 String
:: %2 Return Variable
::

if "%~2"=="" exit /b 10

setlocal EnableDelayedExpansion

set "_Text=%~1"

for %%A in (
A=a B=b C=c D=d E=e F=f G=g H=h I=i J=j
K=k L=l M=m N=n O=o P=p Q=q R=r S=s T=t
U=u V=v W=w X=x Y=y Z=z
) do (
    for /f "tokens=1,2 delims==" %%B in ("%%A") do (
        set "_Text=!_Text:%%B=%%C!"
    )
)

endlocal & set "%~2=%_Text%"

exit /b 0
::==============================================================================
:VT_ISADMIN
::
:: %1 Return Variable
::

if "%~1"=="" exit /b 10

fltmc >nul 2>&1

if %ERRORLEVEL% EQU 0 (
    set "%~1=True"
) else (
    set "%~1=False"
)

exit /b 0
::==============================================================================
:VT_GETARCH
::
:: %1 Return Variable
::

if "%~1"=="" exit /b 10

if /I "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    set "%~1=x64"
    exit /b 0
)

if /I "%PROCESSOR_ARCHITECTURE%"=="ARM64" (
    set "%~1=ARM64"
    exit /b 0
)

set "%~1=x86"

exit /b 0

::==============================================================================
:VT_GETWINDOWSVERSION
::
:: %1 Return Variable
::

if "%~1"=="" exit /b 10

for /f "usebackq delims=" %%I in (`
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -Command ^
"(Get-CimInstance Win32_OperatingSystem).Caption"
`) do (
    set "%~1=%%I"
)

exit /b 0

::==============================================================================
:VT_ISANSIAVAILABLE
::
:: %1 Return Variable
::

if "%~1"=="" exit /b 10

for /f %%I in ('
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -Command ^
"$PSVersionTable.PSVersion.Major"
') do (
    set "_PS=%%I"
)

if not defined _PS (
    set "%~1=False"
    exit /b 0
)

if %_PS% GEQ 5 (
    set "%~1=True"
) else (
    set "%~1=False"
)

exit /b 0

::==============================================================================
:EOF

exit /b 0
::==============================================================================
:: Internal Functions
::==============================================================================

:VT_POWERSHELL
::
:: %1 Command
:: %2 Return Variable
::
:: Internal helper.
::

if "%~2"=="" exit /b 10

setlocal

set "_Result="

for /f "usebackq delims=" %%I in (`
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -Command "%~1"
`) do (
    set "_Result=%%I"
)

endlocal & set "%~2=%_Result%"

exit /b 0

::==============================================================================
:VT_SANITIZEFILENAME
::
:: %1 String
:: %2 Return Variable
::

if "%~2"=="" exit /b 10

setlocal EnableDelayedExpansion

set "_Text=%~1"

for %%C in (\ / : * ? ^< ^> ^| ") do (
    set "_Text=!_Text:%%~C=_!"
)

set "_Text=!_Text: =_!"

:VT_DOUBLE_UNDERSCORE

set "_New=!_Text:__=_!"

if "!_New!"=="!_Text!" goto VT_SANITIZE_DONE

set "_Text=!_New!"
goto VT_DOUBLE_UNDERSCORE

:VT_SANITIZE_DONE

endlocal & set "%~2=%_Text%"

exit /b 0

::==============================================================================
:VT_BOOLTOSTRING
::
:: %1 Value
:: %2 Return Variable
::

if "%~2"=="" exit /b 10

if /I "%~1"=="True" (
    set "%~2=YES"
    exit /b 0
)

if /I "%~1"=="False" (
    set "%~2=NO"
    exit /b 0
)

set "%~2=UNKNOWN"

exit /b 0

::==============================================================================
:VT_GETSCRIPTDIR
::
:: %1 Return Variable
::

if "%~1"=="" exit /b 10

set "%~1=%~dp0"

exit /b 0

::==============================================================================
:VT_GETPROJECTROOT
::
:: %1 Return Variable
::

if "%~1"=="" exit /b 10

for %%I in ("%~dp0..") do (
    set "%~1=%%~fI"
)

exit /b 0

::==============================================================================
:EOF

exit /b 0
