@echo off
setlocal enabledelayedexpansion
title Rushi's Robocopy Pro
color 0B
cls

:: ======================================================
:: SECTION: ADMIN CHECK
:: ======================================================
@echo off
net session >nul 2>&1
if errorlevel 1 (
    echo [WARNING] NOT RUNNING AS ADMIN
    echo Option [6] RESUME will fail without Admin rights.
    echo To fix: Right-click this file and 'Run as Administrator'.
) else (
    echo [STATUS] Running as ADMINISTRATOR (Full Access)
)
echo ======================================================
echo           ROBOCOPY PRO (LOGGING ENABLED)
echo ======================================================
echo.

:: 1. Input Section
set /p source="Enter Source Path (e.g. C:\Rushi\backup): "
set /p dest="Enter Destination Path (e.g. D:\Rushi): "

echo.
echo ------------------------------------------------------
echo CHOOSE AN OPERATION:
echo [1] SAFE COPY (Everything, no deletions)
echo [2] MIRROR    (Dest becomes twin of Source - DELETES EXTRA)
echo [3] MOVE      (Transfer to Dest and WIPE Source)
echo [4] DRY RUN   (Test first - No files actually moved)
echo [5] PURGE     (Cleanup: Delete files in Dest not in Source)
echo [6] RESUME    (Best for huge files - REQUIRES ADMIN)
echo ------------------------------------------------------
set /p choice="Enter choice (1-6): "

:: Create a timestamp for the log filename
set "tstamp=%date:~10,4%-%date:~4,2%-%date:~7,2%_%time:~0,2%-%time:~3,2%"
set "tstamp=%tstamp: =0%"

:: Define Base Performance Flags (64 threads)
set "perf=/MT:64 /R:3 /W:5 /V /TS /FP"
set "logfile=Backup_Log_%tstamp%.txt"

:: Handle User Choices
if "%choice%"=="1" set "op=/E %perf%"
if "%choice%"=="2" set "op=/MIR %perf%"
if "%choice%"=="3" set "op=/MOVE /E %perf%"
if "%choice%"=="4" set "op=/E /L /V"
if "%choice%"=="5" set "op=/PURGE /E %perf%"
if "%choice%"=="6" set "op=/E /Z %perf%"

echo.
echo ======================================================
echo LOGGING TO: %logfile%
echo ======================================================
echo.
pause

:: Run the command with Logging (/LOG) and Screen Output (/TEE)
robocopy "%source%" "%dest%" %op% /LOG:"%logfile%" /TEE

echo.
echo ------------------------------------------------------
echo OPERATION COMPLETE.
echo.
echo [CLEANUP] Deleting logs older than 30 days...
forfiles /P "." /M "Backup_Log_*.txt" /D -30 /C "cmd /c del @path" 2>nul
echo ------------------------------------------------------
pause