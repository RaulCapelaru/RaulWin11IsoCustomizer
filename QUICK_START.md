# 🚀 QUICK START GUIDE - RAULWIN11 ISO CUSTOMIZER

## ⏱️ Ghid rapid (5 minute)

### Pregătire (o singură dată)

1. **Instalează .NET 6.0 Desktop Runtime**
   - 📥 Download: https://dotnet.microsoft.com/download/dotnet/6.0
   - ⚙️ Rulează installer-ul
   - 🔄 Restart PC (opțional dar recomandat)

2. **Instalează Windows ADK**
   - 📥 Download: https://go.microsoft.com/fwlink/?linkid=2243390
   - ⚙️ La instalare, bifează DOAR: **Deployment Tools**
   - ⏳ Așteaptă ~10-15 minute pentru download și instalare

### Utilizare aplicație

#### PASUL 1: Pornește aplicația
```
✅ Dublu-click pe RaulWin11IsoCustomizer.exe
✅ Dacă apare warning de Windows Defender, click "More info" → "Run anyway"
✅ Dacă cere Administrator rights, dă Accept
```

#### PASUL 2: Selectează ISO-ul (30 secunde)
```
📀 Click pe "Browse ISO"
📂 Selectează fișierul Windows11_xxxx.iso
✅ Verifică că path-ul apare în aplicație
```

#### PASUL 3: Alege folder de lucru (30 secunde)
```
📁 Click pe "Browse Folder"
💾 Alege un folder cu minim 10GB liber (de preferință pe SSD)
✅ Recomandare: C:\RaulWin11Working sau D:\IsoWork
```

#### PASUL 4: Extrage ISO-ul (3-5 minute)
```
⚙️ Click pe "Extract ISO"
⏳ Așteaptă 3-5 minute (vezi progress bar)
✅ Mesaj de succes: "ISO extracted successfully!"
```

#### PASUL 5A: Download autounattend RaulWin11 (5 secunde)
```
🌐 Click pe "Download RaulWin11 Autounattend.xml"
⏳ Așteaptă 2-5 secunde pentru download
✅ Status devine verde: "✓ RaulWin11 autounattend.xml added"
```

**SAU**

#### PASUL 5B: Folosește propriul autounattend (10 secunde)
```
📄 Click pe "Use My Custom Autounattend.xml"
📂 Selectează fișierul tău .xml
✅ Status devine verde cu numele fișierului tău
```

#### PASUL 6: Creează ISO-ul custom (5-8 minute)
```
💿 Click pe "Create Custom ISO"
💾 Alege locația de salvare (ex: Desktop\RaulWin11_Custom.iso)
⏳ Așteaptă 5-8 minute (vezi progress bar)
✅ Mesaj: "Custom Windows 11 ISO created successfully!"
📁 Click "Yes" pentru a deschide folder-ul cu ISO-ul
```

## ✨ Gata! ISO-ul tău customizat este pregătit!

---

## 📋 Checklist complet

- [ ] .NET 6.0 Desktop Runtime instalat
- [ ] Windows ADK (Deployment Tools) instalat
- [ ] Minim 15GB spațiu liber pe hard disk
- [ ] Windows 11 ISO original descărcat
- [ ] Aplicația RaulWin11IsoCustomizer.exe descărcată

## ⏱️ Timpi estimați

| Operație | SSD | HDD |
|----------|-----|-----|
| Extragere ISO | 3-5 min | 8-12 min |
| Download autounattend | 2-5 sec | 2-5 sec |
| Creare ISO | 5-8 min | 10-15 min |
| **TOTAL** | **~10-15 min** | **~20-30 min** |

## 🎯 Ce face autounattend.xml?

Fișierul RaulWin11 autounattend.xml configurează automat:

✅ **Skip Microsoft Account** - instalare cu cont local  
✅ **Disable telemetry** - fără tracking  
✅ **Remove bloatware** - Windows curat  
✅ **Optimize performance** - setări optimizate  
✅ **Custom settings** - configurare automată  

## 💡 Tips & Tricks

### Tip #1: Folosește SSD
💨 Procesul e mult mai rapid pe SSD (10 min vs 30 min pe HDD)

### Tip #2: Păstrează folder-ul de lucru
📁 După ce creezi ISO-ul, poți șterge folder-ul de lucru pentru a elibera spațiu

### Tip #3: Testează ISO-ul în VM
🖥️ Testează ISO-ul creat într-o mașină virtuală (VirtualBox, VMware) înainte de instalarea pe hardware real

### Tip #4: Creează USB bootabil
💾 Folosește Rufus pentru a crea stick USB bootabil cu ISO-ul customizat:
- Download Rufus: https://rufus.ie
- Selectează USB stick (minim 8GB)
- Selectează ISO-ul RaulWin11_Custom.iso
- Start și așteaptă finalizarea

### Tip #5: Backup ISO-ul original
💾 Păstrează întotdeauna o copie a ISO-ului original Windows 11

## ❓ Probleme comune - Soluții rapide

### "oscdimg.exe not found"
**Soluție**: Reinstalează Windows ADK și bifează "Deployment Tools"

### "Failed to mount ISO"
**Soluție**: Rulează aplicația ca Administrator (click dreapta → Run as administrator)

### "Not enough disk space"
**Soluție**: Eliberează minim 15GB pe disc sau alege alt folder de lucru

### Aplicația nu pornește
**Soluție**: Instalează/Reinstalează .NET 6.0 Desktop Runtime

### ISO-ul creat nu bootează
**Soluție**: 
1. Verifică că ai folosit ISO original Windows 11
2. Creează USB cu Rufus în modul GPT pentru UEFI
3. Testează în VM pentru validare

## 📞 Ajutor suplimentar

🎥 **Video Tutorial**: [Tutoriale cu Raul](https://tutorialecuraul.ro)  
📝 **GitHub Issues**: [Report a problem](https://github.com/RaulCapelaru/RaulWin11IsoCustomizer/issues)  
📧 **Email Support**: Prin site-ul tutorialecuraul.ro  

## ⭐ Mulțumesc că folosești RAULWIN11 ISO CUSTOMIZER!

**Made with ❤️ by Raul Capelaru**  
**© 2025 Tutoriale cu Raul**

---

*Dacă aplicația ți-a fost utilă, lasă un ⭐ pe GitHub și distribuie-o prietenilor!*
