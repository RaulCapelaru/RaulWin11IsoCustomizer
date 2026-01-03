# GHID DE INSTALARE - RAULWIN11 ISO CUSTOMIZER

## 📋 Cerințe preliminare

### 1. Instalează .NET 6.0 Desktop Runtime

**Acest pas este OBLIGATORIU pentru a rula aplicația!**

1. Descarcă .NET 6.0 Desktop Runtime de aici:
   - **x64 (64-bit)**: https://dotnet.microsoft.com/download/dotnet/thank-you/runtime-desktop-6.0.27-windows-x64-installer
   - **x86 (32-bit)**: https://dotnet.microsoft.com/download/dotnet/thank-you/runtime-desktop-6.0.27-windows-x86-installer

2. Rulează installerul descărcat
3. Urmează pașii din wizard
4. Restart PC-ul (recomandat)

### 2. Instalează Windows ADK (Assessment and Deployment Kit)

**Necesar pentru crearea ISO-urilor bootabile!**

1. Descarcă Windows ADK de aici:
   - https://go.microsoft.com/fwlink/?linkid=2243390

2. Rulează `adksetup.exe`

3. **IMPORTANT**: La ecranul "Select the features you want to install"
   - ✅ Bifează DOAR: **Deployment Tools**
   - ❌ Nu este nevoie de restul componentelor

4. Așteaptă finalizarea instalării (~1-2 GB download)

## 🚀 Pornirea aplicației

### Variantă 1: Release compilat (recomandat)

1. Descarcă ultima versiune din secțiunea [Releases](../../releases)
2. Extrage arhiva ZIP
3. Rulează `RaulWin11IsoCustomizer.exe`

### Variantă 2: Build din cod sursă

#### A. Instalează Visual Studio 2022 Community (GRATUIT)

1. Descarcă de aici: https://visualstudio.microsoft.com/downloads/
2. La instalare, selectează workload-ul: **.NET desktop development**
3. Așteaptă instalarea (poate dura 30-60 minute)

#### B. Compilează aplicația

**Opțiunea 1 - Folosind script-ul build.bat:**
```
1. Deschide folder-ul proiectului
2. Dublu-click pe build.bat
3. Așteaptă finalizarea
4. Executabilul va fi în folder-ul "publish"
```

**Opțiunea 2 - Manual în Visual Studio:**
```
1. Deschide RaulWin11IsoCustomizer.sln în Visual Studio
2. Selectează "Release" în loc de "Debug" (toolbar sus)
3. Click pe Build > Build Solution (sau apasă F7)
4. Executabilul va fi în: bin\Release\net6.0-windows\
```

**Opțiunea 3 - Command Line:**
```bash
# Deschide Command Prompt în folder-ul proiectului
cd path\to\RaulWin11IsoCustomizer

# Build Release
dotnet build -c Release

# Publish single-file (opțional)
dotnet publish -c Release -r win-x64 --self-contained false -p:PublishSingleFile=true -o publish
```

## ✅ Verificare instalare

### Verifică .NET Runtime
```bash
# Deschide Command Prompt și execută:
dotnet --list-runtimes

# Ar trebui să vezi ceva de genul:
# Microsoft.WindowsDesktop.App 6.0.x [C:\Program Files\dotnet\shared\Microsoft.WindowsDesktop.App]
```

### Verifică Windows ADK
```bash
# Verifică dacă există oscdimg.exe:
dir "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\Oscdimg\oscdimg.exe"

# Ar trebui să existe fișierul
```

## 🔧 Rezolvare probleme comune

### Problema: "To run this application, you must install .NET"
**Soluție**: Instalează .NET 6.0 Desktop Runtime (vezi pasul 1 de mai sus)

### Problema: "oscdimg.exe not found"
**Soluție**: 
1. Instalează Windows ADK (vezi pasul 2 de mai sus)
2. Asigură-te că ai bifat "Deployment Tools"
3. Caută manual oscdimg.exe în:
   - `C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\`

### Problema: "This app can't run on your PC"
**Soluție**: 
- Ai nevoie de Windows 10 sau Windows 11 (64-bit)
- Aplicația nu funcționează pe Windows 7/8

### Problema: Aplicația nu pornește deloc
**Soluție**:
1. Click dreapta pe `RaulWin11IsoCustomizer.exe`
2. Alege "Run as administrator"
3. Dacă tot nu merge, verifică din nou .NET Runtime

## 📞 Suport

Dacă întâmpini probleme:

1. **YouTube**: Caută tutoriale pe [Tutoriale cu Raul](https://tutorialecuraul.ro)
2. **GitHub Issues**: Deschide un issue pe pagina proiectului
3. **Email**: Contactează prin site-ul tutorialecuraul.ro

## 📝 Note importante

- ⚠️ Aplicația necesită **DREPTURI DE ADMINISTRATOR** pentru montarea ISO-urilor
- 💾 Asigură-te că ai **minim 15GB spațiu liber** pe hard disk
- 🔒 Unele antivirusuri pot marca aplicația ca "unknown" - este normal, adaugă-o la excepții
- ⏱️ Procesul de creare ISO poate dura **5-10 minute** - nu închide aplicația!

## ✨ Gata de utilizare!

Acum poți folosi **RAULWIN11 ISO CUSTOMIZER** pentru a crea propriile imagini Windows 11 personalizate!

**Made with ❤️ by Raul Capelaru**
