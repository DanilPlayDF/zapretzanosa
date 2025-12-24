:: WSCSVC_Fix_v0.1
:: Сделано Dronatar.

:: Ссылка на обсуждение: https://github.com/Flowseal/zapret-discord-youtube/discussions/3797

@echo off
title %~n0

if "%1"=="admin" (
    @echo off
) else (
    chcp 1251 >nul
    echo Требуются права администратора...
    powershell -Command "Start-Process 'cmd.exe' -ArgumentList '/c \"\"%~f0\" admin\"' -Verb RunAs"
    exit /b
)

:menu
cls
chcp 65001 >nul
for /f "tokens=2*" %%A in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\wscsvc" /v DelayedAutoStart 2^>nul') do (
set "valuee=%%B"
)
if defined valuee (
    setlocal enabledelayedexpansion
    if /i "!valuee:~0,2!"=="0x" (
        set "value=!valuee:~2!"
    ) else (
        set "value=!valuee!"
    )
    echo В данный момент для DelayedAutoStart установлено значение: !value!
    endlocal
) else (
    echo Параметр DelayedAutoStart не найден.
)
echo.
echo Выберите один из вариантов:
echo 1. Установить значение 1 для DelayedAutoStart
echo 2. Установить значение 0 для DelayedAutoStart
echo 0. Выйти
set /p choice=Введите номер варианта(0-2):


if "%choice%"=="1" (
set value=1
goto SetDelayedAutoStart
)
if "%choice%"=="2" (
set value=0
goto SetDelayedAutoStart
)
if "%choice%"=="0" exit /b
goto menu

:SetDelayedAutoStart
echo.
chcp 1251 >nul
reg add "HKLM\System\CurrentControlSet\Services\wscsvc" /v "DelayedAutoStart" /t REG_DWORD /d "%value%" /f
echo.
pause
goto menu