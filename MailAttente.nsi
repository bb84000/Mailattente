;NSIS Modern User Interface
; BB - march 2013
;Installation script for MailAttente

;--------------------------------
;Include Modern UI

  !include "MUI2.nsh"
  ;include MUI_LANGUE_DISPLAY and CloseApp macros

  !include "${NSISDIR}\Contrib\Modern UI\BB.nsh"
  
  !include "FileFunc.nsh"
  
;--------------------------------
;Configuration

 ;General
  Name "MailAttente"
  OutFile "InstallMailAttente.exe"
 !define source_dir "C:\Users\Bernard\delphi\sdtp\Mailattente"

   RequestExecutionLevel admin

  ;Windows 8 manifest
  ;!packhdr "$%TEMP%\exehead.tmp" '"${NSISDIR}\mt.exe" -manifest "${NSISDIR}\app.manifest" -updateresource:"$%TEMP%\exehead.tmp"'
   ManifestSupportedOS all
  
  !define MUI_ICON "${source_dir}\images\mainicon.ico"
  !define MUI_UNICON "${source_dir}\images\mainicon.ico"

  ;Folder selection page
  InstallDir "$PROGRAMFILES\MailAttente"

  ;Get install folder from registry if available
  InstallDirRegKey HKCU "Software\SDTP\MailAttente" "InstallDir"

  ;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING

;--------------------------------
;Language Selection Dialog Settings

  ;Remember the installer language
  !define MUI_LANGDLL_REGISTRY_ROOT "HKCU"
  !define MUI_LANGDLL_REGISTRY_KEY "Software\SDTP\MailAttente"
  !define MUI_LANGDLL_REGISTRY_VALUENAME "Installer Language"
  ;!define MUI_WELCOMEPAGE_TITLE_3LINES
  !define MUI_FINISHPAGE_SHOWREADME
  !define MUI_FINISHPAGE_SHOWREADME_TEXT "$(Check_box)"
  !define MUI_FINISHPAGE_SHOWREADME_FUNCTION inst_shortcut
  !define MUI_FINISHPAGE_SHOWREADME_NOTCHECKED
  !define MUI_FINISHPAGE_RUN "$INSTDIR\MailAttente.exe"
  !define MUI_FINISHPAGE_RUN_TEXT "$(Exec_Box)"
;-----------------------------
;Pages


  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_LICENSE $(licence)
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_DEFAULT MUI_FINISHPAGE_TEXT_REBOOT "$(MUI_${MUI_PAGE_UNINSTALLER_PREFIX}TEXT_FINISH_INFO_REBOOT)"
  !insertmacro MUI_PAGE_FINISH

  !insertmacro MUI_UNPAGE_WELCOME
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  !insertmacro MUI_UNPAGE_FINISH

;--------------------------------
;Languages

  !insertmacro MUI_LANGUAGE "English"
  !insertmacro MUI_LANGUAGE "French"
  
 

  LangString DescStr ${LANG_ENGLISH}  "POP3 mail check"
  LangString DescStr ${LANG_FRENCH} "Vérification de courrier POP3"

  
  ;Licence langage file
  LicenseLangString Licence ${LANG_ENGLISH} "${source_dir}\license.txt"
  LicenseLangString Licence ${LANG_FRENCH}  "${source_dir}\licensf.txt"

  ;Language strings for uninstall string
  LangString RemoveStr ${LANG_ENGLISH}  "MailAttente (remove only)"
  LangString RemoveStr ${LANG_FRENCH} "MailAttente (désinstallation seulement)"

  ;Language string for links
  LangString UninstLnkStr ${LANG_ENGLISH} "MailAttente uninstall.lnk"
  LangString UninstLnkStr ${LANG_FRENCH} "Désinstallation de MailAttente.lnk"

  ;Language string for help
  LangString HelpStr ${LANG_ENGLISH} "MailAttente help.lnk"
  LangString HelpStr ${LANG_FRENCH} "Aide de MailAttente.lnk"

  ;Language strings for language selection dialog
  LangString LangDialog_Title ${LANG_ENGLISH} "Installer Language|$(^CancelBtn)"
  LangString LangDialog_Title ${LANG_FRENCH} "Langue d'installation|$(^CancelBtn)"

  LangString LangDialog_Text ${LANG_ENGLISH} "Please select the installer language."
  LangString LangDialog_Text ${LANG_FRENCH} "Choisissez la langue du programme d'installation."

  ;language strings for checkbox
  LangString Check_box ${LANG_ENGLISH} "Install a shortcut on the desktop"
  LangString Check_box ${LANG_FRENCH} "Installer un raccourci sur le bureau"
  
  LangString Exec_Box ${LANG_ENGLISH} "Launch MailAttente now"
  LangString Exec_Box ${LANG_FRENCH} "Lancer MailAttente maintenant"


  !execute '"${NSISDIR}\GetVersion.exe" "${source_dir}\MailAttente.exe" "NSIS"'
  !include "${source_dir}\version.txt"

  ;Version Information
  VIProductVersion "${FileVersion}"
  VIAddVersionKey /LANG=${LANG_FRENCH} "FileVersion" "${FileVersion}"
  VIAddVersionKey /LANG=${LANG_FRENCH} "ProductName" "InstallMailAttente"
  VIAddVersionKey /LANG=${LANG_FRENCH} "ProductVersion" "${FileVersion}"
  VIAddVersionKey /LANG=${LANG_FRENCH} "CompanyName" "${CompanyName}"
  VIAddVersionKey /LANG=${LANG_FRENCH} "FileDescription" "Installation de ${FileDescription}"
  VIAddVersionKey /LANG=${LANG_FRENCH} "InternalName" "InstallMailAttente.exe"
  VIAddVersionKey /LANG=${LANG_FRENCH} "LegalCopyright" "${LegalCopyright} - ${__DATE__}"
  ;VIAddVersionKey /LANG=${LANG_FRENCH} "LegalTrademarks" "${LegalTrademarks}"
  ;name $(NameStr)

Section "Dummy Section" SecDummy
 SetShellVarContext all
  SetOutPath "$INSTDIR"
  ; Dans le cas ou on n'aurait pas pu fermer l'application
  Delete /REBOOTOK "$INSTDIR\MailAttente.exe"
  File "/oname=MailAttente.tmp" "${source_dir}\MailAttente.exe"
  Delete /REBOOTOK "$INSTDIR\libeay32.dll"
  File "/oname=libeay32.tmp" "${source_dir}\libeay32.dll"
  Delete /REBOOTOK "$INSTDIR\ssleay32.dll"
  File "/oname=ssleay32.tmp" "${source_dir}\ssleay32.dll"

  ; add files / whatever that need to be installed here.
  File "${source_dir}\Aide\MailAttente.chm"
  File "${source_dir}\MailAttente.lng"
  File "${source_dir}\history.txt"
  File "${source_dir}\MailAttente.txt"
  Rename /REBOOTOK "$INSTDIR\MailAttente.tmp" "$INSTDIR\MailAttente.exe"
  Rename /REBOOTOK "$INSTDIR\libeay32.tmp" "$INSTDIR\libeay32.dll"
  Rename /REBOOTOK "$INSTDIR\ssleay32.tmp" "$INSTDIR\ssleay32.dll"
  
  ; write out uninstaller
  WriteUninstaller "$INSTDIR\uninst.exe"

  ;Taille Répertoire pour uninstall
  ${GetSize} "$INSTDIR" "/M=*.* /S=0K /G=1" $0 $1 $2

  ;Write uninstall in register
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\MailAttente" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\MailAttente" "DisplayName" "$(RemoveStr)"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\MailAttente"  "DisplayIcon" "$INSTDIR\uninst.exe"
  WriteRegDWORD HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\MailAttente" "EstimatedSize" $0
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\MailAttente" "DisplayVersion" "${FileVersion}"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\MailAttente" "Publisher" "SDTP"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\MailAttente" "URLInfoAbout" "www.sdtp.com"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\MailAttente" "HelpLink" "www.sdtp.com"
  


  ;Write language to the registry (for the uninstaller)
  ;WriteRegStr HKCU "Software\SDTP\MMTVRecorder" "Installer Language" "$LANGUAGE"

  ;Store install folder
  WriteRegStr HKCU "Software\SDTP\MailAttente" "InstallDir" $INSTDIR


SectionEnd ; end of default section


; Install shortcuts, language dependant

Section "Start Menu Shortcuts"
 SetShellVarContext all
  CreateDirectory "$SMPROGRAMS\MailAttente"
  CreateShortCut  "$SMPROGRAMS\MailAttente\MailAttente.lnk" "$INSTDIR\MailAttente.exe" "" "$INSTDIR\MailAttente.exe" 0 \
                   SW_SHOWNORMAL "" "$(DescStr)"

  CreateShortCut  "$SMPROGRAMS\MailAttente\$(HelpStr)" "$INSTDIR\MailAttente.chm" "" "$INSTDIR\MailAttente.chm" 0
  CreateShortCut  "$SMPROGRAMS\MailAttente\$(UninstLnkStr)" "$INSTDIR\uninst.exe" "" "$INSTDIR\uninst.exe" 0
 
SectionEnd

;Uninstaller Section

Section Uninstall
 SetShellVarContext all
; ON ferme l'application avant de la désinstaller

; add delete commands to delete whatever files/registry keys/etc you installed here.
Delete "$INSTDIR\MailAttente.chm"
Delete "$INSTDIR\history.txt"
Delete "$INSTDIR\MailAttente.txt"
Delete "$INSTDIR\MailAttente.lng"
Delete /REBOOTOK "$INSTDIR\libeay32.dll"
Delete /REBOOTOK "$INSTDIR\ssleay32.dll"
Delete /REBOOTOK "$INSTDIR\MailAttente.exe"
Delete "$INSTDIR\uninst.exe"

; remove shortcuts, if any.
  Delete  "$SMPROGRAMS\MailAttente\MailAttente.lnk"
  Delete  "$DESKTOP\MailAttente.lnk"
  Delete "$SMPROGRAMS\MailAttente\$(HelpStr)"
  Delete "$SMPROGRAMS\MailAttente\$(UninstLnkStr)"

; remove directories used.
  RMDir "$SMPROGRAMS\MailAttente"
  RMDir "$INSTDIR"

DeleteRegKey HKCU "Software\SDTP\MailAttente"
DeleteRegKey HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\MailAttente"
DeleteRegValue HKCU "Software\Microsoft\Windows\CurrentVersion\Run" "MailAttente"

SectionEnd ; end of uninstall section


Function .onInit
   !define MUI_LANGDLL_WINDOWTITLE "$(LangDialog_Title)"
  !define MUI_LANGDLL_INFO "$(LangDialog_Text)"
  !insertmacro MUI_LANGDLL_DISPLAY         ; To use the button localization
  !insertmacro Close_App "TFMailAtt"   ; On ferme l'appli avant d'installer la nouvelle version
FunctionEnd


Function un.onInit
 ;Get language from registry
 !insertmacro MUI_UNGETLANGUAGE
 !insertmacro Close_App "TFMailAtt"    ; On ferme l'appli avant de désinstaller
FunctionEnd

Function inst_shortcut
  CreateShortCut "$DESKTOP\MailAttente.lnk" "$INSTDIR\MailAttente.exe" "" "$INSTDIR\MailAttente.exe" 0 \
                   SW_SHOWNORMAL "" "$(DescStr)"
FunctionEnd

