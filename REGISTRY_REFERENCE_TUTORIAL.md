# 📋 REGISTRY REFERENCE - RAULWIN11 ISO CUSTOMIZER

## Pentru Tutorial YouTube - Registry Paths Complete

---

## 🎯 REZUMAT RAPID

### Ce modifică Camera & Microphone?
**NIMIC** - User alege la prima utilizare! ✅

### Ce modifică Location?
**Deny** - Blocat by default (poate fi activat manual)

### Ce modifică Windows Permissions?
**TOATE dezactivate** - General, Speech, Inking, Diagnostics, Search

---

## 📸 1. CAMERA & MICROPHONE (USER CHOICE)

### 1.1 Camera Permission - NU SE MODIFICĂ
**Path:**
```
HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam
```
**Value Name:** `Value`  
**Type:** `REG_SZ`  
**Data:** **NU SE SETEAZĂ** ← Windows va întreba user-ul la prima utilizare  
**Opțiuni:** `Allow` / `Deny` / `Prompt`

---

### 1.2 Microphone Permission - NU SE MODIFICĂ
**Path:**
```
HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone
```
**Value Name:** `Value`  
**Type:** `REG_SZ`  
**Data:** **NU SE SETEAZĂ** ← Windows va întreba user-ul la prima utilizare  
**Opțiuni:** `Allow` / `Deny` / `Prompt`

---

### 1.3 Location Permission - DENY BY DEFAULT
**Path:**
```
HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location
```
**Value Name:** `Value`  
**Type:** `REG_SZ`  
**Data:** `Deny`  
**Efect:** Location blocat by default (poate fi activat din Settings)

---

## 🔒 2. WINDOWS PERMISSIONS - GENERAL

### 2.1 Advertising ID
**Path:**
```
HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo
```
**Value:** `Enabled` = `0` (REG_DWORD)

**Plus Policy:**
```
HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo
```
**Value:** `DisabledByGroupPolicy` = `1` (REG_DWORD)

**Efect:** Blochează tracking prin Advertising ID

---

### 2.2 Local Content (Language List)
**Path:**
```
HKEY_CURRENT_USER\Control Panel\International\User Profile
```
**Value:** `HttpAcceptLanguageOptOut` = `1` (REG_DWORD)

**Efect:** Nu permite website-urilor să vadă lista de limbi

---

### 2.3 App Launches & Suggested Apps
**Path:**
```
HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager
```
**Values:**
- `SilentInstalledAppsEnabled` = `0`
- `ContentDeliveryAllowed` = `0`
- `PreInstalledAppsEnabled` = `0`
- `SubscribedContent-338388Enabled` = `0`
- `SubscribedContent-338389Enabled` = `0`

**Efect:** Stop tracking app launches + suggested apps

---

### 2.4 Settings Suggestions
**Path:**
```
HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Privacy
```
**Value:** `TailoredExperiencesWithDiagnosticDataEnabled` = `0` (REG_DWORD)

**Efect:** Nu mai arată suggestions în Settings

---

## 🎤 3. SPEECH PERMISSIONS

### 3.1 Online Speech Recognition
**Path:**
```
HKEY_CURRENT_USER\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy
```
**Value:** `HasAccepted` = `0` (REG_DWORD)

**Plus Policy:**
```
HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\InputPersonalization
```
**Value:** `AllowInputPersonalization` = `0` (REG_DWORD)

**Efect:** Dezactivează online speech recognition pentru dictare

---

## ✍️ 4. INKING & TYPING PERSONALIZATION

### 4.1 Restrict Ink Collection
**Path:**
```
HKEY_CURRENT_USER\Software\Microsoft\InputPersonalization
```
**Value:** `RestrictImplicitInkCollection` = `1` (REG_DWORD)

---

### 4.2 Restrict Text Collection
**Path:**
```
HKEY_CURRENT_USER\Software\Microsoft\InputPersonalization
```
**Value:** `RestrictImplicitTextCollection` = `1` (REG_DWORD)

---

### 4.3 Harvest Contacts
**Path:**
```
HKEY_CURRENT_USER\Software\Microsoft\InputPersonalization\TrainedDataStore
```
**Value:** `HarvestContacts` = `0` (REG_DWORD)

---

### 4.4 Personalization Policy
**Path:**
```
HKEY_CURRENT_USER\Software\Microsoft\Personalization\Settings
```
**Value:** `AcceptedPrivacyPolicy` = `0` (REG_DWORD)

**Efect:** Blochează colectarea de date pentru personalizarea typing/handwriting

---

## 📊 5. DIAGNOSTICS & FEEDBACK

### 5.1 Core Telemetry
**Path:**
```
HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection
```
**Values:**
- `AllowTelemetry` = `0` (REG_DWORD)
- `DoNotShowFeedbackNotifications` = `1` (REG_DWORD)

---

### 5.2 Event Transcript
**Path:**
```
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack\EventTranscriptKey
```
**Value:** `EnableEventTranscript` = `0` (REG_DWORD)

---

### 5.3 Feedback Frequency (SIUF)
**Path:**
```
HKEY_CURRENT_USER\Software\Microsoft\Siuf\Rules
```
**Values:**
- `NumberOfSIUFInPeriod` = `0` (REG_DWORD)
- `PeriodInNanoSeconds` = `0` (REG_DWORD)

**Efect:** Elimină complet feedback requests

---

## 🔍 6. SEARCH PERMISSIONS

### 6.1 Cloud Search (Azure AD)
**Path:**
```
HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SearchSettings
```
**Value:** `IsAADCloudSearchEnabled` = `0` (REG_DWORD)

---

### 6.2 Cloud Search (Microsoft Account)
**Path:**
```
HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SearchSettings
```
**Value:** `IsMSACloudSearchEnabled` = `0` (REG_DWORD)

---

### 6.3 Safe Search
**Path:**
```
HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SearchSettings
```
**Value:** `SafeSearchMode` = `0` (REG_DWORD)

**Efect:** Blochează cloud search și indexing în cloud

---

## 📋 7. TABEL REZUMATIV PENTRU TUTORIAL

| Category | Path Root | Modified? | Default Value |
|----------|-----------|-----------|---------------|
| **Camera** | HKCU\\...\\ConsentStore\\webcam | ❌ NO | User choice |
| **Microphone** | HKCU\\...\\ConsentStore\\microphone | ❌ NO | User choice |
| **Location** | HKCU\\...\\ConsentStore\\location | ✅ YES | Deny |
| **General** | HKCU\\...\\AdvertisingInfo | ✅ YES | Disabled |
| **Speech** | HKCU\\...\\OnlineSpeechPrivacy | ✅ YES | Disabled |
| **Inking** | HKCU\\...\\InputPersonalization | ✅ YES | Restricted |
| **Diagnostics** | HKLM\\...\\DataCollection | ✅ YES | Minimal/Off |
| **Search** | HKCU\\...\\SearchSettings | ✅ YES | Cloud off |

---

## 🎬 GHID PENTRU TUTORIAL (DEMO LIVE)

### Pas 1: Arată ÎNAINTE de tweaks
```
1. Deschide regedit.exe
2. Navighează la: HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo
3. Arată că "Enabled" = 1 (activat)
4. Settings → Privacy & security → General → Advertising ID = ON
```

### Pas 2: Instalează Windows cu RaulWin11 ISO

### Pas 3: Arată DUPĂ tweaks
```
1. Deschide regedit.exe
2. Navighează la: HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo
3. Arată că "Enabled" = 0 (dezactivat)
4. Settings → Privacy & security → General → Advertising ID = OFF
```

### Pas 4: Demonstrează Camera/Microphone
```
1. Deschide Camera app
2. Windows va întreba: "Let Camera access your camera?"
3. User alege Allow sau Deny
4. Arată în regedit că acum există valoarea
```

---

## 🔧 COMENZI RAPIDE PENTRU VERIFICARE

### PowerShell - Verifică Advertising ID
```powershell
Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Name "Enabled"
```

### PowerShell - Verifică Telemetry
```powershell
Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry"
```

### PowerShell - Verifică Camera Permission
```powershell
Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam" -Name "Value" -ErrorAction SilentlyContinue
```

---

## 💡 NOTIȚE IMPORTANTE PENTRU TUTORIAL

### ✅ CE SĂ MENȚIONEZI:

1. **Camera & Microphone NU sunt blocate**
   - User are control complet
   - Windows va întreba la prima utilizare
   - E mai sigur decât să le lași active by default

2. **Location E blocat by default**
   - Poate fi activat oricând din Settings
   - Majoritatea nu au nevoie de location pe desktop

3. **Toate celelalte sunt dezactivate**
   - Îmbunătățește privacy
   - Reduce tracking
   - Mai puține date trimise la Microsoft

### ❌ CE SĂ EVIȚI:

1. Nu spune că "blocăm camera" - e fals!
2. Nu spune că "nu poți folosi microfonul" - poți!
3. Nu spune că "setările nu pot fi schimbate" - pot fi!

---

## 📖 GLOSSAR TERMENI PENTRU TUTORIAL

- **HKLM** = HKEY_LOCAL_MACHINE (system-wide, pentru toți userii)
- **HKCU** = HKEY_CURRENT_USER (per-user, doar pentru userul curent)
- **REG_DWORD** = Number value (0 sau 1, de obicei)
- **REG_SZ** = String value (text)
- **Deny/Allow/Prompt** = Valori pentru permissions (Blocat/Permis/Întreabă)

---

**Made with ❤️ for RAULWIN11 ISO CUSTOMIZER**  
**© 2025 Raul Capelaru | Tutoriale cu Raul**
