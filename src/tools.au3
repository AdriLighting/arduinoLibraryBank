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
        EndIf

        Sleep($iDelay)

    WEnd
    
    ; Return SetError(@error, @extended, $sSTD)
    Return $sSTD
EndFunc




func pDev_onTime($sTime = $pDev_onTimeTimer)
    Return _ADFunc_Divers_ConverTime(TimerDiff($sTime))
EndFunc
func pDev_onTimeInit()
    $pDev_onTimeTimer = TimerInit()
EndFunc
func _lbl($str, $len = 15, $sep = " : ")
    $str = String($str)
    While (StringLen($str) < $len)
        $str &= ";"
    WEnd
    return $str & $sep
endfunc
func _upd($sData = "", $mod = 3, $hf= 3, $display = true, $sSize = '', $sColor = "0,255,0", $sLine = @ScriptLineNumber)
    if not $display then return


    Local $uD1 = UBound($sData)
    Local $uD2 = UBound($sData, 2)

    Local $sFch = ''
    Local $sLch = ''
    Local $sHeader = ''
    Local $sFooter = ''
    Switch $mod
        Case 0
            $sFch = ""
            $sLch = ""
        Case 1
            $sFch = "+"
            $sLch = "-"
        Case 2
            $sFch = "!"
            $sLch = "!"
        Case 3
            $sFch = "+"
            $sLch = "+"
    EndSwitch

    Switch $hf
        Case 0
            $sHeader = ""
            $sFooter = ""
        Case 1
            $sHeader = $sFch & "=========================================================== " & "Line(" & StringFormat("%04d", $sLine) & ") " & pDev_onTime($pDev_onTimeTimer) & @LF
            $sFooter = ""
        Case 2
            $sHeader = ""
            $sFooter = $sLch & "===========================================================" & @LF
        Case 3
            $sHeader = $sFch & "=========================================================== " & "Line(" & StringFormat("%04d", $sLine) & ") " &  pDev_onTime($pDev_onTimeTimer) & @LF
            $sFooter = $sLch & "===========================================================" & @LF
    EndSwitch
    local $sSpace   = ";"
    Local $sRow     = ""
    Local $sPrint   = ""
    Local $sCrLf    = ""
    Local $sLf      = @CRLF
    if (($uD1 = 0) And ($uD2 = 0)) Then
        if $sData = "" then $sLf = ""
        if $sHeader <> "" then Out2("***************************", "255,255,255", 7)
        $sData = StringReplace($sData,$sSpace,"  ")
        Out2($sData, $sColor, $sSize)
        if $sFooter <> "" then Out2("***************************", "255,255,255", 7)
        ConsoleWrite( _
                        $sHeader & _
                        $sData & $sLf & _
                        $sFooter)
    Elseif (($uD1 > 0) And ($uD2 = 0)) Then
        $sCrLf = @CRLF
        if $sHeader <> "" then Out2("***************************", "255,255,255", 7)
        For $i = 0 To $uD1 - 1
            if $i >= $uD1 - 1 Then  $sCrLf = ""
            $sData[$i]  = StringReplace($sData[$i],$sSpace,"  ")
            $sRow       =  String($i)
            $sRow       = _lbl($sRow, 6)
            $sRow       = StringReplace($sRow, $sSpace,"  ")
            $sPrint     &= $sRow  & $sData[$i] & $sCrLf
            Out2( $sRow  & $sData[$i], $sColor, $sSize)
        next
        if $sFooter <> "" then Out2("***************************", "255,255,255", 7)
        ConsoleWrite( _
                        $sHeader & _
                        $sPrint & @CRLF & _
                        $sFooter)

    Elseif (($uD1 > 0) And ($uD2 > 0)) Then
        if $sHeader <> "" then Out2("***************************", "255,255,255", 7)
        if $sHeader <> "" then ConsoleWrite($sHeader)
        $sCrLf = @CRLF
        Local $sD1 = ""
        Local $sD2 = ""
        For $i = 0 To $uD1 - 1
            if $i >= $uD1 - 1 Then  $sCrLf = ""
            $sD2 = ""
            For $j = 1 To $uD2 - 1
                $sD2  &=  $sData[$i][$j] & " "
            next
            $sD1 =  String($sData[$i][0])
            $sD1 = _lbl($sD1, 6)
            $sD1 = StringReplace($sD1, $sSpace,"  ")
            $sD2 = StringReplace($sD2, $sSpace,"  ")
            Out2($sD1 & $sD2, $sColor, $sSize)
            ConsoleWrite($sD1 & " " & $sD2 & @CRLF)
        next
        if $sFooter <> "" then Out2("***************************", "255,255,255", 7)
        if $sFooter <> "" then ConsoleWrite($sFooter)

    EndIf
EndFunc
func _debugGui($sShow = @SW_SHOW, $sClear = false)
    GUISetState($sShow, $pDevIdGuiDebug)
    if ($sClear) then  _GUICtrlRichEdit_SetText($pDev_guiDebug_richEdit, "")
    if $sShow = @SW_HIDE then $pDevGuiDebug = false
EndFunc
Func Out2($TEXT, $sColor = "0,255,0", $sSize = '') ; 65280
    #forceref $TEXT, $sColor, $sSize
    if not $pDevGuiDebug then return
    ; GUICtrlSetData($tempGui_edit,  $TEXT & @crlf & GUICtrlRead($tempGui_edit))
    Local $iLine

    if $sSize = '' then $sSize = 10
 
    if StringLeft($TEXT, 1) = "!" then
        $sColor = "255,0,0"
    elseif StringLeft($TEXT, 1) = "-" then
        $sColor = "255,90,0"
    else
        $sColor = $sColor
    endif
    If _GUICtrlRichEdit_GetText($pDev_guiDebug_richEdit) <> '' Then
        _GUICtrlRichEdit_AppendText($pDev_guiDebug_richEdit, @crlf)
    EndIf

    _GUICtrlRichEdit_AppendTextEx($pDev_guiDebug_richEdit, $TEXT, "Arial", $sColor, $sSize, 0, 0, 0, 0)

    if $pDevGuiDebug then
        $iLine = ControlCommand($pDevIdGuiDebug, "", $pDev_guiDebug_richEdit, "GetCurrentLine", "")
        _GUICtrlRichEdit_ScrollLines($pDev_guiDebug_richEdit, $iLine)
    else
    ; ~      $iLine = ControlCommand($pDev_gui_main, "", $pDev_richEdit, "GetCurrentLine", "")
    ; ~      _GUICtrlRichEdit_ScrollLines($pDev_richEdit, $iLine)
    endif

EndFunc   ;==>Out2
Func _GUICtrlRichEdit_AppendTextEx($RichEdit, $text, $font="Arial", $color="0,255,0", $size=12, $bold=0, $italic=0, $strike=0, $underline=0)
    Local $command = "{\rtf1\ansi"
    Local $r, $g, $b, $ul[9] = ["8", '\ul', '\uldb', '\ulth', '\ulw', '\ulwave', '\uld', '\uldash', '\uldashd']

    If $font <> "" Then $command &= "{\fonttbl {\f0 "&$font&";}}"
    If $color <> "" Then
        $b = StringSplit($color, ",")[3]
        $g = StringSplit($color, ",")[2]
        $r = StringSplit($color, ",")[1]
        If $r+$b+$g > 0 Then
            $command &= "{\colortbl;\red"&$r&"\green"&$g&"\blue"&$b&";}\cf1"
        EndIf
    EndIf

  If $size Then $command &= "\fs"&round($size*2)&" "
  If $strike Then $command &= "\strike "
  If $italic Then $command &= "\i "
  If $bold Then $command &= "\b "
  If $underline > 0 and $underline < 9 Then $command &= $ul[$underline]&" "
;~   ConsoleWrite($command&$text&"}"&@CRLF) ; Debugging line
    local   $fText = StringReplace($text,"\","/")
            $fText = StringReplace($fText,@LF,"\line")
            $fText = StringReplace($fText,@CRLF,"\line")
            
  Return _GUICtrlRichEdit_AppendText($RichEdit, $command&$fText&"}" )
EndFunc


Func _pDev_Inet_InetGet($sUrl, $sOutPath, $sTitle = '', $sProgress = False)
    Local $totalsize, $kbrecu, $hDownload = InetGet($sUrl, $sOutPath, 1, 1)
    If $sTitle == '' Then $sTitle = _ADFunc_Files_FileGetFullNameByUrl($sUrl)
    If $sProgress Then
;~      if $pDevGuiDebug then
          GUICtrlSetData($pdev_guiDebug_Progress, 0)
;~      else
;~          ProgressOn("Telechargment en cour", "", "0%")
;~      endif
    endif
    Do
        $totalsize = 0
        $kbrecu = InetGetInfo($hDownload, 0)
        If $kbrecu > 0 Then
            If $totalsize = 0 Then
                $totalsize = InetGetInfo($hDownload, 1)
            EndIf
            local $pourcentage = Round($kbrecu * 100 / $totalsize)
            If $sProgress Then
;~              if $pDevGuiDebug then
                  GUICtrlSetData($pdev_guiDebug_Progress, $pourcentage)
;~              else
;~                  ProgressSet($pourcentage, $pourcentage & '%', $sTitle)
;~              EndIf
            EndIf
        EndIf
        Sleep(50)
    Until InetGetInfo($hDownload, 2)
    If $sProgress Then
;~      if $pDevGuiDebug then
          GUICtrlSetData($pdev_guiDebug_Progress, 0)
;~      else
;~          ProgressOff()
;~      endif
    endif
    InetClose($hDownload)
EndFunc   ;==>_ADFunc_Inet_InetGet


