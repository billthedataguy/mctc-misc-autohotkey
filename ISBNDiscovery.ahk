#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.



#1::

#SingleInstance force
; simple input/output

TITLE :=

NUMBER := 


Gui, Show , w500 h300, Librarian's Little Helper

; basic elements
Gui, Add, Text, x20 y10 w90 Left,ISBN number 
Gui, Add, Edit, w150 h19 x20 y30 vNUMBER Left, 
Gui, Add, Text, x20 y90 w200 Left,TITLE 
Gui, Add, Edit, w250 h19 x20 y110 vTITLE Left, 
Gui, Add, Button, x400 y10 w90 h40 vMYBUTTON1 gGOOGLE ,Google Books
Gui, Add, Button, x400 y60 w90 h40 vMYBUTTON2 gOCLC ,OCLC Classify
Gui, Add, Button, x400 y110 w90 h40 vMYBUTTON3 gRCL ,RCLWeb
Gui, Add, Button, x400 y160 w90 h40 vMYBUTTON4 gMCTC ,MnPALS MCTC
Gui, Add, Button, x400 y210 w90 h40 vMYBUTTON5 gISBNDB ,ISBNSearch
Gui, Add, Button, x20 y150 w90 h40 vMYBUTTON6 gCLEAR ,Start over
Gui, Add, Button, x20 y200 w90 h40 vMYBUTTON7 gEXIT ,EXIT




return

GOOGLE:
{
Gui, Submit, NoHide



If NUMBER
	run https://books.google.com/books?vid=ISBN%NUMBER%
else if TITLE
	{
		TITLETRIM := Trim(TITLE)
		StringReplace, TITLEPLUS, TITLETRIM, %A_SPACE%, +, All
		run https://www.google.com/search?tbo=p&tbm=bks&q=intitle:`%22%TITLEPLUS%`%22&tbs=,bkt:b&num=10
	}
		
else
	MsgBox No data entered!

return
}

OCLC:
{
Gui, Submit, NoHide

If NUMBER
	run http://classify.oclc.org/classify2/ClassifyDemo?search-standnum-txt=%NUMBER%&startRec=0
else if TITLE
	{
		TITLETRIM := Trim(TITLE)
		StringReplace, TITLEPLUS, TITLETRIM, %A_SPACE%, +, All
		run http://classify.oclc.org/classify2/ClassifyDemo?search-title-txt=`%22%TITLEPLUS%`%22&startRec=0
	}
		
else
	MsgBox No data entered!

return
}


RCL:
{
Gui, Submit, NoHide

If NUMBER
	run http://www.rclweb.net/Search/Results?q=isbn=[%NUMBER%]+&ast=pr
else if TITLE
	{
		TITLETRIM := Trim(TITLE)
		StringReplace, TITLEPLUS, TITLETRIM, %A_SPACE%, +, All
		run http://www.rclweb.net/Search/Results?q=title-exact-rcl=[`%22%TITLEPLUS%`%22]+&ast=pr
	}
		
else
	MsgBox No data entered!


return
}

MCTC:
{
Gui, Submit, NoHide


If NUMBER
	run https://mctc.mplus.mnpals.net/vufind/Search/Results?type=ISN&lookfor=%NUMBER%&mylocn=MCT&submit=SEARCH

else if TITLE
	{
		TITLETRIM := Trim(TITLE)
		StringReplace, TITLEPLUS, TITLETRIM, %A_SPACE%, +, All
		run https://mctc.mplus.mnpals.net/vufind/Search/Results?lookfor=`%22%TITLEPLUS%`%22&type=Title&submit=Find&mylocn=MCT
	}
		
else
	MsgBox No data entered!






return
}

ISBNDB:
{
Gui, Submit, NoHide

If NUMBER
	run http://www.isbnsearch.org/search?s=%NUMBER%
else if TITLE
	{
		TITLETRIM := Trim(TITLE)
		StringReplace, TITLEPLUS, TITLETRIM, %A_SPACE%, +, All
		run http://www.isbnsearch.org/search?s=%TITLEPLUS%
	}
		
else
	MsgBox No data entered!


return
}



CLEAR:

{

GuiControl,, NUMBER,
GuiControl,, TITLE,
return

}


EXIT:

{

GuiClose: 
ExitApp

}	




