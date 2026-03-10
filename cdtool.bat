@echo off

:: Define project paths
set PERSONAL_PATH=C:\piyush-work\personal
set PORTFOLIO_PATH=C:\piyush-work\personal\my-portfolio

if "%1"=="" (
    echo Usage: cdtool [alias]
    echo.
    echo Available aliases:
    echo personal     -^> %PERSONAL_PATH%
    echo portfolio -^> %PORTFOLIO_PATH%
    goto :eof
)


if /i "%1"=="personal" (
    cd /d "%PERSONAL_PATH%"
    echo Switched to: %PERSONAL_PATH%
    goto :eof
)

if /i "%1"=="portfolio" (
    cd /d "%PORTFOLIO_PATH%"
    echo Switched to: %PORTFOLIO_PATH%
    goto :eof
)

echo Unknown alias: "%1"
echo Run "cdtool" with no arguments to see available aliases.