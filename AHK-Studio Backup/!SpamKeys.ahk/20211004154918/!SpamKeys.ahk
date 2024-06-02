;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PRELOAD %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%;{
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.  ;*[!TOP]
global tog:=0,toggle:=0
global time_since_last:=0,time_key_s:=0,time_key_c:=0
global ttog:=0
global gk1:=0,gk2:=0,gk3:=0,gk4:=0,gk5:=0,gk6:=0,gk7:=0,gk8:=0,gto:=5,gATitle:="",gik1:=0,gik2:=0,gik3:=0,gik4:=0,gik5:=0,gik6:=0,gik7:=0,gik8:=0,gholdkey1:=5,gholdkey2:=5
global TSOkey1:="",TSOholdto:=5,TSOto:=5,QLB:=0,QRB:=0,QXB1:=0,Qq:=0,Qw:=0,Qe:=0,Qa:=0,Qs:=0,Qd:=0,QEsc:=0
DetectHiddenWindows, ON
WinGet, ScriptPID, PID, ahk_id %A_ScriptHwnd%
;SoundPlay, %A_WinDir%\Media\ding.wav
SoundBeep, 1000, 50
Run, *RunAs E:\Install\SystemFolders\Progs\Tools\nircmd\nircmdc.exe setappvolume /%ScriptPID% 0.02,, hide
SetBatchLines, -1
SetKeyDelay, -1, -1
SetWinDelay, -1 
SetControlDelay, -1
;Critical , On
CoordMode, Mouse, Screen
Thread, interrupt, 0
SendMode, Input
Process, Priority,, High
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
EngCheck() ; check layout current window

send {shift up}{alt up}{ctrl up}
#Persistent
#SingleInstance force
#Warn
#MaxThreadsPerHotkey 255
#MaxThreads 255
;#MaxThreadsBuffer On
#UseHook On
#MaxHotkeysPerInterval 900000
#HotkeyInterval 1
#HotkeyModIFierTimeout 1
;#Include D:\GoogleDrive\Documents\!NeedToSave\myScripts\_Preload.ahk
#InstallKeybdHook
;#MenuMaskKey vk07
;}###########################################################################################################
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Control %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%;{
#IF, A_IsPaused
$^+F11::
suspend
Reload
return
#IF
$^+F11::
Reload
return
$^+F12::
ExitApp
$Pause::
Pause
Suspend
return
^+F10::KeyHistory
;DetectHiddenWindows, Off
;}###########################################################################################################
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FUNCS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%;{
Spam(key1:="",key2:="",key3:="",to1:=5,to4:=5,to2:=40,to3:=40,holdkey1:=5) {
	WinGet, sATitle, ProcessName, A
	if (key1="")
		key1 := % RegExReplace(A_ThisHotkey, "\W", "")
	while ((GetKeyState(key1, "P")) and (WinActive("ahk_exe "sATitle)))
		if (!GetKeyState("ALT", "P"))
		{
			sleep to1
			send {blind}{%key1% down}
			sleep holdkey1
			send {blind}{%key1% up}
			if (key2!="")
			{
				sleep to2
				send {blind}{%key2% down}
				sleep 5
				send {blind}{%key2% up}
				if key3!=""
				{
					sleep to3
					send {blind}{%key3% down}
					sleep 5
					send {blind}{%key3% up}
				}
			}
			sleep to4
		}
	send {blind}{alt up}{shift up}{ctrl up}
	return
}
Spam2(ifkey1,skey1,to1:=5,ifkey2:="",skey2:="",ifkey3:="",skey3:="",ifkey4:="",skey4:="",holdkey1:=5) {
	WinGet, sATitle, ProcessName, A
	while ((GetKeyState(ifkey1, "P")) and (WinActive("ahk_exe "sATitle)))
	{
		if (GetKeyState(ifkey1, "P"))	
		{
			send {blind}{%skey1% down}
			sleep holdkey1
			send {blind}{%skey1% up}
			
		}
		if ((ifkey2!="") and (skey2!=""))
			if (GetKeyState(ifkey2, "P"))
			{
				sleep to1
				send {blind}{%skey2% down}
				sleep 5
				send {blind}{%skey2% up}
			}
		if ((ifkey3!="") and (skey3!=""))
			if (GetKeyState(ifkey3, "P"))
			{
				sleep to1
				send {blind}{%skey3% down}
				sleep 5
				send {blind}{%skey3% up}
			}
		if ((ifkey4!="") and (skey4!=""))
			if (GetKeyState(ifkey4, "P"))
			{
				sleep to1
				send {blind}{%skey4% down}
				sleep 5
				send {blind}{%skey4% up}
			}
	}
	send {blind}{alt up}{shift up}{ctrl up}
	return
}
TogTimerF(kk1:="",kk2:="",kk3:="",kk4:="",kk5:="",to:=5,ik1:="",ik2:="",ik3:="",ik4:="",ik5:="",holdkey1:=5,holdkey2:=5) { ;{
		if (kk1="")
			kk1 := % RegExReplace(A_ThisHotkey, "\W", "")
		gk1=%kk1%
		gk2=%kk2%
		gk3=%kk3%
		gk4=%kk4%
		gk5=%kk5%
		gholdkey1=%holdkey1%
		gholdkey2=%holdkey2%
		gto=%to%
		loop 5
			if (ik%A_Index% !="")
				gik%A_Index%:=ik%A_Index%
		else
			gik%A_Index%:=kk%A_Index%
		WinGet, gATitle, ProcessName, A
		if tog ;and (n=0 or n=3)
		{
			SetTimer, TogSpamTimer, off
			tog:=!tog
			TogSpamTimerRun:=0
			SoundPlay, %A_WinDir%\Media\Speech Sleep.wav
			send {blind}{alt up}{shift up}{ctrl up}
		}
		else if !tog
		{
			Settimer, TogSpamTimer, 5
			tog:=!tog
			TogSpamTimerRun:=1
			SoundPlay, %A_WinDir%\Media\Speech On.wav
		}
	}
	TogSpamTimer:
	if (WinActive("ahk_exe "gATitle)) {
		;msgbox "%gk1% %gik1%"
		if (((gik1!="") and (gik1!=0)) and (GetKeyState(gik1, "P")))
		{
			send {%gk1% down}
			sleep gholdkey1
			send {%gk1% up}
		}
		if (gik1="") or (gik1=0)
		{ 
			send {%gk1% down}
			sleep gholdkey1
			send {%gk1% up}
		}
		;if (gik1!="") or (gik1!=0)
		;{ 
			;send {%gk1% down}
			;sleep gholdkey1
			;send {%gk1% up}
		;}
		if ((gik2!=0) and (gik2!="") and (GetKeyState(gik2, "P"))) {
			send {blind}{%gk2% down}
			sleep gholdkey2
			send {blind}{%gk2% up}
		}
		else if (gik2=0)
		{
			send {blind}{%gk2% down}
			sleep gholdkey2
			send {blind}{%gk2% up}
		}
		if ((gik3!=0) and (gik3!="") and (GetKeyState(gik3, "P"))) {
			send {blind}{%gk3% down}
			sleep 5
			send {blind}{%gk3% up}
		}
		else if (gik3=0)
		{
			send {blind}{%gk3% down}
			sleep 5
			send {blind}{%gk3% up}
		}
		if ((gik4!="") and (GetKeyState(gik4, "P"))) {
			send {blind}{%gk4% down}
			sleep 5
			send {blind}{%gk4% up}
		}
		if ((gik5!="") and GetKeyState(gik5, "P")) {
			send {blind}{%gk5% down}
			sleep 5
			send {blind}{%gk5% up}
		}	
		sleep %gto%
	;send {blind}{shift up} 
	}
return ;}
SpamTimerF(kk1:="",kk2:="",kk3:="",kk4:="",kk5:="",to:=5) { ;{
		kk1 := % RegExReplace(A_ThisHotkey, "\W", "")
		gk1=%kk1%
		gk2=%kk2%
		gk3=%kk3%
		gk4=%kk4%
		gk5=%kk5%
		gto=%to%
		WinGet, gATitle, ProcessName, A
		Settimer, SpamTimer, 5
		while (GetKeyState(kk1, "P"))
			sleep 5
		send {blind}{alt up}{shift up}{ctrl up}
		Settimer, SpamTimer, off
	}
	SpamTimer: 
	if (WinActive("ahk_exe "gATitle)) {
		if (GetKeyState(gk1, "P")) {
			send {blind}{%gk1% down}
			sleep 5
			send {blind}{%gk1% up}
		}
		if (GetKeyState(gk2, "P")) {
			send {blind}{%gk2% down}
			sleep 5
			send {blind}{%gk2% up}
		}
		if (GetKeyState(gk3, "P")) {
			send {blind}{%gk3% down}
			sleep 5
			send {blind}{%gk3% up}
		}
		if (GetKeyState(gk4, "P")) {
			send {blind}{%gk4% down}
			sleep 5
			send {blind}{%gk4% up}
		}
		if (GetKeyState(gk5, "P")) {
			send {blind}{%gk5% down}
			sleep 5
			send {blind}{%gk5% up}
		}
		sleep %gto%
	}
return ;}
togfunc(n,timerr,delay1:=50,doubletimer:="",delay2:=50) {
	if tog and (n=0 or n=3)
	{
		SetTimer, %timerr%, off
		if (doubletimer!="")
			SetTimer, %doubletimer%, off
		tog:=!tog
		SoundPlay, %A_WinDir%\Media\Speech Sleep.wav
		send {blind}{alt up}{shift up}{ctrl up}
	}
	else if !tog and (n=1 or n=3)
	{
		SetTimer, %timerr%, %delay1%
		if (doubletimer!="")
			SetTimer, %doubletimer%, %delay2%
		tog:=!tog
		SoundPlay, %A_WinDir%\Media\Speech On.wav
	}
	return
}
EngCheck() {
	English := 0x4090409
	Russian := 0x4190419
	if(Russian = Format("0x{:x}", DllCall("GetKeyboardLayout", "Int", DllCall("GetWindowThreadProcessId", "Int", WinActive("A"), "Int", 0))))
		SendMessage, 0x50, 0, %English%,, A
} 
TimerSendOnce(key1,to:=5) ;{
	{
		TSOkey1=%key1%
		TSOto=%to%
		SetTimer, TimerSendOnce, on
	}
	TimerSendOnce: 
	send {blind}{%TSOkey1% down}
	sleep TSOto
	send {blind}{%TSOkey1% up}
	SetTimer, TimerSendOnce, off
return ;}
ChatCommand(enterr)	{
	SavedClip1 := ClipboardAll
	Clipboard := % enterr
	;msgbox % Clipboard
	;send {enter}/%enterr%{enter}
	send {enter}
	sleep 1
	send /{ctrl down}{v down}{v up}{ctrl up}{enter}
	sleep 50
	Clipboard :=SavedClip1
	SavedClip1 :=""
	return
}
;}%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% GeneralHK %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%;{
NumLock::
Ctmp := Clipboard
WinGet, currwin, ProcessName, A
WinGetTitle, wintitl, A
;WinGet, procpath, ProcessPath, A
Clipboard := "#IfWinActive ahk_exe "currwin "`t`t`t`t" ";{ ["wintitl "] " "`n`n #IF " ";}"
KeyWait Ctrl, D
KeyWait v, D
Clipboard := Ctmp
return 
/* Block Keys
	Numpad0::return
	Numpad1::return
	Numpad2::return
	Numpad3::return
	Numpad4::return
	Numpad5::return
	Numpad6::return
	Numpad7::return
	Numpad8::return
	Numpad9::return
	NumpadAdd::return
	NumpadClear::return
	NumpadDel::return
	NumpadDiv::return
	NumpadDot::return
	NumpadDown::return
	NumpadEnd::return
	NumpadEnter::return
	NumpadHome::return
	NumpadIns::return
	NumpadLeft::return
	NumpadMult::return
	NumpadPgDn::return
	NumpadPgUp::return
	NumpadRight::return
	NumpadSub::return
	NumpadUp::return
	Left::return
	Right::return
	Up::return
	Down::return
	;RShift::return
	;RCtrl::return
	;RAlt::return
*/
;}
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% GAMES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;# - win ! - alt ^ - ctrl + shift <>- left right buttons
;$j::SetTimer, jSpam, % (x:=!x) ? "10" : "Off"
;RButton::SendInput,% "{RButton "((toggle:=!toggle)?"Down":"Up")"}"
#IfWinActive ahk_exe D2R.exe		;{ [Diablo II: Resurrected] 
	$*XButton1::TogTimerF("LButton","4",,,,10,0,0)
	Numpad1::ChatCommand("players 1")
	Numpad2::ChatCommand("players 4")
	Numpad3::ChatCommand("players 8")
	$~*z::w
#IF ;}
#IfWinActive ahk_exe Tales of Arise.exe		;*[Tales of Arise  ] ;{
	$~*w::z
	$*XButton2::TogTimerF("LButton","RButton",,"2",,15,"LButton","RButton",,"LButton")
#IF ;}
#IfWinActive ahk_exe Avorion.exe		;*[Avorion] ;{
	;*XButton2::TogTimerF("LButton")
	SC029::send {Numpad1}{Numpad0}
	XButton1::i
	XButton2::p
	F8::n
	F1::m
	F6::m
#IF ;}
#IfWinActive ahk_exe Car Mechanic Simulator 2021.exe		;*[Car Mechanic Simulator 2021] ;{
	~*w::shift
	;$*~LButton::Spam2("LButton","RButton")
	$*XButton2::Spam2("XButton2","LButton")
	*XButton1::Enter
#IF ;}
#IfWinActive ahk_exe TheAscent-Win64-Shipping.exe		;*[TheAscent  ] ;{
	XButton1::Spam2("XButton1","LButton")
	XButton2::Spam2("XButton2","Space",,"XButton2","x")
	XButton1 up::send r
	;Space::Spam()
#IF ;}
#IfWinActive ahk_exe Boston-Win64-Shipping.exe		;*[Police Simulator: Patrol Officers  ] ;{
	XButton1::f
#IF ;}
#IfWinActive ahk_class PuTTY		;*[PuTTY && Teamviewer] ;{
	F1::
	SavedClip := ClipboardAll
	Clipboard := "cd ~/Documents/Swar/ && python manager.py view"
	send {RButton}{enter}
	sleep 10
	Clipboard := SavedClip
	SavedClip := ""
	return
	F8::send Myworld)00{enter}
	#IF
	#IfWinActive ahk_exe TeamViewer.exe
	F8::send Myworld)00{enter}
	#IF
	#IfWinActive ahk_exe ubuntu2004.exe
	F8::send Myworld)00{enter}
#IF ;}
#IfWinActive ahk_exe FuryUnleashed.exe		;*[Fury Unleashed] ;{
	XButton1::MButton
	;$~*LButton::MButton
	$~*LButton up::TimerSendOnce("r",10)
	$~*Space::
	KeyWait, Space, T0.2
	if (ErrorLevel)
		TimerSendOnce("Space",300)
	return
	XButton2::TogTimerF(,,"MButton",,,,,,"LButton")
#IF ;}
#IfWinActive ahk_exe Chronicon.exe		;*[Chronicon] ;{
	F8::TogTimerF("q","x","c",,,300,,0,0)
	XButton1::1
	XButton2::2
#IF ;}
#IfWinActive ahk_exe The Slormancer.exe		;*[The Slormancer] ;{
	;$*~^RButton::Spam()
	XButton1::Spam2("XButton1","e")
	$*~w::1
#IF ;}
#IfWinActive ahk_exe OUTRIDERS-Win64-Shipping.exe		;*[Outriders] ;{
	$~*w::F7
	$~*s::F7
	;$~*RButton::Spam2("RButton","LButton",11)
	$~*XButton1::v
	$~*Space::
	if GetKeyState("w","P") or GetKeyState("s","P") or GetKeyState("a","P") or GetKeyState("d","P")
		Spam()
	return
#IF ;}
#IfWinActive ahk_exe SC2_x64.exe		;*[StarCraft 2] ;{
	$*~q::send {F9}
	$*~w::send {F9}
	$*~a::send {F9}
#IF ;}
#IfWinActive ahk_exe ACValhalla.exe		;*[Assassin's Creed Valhalla] ;{
	$XButton2::TogTimerF("f","e",,,,15,"w","XButton1")
	$*XButton1::
	if (!tog)
		Spam2("XButton1","e")
	return
#IF ;}
#IfWinActive ahk_exe DOOMEternalx64vk.exe		;*[DOOM Eternal] ;{
	F8::SetTimer, doomE, % (x:=!x) ? "10" : "Off"
	doomE:
	while GetKeyState("LButton")
	{
		sleep 5
		if !GetKeyState("LButton")	
		{
			send {XButton1}
			sleep 50
			send {XButton1}
		}
	}
	return 
#IF ;}
#IfWinActive ahk_exe GameClient.exe		;*[Magic Legends] ;{
	$*f::Spam()
	*MButton::Send {w down}{RButton down}
	PgUp::
	enterarray := ["/showfps 1","/netgraph 1","/shadows 0", "/vsync 0", "/maxfps 90","/dynamiclights 0","/frameRateStabilizer","/fxQuality 0","/gfxSettingsSetMinimalOptions 1","/highQualityDOF 0","/lensflare_quality 0","/process_priority 2"]
	SavedClip := ClipboardAll
	send {enter down}
	sleep 50
	send {enter up}
	sleep 50
	loop % enterarray.Length()
	{	
		Clipboard := % enterarray[A_Index]
		send {ctrl down}
		sleep 50
		send {v down}
		sleep 50
		send {v up}
		sleep 50
		send {ctrl up}
		sleep 50
		send {enter down}
		sleep 50
		send {enter up}
		sleep 50
	}
	send {enter down}
	sleep 50
	send {enter up}
	Clipboard := SavedClip
	SavedClip := ""
	return
	
#IF ;}
#IfWinActive ahk_exe Indiana-Win64-Shipping.exe ;{
	$*F8::Spam2("F8","E")
;$*Space::Spam()
#IF ;}
#IfWinActive ahk_exe LoR.exe  ;{
	XButton1::Spam2("XButton1","LButton")
#IF ;}
#IfWinActive ahk_exe Breathedge-Win64-Shipping.exe ;{
	XButton1::Spam2("XButton1","LButton")
#IF ;}
#IfWinActive ahk_exe ImmortalsFenyxRising.exe ;{
	$*XButton1::Spam2("XButton1","e")
	$*XButton2::Spam2("XButton2","Alt")
	$*q::Spam()
#If ;}
#IfWinActive ahk_exe GTA5.exe ;*[Grand Theft Auto V] RP ;{
	1::B
	2::j
	3::l
	F8::TAB
	MButton::Up
	F12::
	Process,Close, GTA5.exe
	sleep 3000
	WinWait, ahk_exe GTA5.exe
	Reload
	return
	F9::SetTimer, antiafk, % (x:=!x) ? "120000" : "Off"
	F10::SetTimer, antiafk2, % (x1:=!x1) ? "10000" : "Off"
	antiafk:
	send a{space}
	sleep 5000
	click
	sleep 5000
	click
	sleep 5000
	click
	sleep 5000
	click
	sleep 5000
	click
	return
	antiafk2:
	ControlClick,x0 y0,ahk_exe GTA5.exe
	return
;NumpadDiv::send {w up}{shift up}{w down}{shift down}
;Runwait, taskkill /im GTA5.exe /f
;$*F::Spam("f")
;$*y::Spam("y")
;$*e::Spam("e")
	$*~F4::
	send t/dl{enter}
	return
;::
;SavedClip := ClipboardAll
;Clipboard := "/accept "
;sleep 1
;send t^v
;Clipboard := SavedClip
;SavedClip := ""
;return
#If ;}
#IfWinActive ahk_exe valheim.exe  ;*[Valheim] ;{
	$*XButton1::Spam2("XButton1","E",30)
	$*XButton2::Spam2("XButton2","LButton",30)
	#If
	#IfWinActive ahk_exe Cyberpunk2077.exe
	$*XButton2::Spam("XButton2")
	$*XButton1::Spam("XButton1")
;$*XButton1::Spam("XButton1")
;XButton1 & RButton::
	F7::
	F6::
	send {blind}{XButton1 down}
	sleep 500
	send {blind}{XButton1 up}
	sleep 5
	return
	
;p := KeyTimeOut()
;If (p = "00")
;{
	;send {XButton1 down}
	;sleep 500
	;send {XButton1 up}
	;sleep 5
;}
;else
	;Spam("XButton1")
;return
	
;Spam("XButton1")
;KeyWait, XButton1, T0.2
;if !(ErrorLevel)
	;Spam("XButton1")
;else 
;{
	;send {XButton1 down}
	;sleep 500
	;send {XButton1 up}
	;sleep 5
	;}
	
	
	
;KeyTimeOut(timeout = 200) { ;
	;tout := timeout/1000
	;key := RegExReplace(A_ThisHotKey,"[\*\~\$\#\+\!\^]")
	;Loop {
		;t := A_TickCount
		;KeyWait %key%
		;Pattern .= A_TickCount-t > timeout
		;KeyWait %key%,DT%tout%
		;If (ErrorLevel)
			;Return Pattern } }
#If ;}
#IfWinActive ahk_exe LoR.exe  ;*[Legends of Runeterra] ;{
	$*XButton1::LButton
#If ;}
#IfWinActive ahk_exe chrome.exe ;Number sender to phone, LFJ WORK ;{
	;F2::
	
	;return
	F1::
	Ctmp := Clipboard
	send {ctrl down}c{ctrl up}
	sleep 50
	Clipb := RegExReplace(Clipboard, "\s", "")
	Clipb := RegExReplace(Clipb, "\-", "")
	send {ctrl down}l{ctrl up}
	sleep 50
	send {ctrl down}c{ctrl up}{tab}
	sleep 50
	FormatTime, time, A_now, d.MM.yy HH:mm
	/*
		FileDelete, tmpbatch.cmd ;adb kill-server adb tcpip 5555 adb connect
		FileAppend, 
	(
	C:\platform-tools\adb.exe connect 192.168.1.115:5555
	C:\platform-tools\adb.exe shell input tap 542 2232
	C:\platform-tools\adb.exe shell input tap 973 1003
	C:\platform-tools\adb.exe shell input tap 317 1003
	C:\platform-tools\adb.exe shell input text "+48%Clipb%"
	C:\platform-tools\adb.exe shell input tap 970 171
	), tmpbatch.cmd
	*/
	SetWorkingDir, C:\platform-tools
	if WinExist("ahk_exe adb.exe")
		runwait, adb.exe connect 192.168.1.115:5555,,hide
	runwait, adb shell input tap 542 2232,,hide
	runwait, adb shell input tap 973 1003,,hide
	runwait, adb shell input tap 317 1003,,hide
	runwait, adb shell input text "+48%Clipb%",,hide
	runwait, adb shell input tap 970 171,,hide
	
	FileAppend, 
(
%time% - %Clipb% - %Clipboard%

), D:\GoogleDrive\Documents\!NeedToSave\IRL\Work\TruckDriver\PhoneNum.txt
	
	RunWait %comspec% /c tmpbatch.cmd
	FileDelete, tmpbatch.cmd
	Clipboard := Ctmp
	
	return 
;C:\platform-tools\adb.exe connect 192.168.1.115:5555
	
;Run, %comspec% C:\platform-tools\adb.exe connect 192.168.1.115
;Run, %comspec% /k C:\platform-tools\adb.exe shell input text '"%clipboard%'"
;StringReplace, Clipboard, Clipboard, `r`n, , All
;Clipb := StrReplace(Clipboard, A_Space,)
;StringReplace, Clipb, Clipboard, %A_Space%, `%s, All 
;C:\platform-tools\adb.exe shell input text "+48%Clipb%"
;C:\platform-tools\adb.exe shell am start -a android.intent.action.INSERT -t vnd.android.cursor.dir/contact -e name '!QQ' -e phone +48%clipboard%
;$ adb shell am start -a android.intent.action.EDIT content://com.android.contacts/contacts/1
;adb shell content query --uri content://com.android.contacts/contacts
;C:\platform-tools\adb.exe shell content query --uri content://com.android.contacts/contacts
#IF ;}
#IfWinActive ahk_exe cmd.exe		;*[Выбрать Администратор: Командная строка] ;{
	::cd adb::
	SavedClip := ClipboardAll
	Clipboard := "cd C:\platform-tools\"
	send {Backspace}{Backspace}{Backspace}^v{enter}
	sleep 10
	Clipboard := SavedClip
	return
#IF ;}
#IfWinActive ahk_exe MassEffectAndromeda.exe ;{
	*SC029::
	$*r::spam("r")
	$*XButton1::Spam("XButton1")
	
	#If
	#IfWinActive ahk_exe Aperion-Win64-Shipping.exe
	$*XButton2::TogTimerF("F","Q","Space","RButton","LButton",20)
	$Shift::K
	$1::Q
	$2::Space
	
#IF ;}
#IfWinActive ahk_exe Frontiers-Win64-Shipping.exe ;{
	XButton1::6
	XButton2::7
;$*~w::trochfunc()
;$*~a::trochfunc()
;$*~s::trochfunc()
;$*~d::trochfunc()
	
	trochfunc() {
		while (GetKeyState("W","P") or GetKeyState("A","P") or GetKeyState("S","P") or GetKeyState("D","P"))
		{
			if GetKeyState("LButton","P")
			{
				send {blind}{LButton}
				sleep 5
			}
		;if GetKeyState("RButton","P")
		;{
			;send {blind}{RButton}
			;sleep 5
		;}
			if GetKeyState("XButton1","P")
			{
				send {blind}6
				sleep 5
			}
			if GetKeyState("XButton2","P")
			{
				send {blind}7
				sleep 5
			}
		}
	}
	
	
#IF ;}
#IfWinActive ahk_exe GenshinImpact.exe ;{
	$*XButton1::Spam2("XButton1","f",50,"XButton1","WheelDown")
	$*Space::SpamTimerF("Space",,,,,50)
	
#IF ;}
#IfWinActive ahk_exe Hades.exe ;{
	
;$*XButton1::Spam2("XButton1","XButton1",5,"LButton","LButton")
;$*XButton1::Spam2("XButton1","XButton1",5,"RButton","RButton","LButton","LButton")
	
	$XButton1::TogTimerF("XButton1","E","LButton","RButton")
	
	$*Space::XButton1
	
#IF ;}
#IfWinActive ahk_class AppWindowClass ;{
	*XButton2::Spam("XButton2")
	
	
#IF ;}
#IfWinActive ahk_exe Game.exe ;{
	XButton1::Spam2("XButton1","LButton")
#IF ;}
#IfWinActive ahk_exe WL3.exe ;{
	XButton1::Numpad7
	XButton2::Spam2("XButton2","LButton")
	
#IF ;}
#IfWinActive ahk_exe HorizonZeroDawn.exe ;{
	$*~XButton1::Spam2("XButton1","E")
	
#IF ;}
#IfWinActive ahk_exe DH-Win64-Shipping.exe ;{
;$*~XButton1::Spam2("XButton1","XButton1",3,"Shift","Shift")
	$*~XButton2::Spam("XButton2")
	$*~XButton1::Spam("XButton1")
	
#IF ;}
#IfWinActive ahk_exe P4G.exe ;{
	XButton1::Spam2("XButton1","LButton",3,3)
	
#IF ;}
#IfWinActive ahk_exe Gunfire Reborn.exe ;{
	$*Space::Spam2("Space","Space",10,"XButton1","XButton1")
	$*XButton1::Spam2("XButton1","XButton1",10,"Space","Space")
;$~*LButton::Spam("LButton")
	$CapsLock::return
	
	
	
#IF ;}
#IfWinActive ahk_exe re2.exe ;{
	click(x) {
		Loop, parse, x
		{
			if WinActive("ahk_exe re2.exe")
			{
				if (A_LoopField="d")
				{
					send {d down}
					sleep 10
					send {d up}
					sleep 15
				}
				else if (A_LoopField="a")
				{
					send {a down}
					sleep 10
					send {a up}
					sleep 15
				}
				else if (A_LoopField="s")
				{
					send {s down}
					sleep 10
					send {s up}
					sleep 350
				}
				else if (A_LoopField="c")
				{
					Click
					sleep 350
				}
				else if (A_LoopField="l")
				{
					Click
					sleep 350
					loop 5
					{
						send {s down}
						sleep 10
						send {s up}
						sleep 350
						Click
						sleep 350
					}
				}
			}
			else
				break
		}
		return
	}
	
	F2::
	click("d,d,s,l")    ;BAO
	loop 5
	{
		loop 5
			click("a,s,d,s,l")
		click("d,s,a,c,s,l")
	}
	return
	
#IF ;}
#IfWinActive ahk_exe LeagueClientUx.exe  ;*[League of Legends LoL]  ;{
	XButton1::Spam2("XButton1","LButton",3,3)
	#IFWinActive ahk_exe League of Legends.exe
	~*SC029::togfunc(0,"tt21")
;F8::togfunc(3,"tt21")
	~*enter::togfunc(0,"tt21")
	~*NumpadEnter::togfunc(0,"tt21")
	~b::togfunc(0,"tt21")
	tt21:
	if ((GetKeyState("Q", "P")) and ((!GetKeyState("CTRL", "P"))))
	{
		send q
		sleep 5
	}
	if (((GetKeyState("W", "P")) or (GetKeyState("T", "P"))) and ((!GetKeyState("CTRL", "P"))))
	{
		send w
		sleep 5
	}
	else 
	{ ;send qw
	;send l
	}
	if ((GetKeyState("E", "P")) and ((!GetKeyState("CTRL", "P"))))
	{
		send e
		sleep 5
	}
	if ((GetKeyState("R", "P")) and ((!GetKeyState("CTRL", "P"))))
	{
		send r
		sleep 5
	}
	if (GetKeyState("XButton1", "P"))
	{
		send {blind}{XButton1}
		sleep 5
	}
	if ((GetKeyState("RButton", "P")) and (!GetKeyState("T", "P")))
	{
		send {blind}{RButton}
		sleep 5
	}
	sleep 10
	if !WinActive("ahk_exe League of Legends.exe")
		togfunc(0,"tt21")
	return
	
	
	
	
#IF ;}
#IfWinActive ahk_exe MetroExodus.exe ;{
	*~$XButton2::Spam2("XButton2","XButton1")
	
#IF ;}
#IfWinActive ahk_exe Gears5.exe ;{
;$*~Space::Spam("Space")
	$*~Ctrl::Spam2("Ctrl","Space")
	
#IF ;}
#IfWinActive ahk_exe Dungeons.exe ;{
	$*XButton2::togfunc(3,"dunge",50)
	~$*LButton::
	if tog
		send {blind}{shift down}
	return
	~$*LButton up::
	if tog
		send {blind}{shift up}
	return
	dunge:
	while GetKeyState("RButton","P")
	{
	;send {blind}{g down}
	;sleep 400
	;send {blind}{g up}
	;sleep 400
		sleep 10
	}
	if GetKeyState("XButton1","P") or GetKeyState("Space","P")
	{
		send {blind}{space}
		sleep 100
		send 1
	}
	
	click
;send 123
	if !WinActive("ahk_exe Dungeons.exe")
		togfunc(0,"dunge",50)
	return
	
#IF ;}
#IfWinActive ahk_exe MiniHealer.exe ;{
	F8::Spam2("F8","LButton",5)
	$*q::Spam()
	$*z::Spam()
	$*x::Spam()
	$*a::Spam()
	CapsLock::return
#IF ;}
#IfWinActive ahk_exe ChildrenOfMorta.exe ;{
;$*c::
;send c
;keywait, c
;send c
#IF ;}
#IfWinActive ahk_exe BloodstainedRotN-Win64-Shipping.exe ;{
	~*WheelDown::
	send {h down}
	sleep 1
	send {h up}
	return
#IF ;}
#IfWinActive ahk_exe war3.exe ;{
	space::F1
	F1::`
	
#IF ;}
#IfWinActive ahk_exe EtG.exe ;*[Enter the Gungeon] ;{ 
	$~*LButton::Spam("LButton")
	~$*LButton up::send r
#IF ;}
#IfWinActive ahk_exe deadcells.exe ;{
	~$*WheelDown::
	send {p down}
	sleep 3
	send {p up}
	return
	~$*WheelUp::
	send {p down}
	sleep 3
	send {p up}
	return
	~*$LButton::Spam("LButton",,,5,5)
	~*$RButton::Spam("RButton",,,5,5)
	
#IF ;}
#IfWinActive ahk_class Diablo II ;{
	XButton1::Numpad1
	XButton2::Numpad2
	~*$LButton::Spam("LButton",,,5,5)
;#IfWinActive, ahk_exe left4dead2.exe
#IF ;}
#IfWinActive ahk_exe left4dead.exe ;{
	#IfWinActive ahk_exe left4dead2.exe
	$*RButton::Spam2("RButton","LButton",3,3)
	$*XButton1::RButton
#IF ;}
#IfWinActive ahk_exe DrugDealerSimulator-Win64-Shipping.exe ;{
	*$c::
	send m
	sleep 50
	keywait, c
	sleep 5
	send m
	return
	*m::return
	CapsLock::return
	*$XButton1::Spam2("XButton1","F",50,5)
	*$XButton2::
	while GetKeyState("XButton2","P")
	{
		send {blind}{shift up}
		send {blind}{shift down}
		sleep 150
		send {blind}{space}
		sleep 10
		send {blind}{shift up}
		sleep 5
	}
	return
	*NumpadSub::ESC
	SC029::return ;` key
	
#IF ;}
#IfWinActive ahk_exe nioh.exe ;{
	#IfWinActive ahk_exe nioh2.exe
	
	~Space::
	send {Shift down}
	sleep 30
	send {shift up}
	return
	XButton2::togfunc(3,"NiohTick",15)
	XButton1::NumpadDot
	r::
	send {r down}{space down}
	sleep 550
	send {space up}{r up}
	return
	F8::m
	SC029::ESC ;` key
	F1::Numpad1
	F2::Numpad2
	F3::Numpad3
	F4::Numpad4
	F5::Numpad5
	F6::Numpad6
	F7::Numpad7
	F9::Numpad9
	F10::Numpad0
	RShift::return
	RControl::return
	RAlt::return
	F12::WinClose
	Right::return
	Up::return
	Down::return
	Left::return 
	NiohTick:
	if WinActive("ahk_exe nioh.exe") or WinActive("ahk_exe nioh2.exe") 
		if !GetKeyState("E","P") and !GetKeyState("ALT","P") and !GetKeyState("XButton1","P") and !GetKeyState("CTRL","P") and !GetKeyState("LWin","P")
			send e
	return
#IF ;}
#IfWinActive ahk_exe Bannerlord.exe ;{
	~$*F::Spam("F",,,10,100)
#IF ;}
#IfWinActive ahk_exe Risk of Rain 2.exe ;{
	~$*Space::Spam()
	~$w::XButton2
	$~*LButton up::
	if GetKeyState("w","d")
	{
		sleep 60
		send {blind}{XButton2}
	}
	return
#IF ;}
#IfWinActive ahk_exe Wolcen.exe ;{
	
	F1::
	SetTimer, testt, on
	return
	
	F2::
	time_key_s:=A_TickCount
	Qq:=1
	return
	
	testt:
	if ((A_TickCount - time_key_s > 2000) and (Qq=1))
	{
		MsgBox %time_key_s% " and " %A_TickCount%-%time_key_s%
		Qq:=0
	}
	sleep 5
	return
	
	
	
	
	;$*~LButton::F6
	
	;$*~LButton up::
	;if toggle
		;send {LButton down}
	;return
	$*~RButton::
	if tog
		QRB:=1
	return
	$~q::Qq:=1
	$~w::Qq:=1
	$~e::Qq:=1
	$~a::Qq:=1
	$~s::Qq:=1
	$~d::Qd:=1
	$~ESC::QEsc:=1
	XButton2::
	if tog
	{
		QEsc:=0
		Qd:=0
		SetTimer, wolcenn1, off
		tog:=!tog
		SoundPlay, %A_WinDir%\Media\Speech Sleep.wav
		sleep 100
		send {blind}{alt up}{shift up}{ctrl up}{F7 up}
		sleep 15
		SetTimer, SendOnce, off
		While (GetKeyState("LButton","D"))
		{
			sleep 5
			SendEvent {LButton down}
			sleep 5
			SendEvent {LButton up}
			
		}
		send {shift}
		QEsc:=0
		Qd:=0
	}
	else if !tog
	{
		QEsc:=0
		Qd:=0
		QRB:=0
		SetTimer, wolcenn1, 20
		tog:=!tog
		SoundPlay, %A_WinDir%\Media\Speech On.wav
		send {blind}{LButton down}{F7 down}
	}
	return
	
	SendOnce: 
	send {blind}{LButton down}
	;sleep 1000
	;send {LButton up}
	;send {F6 down}
	SetTimer, SendOnce, off
	return
	
	wolcenn1:
	;if (!GetKeyState("LButton","D") and (!GetKeyState("LButton","P"))) 
	;{
		;send {blind}{LButton down}
	;}
	if (Qd=1)
	{
		send {F6 up}
		sleep 5
		send {blind}{LButton up}
		sleep 5
		send {blind}{LButton up}
		sleep 5
		;send {shift}
		QEsc:=0
		Qd:=0
		while ((QEsc=0) and (Qd=0) and (tog))
		{
			sleep 20
		}
		QEsc:=0
		Qd:=0
		SetTimer, SendOnce, on
	}
	
	send {F6 down}
	sleep 10
	send {F6 up}
	if (Qq=1)
	{
		Send {F6 up}
		sleep 10
		;Send {shift down}
		sleep 10
		;send {blind}{LButton down}
		;SetTimer, SendOnce, on
		KeyWait % RegExReplace(A_ThisHotkey, "\W", "")
		sleep 10
		;time_key_s:=A_TickCount
		;QLB:=1
		;Send {shift up}
		send {F6 down}
		Qq:=0
		
	}
	if (QRB=1)
	{
		Send {F6 up}
		sleep 5
		send {LButton up}
		sleep 5
		KeyWait % RegExReplace(A_ThisHotkey, "\W", "")
		sleep 5
		send {F6 down}
		sleep 5
		send {LButton down}
		QRB:=0
	}
	
	
	;if (!GetKeyState("F6","D") and (!GetKeyState("LButton","P"))) 
	;{
		;send {F6 down}
	;}
	
	;if (GetKeyState("LButton","D") && (!GetKeyState("LButton","P"))) 
	;if ((A_TickCount - time_key_s > 2000) and (QLB=1))
	;{
		;sleep 10
		;Send {shift up}
		;send {LButton up}
		;QLB:=0
	;}
	if (GetKeyState("LButton","P")) and (!GetKeyState("XButton1","P"))
	{
		;send {F6 up}
		send {blind}{LButton up}
		
		while (GetKeyState("LButton","P")) 
		{
			send {LButton down}
			sleep 5
			send {LButton up}
			sleep 20
		}
		;send {F6 down}
		send {blind}{LButton down}
		;send {F7 up}
	}
	else if (GetKeyState("XButton1","P"))
	{
		send {F6 up}
		send {blind}{LButton up}
		send {shift}
		keywait, XButton1
		send {F6 down}
		send {blind}{LButton down}
	}
	
	
	
	return
	
	
	
	
	#IF
	#IfWinActive ahk_exe Wolcen2.exe ;{
		*$XButton2::
		if ttog
		{
			send {XButton2}
			keywait XButton2
			send {XButton2}
		}
		return
		
		~$*F8::
		if !ttog
		{
			SetTimer,wolcen_main_tick, 30
			global ttog := !ttog
			send {F1 down}{w down}{e down}{XButton1 down}
		}
		else if ttog
		{
			SetTimer,wolcen_main_tick,off
			global ttog := !ttog
			send {F1 up}
			send {w up}{e up}{XButton1 up}
		}
		return
		
		wolcen_main_tick:
		if !GetKeyState("XButton1","P")
		{
			if GetKeyState("RButton","P")
			{
				send {blind}{F1 up}
				send {RButton up}
				send {RButton down}
				while GetKeyState("RButton","P")
				{
					if !GetKeyState("RButton","D")
						send {RButton down}
					sleep 10
				}
				send {RButton up}
				send 1
			}
			if GetKeyState("R","P")
			{
				send {blind}{F1 up}
				while GetKeyState("R","P")
				{
					sleep 5
				}
			}
			if !GetKeyState("XButton1","D")
				send {XButton1 down}
			if !GetKeyState("w","D")
				send {w down}
			if !GetKeyState("e","D")
				send {e down}
			if !GetKeyState("F1","D") and !GetKeyState("XButton1","P")
				send {F1 down}
			if GetKeyState("LButton","P") and !GetKeyState("RButton","P")
			{
				send {blind}{F1 up}
				while GetKeyState("LButton","P")
				{
					click
					sleep 10
				}
			}
		}
		else
			send {F1 up}{w up}{e up}
		if !WinActive("ahk_exe Wolcen.exe")
		{
			
			SetTimer,wolcen_main_tick,off
			global ttog := !ttog
			send {XButton1 up}{XButton1 up}
		}
		return
		
		
		
		timer_wolcen_s1:
		if ttog
			SetTimer,wolcen_main_tick,off
		send www
		sleep 700
		send ee
		sleep 100
		send 1
		if ttog
			SetTimer,wolcen_main_tick,5
		sleep 9600
		if !WinActive("ahk_exe Wolcen.exe")
		{
			SetTimer,timer_wolcen_s1,off
			SetTimer,wolcen_main_tick,off
			global ttog := !ttog
		}
	return ;}
	
;return
;MouseGetPos, xpos, ypos,,,2
;if (xpos not between 1770 and 1854) and (ypos not between 1163 and 1238)
	
#IF ;} 
#IfWinActive ahk_exe JTTSP.exe ;{
	$F1::ESC
	$ESC::Backspace
	$XButton2::Backspace
	$*~f::Spam("f")
#IF ;}
#IfWinActive ahk_exe DarksidersGenesis-Win64-Shipping.exe ;{
	*XButton1::Spam2("XButton1","Numpad8")
	*XButton2::Spam2("XButton2","f")
	$*~f::Spam("f")
	~e & Shift::Spam("Shift")
#IF ;}
#IfWinActive ahk_exe ShadowOfWar.exe ;{
	*~XButton2::Spam2("XButton2","LButton")
#IF ;}
#IfWinActive ahk_class SDL_app ;*[VN pron games] ;{
	*~XButton1::Spam2("XButton1","LButton")
	*~XButton2::CTRL
	#IfWinActive ahk_exe Man of the house.exe 
	*~XButton1::Spam2("XButton1","LButton")
	*~XButton2::CTRL
	#IF
	#IfWinActive ahk_exe Glamour.exe		;*[Glamour]
	*~XButton1::Space
	*~XButton2::Spam2("XButton2","LButton")
#IF ;}
#IfWinActive ahk_exe APlagueTaleInnocence_x64.exe ;{
	*~XButton1::Spam2("XButton1","e")
#IF ;}
#IfWinActive ahk_exe Borderlands3.exe ;{
	*~XButton2::Spam2("XButton2","e")
	$*~Space::Spam("Space")
	$*~XButton1::Spam("XButton1")
;$*~LButton::Spam("LButton")
	
#IF ;}
#IfWinActive ahk_exe LOSTARK.exe ;{
	*~XButton1::Spam2("XButton1","g")
	$*c::i
	$*WheelDown::return
	$*WheelUp::return
#IF ;}
#IfWinActive ahk_exe GreedFall.exe ;{
	$*~e::Spam("e","q")
	$*RButton::Spam("RButton","Shift","Shift",0,190,50,50)
	
#IF ;}
#IfWinActive ahk_exe Diablo III64.exe ;{
	~$*LButton::Spam("LButton",,,5,50)
	
	
	#IfWinActive, ahk_exe ACOdyssey.exe
	$*~f::Spam("f")
	$*~Space::Spam("Space")
	$*~XButton2::togfunc(3,"eee") ;spam eee func [deleted]
	$*~XButton1::Spam("XButton1")
	$*~Shift::Spam("Shift")
#IF ;}
#IfWinActive ahk_exe GH.exe ;{
	$*~e::Spam("e")
	$*~XButton1::E
#IF ;}
#IfWinActive ahk_exe Remnant-Win64-Shipping.exe ;{
;global tog:=0
	
	$*~XButton1::Spam("XButton1")
	$*~Space::Spam("Space")
	$*~e::XButton2
	$*~f::Spam("f")
	$*~RButton::
	while GetKeyState("RButton","P")
	{
		Click
		sleep 20
	}
	return
	$*~XButton2::togfunc(3,"eee") ;spam eee func [deleted]
	
#IF ;}
#IfWinActive ahk_exe RAD.exe ;{
	
;$*~XButton1::Spam("XButton1")
	$*~XButton2::Spam("XButton2")
	$*~RButton::Spam("RButton") ;,"XButton1")
	$*~Space::Spam("Space")
	
#IF ;}