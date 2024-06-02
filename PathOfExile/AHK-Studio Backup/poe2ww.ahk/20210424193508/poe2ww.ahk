#NoEnv
#SingleInstance force
;#KeyHistory
#InstallKeybdHook
#InstallMouseHook
#Warn
;#MaxThreadsPerHotkey 1
;#MaxThreads 255
#MaxThreadsBuffer Off
;#UseHook On
#MaxHotkeysPerInterval 20000
;#HotkeyInterval 1
;#HotkeyModIFierTimeout 1
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


global GTP:=0,toggle:=0,bloodragetick_s:=0,bloodragetick_c:=0,waittimer:=5,CRunTickS:=99999,CRunTickC:=0
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

;$*~`::
;IF toggle 
	;Logout()
;return
;!tab::enter

$*CapsLock::
if toggle
	SetTimer, crun, on
else
	MoveInv()
return


$F2::ChatCommand("remaining")
$F3::TPhome()
$F4::ChatCommand("hideout")
$F5::ChatCommand("oos")
$XButton2::ToggleOnOff()
$~1::
$~4::
if toggle
	toggle(0)
return
;$*c::Crun()
;$tab::MapHold()

$~*q::waittimer:=150
$~*w::waittimer:=150
$~*r::waittimer:=50
$~*t::waittimer:=50
$~*RButton::
Critical
waittimer:=300
critical off
return

$~*XButton1::
Critical
waittimer:=190
critical off
return
$~*e::
Critical
waittimer:=500
critical off
return


;sleep 200
;send {F7}
;return
;$~LButton::

;send {space}
;send {blind}{shift down}{LButton down} ;t down}
;send {blind}{RButton down}
;bloodragetick_c:= A_TickCount - bloodragetick_s
;if (bloodragetick_c>8000)
;{
	;send {blind}{MButton}
;}
;return
;$~LButton up::



;send {tab}
;send {blind}{shift up}{LButton up} ;t up}
;send {blind}{RButton up}
;bloodragetick_s:=A_TickCount
;return



smokemine:
send {F7} ;down}
;sleep 5
;send {F7 up}
;sleep 10
;send {F7 down}
;sleep 5
;send {F7 up}
SetTimer, smokemine, off
return

SendSomething:
Critical
sleep 20
sleep %waittimer%
waittimer:=1
Critical off

Send {blind}{LButton down}{LButton up}

if !WinActive("ahk_class POEWindowClass")
{
	toggle(0)
}

return
;Crun()
;{
	;SetTimer, crun, on
;}
crun:
send {blind}{s down}
Sleep, 1
send {blind}{s up}
Sleep, 5
send {blind}{d down}
Sleep, 1
send {blind}{d up}
Sleep, 5
send {blind}{f down}
Sleep, 1
send {blind}{f up}
Sleep, 5
send {blind}{g down}
Sleep, 1
send {blind}{g up}
CRunTickS:=A_TickCount
key1 := % RegExReplace(A_ThisHotkey, "\W", "")
keywait %key1%
SetTimer, Crun, off
return

Toggle(onn)	{
	IF onn = 1
	{
		toggle := 1
		SetTimer, SendSomething, 75
		;Hotkey, $~LButton, on
		;Hotkey, $~LButton up, on
		waittimer:=1
		send {blind}{t down}
		SoundPlay, %A_WinDir%\Media\ding.wav
	}
	if onn = 0
	{
		toggle := 0
		SetTimer, SendSomething, Off
		;Hotkey, $~LButton, off
		;Hotkey, $~LButton up, off
			send {blind}{shift up}{LButton up}{RButton up}{t up}
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
		MouseClick, Left, 831, 639 , 10,1
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
ChatCommand(eenter)	{
	SavedClip := ClipboardAll
	Clipboard := % eenter
	;msgbox % Clipboard
	;send {enter}/%eenter%{enter}
	send {enter}/{ctrl down}{v down}{v up}{ctrl up}{enter}
	sleep 50
	Clipboard :=SavedClip
	SavedClip :=""
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