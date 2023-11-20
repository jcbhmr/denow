@echo off
setlocal enabledelayedexpansion

set "deno_version=%DENO_VERSION%"

:: Get the script directory
set "dir=%~dp0"
set "dir=!dir:~0,-1!"

:: Check if .deno directory exists
if not exist "!dir!\.deno" (
    :: Download and install Deno
    set "install_cmd=curl -fsSL https://deno.land/install.ps1 | $env:DENO_INSTALL=""!dir!\.deno"" powershell -"
    for /f "tokens=* delims=" %%i in ('%install_cmd% v%deno_version%') do set "output=%%i"
    if not !errorlevel! equ 0 (
        echo !output!
        exit /b 1
    )
)

:: Execute the Deno script
"%dir%\.deno\bin\deno.exe" %*
