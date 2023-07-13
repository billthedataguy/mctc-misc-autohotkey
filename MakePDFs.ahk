#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance force





!p::

;InputBox, NamesFileName, Enter name of names file: 
;if ErrorLevel
  ;  MsgBox, CANCEL was pressed.
;else
  ;   FileRead, clip, C:\Users\vannwi\Desktop\%NamesFileName%.txt

MsgBox Select Names File ya Baasterd!
FileSelectFile, NamesFileName, , , Text Documents (*.txt)
FileRead, clip, %NamesFileName%
   
MsgBox Select Project Specs File ya Baasterd!
FileSelectFile, ProjectFileName, , , Pdf Documents (*.pdf)
OrigFile=%ProjectFileName%

MsgBox Select Destination Folder ya Baasterd!
FileSelectFolder, SaveFolder

SetWorkingDir, %SaveFolder%

InputBox, ProjectNumber, Enter project number ya Baasterd!

Counter:=0

Loop, parse, clip, `n, `r
{
	
	
	LineNumber = %A_Index% 
	LineText = %A_LoopField%
	
	
	;MsgBox *%LineText%*
	Counter:=Counter+1		
	FileCopy, %OrigFile%, Project%ProjectNumber%_Specs_%LineText%.pdf
	
	

	


}



MsgBox %Counter% Names

