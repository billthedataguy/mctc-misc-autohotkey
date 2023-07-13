#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance force


!n::

IfWinExist, ALEPH Cataloging
    WinActivate ; use the window found above

;Send !q

Send ^l
Sleep, 500
Send !o

;Send {F1}






