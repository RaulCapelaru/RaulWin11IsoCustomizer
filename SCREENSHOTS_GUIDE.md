# 📸 GHID PENTRU SCREENSHOTS GITHUB

## Ce Screenshots să faci

Pentru README-ul GitHub ai nevoie de 3 screenshots principale:

---

## 1. 🖼️ MAIN WINDOW (main-window.png)

### Setup:
1. Deschide aplicația RaulWin11IsoCustomizer
2. Selectează un ISO (Browse ISO → alege un fișier)
3. Selectează Working Directory (Browse Folder)
4. **NU extrage** încă - vrem să vedem UI-ul curat

### Screenshot:
- Captează întreaga fereastră
- Include title bar "RAULWIN11 ISO CUSTOMIZER"
- Asigură-te că se văd toate cele 6 steps
- Window size: ~1000x700 px (default)

### Tool recomandat:
```
Windows: Win + Shift + S (Snipping Tool)
SAU
ShareX (mai profesional): https://getsharex.com/
```

### Salvează ca:
```
screenshots/main-window.png
```

---

## 2. ⚙️ ADVANCED OPTIONS (advanced-options.png)

### Setup:
1. Scroll down în aplicație până la "STEP 5: Advanced Options"
2. Asigură-te că toate checkbox-urile sunt vizibile:
   - ☑ Prevent bloatware reinstall
   - ☑ Security updates only
   - ☑ Disable telemetry
   - ☑ Disable Cortana
   - ☑ Performance optimizations
   - ☑ Skip OOBE screens

### Screenshot:
- Zoom pe secțiunea Advanced Options
- Include header-ul "STEP 5: Advanced Options"
- Toate 6 checkbox-uri trebuie vizibile
- Include nota de jos: "ℹ️ These options will be applied..."

### Salvează ca:
```
screenshots/advanced-options.png
```

---

## 3. 🔨 BUILDING ISO (building-iso.png)

### Setup:
1. Rulează aplicația până la "Create ISO"
2. În timpul creării ISO-ului, captează:
   - Progress bar activ (ex: 50%)
   - Status: "Creating bootable ISO..."
   - Percentage: "50%"

### Screenshot:
- Captează progress section de jos
- Include progress bar
- Include status text
- Include percentage

### Salvează ca:
```
screenshots/building-iso.png
```

---

## 📁 STRUCTURA FOLDER SCREENSHOTS

```
screenshots/
├── main-window.png          # UI principal
├── advanced-options.png     # Secțiunea Advanced Options
└── building-iso.png         # Progress during ISO creation
```

---

## 🎨 TIPS PENTRU SCREENSHOTS PROFESIONALE

### 1. Rezoluție
- Minim: 1920x1080 (Full HD)
- Recomandat: Setează Windows scaling la 100%
- Evită scaling 125% sau 150% (face UI blurry)

### 2. Background
- Închide celelalte aplicații
- Desktop curat (fără icons)
- Dark wallpaper (pentru contrast cu aplicația)

### 3. Calitate
- Format: PNG (NU JPG - pierde calitate)
- Compression: None sau minimal
- Nu resize după - lasă dimensiunea originală

### 4. Lighting (pentru dark UI)
- UI-ul aplicației e dark theme
- Screenshot-urile vor arăta bine pe fundal alb (GitHub)
- Nu e nevoie de editing suplimentar

---

## 🔧 TOOL RECOMANDAT: ShareX

### Download & Setup:
```
1. Download: https://getsharex.com/
2. Install
3. Configurare:
   - After capture: Save image to file
   - Screenshot folder: C:\Screenshots\RaulWin11
   - Image format: PNG
   - Quality: 100%
```

### Hotkeys:
```
Ctrl + Print Screen  = Captează region
Print Screen         = Captează full screen
Alt + Print Screen   = Captează window
```

### Upload direct pe GitHub:
```
ShareX poate face și upload direct pe GitHub
Task settings → Destinations → Image uploader → GitHub
```

---

## 📤 UPLOAD PE GITHUB

### Variantă 1: Manual (simplu)
```
1. Creează folder "screenshots" în repo
2. Drag & drop imaginile în GitHub web interface
3. Commit changes
```

### Variantă 2: Git Command Line
```bash
# În folder-ul proiectului
mkdir screenshots
# Copiază cele 3 imagini în folder
git add screenshots/*.png
git commit -m "Add screenshots for README"
git push
```

---

## 🎯 CHECKLIST FINAL

Înainte de a publica pe GitHub, verifică:

- [ ] Toate 3 screenshots sunt în folder `screenshots/`
- [ ] Rezoluție minim 1920x1080
- [ ] Format PNG (NU JPG)
- [ ] Numele fișierelor sunt corecte:
  - [ ] main-window.png
  - [ ] advanced-options.png
  - [ ] building-iso.png
- [ ] UI-ul e complet vizibil (nu tăiat)
- [ ] Nu sunt informații personale în screenshot
- [ ] Calitate bună (text clar, nu blurry)

---

## 💡 BONUS: GIF Animat (Opțional)

Dacă vrei să faci și un GIF animat pentru README:

### Tool: ScreenToGif
```
Download: https://www.screentogif.com/
```

### Ce să filmezi:
```
1. Deschide aplicația
2. Select ISO → Select Working Dir
3. Extract ISO (accelerat x2)
4. Add autounattend
5. Check toate Advanced Options
6. Create ISO (progress bar accelerat x4)
7. Success message
8. Open folder cu ISO-ul creat
```

### Settings GIF:
- Frame rate: 10-15 fps
- Loop: Yes
- Size: Max 5MB (pentru GitHub)
- Resolution: 1280x720 (mai mic decât screenshots)

### Salvează ca:
```
screenshots/demo.gif
```

### Adaugă în README:
```markdown
![Demo](screenshots/demo.gif)
```

---

## 📝 TEMPLATE PENTRU COMMIT MESSAGE

```
Add screenshots for GitHub README

- Main window interface
- Advanced options panel
- ISO creation progress
```

---

**Gata! Acum ai totul pregătit pentru un README GitHub profesional! 🚀**
