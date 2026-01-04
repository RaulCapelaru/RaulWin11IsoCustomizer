# RaulWin11 ISO Customizer - Clean Source Code

## 📦 Ce este în această arhivă?

Codul sursă COMPLET al aplicației RaulWin11 ISO Customizer - versiunea simplificată.

**Simplu și curat:** DOAR fișierele esențiale pentru build!

---

## 📁 Conținut:

- **MainWindow.xaml** + **MainWindow.xaml.cs** - Interfața și logica aplicației
- **App.xaml** + **App.xaml.cs** - Entry point
- **RaulWin11IsoCustomizer.csproj** - Project file (.NET 8)
- **installer.iss** - Inno Setup config
- **build-for-inno.bat** / **.ps1** - Build scripts
- **LICENSE** - MIT License
- **.gitignore** - Git ignore rules
- **README.md** - Documentație completă

---

## 🚀 Build rapid:

```bash
# Compilare
dotnet build -c Release

# SAU
build-for-inno.bat

# Apoi creează installer cu Inno Setup
```

---

## 📝 Schimbări față de versiunea anterioară:

### ❌ CE S-A ELIMINAT:
- Advanced Options checkbox-uri (Step 5)
- FirstLogonCommands XML files
- .REG demo files
- Ghiduri suplimentare (15+ documente .md)

### ✅ CE A RĂMAS:
- Aplicația funcțională completă
- Step 5 INFORMATIV (arată ce conține autounattend.xml)
- Build scripts
- Documentație esențială

### 🎯 DE CE?
Toate tweaks-urile sunt acum în **autounattend.xml** pe repo separat:
```
https://github.com/RaulCapelaru/Autounattend-for-RAULWIN11-ISO-CUSTOMIZER
```

Aplicația doar:
1. Extrage ISO
2. Descarcă autounattend.xml
3. Creează ISO bootabil

**Mai simplu, mai curat, mai ușor de întreținut!**

---

**Made with ❤️ by Raul Capelaru**
**© 2025 Tutoriale cu Raul | MIT License**
