@echo off
setlocal enabledelayedexpansion

title RAULWIN11 ISO CUSTOMIZER - Build and Publish Script

echo.
echo ========================================================
echo   RAULWIN11 ISO CUSTOMIZER - Build and Publish Script
echo ========================================================
echo.
echo Acest script va:
echo 1. Verifica .NET SDK
echo 2. Curata build-urile anterioare
echo 3. Restora pachetele NuGet
echo 4. Publica aplicatia ca self-contained executable
echo 5. Pregati fisierele pentru Inno Setup
echo.
pause
echo.

REM Check if .NET SDK is installed
echo [STEP 1/5] Verificare .NET SDK...
dotnet --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] .NET SDK nu este instalat!
    echo.
    echo Descarca si instaleaza .NET 8 SDK de la:
    echo https://dotnet.microsoft.com/download/dotnet/8.0
    echo.
    pause
    exit /b 1
)

for /f "tokens=*" %%i in ('dotnet --version') do set DOTNET_VERSION=%%i
echo [OK] .NET SDK gasit: %DOTNET_VERSION%
echo.

REM Check if version is 8.x
echo %DOTNET_VERSION% | findstr /B "8." >nul
if errorlevel 1 (
    echo [WARNING] Este recomandat .NET 8 SDK!
    echo Versiunea curenta: %DOTNET_VERSION%
    echo.
    echo Continui oricum? (Y/N)
    set /p CONTINUE=
    if /i not "%CONTINUE%"=="Y" exit /b 1
)

REM Clean previous builds
echo [STEP 2/5] Curatare build-uri anterioare...
if exist "bin" (
    echo Stergere folder bin...
    rd /s /q "bin" 2>nul
)
if exist "obj" (
    echo Stergere folder obj...
    rd /s /q "obj" 2>nul
)
if exist "publish" (
    echo Stergere folder publish...
    rd /s /q "publish" 2>nul
)
if exist "installer" (
    echo Stergere folder installer...
    rd /s /q "installer" 2>nul
)
echo [OK] Curatare finalizata
echo.

REM Restore NuGet packages
echo [STEP 3/5] Restaurare pachete NuGet...
dotnet restore
if errorlevel 1 (
    echo [ERROR] Restaurarea pachetelor a esuat!
    pause
    exit /b 1
)
echo [OK] Pachete restaurate cu succes
echo.

REM Publish as self-contained executable
echo [STEP 4/5] Publicare aplicatie (self-contained, .NET 8)...
echo.
echo Acest pas poate dura 2-5 minute...
echo.

dotnet publish -c Release -r win-x64 --self-contained true -p:PublishSingleFile=true -p:IncludeNativeLibrariesForSelfExtract=true -p:PublishReadyToRun=true -p:EnableCompressionInSingleFile=true -o publish

if errorlevel 1 (
    echo [ERROR] Publicarea a esuat!
    echo.
    echo Verifica erorile de mai sus si incearca din nou.
    pause
    exit /b 1
)
echo [OK] Publicare finalizata cu succes
echo.

REM Prepare files for Inno Setup
echo [STEP 5/5] Pregatire fisiere pentru Inno Setup...

REM Check if executable exists
if not exist "publish\RaulWin11IsoCustomizer.exe" (
    echo [ERROR] Executabilul nu a fost gasit in folder-ul publish!
    pause
    exit /b 1
)

REM Get file size
for %%A in ("publish\RaulWin11IsoCustomizer.exe") do set SIZE=%%~zA
set /a SIZE_MB=%SIZE% / 1048576
echo.
echo Fisier executabil: publish\RaulWin11IsoCustomizer.exe
echo Marime: %SIZE_MB% MB
echo.

REM Create installer directory
if not exist "installer" mkdir "installer"

echo [OK] Pregatire finalizata
echo.
echo ========================================================
echo                  BUILD FINALIZAT CU SUCCES!
echo ========================================================
echo.
echo Fisierele sunt pregatite pentru Inno Setup:
echo.
echo   Executabil:  publish\RaulWin11IsoCustomizer.exe
echo   Marime:      %SIZE_MB% MB
echo.
echo --------------------------------------------------------
echo URMATORII PASI:
echo --------------------------------------------------------
echo.
echo 1. Asigura-te ca ai Inno Setup instalat:
echo    https://jrsoftware.org/isdl.php
echo.
echo 2. Deschide fisierul: installer.iss
echo.
echo 3. In Inno Setup Compiler:
echo    - File ^> Open ^> selecteaza installer.iss
echo    - Build ^> Compile
echo.
echo 4. Installer-ul va fi creat in folder-ul: installer\
echo    Fisier: RaulWin11IsoCustomizer-Setup-v1.0.0.exe
echo.
echo --------------------------------------------------------
echo.
echo Vrei sa deschizi folder-ul publish acum? (Y/N)
set /p OPEN_FOLDER=
if /i "%OPEN_FOLDER%"=="Y" (
    start "" "%CD%\publish"
)
echo.
echo Apasa orice tasta pentru a inchide...
pause >nul
