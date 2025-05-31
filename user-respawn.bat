@echo off
setlocal enabledelayedexpansion
cls

echo.
echo ============================================================
echo =                  USER RESPAWN - @SoCal_IT                =
echo ============================================================
echo =   Reviving user profiles with precision and speed...     =
echo =   Source: userdump backup folders                        =
echo =   Compatible: Windows 11                                =
echo ============================================================
echo.

pause
cls

:ask_backup_root
echo Where is the backup stored?
echo ------------------------------------------------------------
echo Example: E:\         or     \\Server\Share
echo (The script will automatically look inside \User_files_backup)
echo.
set /p "root_input=Enter the drive or share path: "
set "backup_root=%root_input%\User_files_backup"

if not exist "%backup_root%" (
    echo ERROR: %backup_root% does not exist. Try again.
    echo.
    goto ask_backup_root
)

set /a user_index=0
set "user_choice="
echo.
echo Available Users:
for /f "delims=" %%u in ('dir /b /ad "%backup_root%"') do (
    set /a user_index+=1
    set "user_!user_index!=%%u"
    echo   !user_index!. %%u
)

set /p "user_choice=Select a user by number: "
if not defined user_%user_choice% (
    echo Invalid choice.
    goto ask_backup_root
)
set "username=!user_%user_choice%!"

set /a pc_index=0
set "pc_choice="
echo.
echo Available backups for user "%username%":
for /f "delims=" %%p in ('dir /b /ad "%backup_root%\%username%"') do (
    set /a pc_index+=1
    set "pc_!pc_index!=%%p"
    echo   !pc_index!. %%p
)

set /p "pc_choice=Select a machine by number: "
if not defined pc_%pc_choice% (
    echo Invalid choice.
    goto ask_backup_root
)
set "machinename=!pc_%pc_choice%!"

set "backup_path=%backup_root%\%username%\%machinename%"

echo.
echo Default restore target: %USERPROFILE%
set /p "restore_target=Enter target folder (leave blank for %USERPROFILE%) : "
if "%restore_target%"=="" set "restore_target=%USERPROFILE%"

echo.
echo ------------------------------------------------------------
echo Restoring backup from:
echo   %backup_path%
echo To:
echo   %restore_target%
echo ------------------------------------------------------------
echo.
pause

robocopy "%backup_path%" "%restore_target%" /E /COPY:DAT /R:3 /W:5 /NFL /NDL

set "errorlevel=%ERRORLEVEL%"
if %errorlevel% LSS 8 (
    echo.
    echo --------------- Restore Complete ---------------------------
    echo Files restored to: %restore_target%
) else (
    echo.
    echo ERROR: Robocopy failed with exit code %errorlevel%
)

pause
endlocal