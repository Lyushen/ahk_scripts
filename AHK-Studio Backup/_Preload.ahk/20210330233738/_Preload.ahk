;IF NOT A_IsAdmin
;{
	;Run *RunAs "%A_ScriptFullPath%"
	;ExitApp
;}
send {shift up}{alt up}{ctrl up}
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;#KeyHistory

;toggle(0)
; preformance
;ListLines Off
SetBatchLines, -1
SetKeyDelay, -1, -1
SetWinDelay, -1 
SetControlDelay, -1
;Critical , On
;#MenuMaskKey vk07



CoordMode, Mouse, Screen
Thread, interrupt, 0
SendMode, Input
;Process, Priority,, High

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
#~e::return
#~d::return

;#####################################################################
;######## AHK  #Include - include all files from directory ###########
;#####################################################################
;FileSelectFile, f, m 1,, Select Files to #Include, AHK Script (*.ahk; *.ahi)
;StringReplace, f, f, `n, `n#Include%A_Space%, A
;Clipboard := "#Include " f
;MsgBox, 0, Clipboard Contents, % Clipboard

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
	*			AHK  #Include - include all files from directory															*
	* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
	
	FileSelectFile, f, m 1,, Select Files to #Include, AHK Script (*.ahk; *.ahi)
	StringReplace, f, f, `n, `n#Include%A_Space%, A
	Clipboard := "#Include " f
	MsgBox, 0, Clipboard Contents, % Clipboard
*/