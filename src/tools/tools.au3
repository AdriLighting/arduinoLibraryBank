

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
	local $sSpace 	= ";"
	Local $sRow		= ""
	Local $sPrint 	= ""
	Local $sCrLf 	= ""
	Local $sLf 		= @CRLF
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
			$sData[$i] 	= StringReplace($sData[$i],$sSpace,"  ")
			$sRow 		=  String($i)
			$sRow 		= _lbl($sRow, 6)
			$sRow 		= StringReplace($sRow, $sSpace,"  ")
			$sPrint 	&= $sRow  & $sData[$i] & $sCrLf
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


Func Out2($TEXT, $sColor = "0,255,0", $sSize = '') ; 65280
	#forceref $TEXT, $sColor, $sSize
;~ 	Local $iLine, $ctrlId
;~ 		if $pDevGuiDebug then
;~ 			$ctrlId = $pDev_guiDebug_richEdit
;~ 			if $sSize = '' then $sSize = 10
;~ 		else
;~ 			$ctrlId = $pDev_richEdit
;~ 			if $sSize = '' then $sSize = 7.8
;~ 		endif

;~ 		if StringLeft($TEXT, 1) = "!" then
;~ 			$sColor = "255,0,0"
;~ 		elseif StringLeft($TEXT, 1) = "-" then
;~ 			$sColor = "255,90,0"
;~ 		else
;~ 			$sColor = $sColor
;~ 		endif
;~ 		If _GUICtrlRichEdit_GetText($ctrlId) <> '' Then
;~ 			_GUICtrlRichEdit_AppendText($ctrlId, @crlf)
;~ 		EndIf

;~ 		_GUICtrlRichEdit_AppendTextEx($ctrlId, $TEXT, "Arial", $sColor, $sSize, 0, 0, 0, 0)

;~ 	if $pDevGuiDebug then
;~ 		$iLine = ControlCommand($pDevIdGuiDebug, "", $pDev_guiDebug_richEdit, "GetCurrentLine", "")
;~ 		_GUICtrlRichEdit_ScrollLines($pDev_guiDebug_richEdit, $iLine)
;~ 	else
;~ 		$iLine = ControlCommand($pDev_gui_main, "", $pDev_richEdit, "GetCurrentLine", "")
;~ 		_GUICtrlRichEdit_ScrollLines($pDev_richEdit, $iLine)
;~ 	endif

EndFunc   ;==>Out2



Func _pDev_Inet_InetGet($sUrl, $sOutPath, $sTitle = '', $sProgress = False)
	Local $totalsize, $kbrecu, $hDownload = InetGet($sUrl, $sOutPath, 1, 1)
	If $sTitle == '' Then $sTitle = _ADFunc_Files_FileGetFullNameByUrl($sUrl)
	If $sProgress Then
;~ 		if $pDevGuiDebug then
;~ 			GUICtrlSetData($pdev_guiDebug_Progress, 0)
;~ 		else
;~ 			ProgressOn("Telechargment en cour", "", "0%")
;~ 		endif
	endif
	Do
		$totalsize = 0
		$kbrecu = InetGetInfo($hDownload, 0)
		If $kbrecu > 0 Then
			If $totalsize = 0 Then
				$totalsize = InetGetInfo($hDownload, 1)
			EndIf
;~ 			$pourcentage = Round($kbrecu * 100 / $totalsize)
			If $sProgress Then
;~ 				if $pDevGuiDebug then
;~ 					GUICtrlSetData($pdev_guiDebug_Progress, $pourcentage)
;~ 				else
;~ 					ProgressSet($pourcentage, $pourcentage & '%', $sTitle)
;~ 				EndIf
			EndIf
		EndIf
		Sleep(50)
	Until InetGetInfo($hDownload, 2)
	If $sProgress Then
;~ 		if $pDevGuiDebug then
;~ 			GUICtrlSetData($pdev_guiDebug_Progress, 0)
;~ 		else
;~ 			ProgressOff()
;~ 		endif
	endif
	InetClose($hDownload)
EndFunc   ;==>_ADFunc_Inet_InetGet


