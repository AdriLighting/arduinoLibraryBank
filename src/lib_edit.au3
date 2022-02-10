func _libraryProperties($grpArr, $sFile, $sName = "", $sUrl = "")


	Local $cu_t = 10
	Local $cu_l = 10
	; Local $cu_h = _Pdev_tools_pourcentage(95, $pDev_guiCppc_h-250)
	local $gu_w = (@desktopwidth/2)
	Local $cu_w = _Pdev_tools_pourcentage(95, (@desktopwidth/4))
	Local $pDev_gui_libAdd			= 	GUICreate("librarie properties", $gu_w, 700)
	local $elements[11][4] = [ _
	["","name", 			"", $sName], _
	["","version", 			"", ""], _
	["","author", 			"", ""], _
	["","maintainer", 		"", ""], _
	["","sentence", 		"", ""], _
	["","paragraph", 		"", ""], _
	["","category", 		"", "Uncategorized"], _
	["","url", 				"", $sUrl], _
	["","architectures",	"", "*"], _
	["","depends", 			"", ""], _
	["","includes", 		"", ""]]

	local $elements_2[4][4] = [ _
	["","library_properties",	"", ""], _
	["","git", 					"", ""], _
	["","dirname", 				"", ""], _
	["","group",				"", ""]]

						GUICtrlCreateGroup($elements[0][1], $cu_l, 		$cu_t, 		$cu_w, 		50)
	$elements[0][0]	= 	GUICtrlCreateInput("", 				$cu_l+10, 	$cu_t+20, 	$cu_w-20, 	20)
	$cu_t+=55
						GUICtrlCreateGroup($elements[1][1], $cu_l, 		$cu_t, 		$cu_w, 		50)
	$elements[1][0]	= 	GUICtrlCreateInput("", 				$cu_l+10, 	$cu_t+20, 	$cu_w-20, 	20)
	$cu_t+=55
						GUICtrlCreateGroup($elements[2][1], $cu_l, 		$cu_t, 		$cu_w, 		50)
	$elements[2][0]	= 	GUICtrlCreateInput("", 				$cu_l+10, 	$cu_t+20, 	$cu_w-20, 	20)
	$cu_t+=55
						GUICtrlCreateGroup($elements[3][1], $cu_l,		$cu_t, 		$cu_w, 		50)
	$elements[3][0]	= 	GUICtrlCreateInput("", 				$cu_l+10, 	$cu_t+20, 	$cu_w-20, 	20)
	$cu_t+=55
						GUICtrlCreateGroup($elements[4][1], $cu_l, 		$cu_t, 		$cu_w, 		50)
	$elements[4][0]	= 	GUICtrlCreateInput("", 				$cu_l+10, 	$cu_t+20, 	$cu_w-20, 	20)
	$cu_t+=55
						GUICtrlCreateGroup($elements[5][1],	$cu_l, 		$cu_t, 		$cu_w, 		50)
	$elements[5][0]	= 	GUICtrlCreateInput("", 				$cu_l+10, 	$cu_t+20, 	$cu_w-20, 	20)
	$cu_t+=55
						GUICtrlCreateGroup($elements[6][1], $cu_l, 		$cu_t, 		$cu_w, 		50)
	$elements[6][0]	= 	GUICtrlCreateCombo("", 				$cu_l+10, 	$cu_t+20, 	$cu_w-20, 	20,		BitOR($gui_ss_default_combo, $cbs_dropdownlist, $ws_hscroll))
	GUICtrlSetData(-1, "Display|Communication|Signal Input/Output|Sensors|Device Control|Timing|Data Storage|Data Processing|Other|Uncategorized|", "Other")
	$cu_t+=55
						GUICtrlCreateGroup($elements[7][1], $cu_l, 		$cu_t, 		$cu_w, 		50)
	$elements[7][0]	= 	GUICtrlCreateInput("", 				$cu_l+10, 	$cu_t+20, 	$cu_w-20, 	20)
	$cu_t+=55
						GUICtrlCreateGroup($elements[8][1], $cu_l, 		$cu_t, 		$cu_w, 		50)
	$elements[8][0]	= 	GUICtrlCreateInput("", 				$cu_l+10, 	$cu_t+20, 	$cu_w-20, 	20)
	$cu_t+=55
						GUICtrlCreateGroup($elements[9][1], $cu_l, 		$cu_t, 		$cu_w, 		50)
	$elements[9][0]	= 	GUICtrlCreateInput("", 				$cu_l+10, 	$cu_t+20, 	$cu_w-20, 	20)
	$cu_t+=55
						GUICtrlCreateGroup($elements[10][1], $cu_l,		$cu_t, 		$cu_w, 		50)
	$elements[10][0] = 	GUICtrlCreateInput("", 				$cu_l+10, 	$cu_t+20, 	$cu_w-20, 	20)
	$cu_t+=55

	local $edit = GUICtrlCreateEdit("", $cu_w+20, 10, ($gu_w-$cu_w)-45, 200, BitOR($ES_AUTOVSCROLL, $ES_READONLY, $ES_WANTRETURN, $WS_VSCROLL), $WS_EX_STATICEDGE)
	local $bt_sav = GUICtrlCreateButton("Sav", $cu_w+20, 220, 100, 30)

	$cu_t = 265
	$cu_l = 10 + $cu_w + 10
	$cu_w = ($gu_w-$cu_w)-45

							GUICtrlCreateGroup($elements_2[0][1], $cu_l, 		$cu_t, 		$cu_w, 		50)
	$elements_2[0][0]	= 	GUICtrlCreateInput(IniRead($pDev_fp_ini_libs, $sName, "library_properties", ""),	$cu_l+10, 	$cu_t+20, 	$cu_w-20, 	20)
	$cu_t+=55
							GUICtrlCreateGroup($elements_2[1][1], $cu_l, 		$cu_t, 		$cu_w, 		50)
	$elements_2[1][0]	= 	GUICtrlCreateInput(IniRead($pDev_fp_ini_libs, $sName, "git", ""), 					$cu_l+10, 	$cu_t+20, 	$cu_w-20, 	20)
	$cu_t+=55
							GUICtrlCreateGroup($elements_2[2][1], $cu_l, 		$cu_t, 		$cu_w, 		50)
	$elements_2[2][0]	= 	GUICtrlCreateInput(IniRead($pDev_fp_ini_libs, $sName, "dirname", ""), 				$cu_l+10, 	$cu_t+20, 	$cu_w-20, 	20)
	$cu_t+=55
							GUICtrlCreateGroup($elements_2[3][1], $cu_l, 		$cu_t, 		$cu_w, 		50)
	$elements_2[3][0]	= 	GUICtrlCreateCombo("", 				$cu_l+10, 	$cu_t+20, 	$cu_w-20, 	20,		BitOR($gui_ss_default_combo, $cbs_dropdownlist, $ws_hscroll))

		GUICtrlSetData($elements_2[3][0], "")
 		Local $data = "";
 		For $i = 0 To UBound($grpArr) - 1
 			$data &= $grpArr[$i] & '|'
 		Next
 		GUICtrlSetData($elements_2[3][0], $data, IniRead($pDev_fp_ini_libs, $sName, "group", ""))

	$cu_t+=55

	local $bt_sav_ini = GUICtrlCreateButton("SavIni", $cu_w+20, $cu_t, 100, 30)

	; local $ir = IniRead($pDev_fp_ini_libs, $sName, "", "")
	; if $sFpini <> "" then

	; 	For $i = 1 To UBound($sFpini) - 1
	; 		if $elements_2[$i-1][1] = $sFpini[$i][0] then
	; 			GUICtrlSetData($elements_2[$i-1][0], $sFpini[$i][1])
	; 		endif
	; 	Next

	; endif

	GUISetState(@sw_show, $pDev_gui_libAdd)

	local $sValue = ""
	local $tempFile = @TempDir & "\temp_GitUrl.ini"
	if fileexists($sFile) then
		if FileExists($tempFile) Then FileDelete($tempFile)
		FileWrite($tempFile, "[section]" & @CRLF & FileRead($sFile))
	endif

	$data = ""
	for $i = 0 to ubound($elements)-1
		if fileexists($sFile) then
			$sValue = iniread($tempFile, "section", $elements[$i][1], $elements[$i][3])
			if $sValue = "" and $elements[$i][1]  = "category" then $sValue = "other"
			guictrlsetdata($elements[$i][0], $sValue)
		else
			$sValue = $elements[$i][3]
			if $sValue = "" and $elements[$i][1]  = "category" then $sValue = "other"
			guictrlsetdata($elements[$i][0], $elements[$i][3] )
		endif
		$elements[$i][2] = GUICtrlRead($elements[$i][0])
		$data &= $elements[$i][1] & " = " & $elements[$i][2] & @crlf
	next
	guictrlsetdata($edit, "")
	guictrlsetdata($edit, $data)

	local $upd = false
	Local $result = false
	While 1
		Local $nMsg = GUIGetMsg()
		Switch $nMsg
			Case $bt_sav_ini
				for $i = 0 to ubound($elements_2)-1
					iniwrite($pDev_fp_ini_libs, $sName, $elements_2[$i][1], GUICtrlRead($elements_2[$i][0]))
				next
				$result = true
			Case $bt_sav
				$data = ""

				Local $path = $pDev_fo_libraryPropertiesEx & $sName & "\library.properties"
				if not FileExists($path) then DirCreate($pDev_fo_libraryPropertiesEx & $sName)
				if FileExists($path) then FileDelete( $path)
				for $i = 0 to ubound($elements)-1
					$data &= $elements[$i][1] & "=" & $elements[$i][2] & @crlf
				next
				FileWrite($path, $data)
				guictrlsetdata($elements_2[0][0], 1)
				iniwrite($pDev_fp_ini_libs, $sName, "library_properties", "1")
				$result = true
			Case $GUI_EVENT_CLOSE
				exitloop
		endswitch

		for $i = 0 to ubound($elements)-1
			if GUICtrlRead($elements[$i][0]) <> $elements[$i][2]  then
				$upd = true
				$elements[$i][2] = GUICtrlRead($elements[$i][0])
			endif
		next

		if $upd then
			$upd = false
			$data = ""
			for $i = 0 to ubound($elements)-1
				$data &= $elements[$i][1] & " = " & $elements[$i][2] & @crlf
			next
			guictrlsetdata($edit, "")
			guictrlsetdata($edit, $data)
		endif
	wend
	GUIDelete($pDev_gui_libAdd)

	return $result
endfunc


#cs
func _libraryJson($sFile, $sName = "", $sUrl = "", $sFpIni = "")

	if not FileExists($pDev_fo_libraryProperties) then DirCreate($pDev_fo_libraryProperties)

	if FileExists($pDev_fp_libraryProperties) Then FileDelete($pDev_fp_libraryProperties)
	if FileExists($pDev_fp_librarySection) Then FileDelete($pDev_fp_librarySection)

	Local $cu_t = 10
	Local $cu_l = 10
	; Local $cu_h = _Pdev_tools_pourcentage(95, $pDev_guiCppc_h-250)
	local $gu_w = (@desktopwidth/2)
	Local $cu_w = _Pdev_tools_pourcentage(95, (@desktopwidth/4))
	Local $pDev_gui_libAdd			= 	GUICreate("librarie properties", $gu_w, @DesktopHeight-150)
	local $elements[15][6] = [ _
	["","name", 			"", $sName, 0], _
	["","version", 			"", "", 0, ""], _
	["","description",		"", "", 0, ""], _
	["","keywords", 		"", "", 1, ""], _
	["","homepage", 		"", "", 0, ""], _
	["","repository", 		"", "", 2, "type,url"], _
	["","authors",			"", "", 3, "name,email"], _
	["","license",			"", "", 0, ""], _
	["","frameworks",		"", "", 0, ""], _
	["","platforms",		"", "", 1, ""], _
	["","headers",			"", "", 0, ""], _
	["","examples",			"", "", 0, ""], _
	["","dependencies",		"", "", 3, "name,version"], _
	["","export",			"", "", 0, ""], _
	["","build", 			"", "", 0, ""]]

	local $elements_2[6][4] = [ _
	["","library_properties",	"", ""], _
	["","folder_lib", 			"", ""], _
	["","git", 					"", ""], _
	["","name", 				"", ""], _
	["","group", 				"", ""], _
	["","ver", 					"", ""]]

						GUICtrlCreateGroup($elements[0][1], $cu_l, 		$cu_t, 		$cu_w, 		50)
	$elements[0][0]	= 	GUICtrlCreateInput("", 				$cu_l+10, 	$cu_t+20, 	$cu_w-20, 	20)
	$cu_t+=55
						GUICtrlCreateGroup($elements[1][1], $cu_l, 		$cu_t, 		$cu_w, 		50)
	$elements[1][0]	= 	GUICtrlCreateInput("", 				$cu_l+10, 	$cu_t+20, 	$cu_w-20, 	20)
	$cu_t+=55
						GUICtrlCreateGroup($elements[2][1], $cu_l, 		$cu_t, 		$cu_w, 		50)
	$elements[2][0]	= 	GUICtrlCreateInput("", 				$cu_l+10, 	$cu_t+20, 	$cu_w-20, 	20)
	$cu_t+=55
						GUICtrlCreateGroup($elements[3][1], $cu_l,		$cu_t, 		$cu_w, 		50)
	$elements[3][0]	= 	GUICtrlCreateInput("", 				$cu_l+10, 	$cu_t+20, 	$cu_w-20, 	20)
	$cu_t+=55
						GUICtrlCreateGroup($elements[4][1], $cu_l, 		$cu_t, 		$cu_w, 		50)
	$elements[4][0]	= 	GUICtrlCreateInput("", 				$cu_l+10, 	$cu_t+20, 	$cu_w-20, 	20)
	$cu_t+=55
						GUICtrlCreateGroup($elements[5][1],	$cu_l, 		$cu_t, 		$cu_w, 		50)
	$elements[5][0]	= 	GUICtrlCreateInput("", 				$cu_l+10, 	$cu_t+20, 	$cu_w-20, 	20)
	$cu_t+=55
						GUICtrlCreateGroup($elements[6][1], $cu_l, 		$cu_t, 		$cu_w, 		50)
	$elements[6][0]	= 	GUICtrlCreateInput("", 				$cu_l+10, 	$cu_t+20, 	$cu_w-20, 	20)
;~ 	$elements[6][0]	= 	GUICtrlCreateCombo("", 				$cu_l+10, 	$cu_t+20, 	$cu_w-20, 	20,		BitOR($gui_ss_default_combo, $cbs_dropdownlist, $ws_hscroll))
;~ 	GUICtrlSetData(-1, "Display|Communication|Signal Input/Output|Sensors|Device Control|Timing|Data Storage|Data Processing|Other|Uncategorized|", "Other")
	$cu_t+=55
						GUICtrlCreateGroup($elements[7][1], $cu_l, 		$cu_t, 		$cu_w, 		50)
	$elements[7][0]	= 	GUICtrlCreateInput("", 				$cu_l+10, 	$cu_t+20, 	$cu_w-20, 	20)
	$cu_t+=55
						GUICtrlCreateGroup($elements[8][1], $cu_l, 		$cu_t, 		$cu_w, 		50)
	$elements[8][0]	= 	GUICtrlCreateInput("", 				$cu_l+10, 	$cu_t+20, 	$cu_w-20, 	20)
	$cu_t+=55
						GUICtrlCreateGroup($elements[9][1], $cu_l, 		$cu_t, 		$cu_w, 		50)
	$elements[9][0]	= 	GUICtrlCreateInput("", 				$cu_l+10, 	$cu_t+20, 	$cu_w-20, 	20)
	$cu_t+=55
						GUICtrlCreateGroup($elements[10][1], $cu_l,		$cu_t, 		$cu_w, 		50)
	$elements[10][0] = 	GUICtrlCreateInput("", 				$cu_l+10, 	$cu_t+20, 	$cu_w-20, 	20)
	$cu_t+=55

						GUICtrlCreateGroup($elements[11][1], $cu_l,		$cu_t, 		$cu_w, 		50)
	$elements[11][0] = 	GUICtrlCreateInput("", 				$cu_l+10, 	$cu_t+20, 	$cu_w-20, 	20)
	$cu_t+=55

						GUICtrlCreateGroup($elements[12][1], $cu_l,		$cu_t, 		$cu_w, 		50)
	$elements[12][0] = 	GUICtrlCreateInput("", 				$cu_l+10, 	$cu_t+20, 	$cu_w-20, 	20)
	$cu_t+=55

						GUICtrlCreateGroup($elements[13][1], $cu_l,		$cu_t, 		$cu_w, 		50)
	$elements[13][0] = 	GUICtrlCreateInput("", 				$cu_l+10, 	$cu_t+20, 	$cu_w-20, 	20)
	$cu_t+=55

						GUICtrlCreateGroup($elements[14][1], $cu_l,		$cu_t, 		$cu_w, 		50)
	$elements[14][0] = 	GUICtrlCreateInput("", 				$cu_l+10, 	$cu_t+20, 	$cu_w-20, 	20)
	$cu_t+=55


	$fr		= FileRead($sFile)
	$array	= JsonArrayfied($fr)
;~ _ArrayDisplay($array)
	Local $json = Json_StringDecode($fr)
;~ 	Local $json = Json_Decode($fr)
;~ 	$json = Json_Encode($json, 2)

	ConsoleWrite( $json & @lf)
;~ 	ConsoleWrite( $json  & @lf )

	For $i = 1 To UBound($array) - 1
		Dim $dArray
		For $j = 0 To UBound($elements) - 1
			if ($array[$i][1] = $elements[$j][1]) Then
				Switch($elements[$j][4])
					Case 0, 1
						guictrlsetdata($elements[$j][0], $array[$i][2])
					Case 2
						$read = GUICtrlRead($elements[$j][0])
						if ($read = "") Then
							guictrlsetdata($elements[$j][0], $array[$i][3])
						Else
							guictrlsetdata($elements[$j][0], $read & ", " & $array[$i][3])
						EndIf

				EndSwitch
			EndIf
		Next
	Next
	For $j = 0 To UBound($elements) - 1
		Switch($elements[$j][4])
			case 3
				$data = ""
				For $i = 1 To UBound($array) - 1
					if ($array[$i][1] = $elements[$j][1]) Then
						$data &=  $array[$i][3] & ", " & $array[$i][4]
						$data &= "|"
					EndIf
				Next
				guictrlsetdata($elements[$j][0], $data)
		EndSwitch
	Next

	local $edit = GUICtrlCreateEdit("", $cu_w+20, 10, ($gu_w-$cu_w)-45, 200, BitOR($ES_AUTOVSCROLL, $ES_READONLY, $ES_WANTRETURN, $WS_VSCROLL), $WS_EX_STATICEDGE)
	local $bt_sav = GUICtrlCreateButton("Sav", $cu_w+20, 220, 100, 30)

	$cu_t = 265
	$cu_l = 10 + $cu_w + 10
	$cu_w = ($gu_w-$cu_w)-45

							GUICtrlCreateGroup($elements_2[0][1], $cu_l, 		$cu_t, 		$cu_w, 		50)
	$elements_2[0][0]	= 	GUICtrlCreateInput("", 				$cu_l+10, 	$cu_t+20, 	$cu_w-20, 	20)
	$cu_t+=55
							GUICtrlCreateGroup($elements_2[1][1], $cu_l, 		$cu_t, 		$cu_w, 		50)
	$elements_2[1][0]	= 	GUICtrlCreateInput("", 				$cu_l+10, 	$cu_t+20, 	$cu_w-20, 	20)
	$cu_t+=55
							GUICtrlCreateGroup($elements_2[2][1], $cu_l, 		$cu_t, 		$cu_w, 		50)
	$elements_2[2][0]	= 	GUICtrlCreateInput("", 				$cu_l+10, 	$cu_t+20, 	$cu_w-20, 	20)
	$cu_t+=55
							GUICtrlCreateGroup($elements_2[3][1], $cu_l,		$cu_t, 		$cu_w, 		50)
	$elements_2[3][0]	= 	GUICtrlCreateInput("", 				$cu_l+10, 	$cu_t+20, 	$cu_w-20, 	20)
	$cu_t+=55
							GUICtrlCreateGroup($elements_2[4][1], $cu_l, 		$cu_t, 		$cu_w, 		50)
	$elements_2[4][0]	= 	GUICtrlCreateCombo("", 				$cu_l+10, 	$cu_t+20, 	$cu_w-20, 	20,		BitOR($gui_ss_default_combo, $cbs_dropdownlist, $ws_hscroll))

		GUICtrlSetData($elements_2[4][0], "")
;~ 		Local $resultArray[0]
;~ 		For $i = 0 To UBound($pDev_libArray) - 1
;~ 			_ArrayAdd($resultArray, $pDev_libArray[$i][4])
;~ 		Next
;~ 		Local $data = "";
;~ 		Local $tempGrp_clear = _ADFunc_Array_ArrayDeleteClones($resultArray)
;~ 		For $i = 0 To UBound($tempGrp_clear) - 1
;~ 			if ($tempGrp_clear[$i]<>"") then $data &= $tempGrp_clear[$i] & '|'
;~ 		Next
;~ 		GUICtrlSetData($elements_2[4][0], $data, "other")

	$cu_t+=55
							GUICtrlCreateGroup($elements_2[5][1], $cu_l,		$cu_t, 		$cu_w, 		50)
	$elements_2[5][0]	= 	GUICtrlCreateInput("", 				$cu_l+10, 	$cu_t+20, 	$cu_w-20, 	20)
	$cu_t+=55

	local $bt_sav_ini = GUICtrlCreateButton("SavIni", $cu_w+20, $cu_t, 100, 30)

	if $sFpini <> "" then

		For $i = 1 To UBound($sFpini) - 1
			if $elements_2[$i-1][1] = $sFpini[$i][0] then
				GUICtrlSetData($elements_2[$i-1][0], $sFpini[$i][1])
			endif
		Next

	endif

	GUISetState(@sw_show, $pDev_gui_libAdd)


;~ 	local $sValue = ""
;~ 	local $tempFile = @TempDir & "\temp_GitUrl.ini"
;~ 	if fileexists($sFile) then
;~ 		if FileExists($tempFile) Then FileDelete($tempFile)
;~ 		FileWrite($tempFile, "[section]" & @CRLF & FileRead($sFile))
;~ 	endif

;~ 	$data = ""
;~ 	for $i = 0 to ubound($elements)-1
;~ 		if fileexists($sFile) then
;~ 			$sValue = iniread($tempFile, "section", $elements[$i][1], $elements[$i][3])
;~ 			if $sValue = "" and $elements[$i][1]  = "category" then $sValue = "other"
;~ 			guictrlsetdata($elements[$i][0], $sValue)
;~ 		else
;~ 			$sValue = $elements[$i][3]
;~ 			if $sValue = "" and $elements[$i][1]  = "category" then $sValue = "other"
;~ 			guictrlsetdata($elements[$i][0], $elements[$i][3] )
;~ 		endif
;~ 		$elements[$i][2] = GUICtrlRead($elements[$i][0])
;~ 		$data &= $elements[$i][1] & " = " & $elements[$i][2] & @crlf
;~ 	next
;~ 	guictrlsetdata($edit, "")
;~ 	guictrlsetdata($edit, $data)

	local $upd = false
	While 1
		Local $nMsg = GUIGetMsg()
		Switch $nMsg
			Case $bt_sav_ini
				if FileExists($pDev_fp_librarySection) Then FileDelete($pDev_fp_librarySection)
				for $i = 0 to ubound($elements_2)-1
					iniwrite($pDev_fp_librarySection, $sName, $elements_2[$i][1], GUICtrlRead($elements_2[$i][0]))
				next
			Case $bt_sav
				$data = ""
				for $i = 0 to ubound($elements)-1
					$data &= $elements[$i][1] & "=" & $elements[$i][2] & @crlf
				next
				FileWrite($pDev_fp_libraryProperties, $data)
			Case $GUI_EVENT_CLOSE
				exitloop
		endswitch

		for $i = 0 to ubound($elements)-1
			if GUICtrlRead($elements[$i][0]) <> $elements[$i][2]  then
				$upd = true
				$elements[$i][2] = GUICtrlRead($elements[$i][0])
			endif
		next

		if $upd then
			$upd = false
			$data = ""
			for $i = 0 to ubound($elements)-1
				$data &= $elements[$i][1] & " = " & $elements[$i][2] & @crlf
			next
			guictrlsetdata($edit, "")
			guictrlsetdata($edit, $data)
		endif
	wend
	GUIDelete($pDev_gui_libAdd)


endfunc

#ce