; RAULWIN11 ISO CUSTOMIZER - Inno Setup Script
; Version 1.0.0

#define MyAppName "RAULWIN11 ISO CUSTOMIZER"
#define MyAppVersion "1.0.0"
#define MyAppPublisher "Raul Capelaru - Tutoriale cu Raul"
#define MyAppURL "https://tutorialecuraul.ro"
#define MyAppExeName "RaulWin11IsoCustomizer.exe"
#define MyAppId "{{B8E9F7A4-5C3D-4E2B-9A1F-8D6C3E4F2A5B}"

[Setup]
; Basic App Info
AppId={#MyAppId}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
AppCopyright=Copyright © 2025 Raul Capelaru

; Default installation directory
DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}

; Output directory and filename
OutputDir=installer
OutputBaseFilename=RaulWin11IsoCustomizer-Setup-v{#MyAppVersion}

; Compression
Compression=lzma2/max
SolidCompression=yes

; Installer UI
WizardStyle=modern
UninstallDisplayIcon={app}\{#MyAppExeName}

; Architecture
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible

; Privileges
PrivilegesRequired=admin
PrivilegesRequiredOverridesAllowed=dialog

; License
LicenseFile=LICENSE

; Misc
DisableProgramGroupPage=yes
DisableWelcomePage=no

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
; Main executable (self-contained .NET 8 publish output)
Source: "publish\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion

; Include all other files from publish directory
Source: "publish\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

; Documentation
Source: "README.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "QUICK_START.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "LICENSE"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
; Start Menu shortcut
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{group}\Quick Start Guide"; Filename: "{app}\QUICK_START.md"
Name: "{group}\README"; Filename: "{app}\README.md"

; Desktop shortcut (optional)
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
; Option to launch after installation
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[Code]
function IsDotNet8Installed: Boolean;
var
  ResultCode: Integer;
begin
  // Check if .NET 8 Desktop Runtime is installed
  Result := Exec('dotnet', '--list-runtimes', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
end;

function InitializeSetup: Boolean;
begin
  Result := True;
  
  // Note: Since we're using self-contained deployment, 
  // .NET 8 Runtime is NOT required to be installed separately
  // The app includes everything it needs
end;

procedure CurStepChanged(CurStep: TSetupStep);
var
  ResultCode: Integer;
begin
  if CurStep = ssPostInstall then
  begin
    // Optional: Add any post-installation tasks here
  end;
end;

[Messages]
WelcomeLabel2=This will install [name/ver] on your computer.%n%nThis application allows you to create custom Windows 11 ISO images with autounattend.xml.%n%nREQUIREMENTS:%n- Windows 10/11 (64-bit)%n- Windows ADK (Deployment Tools)%n- Minimum 15GB free space%n%nClick Next to continue.
