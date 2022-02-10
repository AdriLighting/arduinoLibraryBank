func repository_clone(ByRef $array, $url = "https://github.com/AdriLighting/esp8266_events", $workingDir = $pDev_fo_tempLib)
	
	if FileExists($workingDir) Then DirRemove($workingDir, 1)
	if Not FileExists($workingDir) Then DirCreate($workingDir)

	$array = _FileListToArrayRec($workingDir, "*", 2, 0, 0, 2)
	if Not @error Then
		For $i = 1 To UBound($array) - 1
			DirRemove($array[$i], 1)
		Next
	EndIf

	Sleep(1000)

	; RunWait("git clone " & $url, $workingDir, $sFlag)
	_getCmdStd("git clone " & $url, $workingDir, $STDERR_MERGED, False, 100)
	$array = _FileListToArrayRec($workingDir, "*", 2, 0, 0, 2)
	if @error Then
		_getCmdStd($_gitCmd_clone_master & $url, $workingDir, False, 100)
	EndIf
	$array = _FileListToArrayRec($workingDir, "*", 2, 0, 0, 2)
	if @error Then
		_getCmdStd($_gitCmd_clone_main & $url, $workingDir, False, 100)
	EndIf
	$array = _FileListToArrayRec($workingDir, "*", 2, 0, 0, 2)

	

EndFunc
func repository_cloneTo( $url = "", $workingDir = @desktopdir & "\")
	Local $sDrive = "", $sDir = "", $sFileName = "", $sExtension = ""
	local $dirName
	Local $path = _pDev_setPath($workingDir)
	Local $temp = _pDev_setPath($workingDir) & "tempLib\"
	if FileExists($temp) Then DirRemove($temp, 1)
	if Not FileExists($temp) Then DirCreate($temp)
	Sleep(1000)

	Local $array

	RunWait("git clone " & $url, $temp, @SW_SHOW)
	$array = _FileListToArrayRec($temp, "*", 2, 0, 0, 2)
	if @error Then
		RunWait($_gitCmd_clone_master & $url, $temp, @SW_SHOW)
	else
		_PathSplit($pDev_fo_libraryProperties, $sDrive, $sDir, $sFileName, $sExtension)
		$dirName = StringSplit($sDir, "\")
		$dirName = $dirName[UBound($dirName)-2]
		DirMove( $array[1], $path , 1)
		DirRemove($temp, 1)
		Return
	EndIf
	$array = _FileListToArrayRec($temp, "*", 2, 0, 0, 2)
	if @error Then
		RunWait($_gitCmd_clone_main & $url, $temp, @SW_SHOW)
	else
		_PathSplit($pDev_fo_libraryProperties, $sDrive, $sDir, $sFileName, $sExtension)
		$dirName = StringSplit($sDir, "\")
		$dirName = $dirName[UBound($dirName)-2]
		DirMove( $array[1], $path , 1)
		DirRemove($temp, 1)
		Return
	EndIf
	$array = _FileListToArrayRec($temp, "*", 2, 0, 0, 2)
	if @error Then
	else
		_PathSplit($pDev_fo_libraryProperties, $sDrive, $sDir, $sFileName, $sExtension)
		$dirName = StringSplit($sDir, "\")
		$dirName = $dirName[UBound($dirName)-2]
		DirMove( $array[1], $path , 1)
		DirRemove($temp, 1)
		Return
	EndIf
EndFunc

func repository_check($sFolder = $pDev_fo_tempLib)
	Local $dirName
	Local $fileList
	local $findIni = false
	local $findJson = false
	Local $aDrive = "", $aDir = "", $aFileName = "", $aExtension = ""
	Local $sDrive = "", $sDir = "", $sFileName = "", $sExtension = ""

	$fileList	= _FileListToArrayRec($sFolder, "*", 1, 0, 0, 2)

	_PathSplit($sFolder, $sDrive, $sDir, $sFileName, $sExtension)
	$dirName = StringSplit($sDir, "\")
	$dirName = $dirName[UBound($dirName)-2]

	For $i = 1 To UBound($fileList) - 1

		_PathSplit($fileList[$i], $aDrive, $aDir, $aFileName, $aExtension)

		if ($aExtension = "driveupload") Then ContinueLoop
		if ($aFileName & $aExtension = "library.properties") Then
			$findIni = $fileList[$i]
		EndIf
		if ($aFileName & $aExtension = "library.json") Then
			$findJson = $fileList[$i]
		EndIf

	Next

	local $result[3]
	$result[0] = $findIni
	$result[1] = $findJson
	$result[2] = $dirName
	return $result
EndFunc