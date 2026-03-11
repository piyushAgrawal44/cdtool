@echo off
:: cdtool v2
setlocal enabledelayedexpansion

:: ─────────────────────────────────────────────
::  cdtool – Smart directory switcher
::  Aliases stored in cdtool_aliases.cfg
:: ─────────────────────────────────────────────

set CONFIG_FILE=%~dp0cdtool_aliases.cfg

:: ── Create config file if it doesn't exist ──
if not exist "%CONFIG_FILE%" (
    type nul > "%CONFIG_FILE%"
    echo [cdtool] Config created at %CONFIG_FILE%
    echo.
)

:: ── No arguments → show help ──
if "%~1"=="" goto :show_help

:: ── Route to sub-commands ──
if /i "%~1"=="set-new" goto :cmd_set_new
if /i "%~1"=="remove"  goto :cmd_remove
if /i "%~1"=="update"  goto :cmd_update
if /i "%~1"=="list"    goto :show_help

:: ── Otherwise treat as alias to cd into ──
goto :cmd_cd


:: ════════════════════════════════════════════
:show_help
:: ════════════════════════════════════════════
echo.
echo  cdtool v2
echo.
echo  Usage:
echo    cdtool ^<alias^>                       - cd into alias path
echo    cdtool list                           - show all aliases
echo    cdtool set-new ^<alias^> ^<path^>        - add a new alias
echo    cdtool remove  ^<alias^>                - delete an alias
echo    cdtool update  ^<alias^> ^<path^>        - change an alias path
echo.
echo  Available aliases:

for /f "usebackq tokens=1,* delims==" %%A in ("%CONFIG_FILE%") do (
    echo    %%A  -^>  %%B
)

echo.
goto :eof


:: ════════════════════════════════════════════
:cmd_cd
:: ════════════════════════════════════════════
set _ALIAS=%~1
set _FOUND_PATH=

for /f "usebackq tokens=1,* delims==" %%A in ("%CONFIG_FILE%") do (
    if /i "%%A"=="!_ALIAS!" set _FOUND_PATH=%%B
)

if not "!_FOUND_PATH!"=="" (
     if exist "!_FOUND_PATH!" (
        endlocal & cd /d "%_FOUND_PATH%"
        echo [cdtool] Switched to: "%_FOUND_PATH%"
    ) else (
        echo [cdtool] Path does not exist: !_FOUND_PATH!
    )
) else (
    echo [cdtool] Unknown alias: "!_ALIAS!"
    echo          Run "cdtool list" to see available aliases.
)
goto :eof


:: ════════════════════════════════════════════
:parse_alias_path
:: Parses alias/path arguments
:: Supports:
::   cdtool set-new myalias C:\path
::   cdtool set-new myalias=C:\path
:: ════════════════════════════════════════════
set _OUT_ALIAS=
set _OUT_PATH=

echo(%~1 | findstr "=" >nul
if !errorlevel! == 0 (
    for /f "tokens=1,* delims==" %%X in ("%~1") do (
        set _OUT_ALIAS=%%X
        set _OUT_PATH=%%Y
    )
) else (
    set _OUT_ALIAS=%~1
    set _OUT_PATH=%~2
)

goto :eof


:: ════════════════════════════════════════════
:cmd_set_new
:: ════════════════════════════════════════════
call :parse_alias_path "%~2" "%~3"

if "!_OUT_ALIAS!"=="" (
    echo [cdtool] Usage: cdtool set-new ^<alias^> ^<path^>
    goto :eof
)

if "!_OUT_PATH!"=="" (
    echo [cdtool] Missing path.
    goto :eof
)

set _EXISTS=
for /f "usebackq tokens=1 delims==" %%A in ("%CONFIG_FILE%") do (
    if /i "%%A"=="!_OUT_ALIAS!" set _EXISTS=1
)

if defined _EXISTS (
    echo [cdtool] Alias "!_OUT_ALIAS!" already exists.
    echo          Use "cdtool update !_OUT_ALIAS! ^<path^>"
    goto :eof
)

echo !_OUT_ALIAS!=!_OUT_PATH!>> "%CONFIG_FILE%"
echo [cdtool] Added: !_OUT_ALIAS!  -^>  !_OUT_PATH!
goto :eof


:: ════════════════════════════════════════════
:cmd_remove
:: ════════════════════════════════════════════
set _RM_ALIAS=%~2

if "!_RM_ALIAS!"=="" (
    echo [cdtool] Usage: cdtool remove ^<alias^>
    goto :eof
)

set _FOUND=
set _TEMP=%CONFIG_FILE%.tmp
if exist "%_TEMP%" del "%_TEMP%"

for /f "usebackq tokens=1,* delims==" %%A in ("%CONFIG_FILE%") do (
    if /i "%%A"=="!_RM_ALIAS!" (
        set _FOUND=1
    ) else (
        echo %%A=%%B>> "%_TEMP%"
    )
)

if defined _FOUND (
    move /y "%_TEMP%" "%CONFIG_FILE%" >nul
    echo [cdtool] Removed alias: !_RM_ALIAS!
) else (
    if exist "%_TEMP%" del "%_TEMP%"
    echo [cdtool] Alias "!_RM_ALIAS!" not found.
)
goto :eof


:: ════════════════════════════════════════════
:cmd_update
:: ════════════════════════════════════════════
call :parse_alias_path "%~2" "%~3"

if "!_OUT_ALIAS!"=="" (
    echo [cdtool] Usage: cdtool update ^<alias^> ^<path^>
    goto :eof
)

if "!_OUT_PATH!"=="" (
    echo [cdtool] Missing path.
    goto :eof
)

set _FOUND=
set _TEMP=%CONFIG_FILE%.tmp
if exist "%_TEMP%" del "%_TEMP%"

for /f "usebackq tokens=1,* delims==" %%A in ("%CONFIG_FILE%") do (
    if /i "%%A"=="!_OUT_ALIAS!" (
        echo !_OUT_ALIAS!=!_OUT_PATH!>> "%_TEMP%"
        set _FOUND=1
    ) else (
        echo %%A=%%B>> "%_TEMP%"
    )
)

if defined _FOUND (
    move /y "%_TEMP%" "%CONFIG_FILE%" >nul
    echo [cdtool] Updated: !_OUT_ALIAS!  -^>  !_OUT_PATH!
) else (
    if exist "%_TEMP%" del "%_TEMP%"
    echo [cdtool] Alias "!_OUT_ALIAS!" not found.
)
goto :eof