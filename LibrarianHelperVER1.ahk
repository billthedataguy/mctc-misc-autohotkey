#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;mctc desktop version



#SingleInstance force



; simple input/output

TITLE :=

NUMBER := 


Gui, Show, w515 h475, Librarian's Little Helper v1.0 ©Bill Vann
Gui, font, s9

; basic elements
Gui, Add, Text, x20 y10 w90 Left,ISBN number 
Gui, Add, Edit, w150 h19 x20 y30 vNUMBER Left, 
Gui, Add, Text, x20 y90 w90 Left,TITLE 
Gui, Add, Edit, w250 h19 x20 y110 vTITLE Left, 
Gui, Add, Checkbox, x280 y115 Checked vEXACT, Exact
Gui, Add, Button, x400 y20 w90 h40 vMYBUTTON1 gGOOGLE ,Google Books

Gui, Add, Button, x400 y70 w90 h40 vMYBUTTON3 gRCL ,RCLWeb
Gui, Add, Button, x400 y120 w90 h40 vMYBUTTON4 gMCTC ,MnPALS MCTC
Gui, Add, Button, x400 y170 w90 h40 vMYBUTTON5 gRESERVES ,Course Reserves
Gui, Add, Button, x400 y220 w90 h40 vMYBUTTON6 gMNPALS ,MnPALS ALL
Gui, Add, Button, x400 y270 w90 h40 vMYBUTTON7 gWC ,WorldCat
Gui, Add, Button, x400 y320 w90 h40 vMYBUTTON8 gBIP ,Books in Print
Gui, Add, Button, x400 y370 w90 h40 vMYBUTTON9 gEBSCO,EBSCO eBooks
Gui, Add, Button, x400 y420 w90 h40 vMYBUTTON10 gCHOICE,Choice

Gui, Add, Button, x20 y150 w90 h40 vMYBUTTON11 gCLEAR ,Start over
Gui, Add, Button, x20 y200 w90 h40 vMYBUTTON12 gEXIT ,EXIT

Gui, font, cBlue bold
Gui, Add, Button, x20 y300 w130 h40 vMYBUTTON2 gOCLC ,OCLC Classify

Gui, Add, Text, x25 y350 w350 Left,Alt-1 (OCLC Classify--> get Call #) 
Gui, Add, Text, x25 y370 w350 Left,Alt-2 (OCLC Classify--> get Subject Heading) 
Gui, Add, Text, x25 y390 w350 Left,Alt-3 (OCLC Classify--> get Title) 
Gui, Add, Text, x25 y410 w350 Left,Alt-4 (OCLC Classify--> get Selector) 

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
		StringReplace, TITLENOPERCENT, TITLEPLUS, `%, "`%25", All
		
		If EXACT = 1
			run https://www.google.com/search?tbo=p&tbm=bks&q=intitle:`%22%TITLENOPERCENT%`%22&tbs=,bkt:b&num=10
		else run https://www.google.com/search?tbo=p&tbm=bks&q=allintitle:%TITLENOPERCENT%&tbs=,bkt:b&num=10
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
		StringReplace, TITLENOPERCENT, TITLEPLUS, `%, "`%25", All
		
		If EXACT = 1
			run http://classify.oclc.org/classify2/ClassifyDemo?search-title-txt=`%22%TITLENOPERCENT%`%22&startRec=0
		else run http://classify.oclc.org/classify2/ClassifyDemo?search-title-txt=%TITLENOPERCENT%&startRec=0
				
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
		StringReplace, TITLENOPERCENT, TITLEPLUS, `%, "`%25", All
		
		If EXACT = 1
			run http://www.rclweb.net/Search/Results?q=title-exact-rcl=[`%22%TITLENOPERCENT%`%22]+&ast=pr
		else run http://www.rclweb.net/Search/Results?q=title-kw-rcl=[%TITLENOPERCENT%]+&ast=pr
		
		
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
		StringReplace, TITLENOPERCENT, TITLEPLUS, `%, "`%25", All
		
		If EXACT = 1
			run https://mctc.mplus.mnpals.net/vufind/Search/Results?lookfor=`%22%TITLENOPERCENT%`%22&type=Title&submit=Find&mylocn=MCT
		else run https://mctc.mplus.mnpals.net/vufind/Search/Results?lookfor=%TITLENOPERCENT%&type=Title&submit=Find&mylocn=MCT
		
		
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
		StringReplace, TITLENOPERCENT, TITLEPLUS, `%, "`%25", All
		
		If EXACT = 1
			run http://minneapolis.mnpals.net/F?func=find-c&local_base=mct_res&ccl_term=WTI`%3D`%22%TITLENOPERCENT%`%22&adjacent=Y
		else run http://minneapolis.mnpals.net/F?func=find-c&local_base=mct_res&ccl_term=WTI`%3D%TITLENOPERCENT%&adjacent=Y
		
		
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
		StringReplace, TITLENOPERCENT, TITLEPLUS, `%, "`%25", All
		
		If EXACT = 1
			run https://mplus.mnpals.net/vufind/Search/Results?lookfor=`%22%TITLENOPERCENT%`%22&type=Title&submit=Find
		else run https://mplus.mnpals.net/vufind/Search/Results?lookfor=%TITLENOPERCENT%&type=Title&submit=Find
		
		
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
		StringReplace, TITLENOPERCENT, TITLEPLUS, `%, "`%25", All
		
		If EXACT = 1
			run http://www.worldcat.org/search?q=ti:`%22%TITLENOPERCENT%`%22&fq=x0:book&qt=advanced&dblist=638
		else run http://www.worldcat.org/search?q=kw:%TITLENOPERCENT%&fq=x0:book&qt=advanced&dblist=638
		
	
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
		StringReplace, TITLENOPERCENT, TITLEPLUS, `%, "`%25", All
		
		If EXACT = 1
			run http://www.booksinprint.com.ezproxy.hclib.org/Search/Results?q=title-exact=[`%22%TITLENOPERCENT%`%22]+&ast=pr
		else run http://www.booksinprint.com.ezproxy.hclib.org/Search/Results?q=title-kw=[%TITLENOPERCENT%]+&ast=pr
		
		
	}
		
else
	MsgBox No data entered!


return
}


EBSCO:
{
Gui, Submit, NoHide

If NUMBER
	run http://mctproxy.mnpals.net/login?url=http://search.ebscohost.com/login.aspx?direct=true&site=ehost-live&scope=site&type=1&db=e000xna&mode=or&lang=en&bquery=IB+%NUMBER%
else if TITLE
	{
		TITLETRIM := Trim(TITLE)
		StringReplace, TITLEPLUS, TITLETRIM, %A_SPACE%, +, All
		StringReplace, TITLENOPERCENT, TITLEPLUS, `%, "`%25", All
		
		If EXACT = 1
			run http://mctproxy.mnpals.net/login?url=http://search.ebscohost.com/login.aspx?direct=true&site=ehost-live&scope=site&type=1&db=e000xna&mode=or&lang=en&bquery=TI+`%22%TITLENOPERCENT%`%22

		else run http://mctproxy.mnpals.net/login?url=http://search.ebscohost.com/login.aspx?direct=true&site=ehost-live&scope=site&type=1&db=e000xna&mode=or&lang=en&bquery=TI+%TITLENOPERCENT%

		
		
	}
		
else
	MsgBox No data entered!


return
}



CHOICE:
{
Gui, Submit, NoHide

If NUMBER
	run http://www.choicereviews.org/search?p=1&totalPages=1&reviewer=&exactauthor=&q=&title=&author=&publisher=&lcstart=&yearstart=&and=&phrase=%NUMBER%&or=&not=&issueyr=&issuevol=&issuenum=&order1=
else if TITLE
	{
		TITLETRIM := Trim(TITLE)
		StringReplace, TITLEPLUS, TITLETRIM, %A_SPACE%, +, All
		StringReplace, TITLENOPERCENT, TITLEPLUS, `%, "`%25", All
		
		If EXACT = 1
			run http://www.choicereviews.org/search?p=1&totalPages=1&reviewer=&exactauthor=&q=&title=&author=&publisher=&lcstart=&yearstart=&and=&phrase=%TITLENOPERCENT%&or=&not=&issueyr=&issuemo=&issuevol=&issuenum=&primary_sort=approvedForApiDate_dt&order1=1&secondary_sort=&rpp=25
		else run http://www.choicereviews.org/search?p=1&totalPages=1&reviewer=&exactauthor=&q=&title=%TITLENOPERCENT%&author=&publisher=&lcstart=&yearstart=&and=&phrase=&or=&not=&issueyr=&issuemo=&issuevol=&issuenum=&primary_sort=approvedForApiDate_dt&order1=1&secondary_sort=&rpp=25
		
		
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



!3::

#SingleInstance force

clipboard = ; Empty the clipboard
Send,^a
Send,^c
ClipWait, 3
clip = %clipboard%
Send {Click}

ArrayCount = 0

FullTitle := "Full Title"

Loop, parse, clip, `n

{
	
	
	LineNumber = %A_Index% 
	LineText = %A_LoopField%
	
	Array%LineNumber% := LineText  ; Store this line in the next array element.

	If InStr(LineText, "Title:")

	{

		HeaderLineText := LineText
		HeaderLineNumber := LineNumber

	}

	
	If InStr(LineText, "Author:")

	{
		FooterLineText := LineText
		FooterLineNumber := LineNumber 

	}

	


}

TitleLineNumber := HeaderLineNumber + 1

FullTitle :=  Array%TitleLineNumber%

CleanFullTitle := Trim(FullTitle)


ColonLocation := InStr(CleanFullTitle, " : ") 

MainTitle := SubStr(CleanFullTitle, 1, ColonLocation - 1)
	
MsgBox Full Title is: %CleanFullTitle%
MsgBox Main Title is: %MainTitle%
clipboard = %CleanFullTitle%
	
	
MsgBox, 3,, Would you like to search the library catalog by Full Title? `n (Copies title to clipboard) 
	
	IfMsgBox Yes
		{
		
			StringReplace, NoPercentTitle, CleanFullTitle, `%, "`%25", All
    		Run https://mctc.mplus.mnpals.net/vufind/Search/Results?lookfor=`%22%NoPercentTitle%`%22&type=Title&submit=Find&limit=20&sort=relevance&mylocn=MCT
			exit
		}
	IfMsgBox No
		{
    			MsgBox You pressed No.		
				exit
	
		}

	IfMsgBox Cancel
		exit	


!4::

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
		MsgBox No Record in OCLC. File under Unknown Selector!
		clipboard = 
		break
	}

	If Position <> 0
		
	{
		
		StringSplit, CallNumberLineArray, LineText, %A_Tab%
		
		CallNumber = %CallNumberLineArray2%		
	
		FirstTwoLetters := SubStr(CallNumber, 1, 2)
		FirstPosition := SubStr(CallNumber, 1, 1)		
		SecondPosition := SubStr(CallNumber, 2, 1)

		
;specific call number ranges tested first



		if FirstTwoLetters = BF 
		{

			MsgBox Call Number is: %CallNumberLineArray2%
			ifMsgBox, OK
			ifMsgBox, OK
				MsgBox Selector is: jenny!
			ifMsgBox, OK
				break

		}

		if FirstTwoLetters = PN 
		{

			MsgBox Call Number is: %CallNumberLineArray2%
			ifMsgBox, OK
				MsgBox If about Theater or Cinema, Selector is: jenny! `nIf about Journalism or Broadcasting, Selector is: TOM!
			ifMsgBox, OK
				break
			
			
		
		}

		if FirstTwoLetters in TT,TX
		{

			MsgBox Call Number is: %CallNumberLineArray2%
			ifMsgBox, OK
				MsgBox Selector is: JANE!
			ifMsgBox, OK
				break
			
			

		}


		if FirstTwoLetters in GV,QM,QP,QR,TD,TS,TR
		{

			MsgBox Call Number is: %CallNumberLineArray2%
			ifMsgBox, OK
				MsgBox Selector is: KATHLEEN!
			ifMsgBox, OK
				break
			
			
		

		}
		
		if FirstTwoLetters = HX 
		{

			MsgBox Call Number is: %CallNumberLineArray2%
			ifMsgBox, OK
				MsgBox Selector is: TOM!
			ifMsgBox, OK
				break

		}



;jenny

		

		if FirstPosition = M
		{
			MsgBox Call Number is: %CallNumberLineArray2%
			ifMsgBox, OK
				MsgBox Selector is: jenny!
			ifMsgBox, OK
				break
			
		}

		
		if FirstPosition = P
		{
			MsgBox Call Number is: %CallNumberLineArray2%
			ifMsgBox, OK
				MsgBox Selector is: jenny!
			ifMsgBox, OK
				break
			
		}


		if FirstTwoLetters between PA and PM 
		{

			MsgBox Call Number is: %CallNumberLineArray2%
			ifMsgBox, OK
				MsgBox Selector is: jenny!
			ifMsgBox, OK
				break

		}

		if FirstTwoLetters between PQ and PZ 
		{

			MsgBox Call Number is: %CallNumberLineArray2%
			ifMsgBox, OK
				MsgBox Selector is: jenny!
			ifMsgBox, OK
				break

		}



;bill

		
		if FirstPosition = B
		{
			MsgBox Call Number is: %CallNumberLineArray2%
			ifMsgBox, OK
				MsgBox Selector is: BILL!
			ifMsgBox, OK
				break
			
		}

		if FirstTwoLetters between BA and BD 
		{

			MsgBox Call Number is: %CallNumberLineArray2%
			ifMsgBox, OK
				MsgBox Selector is: BILL!
			ifMsgBox, OK
			break

		}

		if FirstTwoLetters between BH and BJ 
		{

			MsgBox Call Number is: %CallNumberLineArray2%
			ifMsgBox, OK
				MsgBox Selector is: BILL!
			ifMsgBox, OK
			break

		}


		if FirstTwoLetters between BL and BX 
		{

			MsgBox Call Number is: %CallNumberLineArray2%
			ifMsgBox, OK
				MsgBox Selector is: BILL!
			ifMsgBox, OK
			break

		}


		if FirstPosition = T
		{
			MsgBox Call Number is: %CallNumberLineArray2%
			ifMsgBox, OK
				MsgBox Selector is: BILL!
			ifMsgBox, OK
			break
			
		}


		if FirstTwoLetters between TA and TC 
		{

			MsgBox Call Number is: %CallNumberLineArray2%
			ifMsgBox, OK
				MsgBox Selector is: BILL!
			ifMsgBox, OK
			break

		}

		if FirstTwoLetters between TE and TP 
		{

			MsgBox Call Number is: %CallNumberLineArray2%
			ifMsgBox, OK
				MsgBox Selector is: BILL!
			ifMsgBox, OK
			break

		}
		

;jane

		if FirstPosition in C,D,E,F,U,V,Z
			
		{
			MsgBox Call Number is: %CallNumberLineArray2%
			ifMsgBox, OK
				MsgBox Selector is: JANE!
			ifMsgBox, OK
			break
			
		}

		if FirstPosition = G
		{
			MsgBox Call Number is: %CallNumberLineArray2%
			ifMsgBox, OK
				MsgBox Selector is: JANE!
			ifMsgBox, OK
			break
			
		}



		if FirstTwoLetters between GA and GF 
		{

			MsgBox Call Number is: %CallNumberLineArray2%
			ifMsgBox, OK
				MsgBox Selector is: JANE!
			ifMsgBox, OK
			break

		}
		
		if FirstTwoLetters between GN and GT 
		{

			MsgBox Call Number is: %CallNumberLineArray2%
			ifMsgBox, OK
				MsgBox Selector is: JANE!
			ifMsgBox, OK
			break

		}


		if FirstPosition = H
		{
			MsgBox Call Number is: %CallNumberLineArray2%
			ifMsgBox, OK
				MsgBox Selector is: JANE!
			ifMsgBox, OK
			break
			
		}


		if FirstTwoLetters between HM and HV 
		{

			MsgBox Call Number is: %CallNumberLineArray2%
			ifMsgBox, OK
				MsgBox Selector is: JANE!
			ifMsgBox, OK
			break

		}


		if FirstTwoLetters between HA and HJ 
		{

			MsgBox Call Number is: %CallNumberLineArray2%
			ifMsgBox, OK
				MsgBox Selector is: JANE!
			ifMsgBox, OK
			break

		}



;kathleen





		if FirstPosition in A,K,N,Q,R,S
			
		{
			MsgBox Call Number is: %CallNumberLineArray2%
			ifMsgBox, OK
				MsgBox Selector is: KATHLEEN!
			ifMsgBox, OK
			break
			
		}

		

;tom



		if FirstPosition in L,J
		{
			MsgBox Call Number is: %CallNumberLineArray2%
			ifMsgBox, OK
				MsgBox Selector is: TOM!
			ifMsgBox, OK
			break
			
		}

		
;if all fails, then file under unknown selector	

		else MsgBox Selector is: UNKNOWN SELECTOR!

	}


	


}


Exit
	
