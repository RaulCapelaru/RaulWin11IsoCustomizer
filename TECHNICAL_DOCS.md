# DOCUMENTAȚIE TEHNICĂ - RAULWIN11 ISO CUSTOMIZER

## 📖 Prezentare generală

RAULWIN11 ISO CUSTOMIZER este o aplicație desktop WPF care automatizează procesul de customizare a imaginilor ISO Windows 11, permițând adăugarea fișierului `autounattend.xml` pentru instalări nesupravegheat

## 🎯 Caracteristici principale

### 1. Extragere ISO
- **Montare automată** a ISO-ului folosind PowerShell
- **Copiere fișiere** cu păstrarea structurii de directoare
- **Eliminare atribute read-only** pentru editare
- **Dismontare automată** după extragere
- **Verificare spațiu disc** disponibil

### 2. Adăugare Autounattend.xml

#### Opțiunea A: Descărcare automată RaulWin11
- Download direct de pe GitHub
- URL: `https://raw.githubusercontent.com/RaulCapelaru/Autounattend-for-RAULWIN11-ISO-CUSTOMIZER/main/autounattend.xml`
- Salvare automată în rădăcina ISO-ului

#### Opțiunea B: Fișier custom
- Selectare fișier XML local
- Validare și copiere în ISO
- Suport pentru orice configurație custom

### 3. Creare ISO bootabil
- Folosește **oscdimg.exe** din Windows ADK
- Suport **UEFI** și **Legacy BIOS**
- Boot files:
  - `boot\etfsboot.com` (BIOS)
  - `efi\microsoft\boot\efisys.bin` (UEFI)
- Format **UDF 1.02**
- ISO optimizat pentru boot

### 4. Interfață modernă
- **Design dark theme** profesional
- **Progress tracking** în timp real
- **Status updates** detaliate
- **Validare input** la fiecare pas
- **Mesaje de eroare** clare și utile

## 🏗️ Arhitectură aplicație

### Tehnologii folosite
```
- Framework: .NET 6.0 (WPF)
- UI: XAML cu styling custom
- Backend: C# 10.0
- PowerShell: Pentru operații ISO
- ADK Tools: oscdimg.exe pentru ISO creation
```

### Structura claselor

```csharp
MainWindow
├── isoPath (string) - Calea către ISO-ul original
├── workingDirectory (string) - Directorul de lucru
├── extractedIsoPath (string) - Calea către ISO dezarhivat
├── isIsoExtracted (bool) - Flag pentru extragere completă
└── isAutounattendAdded (bool) - Flag pentru autounattend adăugat

Metode principale:
├── BtnSelectIso_Click() - Selectare fișier ISO
├── BtnSelectWorkDir_Click() - Selectare director lucru
├── BtnExtractIso_Click() - Extragere ISO
├── BtnDownloadAutounattend_Click() - Download autounattend.xml
├── BtnSelectCustomAutounattend_Click() - Selectare custom autounattend
├── BtnCreateIso_Click() - Creare ISO final
├── ExtractIso() - Logică extragere (async)
├── CreateBootableIso() - Logică creare ISO (async)
└── UpdateButtonStates() - Validare și activare butoane
```

## 🔄 Flow-ul aplicației

```
[Start]
   ↓
[Select Windows 11 ISO]
   ↓
[Select Working Directory]
   ↓
[Extract ISO Contents]
   ↓
[Mount ISO → Copy Files → Dismount ISO]
   ↓
[Add Autounattend.xml]
   ↓
[Download RaulWin11 OR Use Custom]
   ↓
[Create Bootable ISO]
   ↓
[oscdimg.exe → Bootable ISO Created]
   ↓
[Done - Open folder with ISO]
```

## 💻 Cerințe sistem

### Minime
- **OS**: Windows 10 (1809+) sau Windows 11
- **RAM**: 4GB
- **Spațiu disc**: 15GB (10GB working + 5GB ISO output)
- **CPU**: Intel/AMD Dual-Core 2.0GHz+
- **Software**: 
  - .NET 6.0 Desktop Runtime
  - Windows ADK (Deployment Tools)
  - PowerShell 5.1+

### Recomandate
- **OS**: Windows 11
- **RAM**: 8GB+
- **Spațiu disc**: 30GB+ SSD
- **CPU**: Intel/AMD Quad-Core 3.0GHz+

## 🛠️ Componente externe

### Windows ADK
**Locații posibile pentru oscdimg.exe:**
```
C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\Oscdimg\oscdimg.exe
C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\x86\Oscdimg\oscdimg.exe
C:\Program Files\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\Oscdimg\oscdimg.exe
```

**Comandă oscdimg pentru creare ISO:**
```bash
oscdimg.exe -m -o -u2 -udfver102 
  -bootdata:2#p0,e,b"boot\etfsboot.com"#pEF,e,b"efi\microsoft\boot\efisys.bin" 
  "C:\ExtractedISO" 
  "C:\Output\Custom.iso"
```

**Parametri:**
- `-m` = Ignore maximum size limit
- `-o` = Optimize storage
- `-u2` = UDF file system
- `-udfver102` = UDF version 1.02
- `-bootdata:2` = Dual boot (BIOS + UEFI)

### PowerShell Scripts

**Montare ISO:**
```powershell
$iso = Mount-DiskImage -ImagePath 'path\to\file.iso' -PassThru
$driveLetter = ($iso | Get-Volume).DriveLetter
```

**Dismontare ISO:**
```powershell
Dismount-DiskImage -ImagePath 'path\to\file.iso'
```

## 📊 Performance

### Timpi estimați (pe SSD)
- **Extragere ISO**: 3-5 minute (4.5GB ISO)
- **Download autounattend**: 1-2 secunde
- **Creare ISO**: 5-8 minute
- **Total proces**: ~10-15 minute

### Timpi estimați (pe HDD)
- **Extragere ISO**: 8-12 minute
- **Creare ISO**: 10-15 minute
- **Total proces**: ~20-30 minute

## 🔒 Securitate

### Validări implementate
- ✅ Verificare existență fișiere
- ✅ Verificare spațiu disc disponibil
- ✅ Validare ISO înainte de procesare
- ✅ Verificare integritate boot files
- ✅ Handling excepții pentru toate operațiile I/O

### Drepturi necesare
- **Administrator**: Recomandat pentru montare ISO
- **File System**: Read/Write în working directory
- **Network**: Pentru download autounattend.xml (HTTPS)

## 🐛 Debugging

### Activare logging (development)
Modifică în `MainWindow.xaml.cs`:
```csharp
private void UpdateStatus(string message)
{
    Dispatcher.Invoke(() =>
    {
        txtStatus.Text = message;
        // Debug logging
        Debug.WriteLine($"[{DateTime.Now:HH:mm:ss}] {message}");
    });
}
```

### Teste recomandate
1. ✅ ISO Windows 11 23H2 original
2. ✅ Diverse locații working directory (C:, D:, etc.)
3. ✅ Download autounattend.xml cu/fără internet
4. ✅ Custom autounattend.xml files
5. ✅ Spațiu disc insuficient (error handling)
6. ✅ ISO deja montat (conflict handling)

## 📈 Posibile îmbunătățiri viitoare

### v1.1
- [ ] Verificare checksum ISO
- [ ] Suport pentru Windows 10
- [ ] Logging în fișier
- [ ] Auto-detect Windows ADK path
- [ ] Preview autounattend.xml înainte de adăugare

### v1.2
- [ ] Multi-language support
- [ ] Teme de culoare (dark/light)
- [ ] Batch processing (multiple ISOs)
- [ ] Integration cu Windows 11 Media Creation Tool
- [ ] Auto-update checker

### v2.0
- [ ] Editor vizual pentru autounattend.xml
- [ ] Pre-built templates pentru diverse scenarii
- [ ] Driver injection support
- [ ] Windows Updates integration
- [ ] Cloud storage integration (OneDrive, Google Drive)

## 📞 Contribuții

Pentru a contribui la proiect:

1. Fork repository-ul
2. Creează un branch pentru feature (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Deschide un Pull Request

## 📝 Changelog

### v1.0.0 (2025-01-03)
- ✨ Release inițial
- ✨ Extragere ISO Windows 11
- ✨ Download autounattend.xml de pe GitHub
- ✨ Suport pentru custom autounattend.xml
- ✨ Creare ISO bootabil UEFI + BIOS
- ✨ UI modern dark theme
- ✨ Progress tracking în timp real

---

**Dezvoltat cu ❤️ de Raul Capelaru**  
**© 2025 Tutoriale cu Raul | MIT License**
