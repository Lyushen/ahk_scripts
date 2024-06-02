#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; ------------- AutoRUN section ---------------- RButton::SendInput,% "{RButton "((toggle:=!toggle)?"Down":"Up")"}"
global tog:=0
global time_since_last:=0
global ttog:=0
global gk1:=0,gk2:=0,gk3:=0,gk4:=0,gk5:=0,gk6:=0,gk7:=0,gk8:=0,gto:=5,gATitle:=""
DetectHiddenWindows, ON
WinGet, ScriptPID, PID, ahk_id %A_ScriptHwnd%
SoundPlay, %A_WinDir%\Media\ding.wav
Run, *RunAs E:\Install\SystemFolders\Progs\Tools\nircmd\nircmdc.exe setappvolume /%ScriptPID% 0.02,, hide
;DetectHiddenWindows, Off

EngCheck() ; check layout current window
; ----------------------------------------------
#Include _Preload.ahk
;#MaxThreadsPerHotkey 1
;#MaxThreads 10
#InstallKeybdHook
#Persistent
#SingleInstance,Force
;#Warn,All,OutputDebug
;#######################FUNCS#######################################
EngCheck() {
	English := 0x4090409
	Russian := 0x4190419
	if(Russian = Format("0x{:x}", DllCall("GetKeyboardLayout", "Int", DllCall("GetWindowThreadProcessId", "Int", WinActive("A"), "Int", 0))))
		SendMessage, 0x50, 0, %English%,, A
}

Spam(key,key2:="",key3:="",to1:=5,to4:=5,to2:=40,to3:=40) {
	WinGet, sATitle, ProcessName, A
	while ((GetKeyState(key, "P")) and (WinActive("ahk_exe "sATitle)))
		if (!GetKeyState("ALT", "P"))
		{
			sleep to1
			send {blind}{%key% down}
			sleep 5
			send {blind}{%key% up}
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
	return
}

Spam2(ifkey1,skey1,to1:=5,ifkey2:="",skey2:="",ifkey3:="",skey3:="",ifkey4:="",skey4:="") {
	WinGet, sATitle, ProcessName, A
	while ((GetKeyState(ifkey1, "P")) and (WinActive("ahk_exe "sATitle)))
	{
		if (!GetKeyState("ALT", "P"))
		{
			sleep to1
			send {blind}{%skey1% down}
			sleep 5
			send {blind}{%skey1% up}
			if ((ifkey2!="") and (skey2!="") and (GetKeyState(ifkey2, "P")))
			{
				sleep to1
				send {blind}{%skey2% down}
				sleep 5
				send {blind}{%skey2% up}
			}
			if ((ifkey3!="") and (skey3!="") and (GetKeyState(ifkey3, "P")))
			{
				sleep to1
				send {blind}{%skey3% down}
				sleep 5
				send {blind}{%skey3% up}
			}
			if ((ifkey4!="") and (skey4!="") and (GetKeyState(ifkey4, "P")))
			{
				sleep to1
				send {blind}{%skey4% down}
				sleep 5
				send {blind}{%skey4% up}
			}
		}	
	}
	send {blind}{alt up}
	return
}

TogSpamTimerFunc(kk1,kk2:="",kk3:="",kk4:="",kk5:="",to:=5) {
	gk1=%kk1%
	gk2=%kk2%
	gk3=%kk3%
	gk4=%kk4%
	gk5=%kk5%
	gto=%to%
	WinGet, gATitle, ProcessName, A
	if tog ;and (n=0 or n=3)
	{
		SetTimer, TogSpamTimer, off
		tog:=!tog
		SoundPlay, %A_WinDir%\Media\Speech Sleep.wav
	}
	else if !tog
	{
		Settimer, TogSpamTimer, 5
		tog:=!tog
		SoundPlay, %A_WinDir%\Media\Speech On.wav
	}
}
TogSpamTimer:
if (WinActive("ahk_exe "gATitle)) {
	send {blind}{%gk1% down}
	sleep 5
	send {blind}{%gk1% up}
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
	send {blind}{shift up} 
}
return

SpamTimerF(kk1,kk2:="",kk3:="",kk4:="",kk5:="",to:=5) {
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
return

togfunc(n,timerr,delay1:=50,doubletimer:="",delay2:=50) {
	if tog and (n=0 or n=3)
	{
		SetTimer, %timerr%, off
		if (doubletimer!="")
			SetTimer, %doubletimer%, off
		tog:=!tog
		SoundPlay, %A_WinDir%\Media\Speech Sleep.wav
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
;$j::SetTimer, jSpam, % (x:=!x) ? "10" : "Off"
;############################################################################################################

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
			;Return Pattern
	;}
;}

#If
#IfWinActive ahk_class LDPlayerMainFrame
XButton1::
$Enter::
send {End}
sleep 50
send {End}
sleep 50
send {End}{End}
sleep 100
send {PgUp}{PgUp}{tab}{tab}{tab}{tab}{tab}{tab}
sleep 50
return
RButton::Spam2("RButton","LButton",1)
#If
#IfWinActive ahk_exe LoR.exe
$*XButton1::LButton

#If
#IfWinActive ahk_exe chrome.exe ;Number sender to phone, LFJ
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
FileDelete, tmpbatch.cmd
FileAppend, 
(
C:\platform-tools\adb.exe connect 192.168.1.115:5555
C:\platform-tools\adb.exe shell input text "+48%Clipb%"
), tmpbatch.cmd
FileAppend, 
(
%Clipb% - %Clipboard%

), E:\Install\SystemFolders\Desktop\TruckDriver\PhoneNum.txt

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
#IF


#IfWinActive ahk_exe MassEffectAndromeda.exe
*SC029::
$*r::spam("r")
$*XButton1::Spam("XButton1")

#If
#IfWinActive ahk_exe Aperion-Win64-Shipping.exe
$*XButton2::TogSpamTimerFunc("F","Q","Space","RButton","LButton",20)
$Shift::K
$1::Q
$2::Space

#IF
#IfWinActive ahk_exe Frontiers-Win64-Shipping.exe
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


#IF
#IfWinActive ahk_exe GenshinImpact.exe
$*XButton1::Spam2("XButton1","f",50,"XButton1","WheelDown")
$*Space::SpamTimerF("Space",,,,,50)

#IF
#IfWinActive ahk_exe Hades.exe

;$*XButton1::Spam2("XButton1","XButton1",5,"LButton","LButton")
;$*XButton1::Spam2("XButton1","XButton1",5,"RButton","RButton","LButton","LButton")

$XButton1::TogSpamTimerFunc("XButton1","E","LButton","RButton")

$*Space::XButton1

#IF
#IfWinActive ahk_class AppWindowClass
*XButton2::Spam("XButton2")


#IF
#IfWinActive ahk_exe Game.exe
XButton1::Spam2("XButton1","LButton")
#IF
#IfWinActive ahk_exe WL3.exe
XButton1::Numpad7
XButton2::Spam2("XButton2","LButton")

#IF
#IfWinActive ahk_exe HorizonZeroDawn.exe
$*~XButton1::Spam2("XButton1","E")

#IF
#IfWinActive ahk_exe DH-Win64-Shipping.exe
;$*~XButton1::Spam2("XButton1","XButton1",3,"Shift","Shift")
$*~XButton2::Spam("XButton2")
$*~XButton1::Spam("XButton1")

#IF
#IfWinActive ahk_exe P4G.exe
XButton1::Spam2("XButton1","LButton",3,3)

#IF
#IfWinActive ahk_exe Gunfire Reborn.exe
$*Space::Spam2("Space","Space",10,"XButton1","XButton1")
$*XButton1::Spam2("XButton1","XButton1",10,"Space","Space")
;$~*LButton::Spam("LButton")
$CapsLock::return



#IF
#IfWinActive ahk_exe re2.exe
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

#If
#IfWinActive ahk_exe LeagueClientUx.exe
XButton1::Spam2("XButton1","LButton",3,3)
#IfWinActive ahk_exe League of Legends.exe
~*SC029::togfunc(0,"tt21")
F8::togfunc(3,"tt21")
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
	send l
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




#IF
#IfWinActive, ahk_exe MetroExodus.exe
*~$XButton2::Spam2("XButton2","XButton1")

#If
#IfWinActive, ahk_exe Gears5.exe
;$*~Space::Spam("Space")
$*~Ctrl::Spam2("Ctrl","Space")

#If
#IfWinActive, ahk_exe Dungeons.exe
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

#IF




#IfWinActive, ahk_exe MiniHealer.exe
XButton1::Spam2("XButton1","LButton",5,5)
#IF

#IfWinActive, ahk_exe ChildrenOfMorta.exe
$*c::
send c
keywait, c
send c
#IF

#IfWinActive, ahk_exe BloodstainedRotN-Win64-Shipping.exe
~*WheelDown::
send {h down}
sleep 1
send {h up}
return
#IF
#IfWinActive, ahk_exe war3.exe
space::F1
F1::`

#IF
#IfWinActive, ahk_exe EtG.exe ;Enter the Gungeon
$~*LButton::Spam("LButton")
~$*LButton up::send r
#IF
#IfWinActive, ahk_exe deadcells.exe
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

#If
#IfWinActive, ahk_class Diablo II
XButton1::Numpad1
XButton2::Numpad2
~*$LButton::Spam("LButton",,,5,5)
;#IfWinActive, ahk_exe left4dead2.exe

#IfWinActive, ahk_exe left4dead.exe or ahk_exe left4dead2.exe
$*RButton::Spam2("RButton","LButton",3,3)
$*XButton1::RButton

#IfWinActive, ahk_exe DrugDealerSimulator-Win64-Shipping.exe
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


#IfWinActive, ahk_exe nioh.exe
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
if WinActive("ahk_exe nioh.exe")
	if !GetKeyState("E","P") and !GetKeyState("ALT","P") and !GetKeyState("XButton1","P") and !GetKeyState("CTRL","P") and !GetKeyState("LWin","P")
		send e
return

#IfWinActive, ahk_exe Bannerlord.exe
~$*F::Spam("F",,,10,100)

#IfWinActive, ahk_exe Risk of Rain 2.exe
;~$*F::Spam("F",,,5,5)
;~$Space::Spam("Space","Space",,5,5)
$F8::ttog(30)
~$w::XButton2
~$*s::
return
*$~s up::
if ttog
	sleep 20
send {XButton2}
return

~$*XButton1::
if ttog
{
	if !GetKeyState("W","P")
		send {blind}{XButton2}
}
return
~$*XButton1 up::
if ttog
{
	sleep 200
	send {blind}{XButton2}
}
return

ttog(to:=5) {
	if (!ttog ) {
		SetTimer,ttog, %to%
		global ttog := !ttog
	} else if (ttog)	{
		SetTimer,ttog,off
		global ttog := !ttog
		send {blind}{LButton up}
	}
}

ttog:
if GetKeyState("LButton","P")
{
	send {LButton up}
	send click
}
if !GetKeyState("LButton","D") and !GetKeyState("LButton","P")
{
	send {LButton down}
}
if !WinActive("ahk_exe Risk of Rain 2.exe")
{
	SetTimer,ttog,off
	global ttog := !ttog
	send {LButton up}{w up}
}
return

#IfWinActive, ahk_exe Wolcen.exe
;~$*XButton1::Spam2("XButton1","LButton",2,2)
;~$*XButton2::togfunc(3,"wolcen_main_tick",5,"timer_wolcen_s1",100)
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
return

;return
;MouseGetPos, xpos, ypos,,,2
;if (xpos not between 1770 and 1854) and (ypos not between 1163 and 1238)


#IfWinActive, ahk_exe JTTSP.exe
$F1::ESC
$ESC::Backspace
$XButton2::Backspace
$*~f::Spam("f")
#If


#IfWinActive ahk_exe DarksidersGenesis-Win64-Shipping.exe
*XButton1::Spam2("XButton1","Numpad8")
*XButton2::Spam2("XButton2","f")
$*~f::Spam("f")
~e & Shift::Spam("Shift")

#IfWinActive ahk_exe ShadowOfWar.exe
*~XButton2::Spam2("XButton2","LButton")


#IfWinActive ahk_class SDL_app
*~XButton1::Spam2("XButton1","LButton")

#IfWinActive ahk_exe APlagueTaleInnocence_x64.exe
*~XButton1::Spam2("XButton1","e")

#IfWinActive ahk_exe Borderlands3.exe
*~XButton2::Spam2("XButton2","e")
$*~Space::Spam("Space")
$*~XButton1::Spam("XButton1")
;$*~LButton::Spam("LButton")


#IfWinActive, ahk_exe LOSTARK.exe
*~XButton1::Spam2("XButton1","g")
$*c::i
$*WheelDown::return
$*WheelUp::return
#IF

#IfWinActive, ahk_exe GreedFall.exe
$*~e::Spam("e","q")
$*RButton::Spam("RButton","Shift","Shift",0,190,50,50)


#IfWinActive ahk_exe Diablo III64.exe
~$*LButton::Spam("LButton",,,5,50)


#IfWinActive, ahk_exe ACOdyssey.exe
$*~f::Spam("f")
$*~Space::Spam("Space")
$*~XButton2::togfunc(3,"eee")
$*~XButton1::Spam("XButton1")
$*~Shift::Spam("Shift")


#IfWinActive, ahk_exe GH.exe
$*~e::Spam("e")
$*~XButton1::E


#IfWinActive, ahk_exe Remnant-Win64-Shipping.exe
global tog:=0

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
$*~XButton2::togfunc(3,"eee")
;$*~ESC::togfunc(0)
;$*~i::togfunc(0)
;$*~o::togfunc(0)
;$*~t::togfunc(0)
#If


eee:
if WinActive("ahk_exe Remnant-Win64-Shipping.exe")
	if (GetKeyState("W","P") or GetKeyState("XButton1","P") or GetKeyState("A","P") or GetKeyState("D","P")) and !GetKeyState("LButton","P")
	{
		send {blind}{XButton2 down}
		sleep 5
		send {blind}{XButton2 up}
	}
if WinActive("ahk_exe ACOdyssey.exe")
	if (GetKeyState("W","P") or GetKeyState("XButton1","P") or GetKeyState("A","P") or GetKeyState("D","P")) and !GetKeyState("LButton","P")
	{
		send {blind}{e down}
		sleep 5
		send {blind}{e up}
	}
;IfWinNotActive, ahk_exe Remnant-Win64-Shipping.exe
;togfunc(0)
return


#IfWinActive, ahk_exe RAD.exe

;$*~XButton1::Spam("XButton1")
$*~XButton2::Spam("XButton2")
$*~RButton::Spam("RButton") ;,"XButton1")
$*~Space::Spam("Space")

#If