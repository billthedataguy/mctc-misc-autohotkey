﻿#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


!m::

;IfWinExist, ALEPH Cataloging
    WinActivate ; use the window found above

Send {TAB}
Sleep, 500
Send {Enter}
;Send {F1}
;Send {Enter}

;Send !q