#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance force


!1::

;IfWinExist, ALEPH Cataloging
    WinActivate ; use the window found above


; Delete Order Rec

Send ^1
Sleep 50
Send ^!2
Sleep 50
Send ^2
Sleep 500
Send o
;Send {Tab}
;Send {Tab}
;Send {Tab}
;Send {Tab}
;Send {Enter}
;Sleep 50
;Send ^2
Sleep 50
Send !d
Sleep 50
Send y

 



