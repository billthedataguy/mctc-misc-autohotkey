#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; RegWrite,Reg_sz,HKCU,Software\Microsoft\Windows NT\CurrentVersion\Devices,%PrintName%`,%PrintSet%

; RUNDLL32 PRINTUI.DLL,PrintUIEntry /y /n "DYMO LabelWriter 450"
 
#SingleInstance force

!z::

Send {F10}
Sleep 50
Send {Tab}
Sleep 50
Send {Enter}
Sleep 50
Send !{F4}
Sleep 50

run, NOTEPAD.EXE /PT "C:\Users\vannwi\Desktop\labels.txt" "DYMO LabelWriter 450"

Sleep, 2000


FileDelete, C:\Users\vannwi\Desktop\labels.txt

Sleep, 2000


FileAppend, , C:\Users\vannwi\Desktop\labels.txt

Sleep, 2000