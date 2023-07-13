#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance force

; Win v hotkey





#v::
clipboard = ; Empty the clipboard
Send,^a
Send,^c
ClipWait, 2
clip = %clipboard%

Send {Click}

AlephBibNo := 0 

;Send {Browser_Refresh}

;If RegExMatch(clip, "00\S+", AlephBibNoSpace) 

;If RegExMatch(clip, "Record Id" 00\S+", AlephBibNoSpace) 

If InStr(clip, "Record Id")<>0

{
;StringTrimLeft, AlephBibNo, AlephBibNoSpace, 1

AlephBibNo := SubStr(clip, InStr(clip, "Record Id")+12, 9)

MsgBox %AlephBibNo% 

clipboard =

clipboard := AlephBibNo
ClipWait, 2

}

Else MsgBox %clip%



Return





