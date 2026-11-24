Unicode true
!include "MUI2.nsh"
!include "LogicLib.nsh"
!include "FileFunc.nsh"

!define PRODUCT_NAME "NexForge · 连接锻造"
!define PRODUCT_VERSION "3.0.1"
!define PRODUCT_PUBLISHER "NexForge"
!define APP_EXE "游戏开发工作台.exe"
!define STAGE "[local release folder]\staging\NexForge-3.0.1"
!define INSTALL_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\NexForge"

Name "${PRODUCT_NAME}"
OutFile "[local release folder]\NexForge-连接锻造-3.0.1-Setup.exe"
InstallDir "$LOCALAPPDATA\Programs\NexForge"
InstallDirRegKey HKCU "${INSTALL_KEY}" "InstallLocation"
RequestExecutionLevel user
SetCompressor /SOLID lzma
SetCompressorDictSize 64
BrandingText "NexForge · 本地游戏设计与生产工作站"

VIProductVersion "3.0.1.0"
VIAddVersionKey /LANG=2052 "ProductName" "${PRODUCT_NAME}"
VIAddVersionKey /LANG=2052 "ProductVersion" "${PRODUCT_VERSION}"
VIAddVersionKey /LANG=2052 "FileDescription" "NexForge 安装程序"
VIAddVersionKey /LANG=2052 "FileVersion" "3.0.1.0"
VIAddVersionKey /LANG=2052 "CompanyName" "${PRODUCT_PUBLISHER}"
VIAddVersionKey /LANG=2052 "LegalCopyright" "NexForge"

!define MUI_ABORTWARNING
!define MUI_ICON "[local release folder]\installer\NexForge.ico"
!define MUI_UNICON "[local release folder]\installer\NexForge.ico"
!define MUI_WELCOMEPAGE_TITLE "安装 ${PRODUCT_NAME}"
!define MUI_WELCOMEPAGE_TEXT "安装程序会把 NexForge 安装到当前用户目录，不需要管理员权限。$\r$\n$\r$\n首次启动是全新状态：没有项目、资产库、模型配置或使用记录。"
!define MUI_FINISHPAGE_RUN "$INSTDIR\${APP_EXE}"
!define MUI_FINISHPAGE_RUN_TEXT "启动 ${PRODUCT_NAME}"
!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\README-使用说明.txt"
!define MUI_FINISHPAGE_SHOWREADME_TEXT "查看使用说明"

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

!insertmacro MUI_LANGUAGE "SimpChinese"

Section "NexForge 主程序" SecMain
  SectionIn RO
  SetOutPath "$INSTDIR"
  SetOverwrite on
  File /r "${STAGE}\*"
  WriteUninstaller "$INSTDIR\Uninstall.exe"

  CreateDirectory "$SMPROGRAMS\NexForge"
  CreateShortCut "$SMPROGRAMS\NexForge\${PRODUCT_NAME}.lnk" "$INSTDIR\${APP_EXE}" "" "$INSTDIR\${APP_EXE}" 0
  CreateShortCut "$DESKTOP\${PRODUCT_NAME}.lnk" "$INSTDIR\${APP_EXE}" "" "$INSTDIR\${APP_EXE}" 0
  CreateShortCut "$SMPROGRAMS\NexForge\卸载 NexForge.lnk" "$INSTDIR\Uninstall.exe"

  WriteRegStr HKCU "${INSTALL_KEY}" "DisplayName" "${PRODUCT_NAME}"
  WriteRegStr HKCU "${INSTALL_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr HKCU "${INSTALL_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
  WriteRegStr HKCU "${INSTALL_KEY}" "DisplayIcon" "$INSTDIR\${APP_EXE}"
  WriteRegStr HKCU "${INSTALL_KEY}" "InstallLocation" "$INSTDIR"
  WriteRegStr HKCU "${INSTALL_KEY}" "UninstallString" '"$INSTDIR\Uninstall.exe"'
  WriteRegStr HKCU "${INSTALL_KEY}" "QuietUninstallString" '"$INSTDIR\Uninstall.exe" /S'
  WriteRegDWORD HKCU "${INSTALL_KEY}" "NoModify" 1
  WriteRegDWORD HKCU "${INSTALL_KEY}" "NoRepair" 1
SectionEnd

Section "Uninstall"
  SetShellVarContext current
  Delete "$DESKTOP\${PRODUCT_NAME}.lnk"
  Delete "$SMPROGRAMS\NexForge\${PRODUCT_NAME}.lnk"
  Delete "$SMPROGRAMS\NexForge\卸载 NexForge.lnk"
  RMDir "$SMPROGRAMS\NexForge"

  DeleteRegKey HKCU "${INSTALL_KEY}"
  RMDir /r "$INSTDIR"
SectionEnd