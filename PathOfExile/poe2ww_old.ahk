#NoEnv
; #InstallKeybdHook
#SingleInstance force
; #Warn
#MaxThreadsPerHotkey 1
#MaxThreads 255
;#MaxThreadsBuffer On
;#UseHook On
;#MaxHotkeysPerInterval 20000
;#HotkeyInterval 1
;#HotkeyModIFierTimeout 1
#Persistent
Thread, interrupt, 0

Process, Priority,, High

SendMode Input

SetWorkingDir D:\GoogleDrive\Documents\!NeedToSave\myScripts\PathOfExile\Resources\

I_Icon = D:\Steam\steamapps\common\Path of Exile\Client.exe
IFExist, %I_Icon%
Menu, Tray, Icon, %I_Icon%

; IFWinExist, ahk_exe AutoHotkey.exe
; run, E:\Install\SystemFolders\Progs\nircmd\nircmdc.exe setappvolume AutoHotkey.exe 0.2,, hide


SendMode input
#IF, A_IsPaused
$F9::
suspend
Reload
return
#IF
$F9::
Reload
return
$F12::
ExitApp
$Pause::
Pause
Suspend
return



global toggle := 0

;==========launch PoE
$F4::
IFWinNotExist, ahk_exe PathOfExile_x64.exe
	Run, PathOfExile_x64.lnk
else IFWinNotActive
	WinActivate, ahk_exe PathOfExile_x64.exe
return

;	D:\Steam\steamapps\common\Path of Exile
#IFWinActive ahk_exe PathOfExile_x64.exe


$*~`::Logout()
$*~Q::PauseSendSomething()
$*~W::PauseSendSomething()
$*~E::PauseSendSomething()
$*~R::PauseSendSomething()
$*~T::PauseSendSomething()
$*CapsLock::MoveInv()
$F2::Remaining()
$F3::TPhome()
$*XButton2::ToggleOnOff()
$tab::MapHold()

WheelDown::Send {Right} ; ALT+WheelDown: Stash scroll 
WheelUp::Send {Left} ; ALT+WheelUp: Stash scroll

$~1::
$~4::
IF toggle
	toggle(0)
return


$*~C::
 ;Critical
IF toggle and GetKeyState("LButton", "P") or GetKeyState("RButton", "P")
{
		Crun()
}
return


$*~LButton::
IF toggle
	{
		;IF GetKeyState("RButton","P")
		;{
			;send {blind}{RButton up}
			;Sleep, 10
		;}
		send {blind}{Shift down}
		While GetKeyState("LButton","P") 
			sleep 50
		;IF GetKeyState("RButton","P")
		;{
			;send {blind}{RButton down}
			;Sleep, 10
		;}
		send {blind}{Shift up}
		
		;Hotkey, $*~LButton, Off
		;Hotkey, $*~LButton up, on
		
	}
return
;
;$*~LButton up::
;IF toggle
;{
	;IF GetKeyState("RButton","P")
	;{
		;send {blind}{RButton down}
;Sleep, 10
	;}
	;send {blind}{Shift up}
	;Hotkey, $*~LButton, on
	;Hotkey, $*~LButton up, off
	;
;}
;return

$*~RButton::
IF toggle
	RM()
Return

$*~RButton up::
if toggle
send {blind}{RButton up}
Return
/*
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
*/
	
	/*
		Hotkey, $*~RButton, Off
		Hotkey, $*~RButton up, on
		}
		return
	*/
 ;#[poe2ww]
	/*
		$*~RButton up::
		IF toggle
		{
			IF !GetKeyState("TAB", "P")
				send {blind}{space}
			Hotkey, $*~RButton, on
			Hotkey, $*~RButton up, off
		}
		return
		
	*/
	/*	$*~LButton::LM()
		
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
			;while GetKeyState("LButton", "P")
			;{
				;IF GetKeyState("C", "P")
					;Crun()
				;sleep, 10
			;}
				IF GetKeyState("RButton","P")
				{
					send {blind}{RButton down}
					Sleep, 10
				}
				send {Shift up}
			}
			Return
		}
		
	*/
	
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

TPhome()
{
		BlockInput,Mouse
		MouseGetPos,mx,my
		IF toggle 
			ToggleOnOff()
		send 1
		Sleep, 99
		MouseClick, Right, 2496, 1101,,0
		Sleep, 319
		MouseClick, Left, 831, 639 , 10,0
		MouseMove %mx%,%my%,0
		BlockInput,Off
		Return
	}
	
	
	MoveInv()
	{
		IF !toggle
		{
			send {Control down}
			while GetKeyState("CapsLock","P")
			{
				send {blind}{LButton}
				Sleep, 75
			}
			send {Control up}
		}
		return
	}
	
	
	MapHold()
	{
		IF !GetKeyState("RButton", "P")
		{
			SendInput {blind}{tab}
		}
		while GetKeyState("Tab", "p")
			Sleep 20
		IF !GetKeyState("RButton", "D")
			send {space}
		return
	}
	
	
	PauseSendSomething()	
	{
		IF toggle	
		{
			ToggleOnOff()
			Sleep 300
			ToggleOnOff()
		}
		return	
	}
	
	
	Crun()
	{
		send {XButton1}
		send {s down}
		Sleep, 10
		send {s up}
		Sleep, 10
		send {d down}
		Sleep, 10
		send {d up}
		Sleep, 10
		send {f down}
		Sleep, 10
		send {f up}
		Sleep, 10
		send {g down}
		Sleep, 10
		send {g up}
		sleep 1000
		return
	}
	
; SoundPlay *32
	Remaining()
	{
		send {enter}/remaining{enter}
		return	
	}
	
	
	
	
	Logout()
	{
		IF toggle
		{
			Critical
			BlockInput On
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
			BlockInput Off
			return
		}
	}
	
	
	ToggleOnOff()
	{
		IF toggle
			toggle(0)
		else
			toggle(1)
		return
	}
	
	Toggle(onn)
	{
		IF %onn%
		{
			toggle := !toggle
			SetTimer, SendSomething, 110
; PotCheck(1)
		}
		else
		{
			toggle := !toggle
			SetTimer, SendSomething, Off
; PotCheck(0)
		}
		return
}



SendSomething:
IF (!GetKeyState("ALT", "P") and !GetKeyState("LButton", "P"))
	Click
IFWinNotActive ahk_class POEWindowClass
{
	toggle(0)
; PotCheck(0)
}
return
; PotCheckTimer:
; IF GetKeyState("C", "P")
	; IF GetKeyState("LButton", "P") or GetKeyState("RButton", "P")
	; {
		; Crun()
		; Sleep 1000
	; }
; IF !toggle
; PotCheck(0)
; return

; PotCheck(onn)
; {
; IF %onn%
; SetTimer, PotCheckTimer, 50
; else
; SetTimer, PotCheckTimer, off
; return
; }


; $~a::
; $~+a::
; IF (toggle=1)
; {
; send s
; }
; return

		; IF (GetKeyState(":=LButton", "P"))
		; {
			; IF (!GetKeyState("q", "P") or !GetKeyState("XButton1", "P"))
			; {
				; send {Shift down}
				; while GetKeyState("LButton", "P")
				; {
					; sleep 20
				; }
				; send {Shift up}
			; }
		; }
; $~q::
; IF (!GetKeyState("RButton",p))
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