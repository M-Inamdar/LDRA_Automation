@echo off
REM Set TCF directories to the provided paths with quotes
SET "TCF_ROOT=D:\LDRA\directories"
SET "TCF_ROOT1=D:\LDRA\directories"

REM Set LDRA Tool Suite path to Conunit Application
SET "LDRA_APP=C:\Program Files\LDRA\LDRAunit_C_CPP_9.8.6\Conunit"

REM Define log file path and name
SET "LOG_FILE=D:\Command_Line\ldra_execution_log.txt"

REM Start logging
echo LDRA TCF execution started at %date% %time% > "%LOG_FILE%"

REM Function to execute a TCF file
:execute_tcf
REM Parameters: %1 - TCF File
echo Executing: %1 at %date% %time% >> "%LOG_FILE%"
"%LDRA_APP%" "%~1" /run /quit >> "%LOG_FILE%" 2>&1

REM Check for errors
IF %ERRORLEVEL% NEQ 0 (
    echo Error: Execution of %1 failed with error code %ERRORLEVEL%. Check the log file for details. >> "%LOG_FILE%"
) ELSE (
    echo Success: Execution of %1 completed successfully at %date% %time%. >> "%LOG_FILE%"
)
exit /b

REM Execute TCF files in the first directory
echo Running TCF files in %TCF_ROOT% >> "%LOG_FILE%"
for %%i in ("%TCF_ROOT%\*.tcf") do (
    echo Starting parallel execution for %%i >> "%LOG_FILE%"
    start "" cmd /c call :execute_tcf "%%i"
)

REM Execute TCF files in the second directory
echo Running TCF files in %TCF_ROOT1% >> "%LOG_FILE%"
for %%i in ("%TCF_ROOT1%\*.tcf") do (
    echo Starting parallel execution for %%i >> "%LOG_FILE%"
    start "" cmd /c call :execute_tcf "%%i"
)

REM Wait for all parallel tasks to complete by checking the log size
:wait_for_completion
REM Check if all tasks have finished by monitoring the log file size
set prev_size=0
set curr_size=1
echo Waiting for all tasks to complete... >> "%LOG_FILE%"
REM Loop until the log file size stops increasing
:check_log_size
for %%A in ("%LOG_FILE%") do set curr_size=%%~zA
IF %curr_size% NEQ %prev_size% (
    set prev_size=%curr_size%
    timeout /t 5 >nul
    goto check_log_size
)

echo All tasks completed at %date% %time%. >> "%LOG_FILE%"

REM End of script
echo LDRA TCF execution completed at %date% %time% >> "%LOG_FILE%"
pause
