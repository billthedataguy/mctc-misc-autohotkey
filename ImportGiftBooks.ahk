#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


#SingleInstance force

; Hotkey Alt-g to get to Alma Import Screen and Start Gift Book Import Job




!g::


Send +{F2}
Sleep 2000


MouseClick, left, 580, 140, 2

Sleep 2000

Clipboard := 

Clipboard = Connexion Book Import Profile (copied

MouseClick, left, 315, 386, 2


Send ^v

Send {Enter}

Sleep 1000

IfWinExist, Import Profiles - Chromium
    WinActivate 


ImageSearch, FoundX, FoundY, -1000, -1000, 5000, 5000, C:\Users\ej2595ht\Desktop\OCLC MACROS\Ellipsis.PNG


if ErrorLevel = 2
    MsgBox Could not find image file.
else if ErrorLevel = 1
    MsgBox Ellipsis could not be found on the screen.
else

	{
		;MsgBox The icon was found at %FoundX%x%FoundY%.
		
		MiddleX := FoundX + 5
		MiddleY := FoundY + 5
		
		;MsgBox %MiddleX% %MiddleY%
		
		MouseClick, left, %MiddleX%, %MiddleY%

	}

