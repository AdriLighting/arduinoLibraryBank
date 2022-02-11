func _pDev_pio_libBuiltinList($sOutput)
	Local $aReturned = JsonArrayfied($sOutput)

	if not FileExists($pDev_fo_ini_framework) 	then DirCreate($pDev_fo_ini_framework)
	if not FileExists($pDev_fo_ini_libCheck)	then DirCreate($pDev_fo_ini_libCheck)

	_upd("- _pDev_pio_libBuiltinList", 3, 1)

	_upd("UBound($aReturned) : " & UBound($aReturned), 3, 0)

 	GUICtrlSetData($pdev_guiDebug_Progress, 0)

	Local $ir, $value, $key, $framework = "", $frameworkPath = ""
	For $i = 1 to UBound($aReturned) - 1
 		local $pourcentage = Round($i * 100 / UBound($aReturned) - 1)
 		if $pDevGuiDebug then GUICtrlSetData($pdev_guiDebug_Progress, $pourcentage)

		if $aReturned[$i][2] = "name" Then $framework 		=  $aReturned[$i][3]
		if $aReturned[$i][2] = "path" Then $frameworkPath 	=  $aReturned[$i][3]

		if $aReturned[$i][4] = "name" Then

			Local $cnt = 1

			_upd($aReturned[$i][4] & " = " & $aReturned[$i][5], 3, 0)

			IniWrite($pDev_fo_ini_libCheck & $framework & ".ini", $aReturned[$i][5], "name", $aReturned[$i][5])
			IniWrite($pDev_fo_ini_libCheck & $framework & ".ini", $aReturned[$i][5], "group", $framework)
			IniWrite($pDev_fo_ini_libCheck & $framework & ".ini", $aReturned[$i][5], "framework_path", _pDev_setPath(stringreplace($frameworkPath, $_fo_pioPackages, "")))

			local $foFramework = _pDev_setPath($pDev_fo_ini_framework) & _pDev_setPath($framework)
			if not FileExists($foFramework) then DirCreate($foFramework)

			While 1
				if ($i+$cnt) > UBound($aReturned)-1 Then ExitLoop

				if ($aReturned[$i+$cnt][4] = "name") Then ExitLoop

				$value 	= $aReturned[$i+$cnt][5]
				$key 	= $aReturned[$i+$cnt][4]

				; if $aReturned[$i+$cnt][4] <> "" Then
					if $aReturned[$i+$cnt][7] <> "" Then
						$key 	= $aReturned[$i+$cnt][4] & " " &  $aReturned[$i+$cnt][5] & " " & $aReturned[$i+$cnt][6]
						$value 	=  $aReturned[$i+$cnt][7]
					elseif $aReturned[$i+$cnt][6] <> "" Then
						$key 	= $aReturned[$i+$cnt][4] & " " & $aReturned[$i+$cnt][5]
						$value 	=  $aReturned[$i+$cnt][6]
					else
						$key 	=  $aReturned[$i+$cnt][4]
						$value 	= $aReturned[$i+$cnt][5]
					EndIf
				; EndIf

				IniWrite($foFramework & $aReturned[$i][5] & ".ini", $aReturned[$i][5], $key, $value)
				; _upd(@TAB & $key & " = " & $value, 3, 0)
				$cnt+=1
			wend

			$ir = iniread($foFramework & $aReturned[$i][5] & ".ini", $aReturned[$i][5], "__pkg_dir", "")
			IniWrite($pDev_fo_ini_libCheck & $framework & ".ini", $aReturned[$i][5], "folder_lib", _pDev_setPath(stringreplace($ir, $_fo_pioPackages, "")))
			IniWrite($pDev_fo_ini_libCheck & $framework & ".ini", $aReturned[$i][5], "library_properties", _pDev_setPath(stringreplace($ir, $_fo_pioPackages, "")) & "library.properties")

			$ir = iniread($foFramework & $aReturned[$i][5] & ".ini", $aReturned[$i][5], "url", "")
			IniWrite($pDev_fo_ini_libCheck & $framework & ".ini", $aReturned[$i][5], "git", $ir)


			_upd("---", 3, 0)

		EndIf
	Next
;~ 	_ArrayDisplay($aReturned)
	_upd("", 3, 2)

EndFunc