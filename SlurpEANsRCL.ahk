#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance force



!.::

IfExist, C:\Users\vannwi\Desktop\EANNumbers.txt
    FileDelete, C:\Users\vannwi\Desktop\EANNumbers.txt

IfExist, C:\Users\vannwi\Desktop\recs.txt
    FileRead, clip, C:\Users\vannwi\Desktop\recs.txt

Counter:=0

Loop, parse, clip, `n
{
	
	
	LineNumber = %A_Index% 
	LineText = %A_LoopField%
	;MsgBox %LineNumber% %LineText%
	
	
	Position := InStr(LineText, "EAN: ")
	
	If Position <> 0
		
	{
		
		Counter:=Counter+1		
		EANNumberWithSpaces := SubStr(LineText, 5)
		EANNumber := Trim(EANNumberWithSpaces)	
		;MsgBox EAN Number = %EANNumber%
		
		FileAppend %EANNumber%`n, C:\Users\vannwi\Desktop\EANNumbers.txt
	
		
		

	}


	


}

MsgBox %Counter% EAN Numbers
 
FileRead, EANSet, C:\Users\vannwi\Desktop\EANNumbers.txt

Clipboard := EANSet

Run http://www.gobi3.com/hx/Falcon.ashx?location=addtitlesbyisbnparms
