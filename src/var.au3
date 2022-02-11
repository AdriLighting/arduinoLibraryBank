	Global Const $_gitCmd_clone_master	= "git clone --single-branch --branch master "
	Global Const $_gitCmd_clone_main	= "git clone --single-branch --branch main "

	Global $pDev_onTimeTimer
		global $pDev_frameworkName[3][2] = [["framework-arduino-avr", "atmelavr"], _
	["framework-arduinoespressif32", "espressif32"], _
	["framework-arduinoespressif8266", "espressif8266"]]

	Global $pDev_fo_compil = @ScriptDir
	if @Compiled Then
		$pDev_fo_compil = @ScriptDir
	else
		$pDev_fo_compil = ".."
	EndIf
	Global $pDev_fp_ini_libs			= $pDev_fo_compil & "\data\ini\_libsEx.ini"
	Global $pDev_fp_ini_libs_2			= $pDev_fo_compil & "\data\ini\_libs.ini"
	Global $pDev_fp_ini_libsManage		= $pDev_fo_compil & "\data\ini\lib_manage.ini"
	Global $pDev_fo_libraryProperties 	= $pDev_fo_compil & "\data\arduinoLib\library_properties\"
	Global $pDev_fo_libraryPropertiesEx	= $pDev_fo_compil & "\data\arduinoLib\library_propertiesEx\"
	; Global $pDev_fp_libraryProperties 	= $pDev_fo_compil & "\data\ini\library.properties"
	; Global $pDev_fp_librarySection 		= $pDev_fo_compil & "\data\ini\library.ini"
	Global $pDev_fo_tempLib  			= $pDev_fo_compil & "\data\arduinoLib\tempLib\"

	Global $_fo_pioPackages				= @UserProfileDir & "\.platformio\packages\"
	Global $pDev_fo_ini_framework		= $pDev_fo_compil & "\data\ini\framework\"
	Global $pDev_fo_ini_libCheck		= $pDev_fo_compil & "\data\ini\"
	Global $pDev_fo_data				= $pDev_fo_compil & "\data\"


Global $pDev_arrInp_lib[3]
Global $pDev_gui_main, $pDev_inp_filterName
Global $pDev_cmb_filterCat, $pDev_inp_filterCat, $pDev_bt_filterCat
Global $pDev_cmb_filterKeys, $pDev_inp_filterKeys
Global $pDev_cmb_filterGrp, $pDev_inp_filterGrp
Global $pDev_cmb_filterKPlat, $pDev_inp_filterKPlat
Global $pDev_lv_pj

Global $mLibAddItem, $mPioFrameworkItem, $mExititem, $mLibSetItem

; Global $tempGui = GUICreate("libDl", 500, 300)
; Global $tempGui_edit = GUICtrlCreateEdit("", 10, 10, 480, 280)



global $pDevGuiDebug = false
global $pDevIdGuiDebug
global $pDev_guiDebug_richEdit
global $pdev_guiDebug_Progress

Local $style = BitOR($ES_MULTILINE, $WS_VSCROLL, $ES_AUTOVSCROLL, $ES_READONLY)
$pDevIdGuiDebug = GUICreate("AdriUnoManager - 0.1", @desktopwidth / 2, @desktopheight - 400)
$pDev_guiDebug_richEdit = _GUICtrlRichEdit_Create($pDevIdGuiDebug, "", 5, 5, (@desktopwidth / 2)-10, ( @desktopheight - 400)-50, $style)
$pdev_guiDebug_Progress  = GUICtrlCreateProgress(5, ( @desktopheight - 400) - 40, (@desktopwidth / 2)-10, 25, $PBS_SMOOTH)
GUICtrlSetData($pdev_guiDebug_Progress, 0)

_GUICtrlRichEdit_SetBkColor($pDev_guiDebug_richEdit, 0)
_GUICtrlRichEdit_SetCharColor($pDev_guiDebug_richEdit, 65280)
_GUICtrlRichEdit_SetFont($pDev_guiDebug_richEdit, Default, "Arial") ; set the default font
_GUICtrlRichEdit_ChangeFontSize($pDev_guiDebug_richEdit, 32) ; set the default font size
_GUICtrlRichEdit_SetEventMask($pDev_guiDebug_richEdit, $ENM_LINK)
_GUICtrlRichEdit_AutoDetectURL($pDev_guiDebug_richEdit, True)


Global $_update_lv = false
Global $_collArr_1[11][3] = [ _
["dirname",         160,    0   ] , _
["version",         80,     5   ] , _
["author",          160,    6   ] , _
["group",       	80,     18  ] , _
["category",        100,    11  ] , _
["architectures",   80,     12  ] , _
["keywords",        150,     15  ] , _
["platforms",       80,     17  ] _
]

Global $_grpArr    [0]
Global $_catArr    [0]
Global $_keysArr   [0]
Global $_libs_v1   [0][0]

Global $pDev_gui_editProp = false

Global $currInputGit = ""

; ["ini",             20,     2   ] , _
; ["json",            20,     3   ] , _
; ["name",            160,    4   ] , _
; ["frameworks",      80,     16  ] , _


