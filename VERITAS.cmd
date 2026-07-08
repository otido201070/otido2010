@echo off
:: =============================================================================
:: Project : VERITAS
:: File    : VERITAS.cmd
:: Module  : Application Entry Point
::
:: Variable Extraction & Reliable Inspection Tool for Android Systems
:: Truth Inside Every Device
::
:: Author  : OTiDO2010
:: Version : 0.1.0 Alpha
:: Build   : 0001
::
:: Copyright (c) 2026
:: =============================================================================

setlocal EnableExtensions EnableDelayedExpansion

:: -----------------------------------------------------------------------------
:: Save startup directory
:: -----------------------------------------------------------------------------

set "VERITAS_ROOT=%~dp0"

:: Remove trailing slash

if "%VERITAS_ROOT:~-1%"=="\" (
    set "VERITAS_ROOT=%VERITAS_ROOT:~0,-1%"
)

cd /d "%VERITAS_ROOT%"

:: -----------------------------------------------------------------------------
:: Console configuration
:: -----------------------------------------------------------------------------

title VERITAS - Truth Inside Every Device

mode con: cols=100 lines=35 >nul 2>&1

:: UTF-8 (ignored on unsupported systems)

chcp 65001 >nul 2>&1

:: -----------------------------------------------------------------------------
:: Create required folders
:: -----------------------------------------------------------------------------

call :CreateDirectory Logs
call :CreateDirectory Reports
call :CreateDirectory Temp
call :CreateDirectory Backup

:: -----------------------------------------------------------------------------
:: Check Core Engine
:: -----------------------------------------------------------------------------

if not exist "Core\engine.cmd" (
    echo.
    echo ================================================================
    echo  VERITAS
    echo ================================================================
    echo.
    echo [FAIL] Core\engine.cmd not found.
    echo.
    echo VERITAS cannot continue.
    echo.
    pause
    exit /b 1001
)

:: -----------------------------------------------------------------------------
:: Start Core Engine
:: -----------------------------------------------------------------------------

call "Core\engine.cmd"

exit /b %ERRORLEVEL%

:: =============================================================================
:: FUNCTIONS
:: =============================================================================

:CreateDirectory

if not exist "%~1" (
    mkdir "%~1" >nul 2>&1
)

exit /b 0