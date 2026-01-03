# 📦 GHID COMPLET: CREARE INSTALLER CU INNO SETUP

## 🎯 Pași pentru creare installer

### PASUL 1: Pregătire sistem

#### A. Instalează .NET 8 SDK
1. Descarcă .NET 8 SDK de aici:
   - 📥 https://dotnet.microsoft.com/download/dotnet/8.0
   - Alege: **SDK x64** (nu Runtime!)
2. Rulează installer-ul
3. Restart PC (recomandat)

#### B. Instalează Inno Setup
1. Descarcă Inno Setup de aici:
   - 📥 https://jrsoftware.org/isdl.php
   - Versiune recomandată: **Inno Setup 6.3.3** sau mai nou
2. Rulează installer-ul cu setările default
3. Verifică că s-a instalat în: `C:\Program Files (x86)\Inno Setup 6`

#### C. Verifică instalarea
```bash
# Deschide Command Prompt și verifică:
dotnet --version
# Ar trebui să vezi: 8.x.x
```

---

### PASUL 2: Compilare aplicație

#### Variantă A: Folosind script BAT (Recomandat)

1. **Extrage** arhiva proiectului într-un folder (ex: `C:\RaulWin11`)
2. **Navighează** în folder în Explorer
3. **Dublu-click** pe: `build-for-inno.bat`
4. **Așteaptă** 2-5 minute pentru compilare
5. **Verifică** mesajul "BUILD FINALIZAT CU SUCCES!"

#### Variantă B: Folosind PowerShell

1. **Click dreapta** pe `build-for-inno.ps1`
2. Alege: **"Run with PowerShell"**
3. Dacă apare eroare de execution policy:
   ```powershell
   # Rulează PowerShell ca Administrator și execută:
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```
4. **Așteaptă** finalizarea

#### Variantă C: Manual (Comandă directă)

```bash
# Deschide Command Prompt în folder-ul proiectului
cd C:\RaulWin11

# Curăță build-uri anterioare
rmdir /s /q bin obj publish installer

# Publică aplicația (self-contained)
dotnet publish -c Release -r win-x64 --self-contained true ^
  -p:PublishSingleFile=true ^
  -p:IncludeNativeLibrariesForSelfExtract=true ^
  -p:PublishReadyToRun=true ^
  -p:EnableCompressionInSingleFile=true ^
  -o publish
```

---

### PASUL 3: Verificare fișiere generate

După compilare, verifică structura:

```
RaulWin11/
├── publish/
│   ├── RaulWin11IsoCustomizer.exe  ← IMPORTANT! (40-60 MB)
│   └── (alte DLL-uri și fișiere)
├── installer.iss                   ← Script Inno Setup
├── README.md
├── QUICK_START.md
├── LICENSE
└── build-for-inno.bat
```

**Verificări importante:**
- ✅ `publish\RaulWin11IsoCustomizer.exe` există
- ✅ Mărimea executabilului: **~40-60 MB** (self-contained)
- ✅ Folder-ul `installer` a fost creat (poate fi gol)

---

### PASUL 4: Creare installer cu Inno Setup

#### A. Deschide Inno Setup Compiler

1. Start Menu → **Inno Setup Compiler**
2. File → **Open** → selectează `installer.iss`

#### B. Configurare (Opțional)

Poți edita `installer.iss` pentru:
- Schimbare versiune: `#define MyAppVersion "1.0.0"`
- Schimbare URL: `#define MyAppURL "https://tutorialecuraul.ro"`
- Adăugare icon custom (dacă ai `icon.ico`)

#### C. Compilare installer

1. Build → **Compile** (sau apasă `Ctrl+F9`)
2. **Așteaptă** 30-60 secunde
3. Verifică output-ul în fereastra de jos

**Mesaje așteptate:**
```
Successful compile (0 sec).
Result: Success
Output: installer\RaulWin11IsoCustomizer-Setup-v1.0.0.exe
```

#### D. Verificare installer creat

```
installer/
└── RaulWin11IsoCustomizer-Setup-v1.0.0.exe  (40-65 MB)
```

---

### PASUL 5: Testare installer

#### A. Instalare de test

1. **Dublu-click** pe `RaulWin11IsoCustomizer-Setup-v1.0.0.exe`
2. Urmează wizard-ul de instalare:
   - Welcome → Next
   - License Agreement → I accept → Next
   - Destination → Next (default: `C:\Program Files\RAULWIN11 ISO CUSTOMIZER`)
   - Start Menu → Next
   - Additional Tasks → Next (cu/fără desktop icon)
   - Ready to Install → Install
3. **Așteaptă** 10-30 secunde
4. Finish → Launch application

#### B. Verificări post-instalare

✅ **Start Menu:**
- RAULWIN11 ISO CUSTOMIZER → aplicația pornește
- Quick Start Guide → documentația se deschide
- README → informații despre aplicație

✅ **Desktop (dacă ai bifat):**
- Shortcut pentru aplicație

✅ **Folder instalare:**
- `C:\Program Files\RAULWIN11 ISO CUSTOMIZER\`
- Conține: executabilul + documentație

#### C. Test funcționalitate

1. **Pornește** aplicația
2. **Verifică** că UI-ul se deschide corect
3. **Testează** selecția de fișiere (Browse ISO, Browse Folder)
4. **Oprește** aplicația

#### D. Dezinstalare de test

1. Settings → Apps → Installed apps
2. Caută: **RAULWIN11 ISO CUSTOMIZER**
3. Uninstall → confirmă
4. Verifică că folder-ul din Program Files a fost șters

---

## 🎁 DISTRIBUȚIE INSTALLER

### Opțiuni de distribuire:

#### 1. **Upload pe site/Google Drive**
- Redenumește: `RaulWin11IsoCustomizer-Setup-v1.0.0.exe`
- Upload pe tutorialecuraul.ro sau Google Drive
- Creează link de download

#### 2. **YouTube video description**
```
📥 DOWNLOAD RAULWIN11 ISO CUSTOMIZER:
https://tutorialecuraul.ro/download/raulwin11-customizer

CERINȚE:
- Windows 10/11 (64-bit)
- Windows ADK (Deployment Tools)
- 15GB spațiu liber

INSTALARE:
1. Download installer
2. Rulează RaulWin11IsoCustomizer-Setup-v1.0.0.exe
3. Urmează pașii din wizard
```

#### 3. **GitHub Release**
1. Creează repository pe GitHub
2. Creează un Release (tag v1.0.0)
3. Atașează `.exe` la release
4. Adaugă release notes

---

## 🔧 TROUBLESHOOTING

### Problema 1: "dotnet command not found"
**Soluție:**
- Reinstalează .NET 8 SDK
- Verifică PATH environment variable
- Restart Command Prompt

### Problema 2: Build failed - "target framework not found"
**Soluție:**
```bash
# Verifică .NET SDK instalat:
dotnet --list-sdks

# Ar trebui să vezi 8.x.x
# Dacă nu, instalează .NET 8 SDK
```

### Problema 3: Inno Setup nu găsește fișierele
**Soluție:**
- Verifică că `publish\RaulWin11IsoCustomizer.exe` există
- Verifică că `installer.iss` este în același folder cu `publish\`
- Path-urile în `installer.iss` sunt relative la locația script-ului

### Problema 4: Installer-ul creat nu pornește aplicația
**Soluție:**
- Aplicația este **self-contained** (include .NET 8 Runtime)
- NU este nevoie de .NET instalat separat pentru utilizatori
- Dacă totuși nu pornește, verifică Windows Defender

### Problema 5: "File size too large"
**Soluție:**
- Normal pentru self-contained: **40-60 MB**
- Poți reduce mărimea eliminând `PublishReadyToRun`:
  ```bash
  dotnet publish -c Release -r win-x64 --self-contained true ^
    -p:PublishSingleFile=true ^
    -p:IncludeNativeLibrariesForSelfExtract=true ^
    -o publish
  ```

---

## 📋 CHECKLIST FINAL

Înainte de distribuție, verifică:

- [ ] .NET 8 SDK instalat
- [ ] Inno Setup instalat
- [ ] Build script rulat cu succes
- [ ] `publish\RaulWin11IsoCustomizer.exe` există (~40-60 MB)
- [ ] Installer-ul compilat cu Inno Setup
- [ ] `installer\RaulWin11IsoCustomizer-Setup-v1.0.0.exe` creat
- [ ] Installer testat (instalare + rulare + dezinstalare)
- [ ] Aplicația pornește și funcționează corect
- [ ] Documentația inclusă (README, QUICK_START, LICENSE)
- [ ] Icon-ul aplicației se afișează corect (dacă ai icon.ico)

---

## 📞 SUPORT

Probleme? Contactează:
- 🎥 YouTube: Tutoriale cu Raul
- 🌐 Website: tutorialecuraul.ro
- 📧 Email: prin formular de contact

---

**Succes cu distribuirea aplicației! 🚀**

*Made with ❤️ by Raul Capelaru*
