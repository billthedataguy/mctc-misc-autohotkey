#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;mctc desktop version

;#1::

#SingleInstance force

;Hotkey, #1, , Off


; simple input/output

TITLE :=

NUMBER := 


Gui, Show, w515 h450, Librarian's Little Helper
Gui, font, s9

; basic elements
Gui, Add, Text, x20 y10 w90 Left,ISBN number 
Gui, Add, Edit, w150 h19 x20 y30 vNUMBER Left, 
Gui, Add, Text, x20 y90 w90 Left,TITLE 
Gui, Add, Edit, w250 h19 x20 y110 vTITLE Left, 
Gui, Add, Checkbox, x280 y115 Checked vEXACT, Exact
Gui, Add, Button, x400 y10 w90 h40 vMYBUTTON1 gGOOGLE ,Google Books
Gui, Add, Button, x400 y60 w90 h40 vMYBUTTON2 gOCLC ,OCLC Classify
Gui, Add, Button, x400 y110 w90 h40 vMYBUTTON3 gRCL ,RCLWeb
Gui, Add, Button, x400 y160 w90 h40 vMYBUTTON4 gMCTC ,MnPALS MCTC
Gui, Add, Button, x400 y210 w90 h40 vMYBUTTON5 gRESERVES ,Course Reserves
Gui, Add, Button, x400 y260 w90 h40 vMYBUTTON6 gMNPALS ,MnPALS ALL
Gui, Add, Button, x400 y310 w90 h40 vMYBUTTON7 gWC ,WorldCat
Gui, Add, Button, x400 y360 w90 h40 vMYBUTTON8 gBIP ,Books in Print
Gui, Add, Button, x20 y150 w90 h40 vMYBUTTON9 gCLEAR ,Start over
Gui, Add, Button, x20 y200 w90 h40 vMYBUTTON10 gEXIT ,EXIT
Gui, font, cBlue bold
Gui, Add, Text, x20 y350 w400 Left,Alt-1 (OCLC Classify--> Get Call #) 
Gui, Add, Text, x20 y370 w400 Left,Alt-2 (OCLC Classify--> Get Subject Heading) 
Gui, font, norm




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
		
		If EXACT = 1
			run https://www.google.com/search?tbo=p&tbm=bks&q=intitle:`%22%TITLEPLUS%`%22&tbs=,bkt:b&num=10
		else run https://www.google.com/search?tbo=p&tbm=bks&q=allintitle:%TITLEPLUS%&tbs=,bkt:b&num=10
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
		
		If EXACT = 1
			run http://classify.oclc.org/classify2/ClassifyDemo?search-title-txt=`%22%TITLEPLUS%`%22&startRec=0
		else run http://classify.oclc.org/classify2/ClassifyDemo?search-title-txt=%TITLEPLUS%&startRec=0
				
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
		
		If EXACT = 1
			run http://www.rclweb.net/Search/Results?q=title-exact-rcl=[`%22%TITLEPLUS%`%22]+&ast=pr
		else run http://www.rclweb.net/Search/Results?q=title-kw-rcl=[%TITLEPLUS%]+&ast=pr
		
		
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
		
		If EXACT = 1
			run https://mctc.mplus.mnpals.net/vufind/Search/Results?lookfor=`%22%TITLEPLUS%`%22&type=Title&submit=Find&mylocn=MCT
		else run https://mctc.mplus.mnpals.net/vufind/Search/Results?lookfor=%TITLEPLUS%&type=Title&submit=Find&mylocn=MCT
		
		
	}
		
else
	MsgBox No data entered!

return
}


RESERVES:
{
Gui, Submit, NoHide


If NUMBER
	MsgBox "No ISBNs in Course Reserves - Search by Title Instead!"

else if TITLE
	{
		TITLETRIM := Trim(TITLE)
		StringReplace, TITLEPLUS, TITLETRIM, %A_SPACE%, +, All
		
		If EXACT = 1
			run http://minneapolis.mnpals.net/F?func=find-c&local_base=mct_res&ccl_term=WTI`%3D`%22%TITLEPLUS%`%22&adjacent=Y
		else run http://minneapolis.mnpals.net/F?func=find-c&local_base=mct_res&ccl_term=WTI`%3D%TITLEPLUS%&adjacent=Y
		
		
	}
		
else
	MsgBox No data entered!

return
}




MNPALS:
{
Gui, Submit, NoHide


If NUMBER
	run https://mplus.mnpals.net/vufind/Search/Results?type=ISN&lookfor=%NUMBER%&submit=SEARCH

else if TITLE
	{
		TITLETRIM := Trim(TITLE)
		StringReplace, TITLEPLUS, TITLETRIM, %A_SPACE%, +, All
		
		If EXACT = 1
			run https://mplus.mnpals.net/vufind/Search/Results?lookfor=`%22%TITLEPLUS%`%22&type=Title&submit=Find
		else run https://mplus.mnpals.net/vufind/Search/Results?lookfor=%TITLEPLUS%&type=Title&submit=Find
		
		
	}
		
else
	MsgBox No data entered!

return
}






WC:
{
Gui, Submit, NoHide

If NUMBER
	run http://www.worldcat.org/search?q=bn:%NUMBER%&qt=advanced&dblist=638
else if TITLE
	{
		TITLETRIM := Trim(TITLE)
		StringReplace, TITLEPLUS, TITLETRIM, %A_SPACE%, +, All
		
		If EXACT = 1
			run http://www.worldcat.org/search?q=ti:`%22%TITLEPLUS%`%22&fq=x0:book&qt=advanced&dblist=638
		else run http://www.worldcat.org/search?q=kw:%TITLEPLUS%&fq=x0:book&qt=advanced&dblist=638
		
	
	}
		
else
	MsgBox No data entered!


return
}



BIP:
{
Gui, Submit, NoHide

If NUMBER
	run http://www.booksinprint.com.ezproxy.hclib.org/Search/Results?q=isbn=[`%22%NUMBER%`%22]+&ast=pr
else if TITLE
	{
		TITLETRIM := Trim(TITLE)
		StringReplace, TITLEPLUS, TITLETRIM, %A_SPACE%, +, All
		
		If EXACT = 1
			run http://www.booksinprint.com.ezproxy.hclib.org/Search/Results?q=title-exact=[`%22%TITLEPLUS%`%22]+&ast=pr
		else run http://www.booksinprint.com.ezproxy.hclib.org/Search/Results?q=title-kw=[%TITLEPLUS%]+&ast=pr
		
		
	}
		
else
	MsgBox No data entered!


return
}








CLEAR:

{

GuiControl,, NUMBER,
GuiControl,, TITLE,
GuiControl,, EXACT,1

return

}


EXIT:

{

GuiClose: 
ExitApp

}	


!1::

#SingleInstance force


clipboard = ; Empty the clipboard
Send,^a
Send,^c
ClipWait, 2
clip = %clipboard%
Send {Click}


CallNumber = "null call number" 



Loop, parse, clip, `n
{
	
	
	LineNumber = %A_Index% 
	LineText = %A_LoopField%
	
	
	
	Position := InStr(LineText, "classweb")
	AbortLoop := InStr(LineText, "Sorry, your current search did not return any results.")

	If AbortLoop <> 0

	{
		MsgBox No Record in OCLC. 
		clipboard = 
		break
	}

	If Position <> 0
		
	{
		
		StringSplit, CallNumberLineArray, LineText, %A_Tab%

		CallNumber = %CallNumberLineArray2%		
		
		
		LengthCallNumber :=StrLen(CallNumber)

		
		PeriodPosition := InStr(CallNumber, ".")
		
		if PeriodPosition <> 0

		{			

			FullSearchCallNumber := SubStr(CallNumber, 1, PeriodPosition-1)
			MsgBox Search call number: %FullSearchCallNumber%
		
		}
		
		else

		{	
			
			;MsgBox No period
			FullSearchCallNumber := Trim(CallNumber)
			MsgBox Search call number: %FullSearchCallNumber%

		}

		
		
		



		MsgBox, 3,, Would you like to search the library catalog by Call Number?
			IfMsgBox Yes
   				Run https://mctc.mplus.mnpals.net/vufind/Search/Results?lookfor= %FullSearchCallNumber%&type=CallNumber&submit=Find&limit=20&sort=relevance&mylocn=MCT
				
			IfMsgBox No
				{
    					MsgBox You pressed No.		
					continue
				}

			IfMsgBox Cancel
				break

	}

}


return



!2::

#SingleInstance force

clipboard = ; Empty the clipboard
Send,^a
Send,^c
ClipWait, 3
clip = %clipboard%
Send {Click}

ArrayCount = 0

SubjectHeading := ""

Loop, parse, clip, `n

{
	
	
	LineNumber = %A_Index% 
	LineText = %A_LoopField%
	
	Array%LineNumber% := LineText  ; Store this line in the next array element.

	If InStr(LineText, "FAST Subject Headings")

	{

		HeaderLineText := LineText
		HeaderLineNumber := LineNumber

	}

	
	If InStr(LineText, "Subject Headings Chart")

	{
		FooterLineText := LineText
		FooterLineNumber := LineNumber 

	}

	


}



Counter := HeaderLineNumber + 2

While Counter <= FooterLineNumber

{

		

	SubjectHeading :=  Array%Counter%

	If SubjectHeading = "Subject Headings Chart"
		{
			SubjectHeading := ""
			return

		}
	
	TabLocation := InStr(SubjectHeading, A_Tab) - 1

	SubHeadText := SubStr(SubjectHeading, 1, TabLocation)
	MsgBox Subject Heading is "%SubHeadText%"
	
	MsgBox, 3,, Would you like to search the library catalog by Subject Heading? 
	
	IfMsgBox Yes
		{
    			Run https://mctc.mplus.mnpals.net/vufind/Search/Results?lookfor=`%22%SubHeadText%`%22&type=Subject&submit=Find&limit=20&sort=relevance&mylocn=MCT
			Sleep, 2000 
		}
	IfMsgBox No
		{
    			MsgBox You pressed No.		
			Counter := Counter + 1
			continue
	
		}

	IfMsgBox Cancel
		break	



	Counter := Counter + 1

}


return



