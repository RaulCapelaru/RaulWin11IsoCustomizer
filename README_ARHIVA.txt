# RAULWIN11 ISO CUSTOMIZER - Source Code

## 🚀 Quick Start

### Pentru UTILIZATORI:
Dacă vrei doar să folosești aplicația, **NU descărca sursa**!
Descarcă installer-ul gata compilat de pe pagina Releases.

### Pentru DEZVOLTATORI:

#### Ce este în această arhivă?
- Codul sursă complet al aplicației WPF (.NET 8)
- Script-uri pentru compilare automată
- Configurație Inno Setup pentru creare installer
- Documentație completă

#### Cum să compilezi aplicația:

**PASUL 1: Instalează cerințe**
- .NET 8 SDK: https://dotnet.microsoft.com/download/dotnet/8.0
- Inno Setup: https://jrsoftware.org/isdl.php

**PASUL 2: Extrage arhiva**
- Extrage toate fișierele într-un folder (ex: C:\RaulWin11)

**PASUL 3: Compilează**
- Dublu-click pe: `build-for-inno.bat`
- SAU deschide PowerShell și rulează: `.\build-for-inno.ps1`
- Așteaptă 2-5 minute

**PASUL 4: Creează installer**
- Deschide `installer.iss` în Inno Setup Compiler
- Build → Compile
- Installer-ul va fi în folder-ul `installer\`

#### Documentație detaliată:
- **INNO_SETUP_GUIDE.md** - Ghid complet pentru Inno Setup
- **README.md** - Documentație completă a proiectului
- **QUICK_START.md** - Ghid rapid de utilizare
- **TECHNICAL_DOCS.md** - Documentație tehnică

## 📁 Structura fișierelor

```
RaulWin11IsoCustomizer/
├── MainWindow.xaml              # UI design
├── MainWindow.xaml.cs           # Logica aplicației
├── App.xaml                     # Application resources
├── App.xaml.cs                  # Application entry
├── RaulWin11IsoCustomizer.csproj # Configurație .NET 8
├── installer.iss                # Script Inno Setup
├── build-for-inno.bat          # Script compilare (BAT)
├── build-for-inno.ps1          # Script compilare (PowerShell)
├── README.md                    # Documentație completă
├── INNO_SETUP_GUIDE.md         # Ghid Inno Setup
├── QUICK_START.md              # Ghid utilizare
├── TECHNICAL_DOCS.md           # Documentație tehnică
├── INSTALL_GUIDE.md            # Ghid instalare
├── LICENSE                      # MIT License
└── .gitignore                  # Git ignore rules
```

## ⚡ Comenzi rapide

```bash
# Compilare simplă (pentru testing)
dotnet build -c Release

# Publish self-contained (pentru distribuție)
dotnet publish -c Release -r win-x64 --self-contained true ^
  -p:PublishSingleFile=true ^
  -p:IncludeNativeLibrariesForSelfExtract=true ^
  -o publish

# După aceea, compilează installer.iss în Inno Setup
```

## 🔧 Cerințe pentru build

- Windows 10/11 (64-bit)
- .NET 8 SDK
- Inno Setup (pentru installer)
- 5GB spațiu liber pe disc

## 📞 Suport

- YouTube: Tutoriale cu Raul
- Website: https://tutorialecuraul.ro
- GitHub: https://github.com/RaulCapelaru

---

**Made with ❤️ by Raul Capelaru**
**© 2025 Tutoriale cu Raul | MIT License**
