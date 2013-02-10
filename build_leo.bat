@echo off
setlocal enabledelayedexpansion

echo ----------------------------------------------------
echo Starting up build ...
echo ----------------------------------------------------
echo.

if exist build (del /s /q build)
if not exist build\@dayzcc\addons (md build\@dayzcc\addons)
if not exist build\Keys (md build\Keys)
if not exist build\MPMissions (md build\MPMissions)

echo.
echo ----------------------------------------------------
echo Building server addon ...
echo ----------------------------------------------------
echo.

util\cpbo.exe -y -p server\dayz_server build\@dayzcc\addons\dayz_server.pbo

echo.
echo ----------------------------------------------------
echo Building mission files ... skipped
echo ----------------------------------------------------
echo.


echo.
echo ----------------------------------------------------
echo Copying additional files ...
echo ----------------------------------------------------
echo.

copy server\dayz_server_config.hpp build\@dayzcc\addons\dayz_server_config.hpp
copy util\HiveExt.dll build\@dayzcc\HiveExt.dll
copy util\dayz.bikey build\Keys\dayz.bikey

echo.
echo ----------------------------------------------------
echo Finished! Press any key to exit ...
echo ----------------------------------------------------
pause>nul