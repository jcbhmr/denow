set "owd=%CD%"
set "twd=%TEMP%\%RANDOM%"
mkdir "%twd%"
cd "%twd%"

type deno_wrapper.sh | sh -s 1.30.0
if not exist denow exit /b 1
if not exist denow.bat exit /b 1

for /f %%i in ('denow eval "console.log(Deno.version.deno)"') do set "v=%%i"
if "%v%" neq "1.30.0" exit /b 1
if not exist .deno exit /b 1
