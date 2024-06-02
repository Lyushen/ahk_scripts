#NoEnv

SetWorkingDir D:\GoogleDrive\Documents\!NeedToSave\myScripts\PathOfExile\Resources\
IFExist, D:\Steam\steamapps\common\Path of Exile\Client.exe
Menu, Tray, Icon, D:\Steam\steamapps\common\Path of Exile\Client.exe
DetectHiddenWindows, ON
WinGet, ScriptPID, PID, ahk_id %A_ScriptHwnd%
Run, *RunAs E:\Install\SystemFolders\Progs\Tools\nircmd\nircmdc.exe setappvolume /%ScriptPID% 0.01,, hide
SoundPlay, %A_WinDir%\Media\ding.wav

global toggle:=0
global WaitFor:=0

#Include _Preload.ahk
#InstallKeybdHook
#SingleInstance force
#Persistent
Thread, interrupt, 0
CoordMode, Mouse, Screen
Thread, interrupt, 0
SendMode Input
Process, Priority,, AboveNormal


;==========launch PoE
$F4::
IfWinNotExist, ahk_class POEWindowClass
	Run, steam://rungameid/238960
else IfWinNotActive
	WinActivate, ahk_class POEWindowClass
return

;	D:\Steam\steamapps\common\Path of Exile

#IfWinActive, ahk_class POEWindowClass
$*CapsLock::
MoveInv()
Flasks()
return
$F2::Remaining()
$F3::TPhome()
;catsleep
$RSHift::return
$RAlt::return
$Space::return
$RControl::return
$up::return
$down::return
$left::return
$right::return
$Numpad0::return
Ralt & Enter::send !{Enter}

$~*WheelDown::
if (!toggle)
{
	if (GetKeyState("Ctrl")) or (GetKeyState("Shift")) 
		Send {blind}{Right}
}
else if (toggle)	
	Flasks()
return
$~*WheelUp::
if (!toggle)
{
	if (GetKeyState("Ctrl")) or (GetKeyState("Shift"))
		Send {blind}{Left}
}
else if (toggle)	
{
	send sf
}
return

$*~LButton::
if (toggle) and !GetKeyState("Lalt")
{
	send {shift down}{space}
}
return


$*~LButton up::
if (toggle) and !GetKeyState("Lalt")
{
	send {shift up}{tab}
}
return

;$*~tab::return

;$*~tab up::
;if (!GetKeyState("RButton", "P"))
	;send, {space}
;return

$*~XButton1::
if (toggle) 
{
	send {LButton down}
	;while GetKeyState("XButton1","P")
	;{
		;send {shift down}{XButton1}{shift up}
		;sleep 100
	;}
}
return
$*~XButton1 up::
if (toggle) 
	send {shift up}{LButton up}
return
/*
$*~RButton::
if (toggle) 
{
	send {LButton down}
	while GetKeyState("RButton","P")
	{
		;send {shift down}{RButton}{shift up}
		send {RButton}
		sleep 40
	}
}
return
$*~XButton1 up::
$*~RButton up::
if (toggle) 
	send {shift up}{LButton up}
return
*/
;$*~RButton::
;if (toggle) 
;{
	;while GetKeyState("RButton","P")
	;{
		;sleep 50
		send {shift down}{RButton}{shift up}
		;send {RButton}
	;}
;}
;return




$*XButton2::togglescript(3)

togglescript(n){
	if toggle and (n=0 or n=3)	{
		toggle := !toggle
		SetTimer, SendSomething, Off
		SoundPlay, %A_WinDir%\Media\Speech Sleep.wav
	} else if !toggle and (n=1 or n=3) {
		toggle := !toggle
		SetTimer, SendSomething, 100
		SoundPlay, %A_WinDir%\Media\Speech On.wav
	}	return 
}

SendSomething:
if (GetKeyState("q", "P"))
	send q
else if (GetKeyState("w", "P"))
	send w
else if (GetKeyState("e", "P"))
	send e
else if (GetKeyState("r", "P"))
	send r
else if (GetKeyState("t", "P"))
	send t
else if (!GetKeyState("Lalt", "P"))
	{
		;if (!GetKeyState("RButton", "P"))
			Send {blind}{Lbutton}
	}
;else if (WaitFor=1)
;if (GetKeyState("ESC","P") OR GetKeyState("Space","P") OR GetKeyState("1","P") OR GetKeyState("4","P"))
;WaitFor:=0
if !WinActive("ahk_class POEWindowClass")
	togglescript(0)
return

$~1::
$~4::
togglescript(0)
return



MoveInv()	{
	IF !toggle
	{
		global mx, my
		;850, 4   1682, 1142
		send {blind}{Control down}
		while GetKeyState("CapsLock","P")
		{
			MouseGetPos, mx, my
			if (((1683 <= mx) and (mx <= 2542)) and ((771 <= my) and (my <= 1138))) or (((19 <= mx) and (mx <= 879) and (212 <= my) and (my <= 1065)))
			{
				send {blind}{LButton}
			}
			Sleep, 45
		}
		send {blind}{Control up}
	}
	return
}
Flasks()	{
if (toggle)
	{
	send {blind}{MButton}
	send {blind}{s down}
	Sleep, 10
	send {blind}{s up}
	Sleep, 10
	send {blind}{d down}
	Sleep, 10
	send {blind}{d up}
	Sleep, 10
	send {blind}{f down}
	Sleep, 10
	send {blind}{f up}
	Sleep, 10
	send {blind}{g down}
	Sleep, 10
	send {blind}{g up}
	sleep 500
	}
	return
}

Remaining()	{
	send {enter}/remaining{enter}
	return	
}

TPhome()	{
	GTP := 0
	BlockInput,Mouse
	MouseGetPos,mx,my
	sleep 3
	IF (toggle)
		togglescript(0)
	IF (!GTP)
	{
		send {space}
		MouseMove, 831, 639, 0
		send 1
		Sleep, 99
		MouseMove, 831, 639, 1
		sleep 1
		MouseClick, Right, 2496, 1101, 1,0
		Sleep, 319
		MouseClick, Left, 831, 639 , 10,0
		sleep 50
		MouseClick, Left, 831, 639 , 10,0
		MouseMove %mx%,%my%,0
	}
	IF (GTP)
	{
		send {blind}{b down}{b up}
		sleep 200
		BlockInput,on
		click
		click
		;send {blind}{t down}
		;sleep 5
		;send {blind}{t up}
		;send {blind}{t down}
		;sleep 5
		;send {blind}{t up}
		;send {blind}{t down}
		;sleep 5
		;send {blind}{t up}
		sleep 1900
		send {blind}b
		MouseMove, 1281, 650, 0
		MouseClick, Left, 1281, 650 , 10,0
		BlockInput,off
		MouseClick, Left, 1281, 650 , 5,1
		MouseMove %mx%,%my%,0
		sleep 1500
		;sleep 120
		;send {blind}{w down}
		;sleep 5
		;send {blind}{w up}
		
	}
	BlockInput,off
	Return
}

		; if (GetKeyState(":=LButton", "P"))
		; {
			; if (!GetKeyState("q", "P") or !GetKeyState("XButton1", "P"))
			; {
				; send {shift down}
				; while GetKeyState("LButton", "P")
				; {
					; sleep 20
				; }
				; send {shift up}
			; }
		; }
; $~q::
; if (!GetKeyState("RButton",p))
; {
; send {tab}
; keywait q
; send {space}
; }
; return

; $*XButton1::
; send {tab down}
; sleep 10
; send {tab up}
; SetTimer, SendQ, 50
; Hotkey, $*XButton1, off
; Hotkey, $*XButton1 up, On
; return
; $*XButton1 up::
; send {space}
; Settimer, SendQ, off
; Hotkey, $*XButton1, On
; Hotkey, $*XButton1 up, off
; return

; $*q::
; send {tab}
; SetTimer, SendQ, 110
; Hotkey, $*~q, off
; Hotkey, $*~q up, On
; return
; $*q up::
; send {space}
; Settimer, SendQ, off
; Hotkey, $*~q, On
; Hotkey, $*~q up, off
; return


; $~WheelDown::
; send, Q
; return

/*
	$*RButton::
	if toggle {
		
		send {shift down}
		send {RButton down}
		While GetKeyState("RButton", "P")
		{
			Click
			sleep 100
		}
		send {RButton up}
		send {shift up}
	}
	else 
		MouseClick, right
	return
*/

/*
	
	$*F2::
	send {Enter}
	sleep 20
	send {NumpadDiv}remaining
	send {Enter}
	return
	
	$*WheelUp::
	send, Q
	return
	
	
	$*XButton1::
	loop
	{
		
		While GetKeyState("LButton", "P")
		{
			MouseClick, left
			sleep 50
		}
		if GetKeyState("alt","p")
			break
		
	}
	return
	
	
	
	
	
	
	
	
	#IfWinActive ahk_exe Expeditions Viking.exe
	$*XButton1::
	F1Down := !F1Down
	If F1Down
		send {F1 down}
	Else
		send {F1 up}
	Return
*/