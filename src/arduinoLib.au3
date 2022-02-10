#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=res\arduino-icon.ico
#AutoIt3Wrapper_Outfile=..\arduinolib.exe
#AutoIt3Wrapper_Res_Comment=Arduino library bank
#AutoIt3Wrapper_Res_Description=Arduino library bank
#AutoIt3Wrapper_Res_Fileversion=0.0.1
#AutoIt3Wrapper_Res_ProductName=Arduino library bank
#AutoIt3Wrapper_Res_CompanyName=AdriLIghting
#AutoIt3Wrapper_Res_LegalCopyright=AdriLIghting
#AutoIt3Wrapper_Res_Language=1036
#AutoIt3Wrapper_Au3Check_Parameters=-q -d -w 1 -w 2 -w 3 -w- 4 -w 5 -w 6 -w- 7
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include <File.au3>
#include <GuiMenu.au3>

#include "lib_interne/Json.au3"
#include "lib_interne/_ADFunc.au3"
#include "lib_interne/ArrayMultiColSort.au3"
#include "lib_interne/Json_Arrayfied/json.au3"

 Opt("MustDeclareVars", 1)

#include "var.au3"
#include "tools.au3"
#include "gui.au3"
#include "tools/tools.au3"
#include "git.au3"
#include "lib_dl.au3"
#include "lib_edit.au3"
#include "lib_check.au3"
#include "lib_pio.au3"

if not FileExists($pDev_fo_libraryProperties) then 
    GUISetState(@SW_SHOW, $tempGui)
    _lib_dlAll($_libs_v1)
    GUISetState(@SW_HIDE, $tempGui)
endif
_lib_get_keywords($_catArr, $_keysArr, $_grpArr)
_lib_makeArray($_libs_v1)
_ArraySort($_catArr, 0)
_ArraySort($_keysArr, 0)
; _ArraySort($_grpArr, 0)
_ADFunc_Gui_Combo_SetData(0, 0, 0, $pDev_cmb_filterCat, $_catArr)
_ADFunc_Gui_Combo_SetData(0, 0, 0, $pDev_cmb_filterKeys, $_keysArr)
_ADFunc_Gui_Combo_SetData(0, 0, 0, $pDev_cmb_filterGrp, $_grpArr)
_lib_makeArray_lvCol($_libs_v1, $pDev_lv_pj)
GUIRegisterMsg($WM_NOTIFY, "_WM_NOTIFY")
GUISetState(@SW_SHOW, $pDev_gui_main)
GUISetState(@sw_restore)
WinSetOnTop( $pDev_gui_main, "", 1)
GUISetState(@sw_restore)
WinSetOnTop( $pDev_gui_main, "", 0)

func _pDev_loop()
    While 1
        Local $nMsg = GUIGetMsg()
        Switch $nMsg
            Case $mPioFrameworkItem
                Local $sOutput = _pDev_runComspec("pio lib builtin --json-output", @scriptdir)
                _pDev_pio_libBuiltinList($sOutput)
                _lib_makeArray($_libs_v1)
                _lib_makeArray_lvCol($_libs_v1, $pDev_lv_pj)
                                
            Case $mLibSetItem
                 _lib_dlAll($_libs_v1)
                _lib_makeArray($_libs_v1)
                _lib_makeArray_lvCol($_libs_v1, $pDev_lv_pj)
            Case $mLibAddItem
                _lib_dl()
                _lib_makeArray($_libs_v1)
                _lib_makeArray_lvCol($_libs_v1, $pDev_lv_pj)

            Case $pDev_inp_filterCat, $pDev_bt_filterCat, $pDev_inp_filterGrp
                _lib_makeArray_lvCol($_libs_v1, $pDev_lv_pj)

            Case $pDev_cmb_filterGrp
                _cmb_filter($pDev_cmb_filterGrp, $pDev_inp_filterGrp)                
            Case $pDev_cmb_filterCat
                _cmb_filter($pDev_cmb_filterCat, $pDev_inp_filterCat)
            Case $pDev_cmb_filterKeys
                _cmb_filter($pDev_cmb_filterKeys, $pDev_inp_filterKeys)

            Case $GUI_EVENT_MINIMIZE
                GUISetState(@sw_minimize)
            Case $GUI_EVENT_RESTORE
                GUISetState(@sw_restore)
            Case $GUI_EVENT_CLOSE, $mExititem
                Exit
            case else
                Local $currRead_2 = GUICtrlRead($pDev_inp_filterName)
                if $currRead_2 <> $currInputGit Then
                    $currInputGit = $currRead_2
                    _lib_makeArray_lvCol($_libs_v1, $pDev_lv_pj)
                EndIf
        EndSwitch
        if ($pDev_gui_editProp) then
            $pDev_gui_editProp = false
            if (_pDev_menuLv_lib_prop($_libs_v1, GUICtrlGetHandle($pDev_lv_pj))) then
                _lib_makeArray($_libs_v1)
                _lib_makeArray_lvCol($_libs_v1, $pDev_lv_pj)
            endif
        endif
    WEnd
EndFunc

 _pDev_loop()

func _cmb_filter(byref $cmb, byref $inp)
    Local $data, $dataAdd, $split
    if (GUICtrlRead($cmb) <> "_ALL") then
        $data = GUICtrlRead($inp)
        if ($data <> "") then
            $dataAdd = true
            $split = StringSplit($data,";")
            if not @error then
                for $k = 0 to ubound($split)-1
                    if ($split[$k] = GUICtrlRead($cmb)) Then
                        $dataAdd = false
                        ExitLoop
                    endif
                next
            else
                if ($data = GUICtrlRead($cmb)) Then  $dataAdd = false
            endif
            if ($dataAdd) then $data = $data & ";" & GUICtrlRead($cmb)
        else
            $data = GUICtrlRead($cmb)
        endif
        GUICtrlSetData($inp, $data)
    endif
    _lib_makeArray_lvCol($_libs_v1, $pDev_lv_pj, GUICtrlRead($pDev_cmb_filterCat), GUICtrlRead($pDev_cmb_filterKeys), GUICtrlRead($pDev_cmb_filterGrp))
endfunc
Func _WM_NOTIFY($hWnd, $iMsg, $wParam, $lParam)
    #forceref $hWnd, $iMsg, $wParam
    Local $hWndFrom, $iCode, $tNMHDR, $hWndListView, $tInfo, $iItem, $aSelIndices, $idCommand

    $hWndListView = $pDev_lv_pj
    If Not IsHWnd($pDev_lv_pj) Then $hWndListView = GUICtrlGetHandle($pDev_lv_pj)

    $tNMHDR     = DllStructCreate($tagNMHDR, $lParam)
    $hWndFrom   = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
    $iCode      = DllStructGetData($tNMHDR, "Code")
    $tInfo      = DllStructCreate($tagNMLISTVIEW, $lParam)
    $iItem      = DllStructGetData($tInfo, "SubItem")

    Switch $hWndFrom
        Case $hWndListView
            Switch $iCode
                Case $NM_CLICK ;
                    _Pdev_lv_pj_cmd($hWndListView)
                Case $LVN_COLUMNCLICK ;
                    $_update_lv = not $_update_lv
                    local $aSortData[][] = [ _
                        [$_collArr_1[$iItem][2], $_update_lv]]
                    _ArrayMultiColSort($_libs_v1, $aSortData)
                    _lib_makeArray_lvCol($_libs_v1, $pDev_lv_pj)
                Case $NM_RCLICK
                    $aSelIndices = _GUICtrlListView_GetSelectedIndices($hWndListView, True)
                    If $aSelIndices[0] > 0 Then
                        $idCommand = _GUICtrlMenu_TrackPopupMenu(GUICtrlGetHandle($MenuListView_lib), $hWnd, -1, -1, 1, 1, 2)
                        Switch $idCommand
                            Case $MenuListView_lib_clone
                                _pDev_menuLv_lib_gitClone($_libs_v1, $hWndListView)
                            Case $MenuListView_lib_edit
                                $pDev_gui_editProp = true
                        EndSwitch
                    EndIf

            EndSwitch
    EndSwitch
    Return $__LISTVIEWCONSTANT_GUI_RUNDEFMSG
EndFunc   ;==>_WM_NOTIFY
Func _Pdev_lv_pj_cmd($sHwnd = '')

    Local $aSelIndices, $aItems

    $aSelIndices = _GUICtrlListView_GetSelectedIndices($sHwnd, True)
    If _GUICtrlListView_GetSelectedCount($sHwnd) > 0 Then
        If $aSelIndices[0] > 0 Then
            $aItems = $aSelIndices[1]
            Local $sName = _GUICtrlListView_GetItemText($sHwnd, $aItems, 0)
            _upd("- _Pdev_lv_pj_cmd",3, 1)
            _upd(_lbl("item")   & $sName,3, 0)
            for $i = 0 to ubound($_libs_v1)-1
                if ($sName = $_libs_v1[$i][0]) then
                     _upd(_lbl("value") & $_libs_v1[$i][0], 3, 0)
                     GUICtrlSetData($pDev_arrInp_lib[0], $_libs_v1[$i][1])
                     GUICtrlSetData($pDev_arrInp_lib[1], $_libs_v1[$i][9])
                     GUICtrlSetData($pDev_arrInp_lib[2], $_libs_v1[$i][10])
                endif
            next
            _upd("",3, 2)
            Return _GUICtrlListView_GetItemText($sHwnd, $aItems, 0)
        EndIf
    EndIf
    Return SetError(1)
EndFunc   ;==>