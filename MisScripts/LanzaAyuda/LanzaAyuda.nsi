;NSIS Modern User Interface
;Welcome/Finish Page Example Script
;Written by Joost Verburg

;--------------------------------
;Include Modern UI

  !include "MUI2.nsh"

;--------------------------------
;General

  ;Name and file
  Name "Modern UI Test"
  OutFile "InstaladorLanzaAyuda.exe"
  Unicode True

  ;Default installation folder
  InstallDir "$LOCALAPPDATA"

  ;Get installation folder from registry if available
  InstallDirRegKey HKCU "Software\Modern UI Test" ""

  ;Request application privileges for Windows Vista
  RequestExecutionLevel user

;--------------------------------
;Variables



;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING

;--------------------------------
;Pages

  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_LICENSE "D:\MisScripts\License.txt"
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_PAGE_FINISH

  !insertmacro MUI_UNPAGE_WELCOME
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  !insertmacro MUI_UNPAGE_FINISH

;--------------------------------
;Languages

  !insertmacro MUI_LANGUAGE "Spanish"

;--------------------------------
;Installer Sections

Section "Lanza Ayuda" SecDummy
  InitPluginsDir
  SetOutPath "$INSTDIR"

  
  ;ADD YOUR OWN FILES HERE...

  File /r "LanzaAyuda.7z"
  Nsis7z::ExtractWithCallback "$INSTDIR\LanzaAyuda.7z"
  Delete "$INSTDIR\LanzaAyuda.7z"


  ;Store installation folder
  WriteRegStr HKCU "SOFTWARE\LanzaAyuda" "Install_Dir" "$INSTDIR"

  ;Create uninstaller
  WriteUninstaller "$INSTDIR\UninstallLanzaAyuda.exe"



SectionEnd

Section "Start Menu"
  CreateDirectory "$SMPROGRAMS\LanzaAyuda"
  CreateShortcut "$SMPROGRAMS\LanzaAyuda\LanzaAyuda.lnk" "$INSTDIR\LanzaAyuda.jar"
  CreateShortcut "$SMPROGRAMS\LanzaAyuda\UninstallLanzaAyuda.lnk" "$INSTDIR\UninstallLanzaAyuda.exe"

SectionEnd

;--------------------------------
;Descriptions

  ;Language strings
  LangString DESC_SecDummy ${LANG_SPANISH} "A test section."

  ;Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${SecDummy} $(DESC_SecDummy)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------
;Uninstaller Section

Section "Uninstall"

  ;ADD YOUR OWN FILES HERE...

  
  RMDir /r "$INSTDIR\lib"
  Delete "$INSTDIR\UninstallLanzaAyuda.exe"
  Delete "$INSTDIR\README.TXT"
  Delete "$INSTDIR\LanzaAyuda.jar"
  RMDir /r "$SMPROGRAMS\LanzaAyuda"

  DeleteRegKey HKCU "SOFTWARE\LanzaAyuda"

SectionEnd
