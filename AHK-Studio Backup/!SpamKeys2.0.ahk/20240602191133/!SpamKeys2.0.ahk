;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *[PRELOAD] %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%;{
#Requires AutoHotkey v2.0
#SingleInstance Force
Persistent
SoundBeep 1000, 50
SetWorkingDir A_ScriptDir
Global XButton1 := "XButton1", XButton2 := "XButton2", LButton := "LButton", RButton := "RButton", MButton := "MButton", Shift:="Shift" , Ctrl := "Ctrl", Alt := "Alt"
Global sATitle := ""
;}############################################### *[PRELOAD] ###################################################
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *[GeneralHK] %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%;{
;}############################################### *[GeneralHK] #################################################
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *[Control] %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%;{
*F12::
{
	clip_temp := A_Clipboard
	DetectHiddenWindows true
	currwin := WinGetProcessName("A")
	wintitl := WinGetTitle("A")
; procpath := WinGet("ProcessPath", "A") ; Uncomment if needed
	A_Clipboard := "#HotIf WinActive(`"ahk_exe " . currwin . "`")`t`t`t`t`t`t`t`t`t`t" . ";{ [" . wintitl . "]" . "`n`n #HotIF " . ";}"
	KeyWait("Ctrl", "D")
	KeyWait("v", "D")
	A_Clipboard := clip_temp
	DetectHiddenWindows False
}
#HotIf WinActive("AHK Studio")										;{ [AHK Studio]
	*~^s::
	{
		if A_IsCompiled
		{
			Run Format('"{1}" /force', A_ScriptFullPath)
		}
		else
		;Run Format('"{1}" /force "{2}"', A_AhkPath, A_ScriptFullPath)
			Reload
		ExitApp
	}
	#HotIf ;}
;}############################################### *[Control] ###################################################
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *[FUNCS] %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%;{
Spam2(ifkey1,skey1,to1 := 5,ifkey2 := "",skey2 := "",ifkey3 := "",skey3 := "",ifkey4 := "",skey4 := "",holdkey1 := 5) {
	sATitle:=WinGetProcessName("A")
	while ((GetKeyState(ifkey1, "P")) && WinActive("ahk_exe" sATitle) && !GetKeyState("Alt", "P"))
	{
		if (GetKeyState(ifkey1, "P"))	
		{
			send "{blind}{" skey1 " down}"
			sleep holdkey1
			send "{blind}{" skey1 " up}"
			
		}
		if ((ifkey2 != "") and (skey2 != ""))
			if (GetKeyState(ifkey2, "P"))
			{
				sleep to1
				send "{blind}{" skey2 " down}"
				sleep 5
				send "{blind}{" skey2 " up}"
			}
		if ((ifkey3!="") and (skey3!=""))
			if (GetKeyState(ifkey3, "P"))
			{
				sleep to1
				send "{blind}{" skey3 " down}"
				sleep 5
				send "{blind}{" skey3 " up}"
			}
		if ((ifkey4!="") and (skey4!=""))
			if (GetKeyState(ifkey4, "P"))
			{
				sleep to1
				send "{blind}{" skey4 " down}"
				sleep 5
				send "{blind}{" skey4 " up}"
			}
	}
	send "{alt up}{shift up}{ctrl up}"
	return
}
;}############################################### *[FUNCS] #####################################################
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *[GAMES] %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%;{ 
;# - WIN ! - ALT ^ - CTRL + SHIFT <>- left right mods
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#HotIf WinActive("ahk_exe SC2_x64.exe")										;{ [StarCraft II]
	$*~q::
	$*~w::
	$*~e::
	$*~a::
	$*~r::
	$*~t::
	{
		sleep 10
		send "{F9}"
		return
	}
#HotIF ;}
#HotIf WinActive("ahk_exe VRising.exe")		 								;{ [VRising]
	$XButton2::
	{
		Spam2(XButton2,"f",5)
	}
#HotIf ;}
#HotIf WinActive("ahk_exe TheDivision2.exe")								;{ [Tom Clancy's The Division 2]
	$XButton2::Spam2(XButton2,LButton,5)
#HotIf ;}