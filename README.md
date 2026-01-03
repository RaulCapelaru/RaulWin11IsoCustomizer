# RAULWIN11 ISO CUSTOMIZER

![Version](https://img.shields.io/badge/version-1.0-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![Platform](https://img.shields.io/badge/platform-Windows-lightgrey)

## 📋 Descriere

**RAULWIN11 ISO CUSTOMIZER** este o aplicație WPF modernă care permite crearea de imagini ISO personalizate pentru Windows 11, cu posibilitatea de a adăuga fișierul `autounattend.xml` pentru instalări automate.

## ✨ Funcționalități

- 📀 **Extragere ISO** - Extrage conținutul unei imagini ISO Windows 11
- ⚙️ **Customizare autounattend.xml** - Descarcă automat fișierul RaulWin11 sau folosește propriul tău fișier
- 💿 **Creare ISO bootabil** - Creează o imagine ISO bootabilă personalizată
- 🎨 **Interfață modernă** - Design dark modern și intuitiv
- 📊 **Progress tracking** - Monitorizare progres în timp real

## 🔧 Cerințe

### Pentru UTILIZATORI (instalare aplicație):

1. **Windows 10/11** (64-bit)
2. **Windows ADK (Assessment and Deployment Kit)**
   - Necesar pentru utilitarul `oscdimg.exe`
   - [Download Windows ADK](https://docs.microsoft.com/en-us/windows-hardware/get-started/adk-install)
   - La instalare, selectați doar "Deployment Tools"

**NOTĂ**: Aplicația este **self-contained** - .NET Runtime este inclus în installer, NU este nevoie să instalați separat!

### Pentru DEZVOLTATORI (build din sursă):

1. **Windows 10/11** (64-bit)
2. **.NET 8 SDK**
   - [Download .NET 8 SDK](https://dotnet.microsoft.com/download/dotnet/8.0)
3. **Inno Setup** (pentru creare installer)
   - [Download Inno Setup](https://jrsoftware.org/isdl.php)
4. **Windows ADK** (pentru testing)

### Hardware recomandat:

- **RAM**: Minim 4GB, recomandat 8GB+
- **Spațiu disc**: Minim 15GB liber (pentru extragere + creare ISO)
- **Procesor**: Dual-core sau mai bun

## 📦 Instalare

### Opțiunea 1: Instalare folosind installer (RECOMANDAT pentru utilizatori)

1. Descarcă installer-ul de pe pagina [Releases](../../releases)
2. Rulează `RaulWin11IsoCustomizer-Setup-v1.0.0.exe`
3. Urmează wizard-ul de instalare
4. Gata! Aplicația include tot ce e necesar (self-contained)

### Opțiunea 2: Build din sursă (pentru dezvoltatori)

**Pregătire:**
1. Instalează [.NET 8 SDK](https://dotnet.microsoft.com/download/dotnet/8.0)
2. Instalează [Inno Setup](https://jrsoftware.org/isdl.php) (pentru creare installer)

**Compilare:**

**Variantă A - Script automat:**
```bash
# Rulează script-ul de build
build-for-inno.bat
# SAU
build-for-inno.ps1
```

**Variantă B - Manual:**
```bash
# Publică aplicația ca self-contained
dotnet publish -c Release -r win-x64 --self-contained true ^
  -p:PublishSingleFile=true ^
  -p:IncludeNativeLibrariesForSelfExtract=true ^
  -p:PublishReadyToRun=true ^
  -o publish

# Executabilul va fi în: publish\RaulWin11IsoCustomizer.exe
```

**Creare installer:**
1. Deschide `installer.iss` în Inno Setup Compiler
2. Build → Compile
3. Installer-ul va fi în `installer\RaulWin11IsoCustomizer-Setup-v1.0.0.exe`

**Detalii complete:** Vezi [INNO_SETUP_GUIDE.md](INNO_SETUP_GUIDE.md)

## 🚀 Utilizare

### Pasul 1: Selectează ISO-ul Windows 11
- Click pe "Browse ISO"
- Selectează fișierul `.iso` Windows 11

### Pasul 2: Selectează directorul de lucru
- Click pe "Browse Folder"
- Alege un folder cu minim 10GB spațiu liber

### Pasul 3: Extrage ISO-ul
- Click pe "Extract ISO"
- Așteaptă finalizarea extragerii (poate dura câteva minute)

### Pasul 4: Adaugă autounattend.xml
**Opțiunea A**: Descarcă fișierul RaulWin11
- Click pe "Download RaulWin11 Autounattend.xml"
- Fișierul va fi descărcat automat de pe GitHub

**Opțiunea B**: Folosește fișierul tău custom
- Click pe "Use My Custom Autounattend.xml"
- Selectează fișierul tău `.xml`

### Pasul 5: Creează ISO-ul personalizat
- Click pe "Create Custom ISO"
- Alege locația de salvare
- Așteaptă crearea ISO-ului (poate dura 5-10 minute)

## 📁 Structura proiectului

```
RaulWin11IsoCustomizer/
├── MainWindow.xaml          # UI design
├── MainWindow.xaml.cs       # Logica aplicației
├── App.xaml                 # Application resources
├── App.xaml.cs             # Application entry point
├── RaulWin11IsoCustomizer.csproj  # Project file
└── README.md               # Documentație
```

## 🔍 Cum funcționează

1. **Montare ISO**: ISO-ul este montat temporar folosind PowerShell
2. **Copiere fișiere**: Toate fișierele sunt copiate în directorul de lucru
3. **Adăugare autounattend.xml**: Fișierul XML este plasat în rădăcina ISO-ului
4. **Creare ISO**: Folosind `oscdimg.exe`, se creează un ISO bootabil UEFI

## ⚠️ Troubleshooting

### "oscdimg.exe not found"
**Soluție**: Instalează Windows ADK și asigură-te că ai bifat "Deployment Tools"

### "Failed to mount ISO"
**Soluție**: 
- Verifică că ISO-ul nu este deja montat
- Rulează aplicația ca Administrator
- Verifică că fișierul ISO nu este corupt

### "Access denied" la copiere fișiere
**Soluție**: Rulează aplicația ca Administrator

### ISO-ul creat nu este bootabil
**Soluție**:
- Verifică că fișierele `etfsboot.com` și `efisys.bin` există în ISO
- Asigură-te că ai folosit un ISO original Windows 11

## 📝 Link-uri utile

- **Autounattend.xml oficial**: [GitHub Repository](https://github.com/RaulCapelaru/Autounattend-for-RAULWIN11-ISO-CUSTOMIZER)
- **Windows ADK**: [Microsoft Docs](https://docs.microsoft.com/en-us/windows-hardware/get-started/adk-install)
- **Tutorial YouTube**: [Tutoriale cu Raul](https://tutorialecuraul.ro)

## 🛠️ Dezvoltare

### Build în Command Prompt
```bash
# Curăță build-uri anterioare
rmdir /s /q bin obj publish

# Build simplu (pentru testing)
dotnet build -c Release

# Publish self-contained (pentru distribuție)
dotnet publish -c Release -r win-x64 --self-contained true ^
  -p:PublishSingleFile=true ^
  -p:IncludeNativeLibrariesForSelfExtract=true ^
  -p:PublishReadyToRun=true ^
  -o publish

# Creare installer cu Inno Setup
# Deschide installer.iss în Inno Setup Compiler și compilează
```

### Tehnologii folosite
- **WPF** (Windows Presentation Foundation)
- **.NET 8.0** (self-contained deployment)
- **PowerShell** (pentru montare ISO)
- **oscdimg.exe** (pentru creare ISO bootabil)
- **Inno Setup** (pentru installer)

## 📄 Licență

MIT License - vezi fișierul [LICENSE](LICENSE) pentru detalii

## 👤 Autor

**Raul Capelaru**
- Website: [tutorialecuraul.ro](https://tutorialecuraul.ro)
- YouTube: [Tutoriale cu Raul](https://www.youtube.com/@tutorialecuraul)
- GitHub: [@RaulCapelaru](https://github.com/RaulCapelaru)

## 🤝 Contribuții

Contribuțiile sunt binevenite! Simte-te liber să deschizi un issue sau pull request.

## ⭐ Suport

Dacă îți place acest proiect, lasă un ⭐ pe GitHub!

---

**Made with ❤️ by Raul Capelaru | © 2025 Tutoriale cu Raul**
