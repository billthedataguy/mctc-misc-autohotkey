#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance force


!q::

IfWinExist, ALEPH Cataloging
    WinActivate ; use the window found above


Send {F9}
Send {Left}
Send ^{Tab}
Send {TAB 3}
;Send {Enter}



