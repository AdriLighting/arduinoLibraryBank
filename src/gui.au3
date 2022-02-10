func _gui_create()

; $pDev_gui_w = @DesktopWidth
local $pDev_gui_w = _Pdev_tools_pourcentage(70, @DesktopWidth )
local  $pDev_gui_h = _Pdev_tools_pourcentage(65, @DesktopHeight )
; $pDev_gui_h = @DesktopHeight - 300

local  $lv_w = $pDev_gui_w - 20
$lv_w = _Pdev_tools_pourcentage(70, $pDev_gui_w )
local  $lv_h = $pDev_gui_h - 120
local  $cu_l = 10
local  $cu_t = 10

$pDev_gui_main = GUICreate("AdriUnoManager - 0.1", $pDev_gui_w, $pDev_gui_h,-1,-1)

local $mFilemenu = GUICtrlCreateMenu("menu")
$mLibSetItem = GUICtrlCreateMenuItem("lib set", $mFilemenu)
$mLibAddItem = GUICtrlCreateMenuItem("lib add", $mFilemenu)
$mPioFrameworkItem = GUICtrlCreateMenuItem("pio framework", $mFilemenu)
$mExititem = GUICtrlCreateMenuItem("Exit", $mFilemenu)
;~ $mSpecialitem = GUICtrlCreateMenuItem("?", -1) ; I belong to the main menu

; ---------------------------------------------------------------
; $cu_w = _Pdev_tools_pourcentage(2, $pDev_gui_w)
; GUICtrlCreateLabel("url", $cu_l, $cu_t+3, $cu_w , 20)

; ---------------------------------------------------------------
; $cu_l += $cu_w + 5
local $cu_w = _Pdev_tools_pourcentage(30, $pDev_gui_w)
$pDev_arrInp_lib[0] = GUICtrlCreateInput("url", $cu_l, $cu_t, $cu_w, 20)

; ---------------------------------------------------------------
$cu_l += $cu_w + 5
$cu_w = $pDev_gui_w  - $cu_l - 10
$pDev_arrInp_lib[1] = GUICtrlCreateInput("desc 1", $cu_l, $cu_t, $cu_w, 20)

; ---------------------------------------------------------------
$cu_t += 25
$pDev_arrInp_lib[2] = GUICtrlCreateInput("desc 2", $cu_l, $cu_t, $cu_w, 20)

; --------------------------------------------------------------- SEARCH NAME
$cu_l = 10
$cu_w = _Pdev_tools_pourcentage(10, $pDev_gui_w)
$pDev_inp_filterName = GUICtrlCreateInput("", $cu_l, $cu_t, $cu_w, 20)

; --------------------------------------------------------------- CATEGORY
$cu_t += 25
$cu_l = 10
$cu_w = _Pdev_tools_pourcentage(7, $pDev_gui_w)
$pDev_cmb_filterCat = GUICtrlCreateCombo("", $cu_l, $cu_t, $cu_w , 20, BitOR($gui_ss_default_combo, $cbs_dropdownlist, $ws_hscroll))
$cu_l += $cu_w + 5
$cu_w = _Pdev_tools_pourcentage(19.5, $pDev_gui_w)
$pDev_inp_filterCat = GUICtrlCreateInput("", $cu_l, $cu_t, $cu_w, 20)
; $cu_l += $cu_w + 5
; $cu_w = _Pdev_tools_pourcentage(4, $pDev_gui_w)
; $pDev_bt_filterCat = GUICtrlCreateButton("category",  $cu_l, $cu_t, $cu_w, 20)

; --------------------------------------------------------------- KEYWORDS
$cu_l += $cu_w + 5
$cu_w = _Pdev_tools_pourcentage(7, $pDev_gui_w)
$pDev_cmb_filterKeys = GUICtrlCreateCombo("", $cu_l, $cu_t, $cu_w , 20, BitOR($gui_ss_default_combo, $cbs_dropdownlist, $ws_hscroll))
$cu_l += $cu_w + 5
$cu_w = _Pdev_tools_pourcentage(19.5, $pDev_gui_w)
$pDev_inp_filterKeys = GUICtrlCreateInput("", $cu_l, $cu_t, $cu_w, 20)


; --------------------------------------------------------------- AUTHOR
$cu_l += $cu_w + 5 
$cu_w = _Pdev_tools_pourcentage(6, $pDev_gui_w)
$pDev_cmb_filterGrp = GUICtrlCreateCombo("", $cu_l, $cu_t, $cu_w , 20, BitOR($gui_ss_default_combo, $cbs_dropdownlist, $ws_hscroll))
$cu_l += $cu_w + 5
$cu_w = _Pdev_tools_pourcentage(13, $pDev_gui_w)
$pDev_inp_filterGrp = GUICtrlCreateInput("", $cu_l, $cu_t, $cu_w, 20)
; $cu_l += $cu_w + 5
; $cu_w = _Pdev_tools_pourcentage(4, $pDev_gui_w)
; $pDev_bt_filterKAuth = GUICtrlCreateButton("author",  $cu_l, $cu_t, $cu_w, 20)

; --------------------------------------------------------------- PLATFORM
$cu_l += $cu_w + 5 
$cu_w = _Pdev_tools_pourcentage(6, $pDev_gui_w)
$pDev_cmb_filterKPlat = GUICtrlCreateCombo("", $cu_l, $cu_t, $cu_w , 20, BitOR($gui_ss_default_combo, $cbs_dropdownlist, $ws_hscroll))
$cu_l += $cu_w + 5
$cu_w = _Pdev_tools_pourcentage(13, $pDev_gui_w)
$pDev_inp_filterKPlat = GUICtrlCreateInput("", $cu_l, $cu_t, $cu_w, 20)
; $cu_l += $cu_w + 5
; $cu_w = _Pdev_tools_pourcentage(4, $pDev_gui_w)
; $pDev_bt_filterKPlat = GUICtrlCreateButton("platform",  $cu_l, $cu_t, $cu_w, 20)

$cu_l += $cu_w + 5 + 5
$cu_w = _Pdev_tools_pourcentage(4, $pDev_gui_w)
$pDev_bt_filterCat = GUICtrlCreateButton("filter",  $cu_l, $cu_t, $cu_w, 20)

; --------------------------------------------------------------- LV LIBS
$cu_t+=25
$cu_l=10
; $pDev_lv_pj = GUICtrlCreateListView("", $cu_l, $cu_t, $lv_w, $lv_h, BitOR($LVS_SHOWSELALWAYS, $LVS_NOSORTHEADER, $LVS_REPORT))
    Local $iExWindowStyle = BitOR($WS_EX_DLGMODALFRAME, $WS_EX_CLIENTEDGE)
    Local $iExListViewStyle = BitOR($LVS_EX_FULLROWSELECT, $LVS_EX_SUBITEMIMAGES, $LVS_EX_GRIDLINES, $LVS_EX_DOUBLEBUFFER)


    $pDev_lv_pj = GUICtrlCreateListView("",  $cu_l, $cu_t, $lv_w, $lv_h, $LVS_REPORT, $iExWindowStyle)
    _GUICtrlListView_SetExtendedListViewStyle($pDev_lv_pj, $iExListViewStyle)
; ---------------------------------------------------------------

endfunc

_gui_create()

Global Const $DummyMenuListViewGit          = GUICtrlCreateDummy()
Global Const $MenuListView_lib              = GUICtrlCreateContextMenu($DummyMenuListViewGit)
Global Const $MenuListView_lib_menu         = GUICtrlCreateMenu("&Github", $MenuListView_lib)
Global Const $MenuListView_lib_status       = GUICtrlCreateMenuItem("&status", $MenuListView_lib_menu)
Global Const $MenuListView_lib_clone        = GUICtrlCreateMenuItem("&clone", $MenuListView_lib_menu)
Global Const $MenuListView_lib_edit         = GUICtrlCreateMenuItem("&edit", $MenuListView_lib)