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