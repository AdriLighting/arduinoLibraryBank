Func _pDev_Checkword($sWord, $sValidChars)
    Local $sChar
    Local $cnt
    For $i = 1 To StringLen($sWord)
        $sChar = StringMid($sWord, $i, 1)
        If StringInStr($sValidChars, $schar) Then
            $sValidChars = StringReplace($sValidChars, $sChar, "", 1)
            $cnt+=1
        Else
            Return 0
        EndIf
    Next
    Return $cnt
EndFunc

Func _pDev_lv_countItemSelected($Lv = $pDev_lv_pj)
    Local $CountItemChecked = 0
    For $i = 0 To _GUICtrlListView_GetItemCount($Lv) - 1
        If _GUICtrlListView_GetItemSelected($Lv, $i) Then
            $CountItemChecked += 1
        EndIf
    Next
    Return $CountItemChecked
EndFunc   ;==>_pDev_lv_countItemSelected

Func _pDev_lv_checkSelected($Lv = $pDev_lv_pj)
    For $i = 0 To _GUICtrlListView_GetItemCount($Lv) - 1
        If _GUICtrlListView_GetItemSelected($Lv, $i) Then
            _GUICtrlListView_SetItemChecked($Lv, $i, not _GUICtrlListView_GetItemChecked($Lv, $i))
        EndIf
    Next
EndFunc   ;==>_pDev_lv_checkSelected
Func _pDev_lv_slectAll($Lv = $pDev_lv_pj)
    For $i = 0 To _GUICtrlListView_GetItemCount($Lv) - 1
        _GUICtrlListView_SetItemSelected($Lv, $i, true)
    Next
EndFunc   ;==>_pDev_lv_checkSelected

Func _pDev_lv_countItemChecked($Lv = $pDev_lv_pj)
    Local $CountItemChecked = 0
    For $i = 0 To _GUICtrlListView_GetItemCount($Lv) - 1
        If _GUICtrlListView_GetItemChecked($Lv, $i) Then
            $CountItemChecked += 1
        EndIf
    Next
    Return $CountItemChecked
EndFunc   ;==>_pDev_lv_countItemChecked

Func _pDev_lv_deleteColumns($hLV)
    Local $iColumn = _GUICtrlListView_GetColumnCount($hLV)

    For $i = $iColumn - 1 To 0 Step -1
        _GUICtrlListView_DeleteColumn($hLV, $i)
    Next
EndFunc   ;==>DeleteColumns

Func _Pdev_lv_selectedItemText($sHwnd = '')

    Local $aSelIndices, $aItems

    $aSelIndices = _GUICtrlListView_GetSelectedIndices($sHwnd, True)
    If _GUICtrlListView_GetSelectedCount($sHwnd) > 0 Then
        If $aSelIndices[0] > 0 Then
            $aItems = $aSelIndices[1]
            Return _GUICtrlListView_GetItemText($sHwnd, $aItems, 0)
        EndIf
    EndIf
    Return SetError(1)
EndFunc   ;==>
Func _Pdev_lv_selectedItemPos($sHwnd = '')

    Local $aSelIndices, $aItems

    $aSelIndices = _GUICtrlListView_GetSelectedIndices($sHwnd, True)
    If _GUICtrlListView_GetSelectedCount($sHwnd) > 0 Then
        If $aSelIndices[0] > 0 Then
            $aItems = $aSelIndices[1]
            Return $aItems
        EndIf
    EndIf
    Return SetError(1)
EndFunc   ;==>

func _Pdev_tools_pourcentage($val, $start = 500)
	Return ($start * $val) / 100
EndFunc

func _pDev_setPath($str)
	if StringRight($str, 1) <> "\" then
		return $str & "\"
	else
		return $str
	endif
endfunc

func _pDev_runComspec($cmd = "pio boards --installed --json-output", $workingdir = 'E:\Arduino\Arduino_Projet\piotest', $flag = @sw_hide)
    Local $iPID = Run(@ComSpec & " /c " & $cmd, $workingdir, $flag, BitOR($STDERR_CHILD, $STDOUT_CHILD))
    Local $sOutput = ""
    ; While 1
    ;     $sOutput &= String(StdoutRead($iPID))
    ;     If @error Then ; Exit the loop if the process closes or StdoutRead returns an error.
    ;         ExitLoop
    ;     EndIf
    ; WEnd
    ProcessWaitClose($iPID)

    ; Read the Stdout stream of the PID returned by Run. This can also be done in a while loop. Look at the example for StderrRead.
    $sOutput = StdoutRead($iPID)

 	_upd("- _pDev_runComspec", 3, 1)
 	_upd(_lbl("cmd") & $cmd, 3, 0)
 	_upd(_lbl("dir") & $workingDir, 3, 0)
 	_upd(_lbl("outPut") & @lf & $sOutput, 3, 0)
 	_upd("", 3, 2)
	Return $sOutput
EndFunc
Func _getCmdStd(Const $sCMD, Const $sDir = '', Const $iType = $STDERR_MERGED, Const $bShow = False, Const $iDelay = 100)
    Local       $sTMP = ''
    Local       $sSTD = ''
    Local       $sCOM = @ComSpec & ' /c ' & $sCMD
    Local Const $iWin = $bShow ? @SW_SHOW : @SW_HIDE
    Local Const $iPID = Run($sCOM, $sDir, $iWin, $iType)

    ; _GUICtrlRichEdit_SetText($pDev_richEdit, "")
    
    While True

        $sTMP = StdoutRead($iPID, False, False)

        If @error Then

            ExitLoop 1

        ElseIf $sTMP Then

            $sTMP  = StringReplace($sTMP, @CR & @CR, '')
            $sSTD &= $sTMP

            if StringInStr($sTMP, "warning: ", 1) then
                _upd($sTMP,0,0,true,7.5,'255,255,0')
            elseif StringInStr($sTMP, "error: ", 1) then
                _upd($sTMP,0,0,true,7.5,'255,0,0')
            else
                _upd($sTMP,0,0,true,7.5,'255,255,255')
            EndIf
            GUICtrlSetData($tempGui_edit, guictrlread($tempGui_edit)&@crlf&$sCMD&@crlf&$sTMP&@crlf)
        EndIf

        Sleep($iDelay)

    WEnd
    
    ; Return SetError(@error, @extended, $sSTD)
    Return $sSTD
EndFunc