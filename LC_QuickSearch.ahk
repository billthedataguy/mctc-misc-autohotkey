#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


#SingleInstance force

!l::





InputBox, UserInput, Scan ISBN for LC QuickSearch, , 640, 480
if ErrorLevel
    MsgBox, CANCEL was pressed.
else
    run http://catalog.loc.gov/vwebv/search?searchArg1=%UserInput%&argType1=all&searchCode1=KNUM&searchType=2&combine2=and&searchArg2=&argType2=all&searchCode2=GKEY&combine3=and&searchArg3=&argType3=all&searchCode3=GKEY&year=1515-2015&fromYear=&toYear=&location=all&place=all&type=all&language=all&recCount=25