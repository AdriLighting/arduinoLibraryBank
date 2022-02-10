#cs

#ce


func _lib_makeArray_lvCol(byref $array, $lv, $multiFilterCat = "", $multiFilterKey = "", $multiFilterGrp = "")
	; --------------------------------------------------- LV CLEAR
	_GUICtrlListView_DeleteAllItems($lv)
	_pDev_lv_deleteColumns($lv)
    for $i = 0 to ubound($_collArr_1)-1
    	_GUICtrlListView_AddColumn($lv, $_collArr_1[$i][0],  $_collArr_1[$i][1])
    next

    ; --------------------------------------------------- ARRAY FILTER CHECK
	Local $filterArray[][] = [ _
	["", "", "", "", "", "", "", "", "", "", ""], _
	["", "", "", "", "", "", "", "", "", "", ""], _
	["", "", "", "", "", "", "", "", "", "", ""], _
	["", "", "", "", "", "", "", "", "", "", ""], _
	["", "", "", "", "", "", "", "", "", "", ""]]
	$filterArray[0][0] =  GUICtrlRead($pDev_cmb_filterCat)
	$filterArray[1][0] =  GUICtrlRead($pDev_cmb_filterKeys)
	$filterArray[2][0] =  GUICtrlRead($pDev_cmb_filterGrp)
	Local $grpFilterMult	= GUICtrlRead($pDev_inp_filterGrp)
	Local $catFilterMult	= GUICtrlRead($pDev_inp_filterCat)
	Local $ckeyFilterMult 	= GUICtrlRead($pDev_inp_filterKeys)
	Local $split
	if  ($grpFilterMult <> "") and ($multiFilterGrp <> "_ALL") then
		$split = StringSplit($grpFilterMult,";")
		if not @error then
			$filterArray[2][0] =  ""
			for $i = 1 to ubound($split)-1
				for $k = 0 to ubound($filterArray, 2)-1
					if ($filterArray[2][$k] == "") Then
						$filterArray[2][$k] = $split[$i]
						ExitLoop
					endif
				next
			next
		else
			$filterArray[2][0] =  GUICtrlRead($pDev_inp_filterGrp)
		endif
	endif
	if  ($catFilterMult <> "") and ($multiFilterCat <> "_ALL") then
		$split = StringSplit($catFilterMult,";")
		if not @error then
			$filterArray[0][0] =  ""
			for $i = 1 to ubound($split)-1
				for $k = 0 to ubound($filterArray, 2)-1
					if ($filterArray[0][$k] == "") Then
						$filterArray[0][$k] = $split[$i]
						ExitLoop
					endif
				next
			next
		else
			$filterArray[0][0] =  GUICtrlRead($pDev_inp_filterCat)
		endif
	endif
	if  ($ckeyFilterMult <> "") and ($multiFilterKey <> "_ALL")  then
		$split = StringSplit($ckeyFilterMult,";")
		if not @error then
			$filterArray[1][0] =  ""
			for $i = 1 to ubound($split)-1
				for $k = 0 to ubound($filterArray, 2)-1
					if ($filterArray[1][$k] == "") Then
						$filterArray[1][$k] = $split[$i]
						ExitLoop
					endif
				next
			next
		else
			$filterArray[1][0] =  GUICtrlRead($pDev_inp_filterKeys)
		endif
	endif


	local $continue_grpArr[0]
	local $continue_catArr[0]
	local $continue_keyArr[0]
	local $key
    for $i = 0 to ubound($array)-1
    	if IsArray($filterArray) then
			for $k = 0 to ubound($filterArray, 2)-1

				;  compare array[][15] vs object "keywords" from library.json
				if ($filterArray[1][$k] <> "") Then
					if ($filterArray[1][$k] = "_ALL") Then
						_ArrayAdd($continue_keyArr, "_ALL")
					elseif ($array[$i][15] = "") Then
					else
						; split array every ", "
						$key = StringSplit($array[$i][15], ",")
						if not @error then
							for $A = 1 to ubound($key)-1
								if StringInStr( StringLower($filterArray[1][$k]), StringLower(StringStripWS($key[$A],1+2+4))) or  StringInStr(StringLower(StringStripWS($key[$A],1+2+4)) , StringLower($filterArray[1][$k])) Then
								; if StringLower($filterArray[1][$k]) = StringLower(StringStripWS($key[$A],1+2+4)) Then
									_ArrayAdd($continue_keyArr, $array[$i][15])
								endif
							next
						else
							if StringInStr( StringLower($filterArray[1][$k]), StringLower(StringStripWS($array[$i][15],1+2+4))) or  StringInStr(StringLower(StringStripWS($array[$i][15],1+2+4)) , StringLower($filterArray[1][$k])) Then
							; if StringStripWS($array[$i][15],1+2+4) = $filterArray[1][$k] Then
								_ArrayAdd($continue_keyArr, $array[$i][15])
							endif
						endif
					endif
				endif

				; GRP
				if ($filterArray[2][$k] <> "") Then
					if ($filterArray[2][$k] = "_ALL") Then
						_ArrayAdd($continue_grpArr, "_ALL")
					elseif ($array[$i][18] = "") Then
					else
						; split array every ", "

							; if StringInStr( StringLower($filterArray[1][$k]), StringLower(StringStripWS($array[$i][15],1+2+4))) or  StringInStr(StringLower(StringStripWS($array[$i][15],1+2+4)) , StringLower($filterArray[1][$k])) Then
							if StringStripWS($array[$i][18],1+2+4) = $filterArray[2][$k] Then
								_ArrayAdd($continue_grpArr, $array[$i][18])
							endif
					endif
				endif

				;  compare array[][11] vs key "category" from library.properties
				if ($filterArray[0][$k] <> "") Then
					if ($filterArray[0][$k] = "_ALL") Then
						_ArrayAdd($continue_catArr, "_ALL")
					elseif ($array[$i][11] = "") Then
					else
						if $array[$i][11] = $filterArray[0][$k] Then
							_ArrayAdd($continue_catArr, $array[$i][11] )
						endif
					endif
				endif
			next
    	endif

    	; --------------------------------------------------- ARRAY FILTER SET
    	Local $cnt_1 = 0
    	Local $cnt_2 = 0
    	Local $cnt_3 = 0
    	for $j = 0 to ubound($continue_catArr)-1
    		if $continue_catArr[$j] = "_ALL"			then $cnt_1 += 1
    		if $continue_catArr[$j] = $array[$i][11] 	then $cnt_1 += 1
    	next
    	for $j = 0 to ubound($continue_keyArr)-1
    		if $continue_keyArr[$j] = "_ALL" 			then $cnt_2 += 1
    		if $continue_keyArr[$j] = $array[$i][15] 	then $cnt_2 += 1
    	next
     	for $j = 0 to ubound($continue_grpArr)-1
    		if $continue_grpArr[$j] = "_ALL" 			then $cnt_3 += 1
    		if $continue_grpArr[$j] = $array[$i][18] 	then $cnt_3 += 1
    	next
    	
    	if ($cnt_1 = 0 or $cnt_2 = 0 or $cnt_3 = 0) then ContinueLoop

		if GUICtrlRead($pDev_inp_filterName) <> "" Then
			if (_pDev_Checkword(GUICtrlRead($pDev_inp_filterName),  $array[$i][0]) < 3) then ContinueLoop
		EndIf

    	; --------------------------------------------------- LV SET
    	Local $index = _GUICtrlListView_AddItem($lv, $array[$i][0])
    	for $j = 1 to ubound($_collArr_1)-1
    		local $var = $_collArr_1[$j][2]
    		_GUICtrlListView_AddSubItem($lv, $index, $array[$i][$var], $j)
    	next
    next
endfunc
func _lib_makeArray(ByRef $_arr)
    local $data, $arr_2, $fr, $json_1, $sFile,  $tempFile = @TempDir & "\temp_GitUrl.ini"
    local $ir_2, $path, $fo
   	local $pos = 0
    local $ir = IniReadSectionNames($pDev_fp_ini_libs)
	Local $arraySize = ubound($ir)
	for $i = 0 to ubound($pDev_frameworkName)-1
		$path = $pDev_fo_ini_libCheck & $pDev_frameworkName[$i][0] & ".ini"
		if FileExists($path) then
			$ir_2 = IniReadSectionNames($path)
			$arraySize += ubound($ir_2)-1
		endif
	next
    local $arr[$arraySize][19]
    for $i = 1 to ubound($ir)-1
    	; add data from _libsEx.ini
        $fo     			= IniRead($pDev_fp_ini_libs, $ir[$i], "dirname",	"")
        $arr[$i][0] 		= IniRead($pDev_fp_ini_libs, $ir[$i], "dirname", 	"")
        $arr[$i][1] 		= IniRead($pDev_fp_ini_libs, $ir[$i], "git",		"")
        $arr[$i][2] 		= IniRead($pDev_fp_ini_libs, $ir[$i], "ini",		"")
        $arr[$i][3] 		= IniRead($pDev_fp_ini_libs, $ir[$i], "json",		"")
        $arr[$i][18] 		= IniRead($pDev_fp_ini_libs, $ir[$i], "group",		"")

        ; add data from "library.properties" from Library specification files
        if ( IniRead($pDev_fp_ini_libs, $ir[$i], "library_properties", "") = "1") then
        	$sFile = $pDev_fo_libraryPropertiesEx & $fo & "\library.properties"
        else
        	$sFile = $pDev_fo_libraryProperties & $fo & "\library.properties"
        endif
        if fileexists($sFile) then
            if FileExists($tempFile) Then FileDelete($tempFile)
            FileWrite($tempFile, "[section]" & @CRLF & FileRead($sFile))
           	$arr[$i][4] 	= IniRead($tempFile, "section", "name",     		"")
           	$arr[$i][5] 	= IniRead($tempFile, "section", "version",     		"")
           	$arr[$i][6] 	= IniRead($tempFile, "section", "author",     		"")
           	$arr[$i][7] 	= IniRead($tempFile, "section", "maintainer",		"")
           	$arr[$i][8] 	= IniRead($tempFile, "section", "url",				"")
           	$arr[$i][9] 	= IniRead($tempFile, "section", "sentence",     	"")
           	$arr[$i][10] 	= IniRead($tempFile, "section", "paragraph",    	"")
           	$arr[$i][11] 	= IniRead($tempFile, "section", "category",     	"")
           	$arr[$i][12] 	= IniRead($tempFile, "section", "architectures",	"")
           	$arr[$i][13] 	= IniRead($tempFile, "section", "depends",     		"")
           	$arr[$i][14] 	= IniRead($tempFile, "section", "includes",			"")
        endif

        ; add data from "library.json" from Library specification files
        $sFile = $pDev_fo_libraryProperties & $fo & "\library.json"
        if fileexists($sFile) then
        	$fr = FileRead($sFile)
        	$json_1 = Json_Decode($fr)
           	$arr_2 = Json_Get($json_1, '["keywords"]')
           	if IsArray($arr_2) then
           		$data = ""
           		for $j = 0 to ubound($arr_2)-1
           			$data &= Json_Get($json_1, '["keywords"]['&$j&']') & ( ($j = ubound($arr_2)-1) ? "" : ", ")
           		next
           		$arr[$i][15] 	= $data
           	else
           		$arr[$i][15] 	= $arr_2
           	endif
           	$arr_2 = Json_Get($json_1, '["frameworks"]')
           	if IsArray($arr_2) then
           		$data = ""
           		for $j = 0 to ubound($arr_2)-1
           			$data &= Json_Get($json_1, '["frameworks"]['&$j&']') & ( ($j = ubound($arr_2)-1) ? "" : ", ")
           		next
           		$arr[$i][16] 	= $data
           	else
           		$arr[$i][16] 	= $arr_2
           	endif
           	$arr_2 = Json_Get($json_1, '["platforms"]')
           	if IsArray($arr_2) then
           		$data = ""
           		for $j = 0 to ubound($arr_2)-1
           			$data &= Json_Get($json_1, '["platforms"]['&$j&']') & ( ($j = ubound($arr_2)-1) ? "" : ", ")
           		next
           		$arr[$i][17] 	= $data
           	else
           		$arr[$i][17] 	= $arr_2
           	endif
        endif

        $pos+=1
    next

   	; library from installed framework "\.platformio\packages\"
	for $j = 0 to ubound($pDev_frameworkName)-1
		$path = $pDev_fo_ini_libCheck & $pDev_frameworkName[$j][0] & ".ini"
		if FileExists($path) then
			$ir = IniReadSectionNames($path)
			local $pos_2 = $pos
		    for $i = 1 to ubound($ir)-1
		        $arr[$i+$pos_2][0] 		= IniRead($path, $ir[$i], "name", 	"")
		        $arr[$i+$pos_2][1] 		= IniRead($path, $ir[$i], "git",		"")
		        $arr[$i+$pos_2][2] 		= 1
		        $arr[$i+$pos_2][3] 		= 0
		        $arr[$i+$pos_2][18] 	= IniRead($path, $ir[$i], "group",		"")

		        ; add data from "library.properties" from Library specification files
		        $sFile = $_fo_pioPackages & IniRead($path, $ir[$i], "library_properties", "")
		        if fileexists($sFile) then
		            if FileExists($tempFile) Then FileDelete($tempFile)
		            FileWrite($tempFile, "[section]" & @CRLF & FileRead($sFile))
		           	$arr[$i+$pos_2][4] 	= IniRead($tempFile, "section", "name",     		"")
		           	$arr[$i+$pos_2][5] 	= IniRead($tempFile, "section", "version",     		"")
		           	$arr[$i+$pos_2][6] 	= IniRead($tempFile, "section", "author",     		"")
		           	$arr[$i+$pos_2][7] 	= IniRead($tempFile, "section", "maintainer",		"")
		           	$arr[$i+$pos_2][8] 	= IniRead($tempFile, "section", "url",				"")
		           	$arr[$i+$pos_2][9] 	= IniRead($tempFile, "section", "sentence",     	"")
		           	$arr[$i+$pos_2][10]	= IniRead($tempFile, "section", "paragraph",    	"")
		           	$arr[$i+$pos_2][11]	= IniRead($tempFile, "section", "category",     	"")
		           	$arr[$i+$pos_2][12]	= IniRead($tempFile, "section", "architectures",	"")
		           	$arr[$i+$pos_2][13]	= IniRead($tempFile, "section", "depends",     		"")
		           	$arr[$i+$pos_2][14]	= IniRead($tempFile, "section", "includes",			"")
		        endif

		        $pos+=1

		    next
		endif
	next

	; sort decending alphabetic library name
	local $aSortData[][] = [ _
	[0, 0]]
	_ArrayMultiColSort($arr, $aSortData)

	$_arr = $arr
EndFunc



func _lib_checkProp()
	Local $fnEx = $pDev_fp_ini_libs
	Local $ir = IniReadSectionNames($fnEx)
	Local $findProp = False
	Local $findPropArr[0]
	for $i = 1 to ubound($ir)-1
		$findProp = False
		if ( IniRead($fnEx, $ir[$i], "ini", "") = "1") 	Then $findProp = True
		if ( IniRead($fnEx, $ir[$i], "json", "") = "1") Then $findProp = True
		if not $findProp Then _ArrayAdd($findPropArr, IniRead($fnEx, $ir[$i], "dirname", ""))

	Next
	return $findPropArr
EndFunc

func _lib_get_keywords(byref $catArr, byref $keysArr, byref $_grpArr)
	Local $dirName, $fr, $split, $path
	Local $fileList = _FileListToArrayRec($pDev_fo_libraryProperties, "*", 1, 1, 0, 2)
	Local $aDrive = "", $aDir = "", $aFileName = "", $aExtension = ""
	Local $sDrive = "", $sDir = "", $sFileName = "", $sExtension = ""
	_PathSplit($pDev_fo_libraryProperties, $sDrive, $sDir, $sFileName, $sExtension)
	$dirName = StringSplit($sDir, "\")
	$dirName = $dirName[UBound($dirName)-2]
	Local $grpArr[0]
	Local $categoryArr[0]
	Local $keywordyArr[0]
	Local $keywordAllyArr[0]
	_ArrayAdd($categoryArr, "_ALL")
	For $i = 1 To UBound($fileList) - 1
		_PathSplit($fileList[$i], $aDrive, $aDir, $aFileName, $aExtension)
		$fr = FileRead($fileList[$i])
		if ($aExtension = "driveupload") Then ContinueLoop
		if ($aFileName & $aExtension = "library.properties") Then
			local $tempFile = @TempDir & "\temp_GitUrl.ini"
			if FileExists($tempFile) Then FileDelete($tempFile)
			FileWrite($tempFile, @CRLF &  "[section]" & @CRLF & $fr)
			if (IniRead($tempFile, "section",  "category", "")<>"") Then _ArrayAdd($categoryArr, IniRead($tempFile, "section",  "category", "") )
		EndIf
		if ($aFileName & $aExtension = "library.json") Then
			Local $json = Json_Decode($fr)
			_ArrayAdd($keywordyArr,  StringStripWS(Json_Get($json, '["keywords"]'), 1+2+4))
		EndIf
	Next
	$catArr = _ADFunc_Array_ArrayDeleteClones($categoryArr)
	_ArrayAdd($keywordAllyArr, "_ALL")
	For $i = 0 To UBound($keywordyArr) - 1
		$split = StringSplit($keywordyArr[$i], ",")
		if not @error Then
			For $j = 1 To UBound($split) - 1
				_ArrayAdd($keywordAllyArr, StringStripWS($split[$j], 1+2+4))
			Next
		EndIf
	Next
	$keysArr = _ADFunc_Array_ArrayDeleteClones($keywordAllyArr)
	_ArrayAdd($grpArr, "_ALL")
	local $ir = IniReadSectionNames($pDev_fp_ini_libs)
    for $i = 1 to ubound($ir)-1
    	_ArrayAdd($grpArr, IniRead($pDev_fp_ini_libs, $ir[$i], "group", ""))
    next
	for $j = 0 to ubound($pDev_frameworkName)-1
		$path = $pDev_fo_ini_libCheck & $pDev_frameworkName[$j][0] & ".ini"
		if FileExists($path) then
			$ir = IniReadSectionNames($path)
		    for $i = 1 to ubound($ir)-1
		    	_ArrayAdd($grpArr, IniRead($path, $ir[$i], "group", ""))
		    next
		endif
	next
	$_grpArr = _ADFunc_Array_ArrayDeleteClones($grpArr)
EndFunc


