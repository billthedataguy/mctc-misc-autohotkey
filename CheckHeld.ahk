#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance force

; Win q hotkey





#q::
clipboard = ; Empty the clipboard

;IF AT A RECORD LIST VIEW IN OCLC CONNEXION

Click right
Send A

Click right
Send C


ClipWait, 2
clip = %clipboard%

If InStr(clip, "Held")<>0

{

MsgBox HELD FUCKER! 

clipboard =

ClipWait, 2

}

Else MsgBox NOT HELD ASSHOLE!



Return





