# 🎨 ADĂUGARE ICON CUSTOM (OPȚIONAL)

## Aplicația funcționează FĂRĂ icon custom!

Momentan, aplicația folosește icon-ul default Windows (.exe standard).
Dacă vrei să adaugi un icon personalizat, urmează pașii de mai jos.

---

## 📝 Cum să adaugi un icon custom

### PASUL 1: Creează sau găsește un icon

**Opțiuni:**
1. **Creează manual** - folosind un editor de icoane:
   - https://www.online-image-editor.com/
   - https://convertico.com/

2. **Download gratuit**:
   - https://www.flaticon.com/
   - https://icons8.com/

3. **Generează din imagine** (PNG → ICO):
   - https://convertico.com/
   - https://www.icoconverter.com/

**Cerințe:**
- Format: `.ico`
- Rezoluții recomandate: 16x16, 32x32, 48x48, 256x256
- Mărime: sub 100 KB

---

### PASUL 2: Adaugă icon-ul în proiect

1. Salvează fișierul ca `icon.ico`
2. Copiază-l în folder-ul principal al proiectului (alături de `.csproj`)

**Structura ar trebui să fie:**
```
RaulWin11IsoCustomizer/
├── icon.ico                          ← AICI!
├── MainWindow.xaml
├── MainWindow.xaml.cs
├── RaulWin11IsoCustomizer.csproj
└── ...
```

---

### PASUL 3: Modifică fișierele de configurare

#### A. Modifică `RaulWin11IsoCustomizer.csproj`

Adaugă linia cu icon în secțiunea `<PropertyGroup>`:

```xml
<PropertyGroup>
  <OutputType>WinExe</OutputType>
  <TargetFramework>net8.0-windows</TargetFramework>
  <UseWPF>true</UseWPF>
  <UseWindowsForms>true</UseWindowsForms>
  <ApplicationIcon>icon.ico</ApplicationIcon>  ← ADAUGĂ ACEASTĂ LINIE
  <AssemblyName>RaulWin11IsoCustomizer</AssemblyName>
  ...
</PropertyGroup>
```

#### B. Modifică `installer.iss`

Adaugă linia cu icon în secțiunea de UI:

```ini
; Installer UI
WizardStyle=modern
SetupIconFile=icon.ico              ← ADAUGĂ ACEASTĂ LINIE
UninstallDisplayIcon={app}\{#MyAppExeName}
```

---

### PASUL 4: Rebuild aplicația

```bash
# Rulează din nou build script-ul
build-for-inno.bat

# Apoi compilează installer-ul în Inno Setup
```

---

## 🎯 REZULTAT

După ce adaugi icon-ul:

✅ **Executabilul** va avea icon-ul tău custom  
✅ **Installer-ul** va afișa icon-ul în wizard  
✅ **Shortcut-urile** (Start Menu, Desktop) vor avea icon-ul  
✅ **Task Manager** va afișa icon-ul când aplicația rulează  

---

## 💡 TIPS

### Creează un icon simplu cu Windows Paint:
1. Creează o imagine 256x256 pixels în Paint
2. Salvează ca PNG
3. Convertește PNG → ICO pe https://convertico.com/

### Icon pentru Windows 11 style:
- Folosește design minimalist
- Culori: accent colors (albastru, verde, etc.)
- Background transparent
- Formă simplă, recognizabilă

### Exemplu de icon relevant pentru aplicația ta:
```
💿 + 🛠️ = Icon cu disc CD/DVD și wrench/gear
SAU
🪟 + ⚙️ = Windows logo + settings gear
SAU
📀 + ✏️ = Disc + edit/pencil
```

---

## ❓ ÎNTREBĂRI FRECVENTE

### Q: Aplicația nu compilează după ce am adăugat icon-ul
**A:** Verifică că:
- Fișierul se numește exact `icon.ico` (lowercase)
- Este în același folder cu `.csproj`
- Are format valid `.ico` (nu `.png` redenumit!)

### Q: Icon-ul nu apare în installer
**A:** Verifică că:
- Ai modificat `installer.iss` corect
- Ai recompilat installer-ul în Inno Setup

### Q: Pot folosi PNG în loc de ICO?
**A:** NU! Windows .exe necesită format `.ico`
- Convertește PNG → ICO mai întâi

---

## 🔗 RESURSE UTILE

- **Convertoare ICO**: https://convertico.com/
- **Icon generator**: https://www.favicon-generator.org/
- **Free icons**: https://www.flaticon.com/
- **Windows Icon Guidelines**: https://learn.microsoft.com/en-us/windows/apps/design/style/iconography/app-icon-design

---

**NOTĂ:** Aplicația funcționează PERFECT și FĂRĂ icon custom!  
Icon-ul este doar cosmetic - nu afectează funcționalitatea.

---

**Made with ❤️ for RAULWIN11 ISO CUSTOMIZER**
