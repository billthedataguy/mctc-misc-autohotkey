#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


![::

ImageSearch, FoundX, FoundY, -1000, -1000, 5000, 5000, C:\Users\ej2595ht\Desktop\OCLC MACROS\Ellipsis.PNG

;CoordMode Pixel  ; Interprets the coordinates below as relative to the screen rather than the active window.
;ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *Icon3 C:\Users\ej2595ht\Desktop\OCLC MACROS\MClogo.JPG
if ErrorLevel = 2
    MsgBox Could not conduct the search.
else if ErrorLevel = 1
    MsgBox Icon could not be found on the screen.
else

	{
		MsgBox The icon was found at %FoundX%x%FoundY%.
		
		MiddleX := FoundX + 5
		MiddleY := FoundY + 5
		
		MsgBox %MiddleX% %MiddleY%
		
		MouseClick, left, %MiddleX%, %MiddleY%

	}
	

	