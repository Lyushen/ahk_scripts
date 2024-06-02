#NoEnv
#KeyHistory
#InstallKeybdHook
#SingleInstance force
;#Warn
#MaxThreadsPerHotkey 1
#MaxThreads 255
;#MaxThreadsBuffer On
;#UseHook On
#MaxHotkeysPerInterval 20000
#HotkeyInterval 1
#HotkeyModIFierTimeout 1
#Persistent
Process, Priority,, high
toggle(0)

CoordMode, Mouse, Screen
Thread, interrupt, 0
SendMode Input
Process, Priority,, High
SetWorkingDir D:\GoogleDrive\Documents\!NeedToSave\myScripts\PathOfExile\Resources\
IFExist, D:\Steam\steamapps\common\Path of Exile\Client.exe
Menu, Tray, Icon, D:\Steam\steamapps\common\Path of Exile\Client.exe

DetectHiddenWindows, ON
WinGet, ScriptPID, PID, ahk_id %A_ScriptHwnd%
SoundPlay, %A_WinDir%\Media\ding.wav
Run, *RunAs E:\Install\SystemFolders\Progs\Tools\nircmd\nircmdc.exe setappvolume /%ScriptPID% 0.02,, hide
DetectHiddenWindows, Off
;#Include _Preload.ahk


global GTP:=0,toggle:=0,bloodragetick_s:=0,bloodragetick_c:=0,RBtickS:=0,RBtickC:=0
;#Include D:\GoogleDrive\Documents\!NeedToSave\myScripts\!SpamKeys.ahk
;==========*[launch PoE] PathOfExile_x64Steam.exe PathOfExile_x64.exe steam://rungameid/238960
F9::
IFWinNotExist, ahk_class POEWindowClass
	Run, steam://rungameid/238960 ;PathOfExile_x64Steam.lnk ;PathOfExile_x64.lnk 
else IFWinNotActive
	WinActivate, ahk_class POEWindowClass
return

;	D:\Steam\steamapps\common\Path of Exile
#IFWinActive ahk_class POEWindowClass

 ;*[poe2ww]
~*WheelDown::
if (!toggle)
	Send {blind}{Right} ; ALT+WheelDown: Stash scroll
return
~*WheelUp::
if !toggle
	Send {blind}{Left} ; ALT+WheelUp: Stash scroll
return

$*~`::
IF toggle 
	Logout()
return

$*CapsLock::
if toggle
	Crun()
else
	MoveInv()
return
$F2::Remaining()
$F3::TPhome()
$F5::Logout()
$XButton2::ToggleOnOff()
$~1::
$~4::
if toggle
	toggle(0)
return
;$*c::Crun()
;$tab::MapHold()



;$~XButton1::
;sleep 200
;send {F7}
;return
$~LButton::
;send {space}
send {blind}{shift down}{LButton down}{t down}
;send {blind}{RButton down}
bloodragetick_c:= A_TickCount - bloodragetick_s
if (bloodragetick_c>8000)
{
	send {blind}{MButton}
}
return
$~LButton up::
;send {tab}
send {blind}{shift up}{LButton up}{t up}
;send {blind}{RButton up}
bloodragetick_s:=A_TickCount
return

$~*RButton::

return

;F8::Spam2("F8","LButton",90)
;simplerun:
;if !GetKeyState("XButton1","P") or !GetKeyState("E","P")
;{
	;Send {blind}{LButton down}{LButton up}
;}
;else if GetKeyState("XButton1","P")
;{ 
	;send {blind}{LButton down}{XButton1 down}
	;while GetKeyState("XButton1","P")
	;{
		;send {blind}{XButton1}
		;sleep 300
		;click
	;}
	;send {blind}{LButton up}{XButton1 up}
;}
;return



SendSomething:
if (GetKeyState("XButton1", "P"))
{
	sleep 200
}
else if (GetKeyState("RButton", "P"))
{
	keywait RButton
	sleep 300
}
else if (GetKeyState("q", "P"))
	send q
else if (GetKeyState("w", "P"))
	send w
else if (GetKeyState("e", "P"))
{
	send e
	sleep 500
}
else if (GetKeyState("r", "P"))
	send r
else if (GetKeyState("t", "P"))
	send t
else if (!GetKeyState("ALT", "P") and !GetKeyState("LButton", "P") and !GetKeyState("XButton1", "P") and !GetKeyState("RButton", "P"))
	{ ;click
		Send {blind}{LButton down}{LButton up}
	}

	

if !WinActive("ahk_class POEWindowClass")
{
	toggle(0)
}
return

Toggle(onn)	{
	IF onn = 1
	{
		toggle := 1
		SetTimer, SendSomething, 120
		Hotkey, $~LButton, on
		Hotkey, $~LButton up, on
		;Hotkey, *~C, on
		SoundPlay, %A_WinDir%\Media\ding.wav
	}
	if onn = 0
	{
		toggle := 0
		SetTimer, SendSomething, Off
		Hotkey, $~LButton, off
		Hotkey, $~LButton up, off
		;Hotkey, *~C, off
		send {blind}{shift up}{LButton up}{RButton up}
		SoundBeep, 1000, 50
	}
	return
}

TPhome()	{
	BlockInput,Mouse
	MouseGetPos,mx,my
	sleep 3
	IF toggle 
		ToggleOnOff()
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
	MoveInv()	{
		IF !toggle
		{
			;850, 4   1682, 1142
			send {blind}{Control down}
			while GetKeyState("CapsLock","P")
			{
				MouseGetPos, mx, my
				if (1673 <= mx or mx <= 850) and (my <= 1142)
					send {blind}{LButton}
				Sleep, 80
			}
			send {blind}{Control up}
		}
		return
	}
	MapHold()	{
		IF !GetKeyState("RButton", "P")
		{
			Send {tab}
		}
		KeyWait, Tab
		IF !GetKeyState("RButton", "D")
			send {space}
		return
	}
	PauseSendSomething()	{
		IF toggle	
		{
			toggle(0)
			Sleep 300
			toggle(1)
		}
		return	
	}
	Crun()	{
		;send {blind}{XButton1}
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
		return
	}
	Remaining()	{
		send {enter}/remaining{enter}
		return	
	}
	Logout()	{
		Critical
	; IF (ForceLogoutOrExitOnQuit=1) {
		Run cports.exe /close * * * * PathOfExile_x64Steam.exe
		Run cports.exe /close * * * * PathOfExileSteam.exe
		Run cports.exe /close * * * * PathOfExile.exe
		Run cports.exe /close * * * * PathOfExile_x64.exe
	; Send {Enter} /exit {Enter}		
	; } else {
	; Send {Enter} /exit {Enter}		
	; }
		Sleep, 50
		toggle(0)
		return
	}
	ToggleOnOff()	{
		IF toggle
			toggle(0)
		else
			toggle(1)
		return
	}
	



/*
	
	~RButton & ~LButton::
	if toggle
	{
		if GetKeyState("LButton","P")
		{
			send {blind}{shift down}
			SetTimer,RM,off
			SetTimer,LM,on
			SetTimer,SendSomething,off
		}
		if GetKeyState("RButton","P") and !GetKeyState("LButton","P")
		{
			send {blind}{shift up}
			SetTimer,RM,on
			SetTimer,LM,off
			SetTimer,SendSomething,on
		}
	}
	return
~RButton & ~LButton::
	
	~LButton::
	if toggle
	{
		send {shift down}
	}
	return
	
~LButton up::
SetTimer,LM, Off
Return
	
	$~RButton::
	if toggle and !GetKeyState("LButton","P")
	{
		SetTimer,RM, 50
		IF !GetKeyState("TAB", "P") 
			send {blind}{tab}
	}
	return
	
	~RButton up::
	if toggle
	{
		SetTimer,RM, Off
		IF !GetKeyState("TAB", "P")
			send {blind}{space}
	}
if toggle send {blind}{RButton up}
	Return
	
	
LM()
{
	if toggle
	{
		send {shift down}
		SetTimer,LM,50
		SetTimer,SendSomething,off
	}
	return
}
	
	LM:
	if !GetKeyState("LButton","P")
	{
		send {shift up}
		SetTimer,LM, Off
		if toggle 
			SetTimer,SendSomething,on
	}
if GetKeyState("RButton","P")
{
	SetTimer,RM,on
}
	Return
	
	
	RM:
	if !GetKeyState("RButton","P")
	{
		SetTimer,RM, Off
		IF !GetKeyState("TAB", "P")
			send {blind}{space}
	}
if GetKeyState("LButton","P")
{
	SetTimer,RM,off
}
	Return
	
LRM:
if toggle
{
	
}
Return
	
BIGfunc(active)
{
	active := 1
	SetTimer, BIGfunc, 50
	
	
	active := 0
}

BIGfunc:
if GetKeyState("LButton")

Return
	
	
	
	$*~LButton::
	IF toggle
	{
		IF GetKeyState("RButton","P")
		{
			send {blind}{RButton up}
			Sleep, 10
		}
		send {blind}{Shift down}
		While GetKeyState("LButton","P") 
			sleep 50
		IF GetKeyState("RButton","P")
		{
			send {blind}{RButton down}
			Sleep, 10
		}
		send {blind}{Shift up}
		
		Hotkey, $*~LButton, Off
		Hotkey, $*~LButton up, on
		
	}
	return

$*~LButton up::
IF toggle
{
	IF GetKeyState("RButton","P")
	{
		send {blind}{RButton down}
Sleep, 10
	}
	send {blind}{Shift up}
	Hotkey, $*~LButton, on
	Hotkey, $*~LButton up, off
	
}
return
	
	$*~RButton::
	IF toggle
		RM()
	Return
	
$*~RButton up::
if toggle
send {blind}{RButton up}
Return

	IF toggle
		
	{
		IF !GetKeyState("TAB", "P") 
			send {blind}{tab}
		While GetKeyState("RButton","P") 
			sleep 50
		IF !GetKeyState("TAB", "P")
			send {blind}{space}
	}
	return

		Hotkey, $*~RButton, Off
		Hotkey, $*~RButton up, on
		}
		return
	
	
	$*~RButton up::
	IF toggle
	{
		IF !GetKeyState("TAB", "P")
			send {blind}{space}
		Hotkey, $*~RButton, on
		Hotkey, $*~RButton up, off
	}
	return
	
	
	$*~LButton::LM()
	
	LM()
	{
		Thread, %This%, 1
		IF toggle
		{	
			
			IF GetKeyState("RButton","P")
			{
				send {blind}{RButton up}
				Sleep, 10
			}
			send {Shift down}
			keywait, LButton
			while GetKeyState("LButton", "P")
			{
				IF GetKeyState("C", "P")
					Crun()
				sleep, 10
			}
			IF GetKeyState("RButton","P")
			{
				send {blind}{RButton down}
				Sleep, 10
			}
			send {Shift up}
		}
		Return
	}
	
	
	
	RM()
	{
		IF !GetKeyState("TAB", "P")
			send {blind}{tab}
		SetTimer, RMWait, 50
		return
	}
	
	RMWait:
	IF !GetKeyState("RButton", "P")
	{
		SetTimer, RMWait, off
		IF !GetKeyState("TAB", "P")
			send {blind}{space}
	}
	IF (GetKeyState("LButton", "P")) or (GetKeyState("LButton", "P") and GetKeyState("RButton", "P"))
		send {RButton up}
	Return 



SendSomething:

if GetKeyState("LButton", "P")
{
	send {blind}{shift down}
	sleep -1
	while GetKeyState("LButton", "P")
	{
		sleep -1
	}
	send {blind}{shift up}
}

if GetKeyState("RButton", "P")
{
	
	IF !GetKeyState("TAB", "P")
		send {blind}{tab}
	sleep -1
	while GetKeyState("RButton", "P")
	{
		sleep -1
		IF !GetKeyState("LButton", "P")
		{
			sleep -1
			sleep 50
			click
			sleep -1
		}
		else
		{
			send {blind}{shift down}
			sleep 5
			send {RButton up}
			while GetKeyState("LButton", "P")
			{
				sleep -1
			}
			send {blind}{shift up}
			sleep 5
			send {RButton down}
		}
	}
	send {blind}{RButton up}
	sleep -1
	IF !GetKeyState("TAB", "P")
		send {blind}{space}
}

IF (!GetKeyState("ALT", "P") and !GetKeyState("LButton", "P") and !GetKeyState("RButton", "P"))
{
	sleep -1
	click
	sleep -1
	sleep 75
}
IFWinNotActive, ahk_exe PathOfExile_x64.exe
{
	toggle(0)
}
return

 PotCheckTimer:
 IF GetKeyState("C", "P")
	 IF GetKeyState("LButton", "P") or GetKeyState("RButton", "P")
	 {
		 Crun()
		 Sleep 1000
	 }
 IF !toggle
 PotCheck(0)
 return

 PotCheck(onn)
 {
 IF %onn%
 SetTimer, PotCheckTimer, 50
 else
 SetTimer, PotCheckTimer, off
 return
 }


 $~a::
 $~+a::
 IF (toggle=1)
 {
 send s
 }
 return

		 IF (GetKeyState(":=LButton", "P"))
		 {
			 IF (!GetKeyState("q", "P") or !GetKeyState("XButton1", "P"))
			 {
				 send {Shift down}
				 while GetKeyState("LButton", "P")
				 {
					 sleep 20
				 }
				 send {Shift up}
			 }
		 }
 $~q::
 IF (!GetKeyState("RButton",p))
 {
 send {tab}
 keywait q
 send {space}
 }
 return
 $*XButton1::
 send {tab down}
 sleep 10
 send {tab up}
 SetTimer, SendQ, 50
 Hotkey, $*XButton1, off
 Hotkey, $*XButton1 up, On
 return
 $*XButton1 up::
 send {space}
 Settimer, SendQ, off
 Hotkey, $*XButton1, On
 Hotkey, $*XButton1 up, off
 return
 $*q::
 send {tab}
 SetTimer, SendQ, 110
 Hotkey, $*~q, off
 Hotkey, $*~q up, On
 return
 $*q up::
 send {space}
 Settimer, SendQ, off
 Hotkey, $*~q, On
 Hotkey, $*~q up, off
 return
 $~WheelDown::
 send, Q
 return
/*
	$*RButton::
	IF toggle {
		
		send {Shift down}
		send {RButton down}
		While GetKeyState("RButton", "P")
		{
			Click
			sleep 100
		}
		send {RButton up}
		send {Shift up}
	}
	else 
		MouseClick, right
	return
	
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
		IF GetKeyState("alt","p")
			break
		
	}
	return
	
	
	
	
	
	
	
	
	#IFWinActive ahk_exe Expeditions Viking.exe
	$*XButton1::
	F1Down := !F1Down
	IF F1Down
		send {F1 down}
	Else
		send {F1 up}
	Return
*/