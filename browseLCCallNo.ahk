#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; capture LC call number string from clipboard and insert below for LC Call Number Browse

#SingleInstance force

; Win b hotkey

clipboard = ; Empty the clipboard


#b::
Send,^a
Send,^c
ClipWait, 2
clip := 0
clip = %clipboard%

Send {Click}

LCCallNo := 0
LCCallNoFormatted := 0

If RegExMatch(clip, "Call #: \S+", LCCallNo) 

{

StringTrimLeft, LCCallNoFormatted, LCCallNo, 8


;MsgBox %LCCallNoFormatted% 

Run http://minneapolis.mnpals.net/F/?func=scan&scan_code=CA&scan_start=%LCCallNoFormatted%&scan_include=N&x=35&y=9&local_base=MCT_CAT


clipboard =
clipboard := LCCallNoFormatted

ClipWait, 2

}

Else MsgBox Couldn't capture gauddamn call number


Return


