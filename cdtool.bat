@echo off

if "%1"=="show-all" (
    echo Usage: cdtool [alias]
    echo.
    echo Available aliases:
    echo   personal   -^>  C:\piyush-work\personal
    echo   company   -^>  C:\piyush-work\company
    goto :eof
)


if /i "%1"=="personal" (
    cd /d "C:\piyush-work\personal"
    echo Switched to: %CD%
    goto :eof
)

if /i "%1"=="company" (
    cd /d "C:\piyush-work\company\projects"
    echo Switched to: %CD%
    goto :eof
)

echo Unknown alias: "%1"
echo Run "cdtool" with no arguments to see available aliases.