#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.



#SingleInstance force

!e::


InputBox, UserInput, Scan ISBN, , 640, 480
if ErrorLevel
    MsgBox, CANCEL was pressed.
else
    run http://classify.oclc.org/classify2/ClassifyDemo?search-standnum-txt=%UserInput%&startRec=0


clipboard =
ClipWait, 2



