func _lib_oldDlAll(byref $list_1)
	local $name, $url, $group
	Local $fn = $pDev_fp_ini_libs_2
	Local $fnEx = $pDev_fp_ini_libs
	Local $ir = IniReadSectionNames($fn)
	for $i = 1 to ubound($ir)-1
		$name 	= IniRead($fn, $ir[$i], "name", 	"")
		$url 	= IniRead($fn, $ir[$i], "git", 		"")
		$group 	= IniRead($fn, $ir[$i], "group",	"")
		if $group = "adriiot" 		then ContinueLoop
		if $group = "AdriLighting" 	then ContinueLoop
		if $group = "als" 			then ContinueLoop
		if $group = "ALS_matrixRGB"	then ContinueLoop
		if StringInStr($url, "AdriLighting") then ContinueLoop

			ConsoleWrite("$url: " & $url & @lf)
			repository_clone($list_1, $url)
			if UBound($list_1) = 0 Then
				IniWrite($pDev_fp_ini_libsManage, "gitFail", $name, $url)
				ContinueLoop
			EndIf

			Local $list_2 = repository_check($list_1[1])
			ConsoleWrite($list_2[2] & @lf)
			ConsoleWrite(@TAB & "ini: " & $list_2[0] & @lf)
			ConsoleWrite(@TAB & "json:" & $list_2[1] & @lf)
			IniWrite($fnEx, $list_2[2], "dirname",	$list_2[2])
			IniWrite($fnEx, $list_2[2], "git", 		$url)
			IniWrite($fnEx, $list_2[2], "ini", 		FileExists($list_2[0]))
			IniWrite($fnEx, $list_2[2], "json",		FileExists($list_2[1]))
			IniWrite($fnEx, $list_2[2], "group",	$group)
			DirCreate($pDev_fo_libraryProperties&$list_2[2])
			if FileExists($list_2[0]) then FileCopy( $list_2[0], $pDev_fo_libraryProperties & $list_2[2] & "\library.properties")
			if FileExists($list_2[1]) then FileCopy( $list_2[1], $pDev_fo_libraryProperties & $list_2[2] & "\library.json")
			if FileExists($list_2[0]) or FileExists($list_2[1]) then
				IniWrite($pDev_fp_ini_libs, $list_2[2], "library_properties", "0")
			endif
	Next
EndFunc
func _lib_dlAll(byref $list_1)
	GUICtrlSetData($pdev_guiDebug_Progress, 0)
	Local $name, $url, $ir = IniReadSectionNames($pDev_fp_ini_libs)
	for $i = 1 to ubound($ir)-1
		local $pourcentage = Round($i * 100 / UBound($ir) - 1)
		if $pDevGuiDebug then GUICtrlSetData($pdev_guiDebug_Progress, $pourcentage)
		
		$name 	= IniRead($pDev_fp_ini_libs, $ir[$i], "dirname", "")
		$url 	= IniRead($pDev_fp_ini_libs, $ir[$i], "git", "")
		repository_clone($list_1, $url, $pDev_fo_tempLib)
		if UBound($list_1) = 0 Then
			IniWrite($pDev_fp_ini_libsManage, "gitFail", $name, $url)
			ContinueLoop
		EndIf
		local $list_2 = repository_check($list_1[1])
		IniWrite($pDev_fp_ini_libs, $list_2[2], "dirname",	$list_2[2])
		IniWrite($pDev_fp_ini_libs, $list_2[2], "ini", 		FileExists($list_2[0]))
		IniWrite($pDev_fp_ini_libs, $list_2[2], "json",		FileExists($list_2[1]))
		if not FileExists($pDev_fo_libraryProperties&$list_2[2]) then DirCreate($pDev_fo_libraryProperties&$list_2[2])
		if FileExists($list_2[0]) then FileCopy( $list_2[0], $pDev_fo_libraryProperties & $list_2[2] & "\library.properties")
		if FileExists($list_2[1]) then FileCopy( $list_2[1], $pDev_fo_libraryProperties & $list_2[2] & "\library.json")
		if FileExists($list_2[0]) or FileExists($list_2[1]) then
			IniWrite($pDev_fp_ini_libs, $list_2[2], "library_properties", "0")
		endif
	Next
EndFunc

func _lib_dl()
	Local $list_1[0]
	Local $fnEx = $pDev_fp_ini_libs
	Local $url = InputBox("librarie url", "url ?", clipget(), "", 500, 135)
	ConsoleWrite("$url: " & $url & @lf)
	repository_clone($list_1, $url)
	if UBound($list_1) = 0 Then
		Return
	EndIf
	Local $list_2 = repository_check($list_1[1])
	ConsoleWrite($list_2[2] & @lf)
	ConsoleWrite(@TAB & "ini: " & $list_2[0] & @lf)
	ConsoleWrite(@TAB & "json:" & $list_2[1] & @lf)
	IniWrite($fnEx, $list_2[2], "dirname",	$list_2[2])
	IniWrite($fnEx, $list_2[2], "git", 		$url)
	IniWrite($fnEx, $list_2[2], "ini", 		FileExists($list_2[0]))
	IniWrite($fnEx, $list_2[2], "json",		FileExists($list_2[1]))
	DirCreate($pDev_fo_libraryProperties&$list_2[2])
	if FileExists($list_2[0]) then FileCopy( $list_2[0], $pDev_fo_libraryProperties & $list_2[2] & "\library.properties")
	if FileExists($list_2[1]) then FileCopy( $list_2[1], $pDev_fo_libraryProperties & $list_2[2] & "\library.json")
	if FileExists($list_2[0]) or FileExists($list_2[1]) then
		IniWrite($pDev_fp_ini_libs, $list_2[2], "library_properties", "0")
	endif
EndFunc

func _pDev_menuLv_lib_gitClone(byref $array, $Lv = GUICtrlGetHandle($pDev_lv_pj))
	_upd("!_pDev_menuLv_lib_gitClone START",0,0)
	local $sPworkingDir = FileSelectFolder("dev folder", @MyDocumentsDir & "\arduino\libraries")
	if ($sPworkingDir = "") then return
	_debugGui(@SW_SHOW)
	Local $sSubItemTxt
	Local $iSelect = _GUICtrlListView_GetSelectedIndices($Lv, True)
	If $iSelect[0] > 0 Then
		_upd(_lbl("dir") & "file:///" & $sPworkingDir,3,0)
		For $i = 0 To _GUICtrlListView_GetItemCount($Lv) - 1
			If _GUICtrlListView_GetItemSelected($Lv, $i) Then
				$sSubItemTxt = _GUICtrlListView_GetItemText($Lv, $i, 0)
	            for $j = 0 to ubound($array)-1
	                if ($sSubItemTxt = $array[$j][0]) then
	                    _upd(_lbl("value") & $array[$j][1], 3, 0)
						repository_cloneTo( $array[$j][1], $sPworkingDir)
	                endif
	            next					
			EndIf
		Next		
	EndIf
	_upd("!_pDev_menuLv_lib_gitClone END",0,0)
	_debugGui(@SW_HIDE)
endfunc

func _pDev_menuLv_lib_prop(byref $array, $Lv = GUICtrlGetHandle($pDev_lv_pj))
	_upd("!_pDev_menuLv_lib_prop START",0,0)
	Local $sSubItemTxt
	Local $iSelect = _GUICtrlListView_GetSelectedIndices($Lv, True)
	If $iSelect[0] > 0 Then
		If _pDev_lv_countItemChecked($Lv) > 1 Then
			For $i = 0 To _GUICtrlListView_GetItemCount($Lv) - 1
				If _GUICtrlListView_GetItemChecked($Lv, $i) Then
					$sSubItemTxt = _GUICtrlListView_GetItemText($Lv, $i, 0)
				EndIf
			Next
		Else
			$sSubItemTxt = _GUICtrlListView_GetItemText($Lv, $iSelect[1], 0)
            for $j = 0 to ubound($array)-1
                if ($sSubItemTxt = $array[$j][0]) then
			        if ( IniRead($pDev_fp_ini_libs, $array[$j][0], "library_properties", "") = "1") then
			        	return _libraryProperties($_grpArr, $pDev_fo_libraryPropertiesEx & $array[$j][0] & "\library.properties", $array[$j][0], $array[$j][1])
			        else
			        	return _libraryProperties($_grpArr, $pDev_fo_libraryProperties & $array[$j][0] & "\library.properties", $array[$j][0], $array[$j][1])
			        endif
                endif
            next
		EndIf
	EndIf
	_upd("!_pDev_menuLv_lib_prop END",0,0)
endfunc