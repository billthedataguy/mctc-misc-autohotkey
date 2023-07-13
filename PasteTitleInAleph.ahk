#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance force


!a::

IfWinExist, ALEPH Cataloging
    WinActivate ; use the window found above


Send {F9}
Send,^{Tab}
Send {Tab}{Tab}{Tab}
Send,^v
Send,!o

;Send,!+s

TitleWithOutPlusSigns = %clipboard%
TitleWithPlusSigns = %TitleWithOutPlusSigns%

StringReplace, TitleWithPlusSigns, TitleWithOutPlusSigns, %A_SPACE%, +, All

Run http://minneapolis.mnpals.net/F/?func=find-c&local_base=mct_cat&ccl_term=wti`%3D`%22%TitleWithPlusSigns%`%22

;clipboard =
;ClipWait, 2



