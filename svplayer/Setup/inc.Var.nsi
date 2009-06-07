SetCompressor /SOLID lzma

 
;Name and file
Name "射手影音播放器"
Caption "射手影音播放器安装程序"
BrandingText "射手影音播放器"


AutoCloseWindow true
SetDateSave on
SetDatablockOptimize on
CRCCheck off
SilentInstall normal
;BGGradient 000000 800000 FFFFFF
InstallColors FF8080 000030
XPStyle on

;Default installation folder
InstallDir "$PROGRAMFILES\SVPlayer"


InstallDirRegKey HKLM "Software\SVPlayer "Install_Dir"

;!include registry.nsh

;!insertmacro COPY_REGISTRY_KEY



;--------------------------------
;Interface Settings


 !include "MUI.nsh"

;!define MUI_HEADERIMAGE
;!define MUI_ABORTWARNING
;!define MUI_HEADERIMAGE_BITMAP "header.bmp"
;!define MUI_WELCOMEFINISHPAGE_BITMAP "left.bmp"
;!define MUI_UNWELCOMEFINISHPAGE_BITMAP "left.bmp"
!define  MUI_ICON "..\src\apps\mplayerc\res\icon.ico"
;!define  MUI_UNICON "SVPlayer.ico"
!insertmacro MUI_PAGE_LICENSE "License.txt"
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_INSTFILES
!define MUI_FINISHPAGE_RUN "$INSTDIR\svplayer.exe"

!define MUI_FINISHPAGE_SHOWREADME
!define MUI_FINISHPAGE_SHOWREADME_TEXT "启用GPU加速 (需特定显卡硬件和驱动配合)"
!define MUI_FINISHPAGE_SHOWREADME_NOTCHECKED
!define MUI_FINISHPAGE_SHOWREADME_FUNCTION myFinishPageInit

!define MUI_FINISHPAGE_LINK  "点击访问 http://blog.svplayer.cn 查看最近更新"
!define MUI_FINISHPAGE_LINK_LOCATION "http://blog.svplayer.cn/"

!insertmacro MUI_PAGE_FINISH

Function myFinished
		MessageBox MB_OK "myFinished message box"
FunctionEnd


Function myFinishPageInit
	WriteRegDWORD HKCU "SOFTWARE\SVPlayer\射手影音播放器\Settings" "USEGPUAcel" 0x00000001

FunctionEnd



;!insertmacro MUI_UNPAGE_WELCOME
;!insertmacro MUI_UNPAGE_COMPONENTS

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

;--------------------------------
;Pages

;!insertmacro MUI_PAGE_WELCOME


;--------------------------------
;Languages

!insertmacro MUI_LANGUAGE "SimpChinese"
!insertmacro MUI_LANGUAGE "TradChinese"

;--------------------------------
;Installer Sections
/*
;--------------------------------
!macro IfKeyExists ROOT MAIN_KEY KEY
push $R0
push $R1

!define Index 'Line${__LINE__}'

StrCpy $R1 "0"

"${Index}-Loop:"
; Check for Key
EnumRegKey $R0 ${ROOT} "${MAIN_KEY}" "$R1"
StrCmp $R0 "" "${Index}-False"
  IntOp $R1 $R1 + 1
  StrCmp $R0 "${KEY}" "${Index}-True" "${Index}-Loop"

"${Index}-True:"
;Return 1 if found
push "1"
goto "${Index}-End"

"${Index}-False:"
;Return 0 if not found
push "0"
goto "${Index}-End"

"${Index}-End:"
!undef Index
exch 2
pop $R0
pop $R1
!macroend

; Pages

Page components
Page directory
Page instfiles

UninstPage uninstConfirm
UninstPage instfiles*/



SectionGroup /e "射手影音"
; The stuff to install
Section  "射手影音播放器" svplayer

  SectionIn RO

  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
;  !insertmacro IfKeyExists "HKCU" "SOFTWARE\SVPlayer\射手影音播放器" "Recent Dub List"
;  Pop $R0
;  StrCmp $R0 1 skipcopy
;  ${COPY_REGISTRY_KEY} HKCU "SOFTWARE\Gabest\Media Player Classic\Recent Dub List" HKCU "SOFTWARE\SVPlayer\射手影音播放器\Recent Dub List"
;  ${COPY_REGISTRY_KEY} HKCU "SOFTWARE\Gabest\Media Player Classic\Recent File List" HKCU "SOFTWARE\SVPlayer\射手影音播放器\Recent File List"
;  ${COPY_REGISTRY_KEY} HKCU "SOFTWARE\Gabest\Media Player Classic\Recent Url List" HKCU "SOFTWARE\SVPlayer\射手影音播放器\Recent Url List"
;  skipcopy:
	Delete  $INSTDIR\mplayerc.exe
  ; Put file there
  File "..\..\svplayer.exe"
  ;File "..\..\Updater.exe"
  File "..\..\svplayer.bin\unrar.dll"
  File "..\..\PmpSplitter.ax"
  File "..\..\rlapedec.ax"
  File "..\..\NeSplitter.ax"
  ;File "..\..\rms.ax"
  File "..\..\drvc.dll"
  File "..\..\pncrt.dll"
  File "..\..\cook.dll"
  File "..\..\wvc1dmod.dll"
  ;File "..\..\tsccvid.dll"
  
  File "..\..\RadGtSplitter.ax"
	File "..\..\binkw32.dll"
	File "..\..\smackw32.dll"
;  File "..\..\svplayer.bin\VSFilter.dll"
;  RegDLL $INSTDIR\VSFilter.dll
	RegDLL $INSTDIR\wvc1dmod.dll
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\SVPlayer" "DisplayName" "射手影音播放器"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\SVPlayer" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\SVPlayer" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\SVPlayer" "NoRepair" 1
  WriteUninstaller "uninstall.exe"
WriteRegDWORD HKCU "SOFTWARE\SVPlayer\射手影音播放器\Settings" "USEGPUAcel" 0x00000000
	WriteRegStr HKCU "SOFTWARE\GNU\ffdshow" "isWhitelist" 0x00000000
	WriteRegStr HKCU "SOFTWARE\GNU\ffdshow\default" "autoq" 0x00000001
  WriteRegStr HKLM "SOFTWARE\SVPlayer" "Install_Dir" "$INSTDIR"
SectionEnd

Section "程序和开始菜单项"
  CreateDirectory "$SMPROGRAMS\射手影音播放器"
  CreateShortCut "$SMPROGRAMS\射手影音播放器\Uninstall.lnk" "$INSTDIR\uninstall.exe" "" "$INSTDIR\uninstall.exe" 0
  CreateShortCut "$SMPROGRAMS\射手影音播放器\射手影音.lnk" "$INSTDIR\svplayer.exe" "" "$INSTDIR\svplayer.exe" 0

	IfFileExists $INSTDIR\codecs\ffdshow.ax 0 +2
	 CreateShortCut "$SMPROGRAMS\射手影音播放器\设置FFDshow解码器.lnk" "rundll32.exe" '"$INSTDIR\codecs\ffdshow.ax",configure' "$INSTDIR\codecs\ffdshow.ax" 3

	IfFileExists $INSTDIR\codecs\CoreAVCDecoder.ax 0 +2
	 CreateShortCut "$SMPROGRAMS\射手影音播放器\设置CoreCodec .264解码器.lnk" "rundll32.exe" '"$INSTDIR\codecs\CoreAVCDecoder.ax",Configure' "$INSTDIR\codecs\coreavc.ico" 0
	 
	IfFileExists $INSTDIR\codecs\Real\settings.exe 0 +2
 		CreateShortCut "$SMPROGRAMS\射手影音播放器\设置Real Media.lnk" "$INSTDIR\codecs\Real\settings.exe" "" "$INSTDIR\codecs\Real\real.ico" 0
	
;	IfFileExists  $INSTDIR\codecs\powerdvd\CL264dec.ax 0 +2
;		CreateShortCut "$SMPROGRAMS\射手影音播放器\设置CL264.lnk" "rundll32.exe" '"$INSTDIR\codecs\powerdvd\CL264dec.ax",Configure' "$INSTDIR\codecs\powerdvd\CL264dec.ax" 0
	
SectionEnd

Section "桌面快捷方式"
  CreateShortCut "$DESKTOP\射手影音.lnk" "$INSTDIR\svplayer.exe"

SectionEnd

Section "加入快捷菜单"
  CreateShortCut "$QUICKLAUNCH\射手影音.lnk" "$INSTDIR\svplayer.exe"
SectionEnd
;--------------------------------
SectionGroupEnd

!ifndef litepack
SectionGroup /e "影音解码包"
!ifdef fullpack
; The stuff to install
!ifdef ffdshowsec
Section  "FFDShow"  ffdshow
    UnRegDLL $INSTDIR\codecs\ffdshow.ax
    Delete /REBOOTOK $INSTDIR\codecs\ffdshow.ax

	
    SetOutPath $INSTDIR\codecs
    File ..\..\svplayer.bin\ffdshow\*.*
    SetOutPath $INSTDIR\codecs\languages
    File ..\..\svplayer.bin\ffdshow\languages\*.*
    SetOutPath $SYSDIR
    File ..\..\svplayer.bin\ffdshow\sys\ff_acm.acm
    File ..\..\svplayer.bin\ffdshow\sys\ff_vfw.dll
    File ..\..\svplayer.bin\ffdshow\sys\ff_vfw.dll.manifest
    File ..\..\svplayer.bin\ffdshow\sys\pthreadGC2.dll
    
    RegDLL $INSTDIR\codecs\ffdshow.ax

    ;写入注册表
	WriteRegStr HKCU "Software\GNU\ffdshow" "lang" "SC"
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "isBlacklist" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "lastPage" 0x00000073
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "trayIcon" 0x00000000
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "trayIconExt" 0x00000000
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "OSDfontFast" 0x00000000
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "xvid" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "div3" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "divx" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "dx50" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "mp43" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "mp42" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "mp41" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "_3iv" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "ffv1" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "fvfw" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "hfyu" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "iv32" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "png1" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "zlib" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "cvid" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "h261" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "h263" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "h264" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "fastH264" 0x00000000
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "theo" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "tscc" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "vp3" 0x00000001

	WriteRegDWORD HKCU "Software\GNU\ffdshow" "mjpg" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "dvsd" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "cyuv" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "asv1" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "vcr1" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "svq1" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "svq3" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "cram" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "rv10" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "rle" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "mszh" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "flv1" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "8bps" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "qtrle" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "duck" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "qpeg" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "loco" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "zmbv" 0x00000000

	WriteRegDWORD HKCU "Software\GNU\ffdshow" "mpg1" 0x00000005
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "mpg2" 0x00000005
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "mpegAVI" 0x00000005

	WriteRegDWORD HKCU "Software\GNU\ffdshow" "wmv1" 0x00000000
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "wmv2" 0x00000000
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "wmv3" 0x00000000

	WriteRegDWORD HKCU "Software\GNU\ffdshow" "avis" 0x00000000
	WriteRegDWORD HKCU "Software\GNU\ffdshow" "rawv" 0x00000000

	WriteRegDWORD HKCU "Software\GNU\ffdshow_audio" "streamsOptionsMenu" 0x00000000
	WriteRegDWORD HKCU "Software\GNU\ffdshow_audio" "trayIcon" 0x00000000
	WriteRegDWORD HKCU "Software\GNU\ffdshow_audio" "trayIconExt" 0x00000000
	WriteRegDWORD HKCU "Software\GNU\ffdshow_audio" "isAudioSwitcher" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow_audio" "isBlacklist" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow_audio" "lastPage" 0x00000074
	WriteRegDWORD HKCU "Software\GNU\ffdshow_audio" "iadpcm" 0x00000000
	WriteRegDWORD HKCU "Software\GNU\ffdshow_audio" "tta" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow_audio" "aac" 0x00000008
	WriteRegDWORD HKCU "Software\GNU\ffdshow_audio" "mp2" 0x00000000
	WriteRegDWORD HKCU "Software\GNU\ffdshow_audio" "mp3" 0x00000006
	WriteRegDWORD HKCU "Software\GNU\ffdshow_audio" "ac3" 0x00000000
	WriteRegDWORD HKCU "Software\GNU\ffdshow_audio" "dts" 0x00000000
	WriteRegDWORD HKCU "Software\GNU\ffdshow_audio" "lpcm" 0x00000004
	WriteRegDWORD HKCU "Software\GNU\ffdshow_audio" "vorbis" 0x00000012
	WriteRegDWORD HKCU "Software\GNU\ffdshow_audio" "amr" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow_audio\default" "isMixer" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow_audio\default" "mixerNormalizeMatrix" 0x00000000
	WriteRegDWORD HKCU "Software\GNU\ffdshow_audio\default" "mixerOut" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow_enc" "lastPage" 0x00000066
	WriteRegStr HKCU "Software\GNU\ffdshow_vfw" "pth" "$SYSDIR"
	WriteRegDWORD HKCU "Software\GNU\ffdshow_vfw" "lastPage" 0x00000073
	WriteRegDWORD HKCU "Software\GNU\ffdshow_vfw" "_3iv" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow_vfw" "div3" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow_vfw" "divx" 0x00000009
	WriteRegDWORD HKCU "Software\GNU\ffdshow_vfw" "duck" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow_vfw" "dvsd" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow_vfw" "dx50" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow_vfw" "ffv1" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow_vfw" "fvfw" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow_vfw" "h263" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow_vfw" "h264" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow_vfw" "hfyu" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow_vfw" "iv32" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow_vfw" "mjpg" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow_vfw" "png1" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow_vfw" "qtrle" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow_vfw" "svq1" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow_vfw" "svq3" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow_vfw" "theo" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow_vfw" "tscc" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow_vfw" "vp3" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow_vfw" "vcr1" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow_vfw" "xvid" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow_vfw" "zlib" 0x00000001
	WriteRegDWORD HKCU "Software\GNU\ffdshow_vfw" "cvid" 0x00000001
	WriteRegStr HKLM "SOFTWARE\GNU\ffdshow" "pth" "$INSTDIR\codecs"
	WriteRegStr HKCU "SOFTWARE\GNU\ffdshow" "isWhitelist" 0x00000000
SectionEnd
!endif
Section  "Real Media"  realcodec

SetOutPath $INSTDIR
    File ..\..\svplayer.bin\Real\keys.dat
    SetOutPath $INSTDIR\codecs
    File ..\..\svplayer.bin\Real\realcfg.exe
    File ..\..\svplayer.bin\Real\realcfg.ini
    File ..\..\svplayer.bin\Real\embed_cn.dll
    File ..\..\svplayer.bin\Real\rpclsvc_cn.dll
    File ..\..\svplayer.bin\Real\rpclutil_cn.dll
    File ..\..\svplayer.bin\Real\rpgutil_cn.dll
    File ..\..\svplayer.bin\Real\RealMediaSplitter2000.ax
    RegDLL $INSTDIR\codecs\RealMediaSplitter2000.ax
    SetOverwrite try
    SetOutPath $SYSDIR
    File ..\..\svplayer.bin\Real\pncrt.dll
    File ..\..\svplayer.bin\Real\rmoc3260.dll
    RegDLL $SYSDIR\rmoc3260.dll
    File ..\..\svplayer.bin\Real\pndx5016.dll
    File ..\..\svplayer.bin\Real\pndx5032.dll
    SetOutPath $INSTDIR\rpplugins
    File ..\..\svplayer.bin\Real\rpplugins\*.*
    SetOutPath $COMMONFILES\Real\codecs
    File ..\..\svplayer.bin\Real\codecs\*.*
    SetOutPath $COMMONFILES\Real\Common
    File ..\..\svplayer.bin\Real\Common\*.*
    SetOutPath $COMMONFILES\Real\Plugins
    File ..\..\svplayer.bin\Real\Plugins\*.*
    SetOutPath $COMMONFILES\Real\Plugins\ExtResources
    File ..\..\svplayer.bin\Real\Plugins\ExtResources\*.*

    DeleteRegKey HKLM "SOFTWARE\Microsoft\Internet Explorer\ActiveX Compatibility\{CFCDAA03-8BE4-11CF-B84B-0020AFBBCCFA}"


	WriteRegStr HKCR "rtsp" "" "Real-Time Streaming Protocol"
	WriteRegBin HKCR "rtsp" "EditFlags" 02000000
	WriteRegStr HKCR "rtsp" "URL Protocol" ""
	WriteRegStr HKCR "rtsp\DefaultIcon" "" '"$INSTDIR\svplayer.exe"'
	WriteRegStr HKCR "rtsp\shell\open\command" "" '"$INSTDIR\svplayer.exe" "%L"'
	WriteRegStr HKCR "pnm" "" "RealNetworks Streaming Protocol"
	WriteRegBin HKCR "pnm" "EditFlags" 03000000
	WriteRegStr HKCR "pnm" "URL Protocol" ""
	WriteRegStr HKCR "pnm\DefaultIcon" "" '"$INSTDIR\svplayer.exe"'
	WriteRegStr HKCR "pnm\shell\open\command" "" '"$INSTDIR\svplayer.exe" "%L"'
	WriteRegStr HKCR "pnm\shellex\ContextMenuHandlers\RealPlayerHandler" "" "{F0CB00CD-5A07-4D91-97F5-A8C92CDA93E4}"
	WriteRegStr HKCR "MIME\Database\Content Type\application/sdp" "Extension" ".sdp"
	WriteRegStr HKCR "MIME\Database\Content Type\application/smil" "Extension" ".smil"
	WriteRegStr HKCR "MIME\Database\Content Type\application/streamingmedia" "Extension" ".ssm"
	WriteRegStr HKCR "MIME\Database\Content Type\application/vnd.rn-realmedia" "CLSID" "{CFCDAA03-8BE4-11CF-B84B-0020AFBBCCFA}"
	WriteRegStr HKCR "MIME\Database\Content Type\application/vnd.rn-realmedia" "Extension" ".rm"
	WriteRegStr HKCR "MIME\Database\Content Type\application/vnd.rn-realplayer" "Extension" ".rnx"
	WriteRegStr HKCR "MIME\Database\Content Type\application/vnd.rn-rsml" "Extension" ".rsml"
	WriteRegStr HKCR "MIME\Database\Content Type\application/x-rtsp" "CLSID" "{02BF25D5-8C17-4B23-BC80-D3488ABDDC6B}"
	WriteRegStr HKCR "MIME\Database\Content Type\application/x-rtsp" "Extension" ".rtsp"
	WriteRegStr HKCR "MIME\Database\Content Type\audio/vnd.rn-realaudio" "Extension" ".ra"
	WriteRegStr HKCR "MIME\Database\Content Type\audio/x-pn-realaudio-plugin" "CLSID" "{CFCDAA03-8BE4-11CF-B84B-0020AFBBCCFA}"
	WriteRegStr HKCR "MIME\Database\Content Type\audio/x-realaudio" "CLSID" "{CFCDAA03-8BE4-11CF-B84B-0020AFBBCCFA}"
	WriteRegStr HKCR "MIME\Database\Content Type\audio/x-realaudio" "Extension" ".ra"
	WriteRegStr HKCR "MIME\Database\Content Type\image/vnd.rn-realpix" "Extension" ".rp"
	WriteRegStr HKCR "MIME\Database\Content Type\text/vnd.rn-realtext" "Extension" ".rt"
	WriteRegStr HKCR "MIME\Database\Content Type\video/vnd.rn-realvideo" "CLSID" "{CFCDAA03-8BE4-11CF-B84B-0020AFBBCCFA}"
	WriteRegStr HKCR "MIME\Database\Content Type\video/vnd.rn-realvideo" "Extension" ".rv"
	WriteRegStr HKCR "Software\RealNetworks\Preferences\DT_Codecs" "" "$COMMONFILES\Real\Codecs\"
	WriteRegStr HKCR "Software\RealNetworks\Preferences\DT_Common" "" "$COMMONFILES\Real\Common\"
	WriteRegStr HKCR "Software\RealNetworks\Preferences\DT_Objbrokr" "" "$COMMONFILES\Real\Common\"
	WriteRegStr HKCR "Software\RealNetworks\Preferences\DT_Plugins" "" "$COMMONFILES\Real\Plugins\"
	WriteRegStr HKCR "Software\RealNetworks\Preferences\DT_Update_OB" "" "$COMMONFILES\Real\Update_OB\"
	WriteRegStr HKCR "Software\RealNetworks\RealMediaSDK\6.0\Preferences\Bandwidth" "" "10485800"
	WriteRegStr HKCR "Software\RealNetworks\RealMediaSDK\6.0\Preferences\BandwidthNotKnown" "" "0"
	WriteRegStr HKCR "Software\RealNetworks\RealMediaSDK\6.0\Preferences\BufferedPlayTime" "" "30"
	WriteRegStr HKCR "Software\RealNetworks\RealMediaSDK\6.0\Preferences\CacheDefaultTTL" "" "3600"
	WriteRegStr HKCR "Software\RealNetworks\RealMediaSDK\6.0\Preferences\HTTPProxyAutoConfig" "" "0"
	WriteRegStr HKCR "Software\RealNetworks\RealMediaSDK\6.0\Preferences\HTTPProxySupport" "" "0"
	WriteRegStr HKCR "Software\RealNetworks\RealMediaSDK\6.0\Preferences\PerfectPlay" "" "0"
	WriteRegStr HKCR "Software\RealNetworks\RealMediaSDK\6.0\Preferences\PerfectPlayTime" "" "30"
	WriteRegStr HKCR "Software\RealNetworks\RealMediaSDK\6.0\Preferences\PerfPlayEntireClip" "" "0"
	WriteRegStr HKCR "Software\RealNetworks\RealMediaSDK\6.0\Preferences\Rotuma" "" "efggdhhinjjfhlcmeonrkuktlrjrptqufkrgkioiijdkhlpljnorgpptloknqtmpdfhjdmfi"
	WriteRegStr HKCR "Software\RealNetworks\RealMediaSDK\6.0\Preferences\UseSystemProxySettings" "" "1"
	WriteRegStr HKCR "Software\RealNetworks\RealPlayer\6.0\Preferences\ApplicationName" "" "RealPlayer"
	WriteRegStr HKCR "Software\RealNetworks\RealPlayer\6.0\Preferences\ClassName" "" "GeminiWindowClass|The RNWK AppBar"
	WriteRegStr HKCR "Software\RealNetworks\RealPlayer\6.0\Preferences\ClientLicenseKey" "" "0000000000006000C6A2000000007FF7FF00"
	WriteRegStr HKCR "Software\RealNetworks\RealPlayer\6.0\Preferences\DisplayName" "" "RealPlayer"
	WriteRegStr HKCR "Software\RealNetworks\RealPlayer\6.0\Preferences\DistCode" "" "RN30RD"
	WriteRegStr HKCR "Software\RealNetworks\RealPlayer\6.0\Preferences\LangID" "" "zh-cn"
	WriteRegStr HKCR "Software\RealNetworks\RealPlayer\6.0\Preferences\MainApp" "" "$INSTDIR\svplayer.exe"
	WriteRegStr HKCR "Software\RealNetworks\RealPlayer\6.0\Preferences\OrigCode" "" "RN30RD"
	WriteRegStr HKCR "Software\RealNetworks\RealPlayer\6.0\Preferences\PluginFilePath" "" "$INSTDIR\rpplugins"
	WriteRegStr HKCR "Software\RealNetworks\RealPlayer\6.0\Preferences\Satellite3" "" "$INSTDIR\rpplugins\cn\embed_cn.dll"
	WriteRegStr HKCR "Software\RealNetworks\RealPlayer\6.0\Preferences\Satellite17" "" "$INSTDIR\rpplugins\cn\rpclsvc_cn.dll"
	WriteRegStr HKCR "Software\RealNetworks\RealPlayer\6.0\Preferences\Title" "" "RealPlayer"
	WriteRegStr HKCR "Software\RealNetworks\RealPlayer\6.0\Preferences\TriedAutoConfig" "" "0"
	WriteRegStr HKCR "Software\RealNetworks\RealPlayer\CurrentVersion" "" "6.0"
	WriteRegStr HKCU "Software\RealNetworks\RealPlayer\6.0\Preferences\EnableInstantPlayback" "" "1"
	WriteRegStr HKCU "Software\RealNetworks\RealPlayer\6.0\Preferences\GetHTTPProxyFromBrowser" "" "0"
	WriteRegStr HKCR "Software\RealNetworks\RealPlayer\6.0\Preferences\InitialVolume" "" "50"
	WriteRegStr HKCR "Software\RealNetworks\RealPlayer\6.0\Preferences\Language" "" "zh-cn"
	WriteRegStr HKCU "Software\RealNetworks\RealPlayer\6.0\Preferences\NetdetectOptions" "" "1"
	WriteRegStr HKCU "Software\RealNetworks\RealMediaSDK\6.0\Preferences\Bandwidth" "" "10485800"
	WriteRegStr HKCU "Software\RealNetworks\RealMediaSDK\6.0\Preferences\TurboPlay" "" "1"
	WriteRegStr HKCU "Software\RealNetworks\RealMediaSDK\6.0\Preferences\AllowAuthID" "" "0"
	WriteRegStr HKCU "Software\RealNetworks\RealMediaSDK\6.0\Preferences\BufferedPlayTime" "" "30"
	WriteRegStr HKCU "Software\RealNetworks\RealMediaSDK\6.0\Preferences\ConnectionTimeout" "" "20"
	WriteRegStr HKCU "Software\RealNetworks\RealMediaSDK\6.0\Preferences\CookiesEnabled" "" "1"
	WriteRegStr HKCU "Software\RealNetworks\RealMediaSDK\6.0\Preferences\HTTPProxyHost" "" ""
	WriteRegStr HKCU "Software\RealNetworks\RealMediaSDK\6.0\Preferences\HTTPProxyPort" "" "80"
	WriteRegStr HKCU "Software\RealNetworks\RealMediaSDK\6.0\Preferences\HTTPProxySupport" "" "0"
	WriteRegStr HKCU "Software\RealNetworks\RealMediaSDK\6.0\Preferences\MaxBandwidth" "" "10485800"
	WriteRegStr HKCU "Software\RealNetworks\RealMediaSDK\6.0\Preferences\NoProxyFor" "" ""
	WriteRegStr HKCU "Software\RealNetworks\RealMediaSDK\6.0\Preferences\PNAProxyHost" "" ""
	WriteRegStr HKCU "Software\RealNetworks\RealMediaSDK\6.0\Preferences\PNAProxyPort" "" ""
	WriteRegStr HKCU "Software\RealNetworks\RealMediaSDK\6.0\Preferences\PNAProxySupport" "" "0"
	WriteRegStr HKCU "Software\RealNetworks\RealMediaSDK\6.0\Preferences\Quality" "" "4"
	WriteRegStr HKCU "Software\RealNetworks\RealMediaSDK\6.0\Preferences\RTSPProxyHost" "" ""
	WriteRegStr HKCU "Software\RealNetworks\RealMediaSDK\6.0\Preferences\RTSPProxyPort" "" ""
	WriteRegStr HKCU "Software\RealNetworks\RealMediaSDK\6.0\Preferences\RTSPProxySupport" "" "0"
	WriteRegStr HKCU "Software\RealNetworks\RealMediaSDK\6.0\Preferences\SendStatistics" "" "1"
	WriteRegStr HKCU "Software\RealNetworks\RealMediaSDK\6.0\Preferences\ServerTimeOut" "" "90"
	WriteRegStr HKCU "Software\RealNetworks\RealMediaSDK\6.0\Preferences\TurboPlay" "" "1"
	WriteRegStr HKCU "Software\RealNetworks\RealMediaSDK\6.0\Preferences\UseUDPPort" "" "0"
	WriteRegStr HKCU "Software\RealNetworks\RealMediaSDK\6.0\Preferences\Volume" "" "-1"
	WriteRegStr HKCU "Software\RealNetworks\RealMediaSDK\10.0\Preferences\Volume" "" "-1"
SectionEnd
!endif

Section  "CoreAVC解码"  coreavc
    SetOutPath $INSTDIR\codecs
    File ..\..\svplayer.bin\coreavc\CoreAVCDecoder.ax
    File ..\..\svplayer.bin\coreavc\coreavc.ico
    WriteRegStr HKLM "SOFTWARE\CoreCodec\CoreAVC Pro" "Serial" "03JUN-10K9Y-CORE-0CLQV-JOTFL"
    WriteRegStr HKLM "SOFTWARE\CoreCodec\CoreAVC Pro" "User" "Registered User"
    RegDLL $INSTDIR\codecs\CoreAVCDecoder.ax
    ;WriteRegDWORD HKCU "Software\GNU\ffdshow" "h264" 0x00000000
SectionEnd

/*
Section  "GPU硬件显卡加速解码"  powerdvd
    SetOutPath $INSTDIR\codecs\powerdvd
    File ..\..\svplayer.bin\powerdvd\*.*
   
    RegDLL $INSTDIR\codecs\powerdvd\CL264dec.ax
    WriteRegDWORD HKCU "Software\Cyberlink\Common\cl264dec\mplayerc" "UIUseHVA"  0x00000001
    WriteRegDWORD HKCU "Software\Cyberlink\Common\cl264dec\svplayer" "UIUseHVA"  0x00000001
    WriteRegDWORD HKCU "Software\Cyberlink\Common\CLVSD" "UIUseHVA"  0x00000001
    ;WriteRegDWORD HKCU "Software\GNU\ffdshow" "h264" 0x00000000
SectionEnd

;*/
;--------------------------------
SectionGroupEnd

!endif


Function .onInstSuccess
IfSilent +2
 ExecShell open "http://www.splayer.org/install.html"
FunctionEnd

Function un.onUninstSuccess
 ExecShell open "http://www.splayer.org/uninstall.html"
FunctionEnd
