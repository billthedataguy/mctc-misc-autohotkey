#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


#SingleInstance force

; Hotkey Alt-l to Run a Link to NZ Job



!l::


Send +{F2}
Sleep 2000


MouseClick, left, 480, 132, 2

Sleep 2000



Clipboard := 

Clipboard = Link a set of bibliographic records to

MouseClick, left, 322, 340, 2


Send ^v

Send {Enter}

;Sleep 1000




