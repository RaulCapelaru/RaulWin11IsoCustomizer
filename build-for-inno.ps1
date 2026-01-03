# RAULWIN11 ISO CUSTOMIZER - Build and Publish Script (PowerShell)
# Version 1.0.0

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "  RAULWIN11 ISO CUSTOMIZER - Build and Publish Script  " -ForegroundColor Cyan
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Acest script va:" -ForegroundColor White
Write-Host "1. Verifica .NET SDK" -ForegroundColor Gray
Write-Host "2. Curata build-urile anterioare" -ForegroundColor Gray
Write-Host "3. Restora pachetele NuGet" -ForegroundColor Gray
Write-Host "4. Publica aplicatia ca self-contained executable" -ForegroundColor Gray
Write-Host "5. Pregati fisierele pentru Inno Setup" -ForegroundColor Gray
Write-Host ""
Read-Host "Apasa Enter pentru a continua"
Write-Host ""

# Step 1: Check .NET SDK
Write-Host "[STEP 1/5] Verificare .NET SDK..." -ForegroundColor Yellow
try {
    $dotnetVersion = dotnet --version
    Write-Host "[OK] .NET SDK gasit: $dotnetVersion" -ForegroundColor Green
    
    # Check if version is 8.x
    if (-not ($dotnetVersion -match "^8\.")) {
        Write-Host "[WARNING] Este recomandat .NET 8 SDK!" -ForegroundColor Yellow
        Write-Host "Versiunea curenta: $dotnetVersion" -ForegroundColor Yellow
        Write-Host ""
        $continue = Read-Host "Continui oricum? (Y/N)"
        if ($continue -ne 'Y' -and $continue -ne 'y') {
            exit 1
        }
    }
}
catch {
    Write-Host "[ERROR] .NET SDK nu este instalat!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Descarca si instaleaza .NET 8 SDK de la:" -ForegroundColor White
    Write-Host "https://dotnet.microsoft.com/download/dotnet/8.0" -ForegroundColor Cyan
    Write-Host ""
    Read-Host "Apasa Enter pentru a inchide"
    exit 1
}
Write-Host ""

# Step 2: Clean previous builds
Write-Host "[STEP 2/5] Curatare build-uri anterioare..." -ForegroundColor Yellow
$foldersToClean = @("bin", "obj", "publish", "installer")
foreach ($folder in $foldersToClean) {
    if (Test-Path $folder) {
        Write-Host "  Stergere folder $folder..." -ForegroundColor Gray
        Remove-Item -Path $folder -Recurse -Force -ErrorAction SilentlyContinue
    }
}
Write-Host "[OK] Curatare finalizata" -ForegroundColor Green
Write-Host ""

# Step 3: Restore NuGet packages
Write-Host "[STEP 3/5] Restaurare pachete NuGet..." -ForegroundColor Yellow
try {
    dotnet restore
    if ($LASTEXITCODE -ne 0) {
        throw "Restore failed with exit code $LASTEXITCODE"
    }
    Write-Host "[OK] Pachete restaurate cu succes" -ForegroundColor Green
}
catch {
    Write-Host "[ERROR] Restaurarea pachetelor a esuat!" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    Read-Host "Apasa Enter pentru a inchide"
    exit 1
}
Write-Host ""

# Step 4: Publish as self-contained executable
Write-Host "[STEP 4/5] Publicare aplicatie (self-contained, .NET 8)..." -ForegroundColor Yellow
Write-Host ""
Write-Host "Acest pas poate dura 2-5 minute..." -ForegroundColor Gray
Write-Host ""

$publishParams = @(
    "publish",
    "-c", "Release",
    "-r", "win-x64",
    "--self-contained", "true",
    "-p:PublishSingleFile=true",
    "-p:IncludeNativeLibrariesForSelfExtract=true",
    "-p:PublishReadyToRun=true",
    "-p:EnableCompressionInSingleFile=true",
    "-o", "publish"
)

try {
    & dotnet $publishParams
    if ($LASTEXITCODE -ne 0) {
        throw "Publish failed with exit code $LASTEXITCODE"
    }
    Write-Host "[OK] Publicare finalizata cu succes" -ForegroundColor Green
}
catch {
    Write-Host "[ERROR] Publicarea a esuat!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Verifica erorile de mai sus si incearca din nou." -ForegroundColor Yellow
    Write-Host $_.Exception.Message -ForegroundColor Red
    Read-Host "Apasa Enter pentru a inchide"
    exit 1
}
Write-Host ""

# Step 5: Prepare files for Inno Setup
Write-Host "[STEP 5/5] Pregatire fisiere pentru Inno Setup..." -ForegroundColor Yellow

# Check if executable exists
$exePath = "publish\RaulWin11IsoCustomizer.exe"
if (-not (Test-Path $exePath)) {
    Write-Host "[ERROR] Executabilul nu a fost gasit in folder-ul publish!" -ForegroundColor Red
    Read-Host "Apasa Enter pentru a inchide"
    exit 1
}

# Get file size
$fileSize = (Get-Item $exePath).Length
$fileSizeMB = [math]::Round($fileSize / 1MB, 2)

Write-Host ""
Write-Host "Fisier executabil: $exePath" -ForegroundColor White
Write-Host "Marime: $fileSizeMB MB" -ForegroundColor White
Write-Host ""

# Create installer directory
if (-not (Test-Path "installer")) {
    New-Item -ItemType Directory -Path "installer" | Out-Null
}

Write-Host "[OK] Pregatire finalizata" -ForegroundColor Green
Write-Host ""

# Summary
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "                BUILD FINALIZAT CU SUCCES!              " -ForegroundColor Green
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Fisierele sunt pregatite pentru Inno Setup:" -ForegroundColor White
Write-Host ""
Write-Host "  Executabil:  " -NoNewline -ForegroundColor White
Write-Host "publish\RaulWin11IsoCustomizer.exe" -ForegroundColor Cyan
Write-Host "  Marime:      " -NoNewline -ForegroundColor White
Write-Host "$fileSizeMB MB" -ForegroundColor Yellow
Write-Host ""
Write-Host "--------------------------------------------------------" -ForegroundColor Gray
Write-Host "URMATORII PASI:" -ForegroundColor Yellow
Write-Host "--------------------------------------------------------" -ForegroundColor Gray
Write-Host ""
Write-Host "1. Asigura-te ca ai Inno Setup instalat:" -ForegroundColor White
Write-Host "   https://jrsoftware.org/isdl.php" -ForegroundColor Cyan
Write-Host ""
Write-Host "2. Deschide fisierul: installer.iss" -ForegroundColor White
Write-Host ""
Write-Host "3. In Inno Setup Compiler:" -ForegroundColor White
Write-Host "   - File > Open > selecteaza installer.iss" -ForegroundColor Gray
Write-Host "   - Build > Compile" -ForegroundColor Gray
Write-Host ""
Write-Host "4. Installer-ul va fi creat in folder-ul: installer\" -ForegroundColor White
Write-Host "   Fisier: RaulWin11IsoCustomizer-Setup-v1.0.0.exe" -ForegroundColor Cyan
Write-Host ""
Write-Host "--------------------------------------------------------" -ForegroundColor Gray
Write-Host ""

# Offer to open folder
$openFolder = Read-Host "Vrei sa deschidi folder-ul publish acum? (Y/N)"
if ($openFolder -eq 'Y' -or $openFolder -eq 'y') {
    Start-Process explorer.exe -ArgumentList (Get-Location).Path
}

Write-Host ""
Write-Host "Script finalizat!" -ForegroundColor Green
Read-Host "Apasa Enter pentru a inchide"
