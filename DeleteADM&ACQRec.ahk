#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance force


!2::

;IfWinExist, ALEPH Cataloging
    WinActivate ; use the window found above


; Delete ADM & ACQ Recs

Send ^1
Sleep 50
Send ^!2
Sleep 50
Send {End}
Sleep 50
Send ^2
Sleep 50
Send {Enter}
Sleep 50
Send ^r
Sleep 50
Send y
Sleep 50
Send ^r
Sleep 50
Send y
Sleep 50

