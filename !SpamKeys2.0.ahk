;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *[PRELOAD] %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%;{
#Requires AutoHotkey v2.0
#SingleInstance Force
Persistent
SoundBeep 1000, 50
SetWorkingDir A_ScriptDir
Global sound_off := A_WinDir "\Media\Speech Sleep.wav",sound_on := A_WinDir "\Media\Speech On.wav"
Global XButton1 := "XButton1", XButton2 := "XButton2", LButton := "LButton", RButton := "RButton", MButton := "MButton", Shift:="Shift" , Ctrl := "Ctrl", Alt := "Alt"
Global tog := false, sATitle := "", gATitle:="", gk1 := "", gk2 := "", gk3 := "", gk4 := "", gk5 := "", gik1:="", gik2:="", gik3:="", gik4:="", gik5:="", gholdkey1 := 5, gholdkey2 := 5, gto := 5
global timerActive := false
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
	A_Clipboard := "#HotIf WinActive(`"ahk_exe " currwin "`")`t`t`t`t`t`t`t`t`t`t;{ [" wintitl "]`n`n#HotIF " ";}"
	KeyWait "Ctrl", "D T5"
	KeyWait "v", "D"
	A_Clipboard := clip_temp
	DetectHiddenWindows False
}
#HotIf (WinActive("AHK Studio") || WinActive("ahk_exe Code.exe")	)					;{ [AHK Studio or VS Code]
*F11::
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
ShowToolTip(text,duration := 500) {
    ToolTip(text)
    SetTimer(() => ToolTip(), -duration) ; SetTimer with a negative duration runs once after the specified time
}
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
		sleep to1
	}
	send "{alt up}{shift up}{ctrl up}"
	
	return
}
class TogTimer {
    __New(kk := [], to := 5, ik := [], holdkey := []) {
        ; Initialize parameters
        this.kk := kk
        this.to := to
        this.ik := ik
        this.holdkey := holdkey
        this.timer := ObjBindMethod(this, "Tick")
        this.isActive := false
        this.gATitle := ""
    }
    
    Start() {
        this.gATitle := WinGetProcessName("A")
        if !this.isActive {
            SetTimer(this.timer, this.to)
            this.isActive := true
            ShowToolTip("Timer started")
        } else {
            this.Stop()
            ShowToolTip("Timer stopped")
        }
    }

    Stop() {
        SetTimer(this.timer, 0)
        this.isActive := false
        ShowToolTip("Timer stopped")
    }

    Tick() {
        if WinActive("ahk_exe " this.gATitle) {
            for i, key in this.ik {
                if key != "" && GetKeyState(key, "P") {
                    Send("{blind}{" this.kk[i] " down}")
                    Sleep(this.holdkey[i])
                    Send("{blind}{" this.kk[i] " up}")
                } else if key == "" || key == 0 {
                    Send("{blind}{" this.kk[i] " down}")
                    Sleep(this.holdkey[i])
                    Send("{blind}{" this.kk[i] " up}")
                }
            }
            Sleep(this.to)
        }
    }
}
class SpamTimer{
	
}
;}############################################### *[FUNCS] #####################################################
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *[GAMES] %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%;{ 
;# - WIN ! - ALT ^ - CTRL + SHIFT <>- left right mods
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global diablo_counter := TogTimer([LButton], 5, [LButton], [5, 5])
#HotIf WinActive("ahk_exe Diablo IV.exe")										;{ [Diablo IV]
	*XButton2::
	{
		global diablo_counter
    	diablo_counter.Start()
	}
#HotIF ;}

#HotIf WinActive("ahk_class SDL_app")										;{ [VN games]
	*XButton2::Spam2(XButton2,LButton)
	*~XButton1::CTRL
#HotIF ;}

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
	$*~LButton::Spam2(LButton,"F9",100)
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