#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;mctc student gift book sorter version



#SingleInstance force



; simple input/output

TITLE :=

NUMBER :=  

AUTHOR :=

EXACT = 0

EXACTAUTH = 0

AUTH_TITLE = 0

URLResources = 0


Gui, Show, w515 h500, Librarian's Little Helper v5.0 ©Bill Vann
Gui, font, s9

; basic elements
Gui, Add, Text, x20 y10 w90 Left,ISBN number 
Gui, Add, Edit, w150 h19 x20 y30 vNUMBER Left,
Gui, Add, Button, x190 y30 w80 h20 vMYBUTTON13 gCLEANCOPY ,Clean&copy


 
Gui, Add, Text, x20 y90 w90 Left,TITLE 
Gui, Add, Edit, w250 h19 x20 y110 vTITLE Left, 
Gui, Add, Checkbox, x280 y115 vEXACT, Exact

Gui, Add, Text, x20 y170 w90 Left,AUTHOR 
Gui, Add, Edit, w250 h19 x20 y190 vAUTHOR Left, 
Gui, Add, Checkbox, x100 y150 vAUTH_TITLE, Title + Author
Gui, Add, Checkbox, x280 y195 vEXACTAUTH, Exact


Gui, Add, Button, x400 y20 w90 h40 vMYBUTTON1 gGOOGLE ,Google Books

Gui, Add, Button, x400 y70 w90 h40 vMYBUTTON3 gRCL ,RCLWeb
Gui, Add, Button, x400 y120 w90 h40 vMYBUTTON4 gMCTC ,MnPALS MCTC
Gui, Add, Button, x400 y170 w90 h40 vMYBUTTON5 gRESERVES ,Course Reserves
Gui, Add, Button, x400 y220 w90 h40 vMYBUTTON6 gMNPALS ,MnPALS ALL
Gui, Add, Button, x400 y270 w90 h40 vMYBUTTON7 gWC ,WorldCat

Gui, font, cRed bold
Gui, Add, Text, x270 y335 w200 Left,*HCL Login First* 
Gui, font, cBlack norm

Gui, Add, Button, x400 y320 w90 h40 vMYBUTTON8 gBIP ,Books in Print
Gui, Add, Button, x400 y370 w90 h40 vMYBUTTON9 gEBSCO,EBSCO eBooks


Gui, Add, Button, x400 y420 w90 h40 vMYBUTTON10 gCHOICE,Choice

Gui, Add, Checkbox, x140 y260 vURLResources ,URL Resources

Gui, Add, Button, x20 y225 w90 h40 vMYBUTTON11 gCLEAR ,Start over
Gui, Add, Button, x20 y275 w90 h40 vMYBUTTON12 gEXIT ,EXIT



Gui, font, cBlue bold
Gui, Add, Button, x20 y350 w130 h40 vMYBUTTON2 gOCLC ,OCLC Classify



Gui, Add, Text, x25 y410 w350 Left,Ctrl-Alt-c (Classify--> get Call #) 
Gui, Add, Text, x25 y430 w350 Left,Ctrl-Alt-h (Classify--> get Subject Heading) 
Gui, Add, Text, x25 y450 w350 Left,Ctrl-Alt-t  (Classify--> get Title) 
Gui, Add, Text, x25 y470 w350 Left,Ctrl-Alt-s (Classify--> get Selector) 

Gui, font, norm




return

CLEANCOPY:
{

Gui, Submit, NoHide

		;MsgBox Number = %NUMBER%
		StringReplace, NUMBERCLEAN, NUMBER, -, , All
		;MsgBox Numberclean = %NUMBERCLEAN%
		clipboard = %NUMBERCLEAN%
		GuiControl, Text, NUMBER, %NUMBERCLEAN%

	



return

}






GOOGLE:
{
Gui, Submit, NoHide



if NUMBER

	run https://books.google.com/books?vid=ISBN%NUMBER%
		
	

else if TITLE and !AUTHOR
	{
		TITLETRIM := Trim(TITLE)
		StringReplace, TITLEPLUS, TITLETRIM, %A_SPACE%, +, All
		StringReplace, TITLENOPERCENT, TITLEPLUS, `%, "`%25", All
		
		If EXACT = 1
			run https://www.google.com/search?tbo=p&tbm=bks&q=intitle:`%22%TITLENOPERCENT%`%22&tbs=,bkt:b&num=10
		else run https://www.google.com/search?tbo=p&tbm=bks&q=allintitle:%TITLENOPERCENT%&tbs=,bkt:b&num=10
	}
		
else if AUTHOR and !TITLE
	{
		AUTHORTRIM := Trim(AUTHOR)
		StringReplace, AUTHORPLUS, AUTHORTRIM, %A_SPACE%, +, All
		;StringReplace, AUTHORWITHCOMMA, AUTHORPLUS, `,, "`%2C", All
		
		If EXACTAUTH = 1
			run https://www.google.com/search?tbo=p&tbm=bks&q=inauthor:`%22%AUTHORPLUS%`%22&tbs=,bkt:b&num=10
		else run https://www.google.com/search?tbo=p&tbm=bks&q=allinauthor:%AUTHORPLUS%&tbs=,bkt:b&num=10
	}

else if AUTH_TITLE
	{
		TITLETRIM := Trim(TITLE)
		StringReplace, TITLEPLUS, TITLETRIM, %A_SPACE%, +, All
		StringReplace, TITLENOPERCENT, TITLEPLUS, `%, "`%25", All
			
		
		AUTHORTRIM := Trim(AUTHOR)
		StringReplace, AUTHORPLUS, AUTHORTRIM, %A_SPACE%, +, All
		;StringReplace, AUTHORWITHCOMMA, AUTHORPLUS, `,, "`%2C", All
		
		if (EXACTAUTH = 1 and EXACT = 1) 
			run https://www.google.com/search?tbo=p&tbm=bks&q=inauthor:`%22%AUTHORPLUS%`%22`%20intitle:`%22%TITLENOPERCENT%`%22&tbs=,bkt:b&num=10
		
		else if (EXACTAUTH = 1 and EXACT = 0) 
			run https://www.google.com/search?tbo=p&tbm=bks&q=inauthor:`%22%AUTHORPLUS%`%22`%20intitle:%TITLENOPERCENT%&tbs=,bkt:b&num=10

		else if (EXACTAUTH = 0 and EXACT = 1) 
			run https://www.google.com/search?tbo=p&tbm=bks&q=inauthor:%AUTHORPLUS%`%20intitle:`%22%TITLENOPERCENT%`%22&tbs=,bkt:b&num=10
	
					
		else run https://www.google.com/search?tbo=p&tbm=bks&q=inauthor:%AUTHORPLUS%`%20intitle:%TITLENOPERCENT%&tbs=,bkt:b&num=10
	}

	
else if (!NUMBER and !TITLE and !AUTHOR)
	MsgBox No data entered!

else 
	MsgBox Check box to search both title and author!
	
	
return
}

OCLC:
{
Gui, Submit, NoHide



if NUMBER
	run http://classify.oclc.org/classify2/ClassifyDemo?search-standnum-txt=%NUMBER%&startRec=0
else if TITLE and !AUTHOR
	{
		TITLETRIM := Trim(TITLE)
		StringReplace, TITLEPLUS, TITLETRIM, %A_SPACE%, +, All
		StringReplace, TITLENOPERCENT, TITLEPLUS, `%, "`%25", All
		
		If EXACT = 1
			run http://classify.oclc.org/classify2/ClassifyDemo?search-title-txt=`%22%TITLENOPERCENT%`%22&startRec=0
		else run http://classify.oclc.org/classify2/ClassifyDemo?search-title-txt=%TITLENOPERCENT%&startRec=0
	}
		
else if AUTHOR and !TITLE
	{
		AUTHORTRIM := Trim(AUTHOR)
		StringReplace, AUTHORPLUS, AUTHORTRIM, %A_SPACE%, +, All
		;StringReplace, AUTHORWITHCOMMA, AUTHORPLUS, `,, "`%2C", All
		
		If EXACTAUTH = 1
			run http://classify.oclc.org/classify2/ClassifyDemo?search-author-txt=`%22%AUTHORPLUS%`%22&startRec=0
		else run http://classify.oclc.org/classify2/ClassifyDemo?search-author-txt=%AUTHORPLUS%&startRec=0
	}

else if AUTH_TITLE
	{
		TITLETRIM := Trim(TITLE)
		StringReplace, TITLEPLUS, TITLETRIM, %A_SPACE%, +, All
		StringReplace, TITLENOPERCENT, TITLEPLUS, `%, "`%25", All
			
		
		AUTHORTRIM := Trim(AUTHOR)
		StringReplace, AUTHORPLUS, AUTHORTRIM, %A_SPACE%, +, All
		;StringReplace, AUTHORWITHCOMMA, AUTHORPLUS, `,, "`%2C", All
		
		if (EXACTAUTH = 1 and EXACT = 1) 
			run http://classify.oclc.org/classify2/ClassifyDemo?search-title-txt=`%22%TITLENOPERCENT%`%22&search-author-txt=`%22%AUTHORPLUS%`%22&startRec=0
		
		else if (EXACTAUTH = 1 and EXACT = 0) 
			run http://classify.oclc.org/classify2/ClassifyDemo?search-title-txt=%TITLENOPERCENT%&search-author-txt=`%22%AUTHORPLUS%`%22&startRec=0

		else if (EXACTAUTH = 0 and EXACT = 1) 
			run http://classify.oclc.org/classify2/ClassifyDemo?search-title-txt=`%22%TITLENOPERCENT%`%22&search-author-txt=%AUTHORPLUS%&startRec=0
	
					
		else run http://classify.oclc.org/classify2/ClassifyDemo?search-title-txt=%TITLENOPERCENT%&search-author-txt=%AUTHORPLUS%&startRec=0
	}

	
else if (!NUMBER and !TITLE and !AUTHOR)
	MsgBox No data entered!

else 
	MsgBox Check box to search both title and author!
	


return
}


RCL:
{
Gui, Submit, NoHide



if NUMBER
	run http://www.rclweb.net/Search/Results?q=isbn=[%NUMBER%]+&ast=pr
else if TITLE and !AUTHOR
	{
		TITLETRIM := Trim(TITLE)
		StringReplace, TITLEPLUS, TITLETRIM, %A_SPACE%, +, All
		StringReplace, TITLENOPERCENT, TITLEPLUS, `%, "`%25", All
		
		If EXACT = 1
			run http://www.rclweb.net/Search/Results?q=title-exact-rcl=[`%22%TITLENOPERCENT%`%22]+&ast=pr
		else run http://www.rclweb.net/Search/Results?q=title-kw-rcl=[%TITLENOPERCENT%]+&ast=pr
	}
		
else if AUTHOR and !TITLE
	{
		AUTHORTRIM := Trim(AUTHOR)
		StringReplace, AUTHORPLUS, AUTHORTRIM, %A_SPACE%, +, All
		;StringReplace, AUTHORWITHCOMMA, AUTHORPLUS, `,, "`%2C", All
		
		If EXACTAUTH = 1
			run http://www.rclweb.net/Search/Results?q=author=[`%22%AUTHORPLUS%`%22]+&ast=pr
		else run http://www.rclweb.net/Search/Results?q=author=[%AUTHORPLUS%]+&ast=pr
	}

else if AUTH_TITLE
	{
		TITLETRIM := Trim(TITLE)
		StringReplace, TITLEPLUS, TITLETRIM, %A_SPACE%, +, All
		StringReplace, TITLENOPERCENT, TITLEPLUS, `%, "`%25", All
			
		
		AUTHORTRIM := Trim(AUTHOR)
		StringReplace, AUTHORPLUS, AUTHORTRIM, %A_SPACE%, +, All
		;StringReplace, AUTHORWITHCOMMA, AUTHORPLUS, `,, "`%2C", All
		
		if (EXACTAUTH = 1 and EXACT = 1) 
			run http://www.rclweb.net/Search/Results?q=author=[`%22%AUTHORPLUS%`%22]+AND+title-exact-rcl=[`%22%TITLENOPERCENT%`%22]+&ast=pr
		
		else if (EXACTAUTH = 1 and EXACT = 0) 
			run http://www.rclweb.net/Search/Results?q=author=[`%22%AUTHORPLUS%`%22]+AND+title-kw-rcl=[%TITLENOPERCENT%]+&ast=pr

		else if (EXACTAUTH = 0 and EXACT = 1) 
			run http://www.rclweb.net/Search/Results?q=author=[%AUTHORPLUS%]+AND+title-exact-rcl=[`%22%TITLENOPERCENT%`%22]+&ast=pr
	
					
		else run http://www.rclweb.net/Search/Results?q=author=[%AUTHORPLUS%]+AND+title-kw-rcl=[%TITLENOPERCENT%]+&ast=pr
	}

	
else if (!NUMBER and !TITLE and !AUTHOR)
	MsgBox No data entered!

else 
	MsgBox Check box to search both title and author!
	


return
}



MCTC:
{
Gui, Submit, NoHide



if NUMBER and URLResources
	run https://mctc.mplus.mnpals.net/vufind/Search/Results?type=ISN&lookfor=%NUMBER%&mylocn=MCT&submit=SEARCH&filter`%5B`%5D=format`%3A"URL+Resource"
	
else if NUMBER and !URLResources	
	run https://mctc.mplus.mnpals.net/vufind/Search/Results?type=ISN&lookfor=%NUMBER%&mylocn=MCT&submit=SEARCH
	
else if TITLE and !AUTHOR and !URLResources
	{
		TITLETRIM := Trim(TITLE)
		StringReplace, TITLEPLUS, TITLETRIM, %A_SPACE%, +, All
		StringReplace, TITLENOPERCENT, TITLEPLUS, `%, "`%25", All
		
		If EXACT = 1
			run https://mctc.mplus.mnpals.net/vufind/Search/Results?lookfor=`%22%TITLENOPERCENT%`%22&type=Title&submit=Find&mylocn=MCT
		else run https://mctc.mplus.mnpals.net/vufind/Search/Results?lookfor=%TITLENOPERCENT%&type=Title&submit=Find&mylocn=MCT
	}

else if TITLE and !AUTHOR and URLResources
	{
		TITLETRIM := Trim(TITLE)
		StringReplace, TITLEPLUS, TITLETRIM, %A_SPACE%, +, All
		StringReplace, TITLENOPERCENT, TITLEPLUS, `%, "`%25", All
		
		If EXACT = 1
			run https://mctc.mplus.mnpals.net/vufind/Search/Results?lookfor=`%22%TITLENOPERCENT%`%22&type=Title&submit=Find&mylocn=MCT&filter`%5B`%5D=format`%3A"URL+Resource"
		else run https://mctc.mplus.mnpals.net/vufind/Search/Results?lookfor=%TITLENOPERCENT%&type=Title&submit=Find&mylocn=MCT&filter`%5B`%5D=format`%3A"URL+Resource"
	}




	
else if AUTHOR and !TITLE and !URLResources
	{
		AUTHORTRIM := Trim(AUTHOR)
		StringReplace, AUTHORPLUS, AUTHORTRIM, %A_SPACE%, +, All
		;StringReplace, AUTHORWITHCOMMA, AUTHORPLUS, `,, "`%2C", All
		
		If EXACTAUTH = 1
			run https://mctc.mplus.mnpals.net/vufind/Search/Results?type=Author&lookfor=`%22%AUTHORPLUS%`%22&mylocn=MCT&submit=SEARCH
		else run https://mctc.mplus.mnpals.net/vufind/Search/Results?type=Author&lookfor=%AUTHORPLUS%&mylocn=MCT&submit=SEARCH
		
	}
	
	
else if AUTHOR and !TITLE and URLResources
	{
		AUTHORTRIM := Trim(AUTHOR)
		StringReplace, AUTHORPLUS, AUTHORTRIM, %A_SPACE%, +, All
		;StringReplace, AUTHORWITHCOMMA, AUTHORPLUS, `,, "`%2C", All
		
		If EXACTAUTH = 1
			run https://mctc.mplus.mnpals.net/vufind/Search/Results?type=Author&lookfor=`%22%AUTHORPLUS%`%22&mylocn=MCT&submit=SEARCH&filter`%5B`%5D=format`%3A"URL+Resource"
		else run https://mctc.mplus.mnpals.net/vufind/Search/Results?type=Author&lookfor=%AUTHORPLUS%&mylocn=MCT&submit=SEARCH&filter`%5B`%5D=format`%3A"URL+Resource"
		
	}	


else if AUTH_TITLE and !URLResources
	{
		TITLETRIM := Trim(TITLE)
		StringReplace, TITLEPLUS, TITLETRIM, %A_SPACE%, +, All
		StringReplace, TITLENOPERCENT, TITLEPLUS, `%, "`%25", All
			
		
		AUTHORTRIM := Trim(AUTHOR)
		StringReplace, AUTHORPLUS, AUTHORTRIM, %A_SPACE%, +, All
		;StringReplace, AUTHORWITHCOMMA, AUTHORPLUS, `,, "`%2C", All
		
		if (EXACTAUTH = 1 and EXACT = 1) 
			run https://mctc.mplus.mnpals.net/vufind/Search/Results?stype=adv&join=AND&bool0`%5B`%5D=AND&lookfor0`%5B`%5D=`%22%TITLENOPERCENT%`%22&type0`%5B`%5D=Title&lookfor0`%5B`%5D=`%22%AUTHORPLUS%`%22&type0`%5B`%5D=Author&bool1`%5B`%5D=AND&lookfor1`%5B`%5D=&type1`%5B`%5D=AllFields&sort=relevance&submit=Find&daterange`%5B`%5D=publishDate&publishDatefrom=&publishDateto=&mylocn=MCT
							
		else if (EXACTAUTH = 1 and EXACT = 0) 
			run https://mctc.mplus.mnpals.net/vufind/Search/Results?stype=adv&join=AND&bool0`%5B`%5D=AND&lookfor0`%5B`%5D=%TITLENOPERCENT%&type0`%5B`%5D=Title&lookfor0`%5B`%5D=`%22%AUTHORPLUS%`%22&type0`%5B`%5D=Author&bool1`%5B`%5D=AND&lookfor1`%5B`%5D=&type1`%5B`%5D=AllFields&sort=relevance&submit=Find&daterange`%5B`%5D=publishDate&publishDatefrom=&publishDateto=&mylocn=MCT 

		else if (EXACTAUTH = 0 and EXACT = 1) 
			run https://mctc.mplus.mnpals.net/vufind/Search/Results?stype=adv&join=AND&bool0`%5B`%5D=AND&lookfor0`%5B`%5D=`%22%TITLENOPERCENT%`%22&type0`%5B`%5D=Title&lookfor0`%5B`%5D=%AUTHORPLUS%&type0`%5B`%5D=Author&bool1`%5B`%5D=AND&lookfor1`%5B`%5D=&type1`%5B`%5D=AllFields&sort=relevance&submit=Find&daterange`%5B`%5D=publishDate&publishDatefrom=&publishDateto=&mylocn=MCT 
	
					
		else run https://mctc.mplus.mnpals.net/vufind/Search/Results?stype=adv&join=AND&bool0`%5B`%5D=AND&lookfor0`%5B`%5D=%TITLENOPERCENT%&type0`%5B`%5D=Title&lookfor0`%5B`%5D=%AUTHORPLUS%&type0`%5B`%5D=Author&bool1`%5B`%5D=AND&lookfor1`%5B`%5D=&type1`%5B`%5D=AllFields&sort=relevance&submit=Find&daterange`%5B`%5D=publishDate&publishDatefrom=&publishDateto=&mylocn=MCT 
	}

	
	
	
else if AUTH_TITLE and URLResources
	{
		TITLETRIM := Trim(TITLE)
		StringReplace, TITLEPLUS, TITLETRIM, %A_SPACE%, +, All
		StringReplace, TITLENOPERCENT, TITLEPLUS, `%, "`%25", All
			
		
		AUTHORTRIM := Trim(AUTHOR)
		StringReplace, AUTHORPLUS, AUTHORTRIM, %A_SPACE%, +, All
		;StringReplace, AUTHORWITHCOMMA, AUTHORPLUS, `,, "`%2C", All
		
		if (EXACTAUTH = 1 and EXACT = 1) 
			run https://mctc.mplus.mnpals.net/vufind/Search/Results?stype=adv&join=AND&bool0`%5B`%5D=AND&lookfor0`%5B`%5D=`%22%TITLENOPERCENT%`%22&type0`%5B`%5D=Title&lookfor0`%5B`%5D=`%22%AUTHORPLUS%`%22&type0`%5B`%5D=Author&bool1`%5B`%5D=AND&lookfor1`%5B`%5D=&type1`%5B`%5D=AllFields&sort=relevance&submit=Find&daterange`%5B`%5D=publishDate&publishDatefrom=&publishDateto=&mylocn=MCT&filter`%5B`%5D=format`%3A"URL+Resource"
							
		else if (EXACTAUTH = 1 and EXACT = 0) 
			run https://mctc.mplus.mnpals.net/vufind/Search/Results?stype=adv&join=AND&bool0`%5B`%5D=AND&lookfor0`%5B`%5D=%TITLENOPERCENT%&type0`%5B`%5D=Title&lookfor0`%5B`%5D=`%22%AUTHORPLUS%`%22&type0`%5B`%5D=Author&bool1`%5B`%5D=AND&lookfor1`%5B`%5D=&type1`%5B`%5D=AllFields&sort=relevance&submit=Find&daterange`%5B`%5D=publishDate&publishDatefrom=&publishDateto=&mylocn=MCT&filter`%5B`%5D=format`%3A"URL+Resource" 

		else if (EXACTAUTH = 0 and EXACT = 1) 
			run https://mctc.mplus.mnpals.net/vufind/Search/Results?stype=adv&join=AND&bool0`%5B`%5D=AND&lookfor0`%5B`%5D=`%22%TITLENOPERCENT%`%22&type0`%5B`%5D=Title&lookfor0`%5B`%5D=%AUTHORPLUS%&type0`%5B`%5D=Author&bool1`%5B`%5D=AND&lookfor1`%5B`%5D=&type1`%5B`%5D=AllFields&sort=relevance&submit=Find&daterange`%5B`%5D=publishDate&publishDatefrom=&publishDateto=&mylocn=MCT&filter`%5B`%5D=format`%3A"URL+Resource" 
	
					
		else run https://mctc.mplus.mnpals.net/vufind/Search/Results?stype=adv&join=AND&bool0`%5B`%5D=AND&lookfor0`%5B`%5D=%TITLENOPERCENT%&type0`%5B`%5D=Title&lookfor0`%5B`%5D=%AUTHORPLUS%&type0`%5B`%5D=Author&bool1`%5B`%5D=AND&lookfor1`%5B`%5D=&type1`%5B`%5D=AllFields&sort=relevance&submit=Find&daterange`%5B`%5D=publishDate&publishDatefrom=&publishDateto=&mylocn=MCT&filter`%5B`%5D=format`%3A"URL+Resource" 
	}
	
else if (!NUMBER and !TITLE and !AUTHOR)
	MsgBox No data entered!

else 
	MsgBox Check box to search both title and author!
	


return
}




RESERVES:
{
Gui, Submit, NoHide



if NUMBER and !TITLE
	MsgBox "No ISBNs in Course Reserves - Search by Title Instead!"
else if TITLE and !AUTHOR
	{
		TITLETRIM := Trim(TITLE)
		StringReplace, TITLEPLUS, TITLETRIM, %A_SPACE%, +, All
		StringReplace, TITLENOPERCENT, TITLEPLUS, `%, "`%25", All
		
		If EXACT = 1
			run http://minneapolis.mnpals.net/F?func=find-c&local_base=mct_res&ccl_term=WTI`%3D`%22%TITLENOPERCENT%`%22&adjacent=Y
		else run http://minneapolis.mnpals.net/F?func=find-c&local_base=mct_res&ccl_term=WTI`%3D%TITLENOPERCENT%&adjacent=Y
	}
		
else if AUTHOR and !TITLE
	{
		AUTHORTRIM := Trim(AUTHOR)
		StringReplace, AUTHORPLUS, AUTHORTRIM, %A_SPACE%, +, All
		;StringReplace, AUTHORWITHCOMMA, AUTHORPLUS, `,, "`%2C", All
		
		If EXACTAUTH = 1
			run http://minneapolis.mnpals.net/F?func=find-c&local_base=mct_res&ccl_term=WAU`%3D`%22%AUTHORPLUS%`%22&adjacent=Y
		else run http://minneapolis.mnpals.net/F?func=find-c&local_base=mct_res&ccl_term=WAU`%3D%AUTHORPLUS%&adjacent=Y
		
	}

else if AUTH_TITLE
	{
		TITLETRIM := Trim(TITLE)
		StringReplace, TITLEPLUS, TITLETRIM, %A_SPACE%, +, All
		StringReplace, TITLENOPERCENT, TITLEPLUS, `%, "`%25", All
			
		
		AUTHORTRIM := Trim(AUTHOR)
		StringReplace, AUTHORPLUS, AUTHORTRIM, %A_SPACE%, +, All
		;StringReplace, AUTHORWITHCOMMA, AUTHORPLUS, `,, "`%2C", All
		
		if (EXACTAUTH = 1 and EXACT = 1) 
			run http://minneapolis.mnpals.net/F?func=find-c&local_base=mct_res&ccl_term=WTI`%3D`%22%TITLENOPERCENT%`%22+and+WAU`%3D`%22%AUTHORPLUS%`%22&adjacent=Y				
		else if (EXACTAUTH = 1 and EXACT = 0) 
			run http://minneapolis.mnpals.net/F?func=find-c&local_base=mct_res&ccl_term=WTI`%3D%TITLENOPERCENT%+and+WAU`%3D`%22%AUTHORPLUS%`%22&adjacent=Y		
		else if (EXACTAUTH = 0 and EXACT = 1) 
			run http://minneapolis.mnpals.net/F?func=find-c&local_base=mct_res&ccl_term=WTI`%3D`%22%TITLENOPERCENT%`%22+and+WAU`%3D%AUTHORPLUS%&adjacent=Y	
					
		else run http://minneapolis.mnpals.net/F?func=find-c&local_base=mct_res&ccl_term=WTI`%3D%TITLENOPERCENT%+and+WAU`%3D%AUTHORPLUS%&adjacent=Y	

	}

	
else if (!NUMBER and !TITLE and !AUTHOR)
	MsgBox No data entered!

else 
	MsgBox Check box to search both title and author!
	


return
}



MNPALS:
{
Gui, Submit, NoHide



if NUMBER and URLResources
	run https://mctc.mplus.mnpals.net/vufind/Search/Results?type=ISN&lookfor=%NUMBER%&mylocn=SYS&submit=SEARCH&filter`%5B`%5D=format`%3A"URL+Resource"
	
else if NUMBER and !URLResources	
	run https://mctc.mplus.mnpals.net/vufind/Search/Results?type=ISN&lookfor=%NUMBER%&mylocn=SYS&submit=SEARCH
	
else if TITLE and !AUTHOR and !URLResources
	{
		TITLETRIM := Trim(TITLE)
		StringReplace, TITLEPLUS, TITLETRIM, %A_SPACE%, +, All
		StringReplace, TITLENOPERCENT, TITLEPLUS, `%, "`%25", All
		
		If EXACT = 1
			run https://mctc.mplus.mnpals.net/vufind/Search/Results?lookfor=`%22%TITLENOPERCENT%`%22&type=Title&submit=Find&mylocn=SYS
		else run https://mctc.mplus.mnpals.net/vufind/Search/Results?lookfor=%TITLENOPERCENT%&type=Title&submit=Find&mylocn=SYS
	}

else if TITLE and !AUTHOR and URLResources
	{
		TITLETRIM := Trim(TITLE)
		StringReplace, TITLEPLUS, TITLETRIM, %A_SPACE%, +, All
		StringReplace, TITLENOPERCENT, TITLEPLUS, `%, "`%25", All
		
		If EXACT = 1
			run https://mctc.mplus.mnpals.net/vufind/Search/Results?lookfor=`%22%TITLENOPERCENT%`%22&type=Title&submit=Find&mylocn=SYS&filter`%5B`%5D=format`%3A"URL+Resource"
		else run https://mctc.mplus.mnpals.net/vufind/Search/Results?lookfor=%TITLENOPERCENT%&type=Title&submit=Find&mylocn=SYS&filter`%5B`%5D=format`%3A"URL+Resource"
	}




	
else if AUTHOR and !TITLE and !URLResources
	{
		AUTHORTRIM := Trim(AUTHOR)
		StringReplace, AUTHORPLUS, AUTHORTRIM, %A_SPACE%, +, All
		;StringReplace, AUTHORWITHCOMMA, AUTHORPLUS, `,, "`%2C", All
		
		If EXACTAUTH = 1
			run https://mctc.mplus.mnpals.net/vufind/Search/Results?type=Author&lookfor=`%22%AUTHORPLUS%`%22&mylocn=SYS&submit=SEARCH
		else run https://mctc.mplus.mnpals.net/vufind/Search/Results?type=Author&lookfor=%AUTHORPLUS%&mylocn=SYS&submit=SEARCH
		
	}
	
	
else if AUTHOR and !TITLE and URLResources
	{
		AUTHORTRIM := Trim(AUTHOR)
		StringReplace, AUTHORPLUS, AUTHORTRIM, %A_SPACE%, +, All
		;StringReplace, AUTHORWITHCOMMA, AUTHORPLUS, `,, "`%2C", All
		
		If EXACTAUTH = 1
			run https://mctc.mplus.mnpals.net/vufind/Search/Results?type=Author&lookfor=`%22%AUTHORPLUS%`%22&mylocn=SYS&submit=SEARCH&filter`%5B`%5D=format`%3A"URL+Resource"
		else run https://mctc.mplus.mnpals.net/vufind/Search/Results?type=Author&lookfor=%AUTHORPLUS%&mylocn=SYS&submit=SEARCH&filter`%5B`%5D=format`%3A"URL+Resource"
		
	}	


else if AUTH_TITLE and !URLResources
	{
		TITLETRIM := Trim(TITLE)
		StringReplace, TITLEPLUS, TITLETRIM, %A_SPACE%, +, All
		StringReplace, TITLENOPERCENT, TITLEPLUS, `%, "`%25", All
			
		
		AUTHORTRIM := Trim(AUTHOR)
		StringReplace, AUTHORPLUS, AUTHORTRIM, %A_SPACE%, +, All
		;StringReplace, AUTHORWITHCOMMA, AUTHORPLUS, `,, "`%2C", All
		
		if (EXACTAUTH = 1 and EXACT = 1) 
			run https://mctc.mplus.mnpals.net/vufind/Search/Results?stype=adv&join=AND&bool0`%5B`%5D=AND&lookfor0`%5B`%5D=`%22%TITLENOPERCENT%`%22&type0`%5B`%5D=Title&lookfor0`%5B`%5D=`%22%AUTHORPLUS%`%22&type0`%5B`%5D=Author&bool1`%5B`%5D=AND&lookfor1`%5B`%5D=&type1`%5B`%5D=AllFields&sort=relevance&submit=Find&daterange`%5B`%5D=publishDate&publishDatefrom=&publishDateto=&mylocn=SYS
							
		else if (EXACTAUTH = 1 and EXACT = 0) 
			run https://mctc.mplus.mnpals.net/vufind/Search/Results?stype=adv&join=AND&bool0`%5B`%5D=AND&lookfor0`%5B`%5D=%TITLENOPERCENT%&type0`%5B`%5D=Title&lookfor0`%5B`%5D=`%22%AUTHORPLUS%`%22&type0`%5B`%5D=Author&bool1`%5B`%5D=AND&lookfor1`%5B`%5D=&type1`%5B`%5D=AllFields&sort=relevance&submit=Find&daterange`%5B`%5D=publishDate&publishDatefrom=&publishDateto=&mylocn=SYS

		else if (EXACTAUTH = 0 and EXACT = 1) 
			run https://mctc.mplus.mnpals.net/vufind/Search/Results?stype=adv&join=AND&bool0`%5B`%5D=AND&lookfor0`%5B`%5D=`%22%TITLENOPERCENT%`%22&type0`%5B`%5D=Title&lookfor0`%5B`%5D=%AUTHORPLUS%&type0`%5B`%5D=Author&bool1`%5B`%5D=AND&lookfor1`%5B`%5D=&type1`%5B`%5D=AllFields&sort=relevance&submit=Find&daterange`%5B`%5D=publishDate&publishDatefrom=&publishDateto=&mylocn=SYS 
	
					
		else run https://mctc.mplus.mnpals.net/vufind/Search/Results?stype=adv&join=AND&bool0`%5B`%5D=AND&lookfor0`%5B`%5D=%TITLENOPERCENT%&type0`%5B`%5D=Title&lookfor0`%5B`%5D=%AUTHORPLUS%&type0`%5B`%5D=Author&bool1`%5B`%5D=AND&lookfor1`%5B`%5D=&type1`%5B`%5D=AllFields&sort=relevance&submit=Find&daterange`%5B`%5D=publishDate&publishDatefrom=&publishDateto=&mylocn=SYS 
	}

	
	
	
else if AUTH_TITLE and URLResources
	{
		TITLETRIM := Trim(TITLE)
		StringReplace, TITLEPLUS, TITLETRIM, %A_SPACE%, +, All
		StringReplace, TITLENOPERCENT, TITLEPLUS, `%, "`%25", All
			
		
		AUTHORTRIM := Trim(AUTHOR)
		StringReplace, AUTHORPLUS, AUTHORTRIM, %A_SPACE%, +, All
		;StringReplace, AUTHORWITHCOMMA, AUTHORPLUS, `,, "`%2C", All
		
		if (EXACTAUTH = 1 and EXACT = 1) 
			run https://mctc.mplus.mnpals.net/vufind/Search/Results?stype=adv&join=AND&bool0`%5B`%5D=AND&lookfor0`%5B`%5D=`%22%TITLENOPERCENT%`%22&type0`%5B`%5D=Title&lookfor0`%5B`%5D=`%22%AUTHORPLUS%`%22&type0`%5B`%5D=Author&bool1`%5B`%5D=AND&lookfor1`%5B`%5D=&type1`%5B`%5D=AllFields&sort=relevance&submit=Find&daterange`%5B`%5D=publishDate&publishDatefrom=&publishDateto=&mylocn=SYS&filter`%5B`%5D=format`%3A"URL+Resource"
							
		else if (EXACTAUTH = 1 and EXACT = 0) 
			run https://mctc.mplus.mnpals.net/vufind/Search/Results?stype=adv&join=AND&bool0`%5B`%5D=AND&lookfor0`%5B`%5D=%TITLENOPERCENT%&type0`%5B`%5D=Title&lookfor0`%5B`%5D=`%22%AUTHORPLUS%`%22&type0`%5B`%5D=Author&bool1`%5B`%5D=AND&lookfor1`%5B`%5D=&type1`%5B`%5D=AllFields&sort=relevance&submit=Find&daterange`%5B`%5D=publishDate&publishDatefrom=&publishDateto=&mylocn=SYS&filter`%5B`%5D=format`%3A"URL+Resource" 

		else if (EXACTAUTH = 0 and EXACT = 1) 
			run https://mctc.mplus.mnpals.net/vufind/Search/Results?stype=adv&join=AND&bool0`%5B`%5D=AND&lookfor0`%5B`%5D=`%22%TITLENOPERCENT%`%22&type0`%5B`%5D=Title&lookfor0`%5B`%5D=%AUTHORPLUS%&type0`%5B`%5D=Author&bool1`%5B`%5D=AND&lookfor1`%5B`%5D=&type1`%5B`%5D=AllFields&sort=relevance&submit=Find&daterange`%5B`%5D=publishDate&publishDatefrom=&publishDateto=&mylocn=SYS&filter`%5B`%5D=format`%3A"URL+Resource" 
	
					
		else run https://mctc.mplus.mnpals.net/vufind/Search/Results?stype=adv&join=AND&bool0`%5B`%5D=AND&lookfor0`%5B`%5D=%TITLENOPERCENT%&type0`%5B`%5D=Title&lookfor0`%5B`%5D=%AUTHORPLUS%&type0`%5B`%5D=Author&bool1`%5B`%5D=AND&lookfor1`%5B`%5D=&type1`%5B`%5D=AllFields&sort=relevance&submit=Find&daterange`%5B`%5D=publishDate&publishDatefrom=&publishDateto=&mylocn=SYS&filter`%5B`%5D=format`%3A"URL+Resource" 
	}
	
else if (!NUMBER and !TITLE and !AUTHOR)
	MsgBox No data entered!

else 
	MsgBox Check box to search both title and author!
	


return
}





WC:
{
Gui, Submit, NoHide



if NUMBER
	run http://www.worldcat.org/search?q=bn:%NUMBER%&qt=advanced&dblist=638
else if TITLE and !AUTHOR
	{
		TITLETRIM := Trim(TITLE)
		StringReplace, TITLEPLUS, TITLETRIM, %A_SPACE%, +, All
		StringReplace, TITLENOPERCENT, TITLEPLUS, `%, "`%25", All
		
		If EXACT = 1
			run http://www.worldcat.org/search?q=ti`%3A`%22%TITLENOPERCENT%`%22&qt=advanced&dblist=638

		else run http://www.worldcat.org/search?q=ti`%3A%TITLENOPERCENT%&qt=advanced&dblist=638

	}
		
else if AUTHOR and !TITLE
	{
		AUTHORTRIM := Trim(AUTHOR)
		StringReplace, AUTHORPLUS, AUTHORTRIM, %A_SPACE%, +, All
		;StringReplace, AUTHORWITHCOMMA, AUTHORPLUS, `,, "`%2C", All
		
		If EXACTAUTH = 1
			run http://www.worldcat.org/search?q=au`%3A`%22%AUTHORPLUS%`%22&qt=advanced&dblist=638

		else run http://www.worldcat.org/search?q=au`%3A%AUTHORPLUS%&qt=advanced&dblist=638
		
	}

else if AUTH_TITLE
	{
		TITLETRIM := Trim(TITLE)
		StringReplace, TITLEPLUS, TITLETRIM, %A_SPACE%, +, All
		StringReplace, TITLENOPERCENT, TITLEPLUS, `%, "`%25", All
			
		
		AUTHORTRIM := Trim(AUTHOR)
		StringReplace, AUTHORPLUS, AUTHORTRIM, %A_SPACE%, +, All
		;StringReplace, AUTHORWITHCOMMA, AUTHORPLUS, `,, "`%2C", All
		
		if (EXACTAUTH = 1 and EXACT = 1) 
			run http://www.worldcat.org/search?q=ti`%3A`%22%TITLENOPERCENT%`%22+au`%3A`%22%AUTHORPLUS%`%22&qt=advanced&dblist=638
		else if (EXACTAUTH = 1 and EXACT = 0) 
			run http://www.worldcat.org/search?q=ti`%3A%TITLENOPERCENT%+au`%3A`%22%AUTHORPLUS%`%22&qt=advanced&dblist=638		
		else if (EXACTAUTH = 0 and EXACT = 1) 
			run http://www.worldcat.org/search?q=ti`%3A`%22%TITLENOPERCENT%`%22+au`%3A%AUTHORPLUS%&qt=advanced&dblist=638	
					
		else run http://www.worldcat.org/search?q=ti`%3A%TITLENOPERCENT%+au`%3A%AUTHORPLUS%&qt=advanced&dblist=638

	}

	
else if (!NUMBER and !TITLE and !AUTHOR)
	MsgBox No data entered!

else 
	MsgBox Check box to search both title and author!
	


return
}




BIP:
{
Gui, Submit, NoHide



if NUMBER
	run http://www.booksinprint.com.ezproxy.hclib.org/Search/Results?q=isbn=[`%22%NUMBER%`%22]+&ast=pr
else if TITLE and !AUTHOR
	{
		TITLETRIM := Trim(TITLE)
		StringReplace, TITLEPLUS, TITLETRIM, %A_SPACE%, +, All
		StringReplace, TITLENOPERCENT, TITLEPLUS, `%, "`%25", All
		
		If EXACT = 1
			run http://www.booksinprint.com.ezproxy.hclib.org/Search/Results?q=title-exact=[`%22%TITLENOPERCENT%`%22]+&ast=pr
		else run http://www.booksinprint.com.ezproxy.hclib.org/Search/Results?q=title-kw=[%TITLENOPERCENT%]+&ast=pr
	}
		
else if AUTHOR and !TITLE
	{
		AUTHORTRIM := Trim(AUTHOR)
		StringReplace, AUTHORPLUS, AUTHORTRIM, %A_SPACE%, +, All
		;StringReplace, AUTHORWITHCOMMA, AUTHORPLUS, `,, "`%2C", All
		
		If EXACTAUTH = 1
			run http://www.booksinprint.com.ezproxy.hclib.org/Search/Results?q=author=[`%22%AUTHORPLUS%`%22]+&ast=pr
		else run http://www.booksinprint.com.ezproxy.hclib.org/Search/Results?q=author=[%AUTHORPLUS%]+&ast=pr
	}

else if AUTH_TITLE
	{
		TITLETRIM := Trim(TITLE)
		StringReplace, TITLEPLUS, TITLETRIM, %A_SPACE%, +, All
		StringReplace, TITLENOPERCENT, TITLEPLUS, `%, "`%25", All
			
		
		AUTHORTRIM := Trim(AUTHOR)
		StringReplace, AUTHORPLUS, AUTHORTRIM, %A_SPACE%, +, All
		;StringReplace, AUTHORWITHCOMMA, AUTHORPLUS, `,, "`%2C", All
		
		if (EXACTAUTH = 1 and EXACT = 1) 
			run http://www.booksinprint.com.ezproxy.hclib.org/Search/Results?q=author=[`%22%AUTHORPLUS%`%22]+AND+title-exact-rcl=[`%22%TITLENOPERCENT%`%22]+&ast=pr
		
		else if (EXACTAUTH = 1 and EXACT = 0) 
			run http://www.booksinprint.com.ezproxy.hclib.org/Search/Results?q=author=[`%22%AUTHORPLUS%`%22]+AND+title-kw=[%TITLENOPERCENT%]+&ast=pr
			
		else if (EXACTAUTH = 0 and EXACT = 1) 
			run http://www.booksinprint.com.ezproxy.hclib.org/Search/Results?q=author=[%AUTHORPLUS%]+AND+title-exact=[`%22%TITLENOPERCENT%`%22]+&ast=pr
	
					
		else run http://www.booksinprint.com.ezproxy.hclib.org/Search/Results?q=author=[%AUTHORPLUS%]+AND+title-kw=[%TITLENOPERCENT%]+&ast=pr
	}

	
else if (!NUMBER and !TITLE and !AUTHOR)
	MsgBox No data entered!

else 
	MsgBox Check box to search both title and author!
	


return
}





EBSCO:
{
Gui, Submit, NoHide



if NUMBER
	run http://mctproxy.mnpals.net/login?url=http://search.ebscohost.com/login.aspx?direct=true&site=ehost-live&scope=site&type=1&db=e000xna&mode=or&lang=en&bquery=IB+%NUMBER%
else if TITLE and !AUTHOR
	{
		TITLETRIM := Trim(TITLE)
		StringReplace, TITLEPLUS, TITLETRIM, %A_SPACE%, +, All
		StringReplace, TITLENOPERCENT, TITLEPLUS, `%, "`%25", All
		
		If EXACT = 1
			run http://mctproxy.mnpals.net/login?url=http://search.ebscohost.com/login.aspx?direct=true&site=ehost-live&scope=site&type=1&db=e000xna&mode=or&lang=en&bquery=TI+`%22%TITLENOPERCENT%`%22

		else run http://mctproxy.mnpals.net/login?url=http://search.ebscohost.com/login.aspx?direct=true&site=ehost-live&scope=site&type=1&db=e000xna&mode=or&lang=en&bquery=TI+%TITLENOPERCENT%

	}
		
else if AUTHOR and !TITLE
	{
		AUTHORTRIM := Trim(AUTHOR)
		StringReplace, AUTHORPLUS, AUTHORTRIM, %A_SPACE%, +, All
		;StringReplace, AUTHORWITHCOMMA, AUTHORPLUS, `,, "`%2C", All
		
		If EXACTAUTH = 1
			run http://mctproxy.mnpals.net/login?url=http://search.ebscohost.com/login.aspx?direct=true&site=ehost-live&scope=site&type=1&db=e000xna&mode=or&lang=en&bquery=AU+`%22%AUTHORPLUS%`%22

		else run http://mctproxy.mnpals.net/login?url=http://search.ebscohost.com/login.aspx?direct=true&site=ehost-live&scope=site&type=1&db=e000xna&mode=or&lang=en&bquery=AU+%AUTHORPLUS%

	}

else if AUTH_TITLE
	{
		TITLETRIM := Trim(TITLE)
		StringReplace, TITLEPLUS, TITLETRIM, %A_SPACE%, +, All
		StringReplace, TITLENOPERCENT, TITLEPLUS, `%, "`%25", All
			
		
		AUTHORTRIM := Trim(AUTHOR)
		StringReplace, AUTHORPLUS, AUTHORTRIM, %A_SPACE%, +, All
		;StringReplace, AUTHORWITHCOMMA, AUTHORPLUS, `,, "`%2C", All
		
		if (EXACTAUTH = 1 and EXACT = 1) 
			run http://mctproxy.mnpals.net/login?url=http://search.ebscohost.com/login.aspx?direct=true&site=ehost-live&scope=site&type=1&db=e000xna&mode=or&lang=en&bquery=(TI+`%22%TITLENOPERCENT%`%22)+AND+(AU+`%22%AUTHORPLUS%`%22)

		
		else if (EXACTAUTH = 1 and EXACT = 0) 
			run http://mctproxy.mnpals.net/login?url=http://search.ebscohost.com/login.aspx?direct=true&site=ehost-live&scope=site&type=1&db=e000xna&mode=or&lang=en&bquery=(TI+%TITLENOPERCENT%)+AND+(AU+`%22%AUTHORPLUS%`%22)
			
		else if (EXACTAUTH = 0 and EXACT = 1) 
			run http://mctproxy.mnpals.net/login?url=http://search.ebscohost.com/login.aspx?direct=true&site=ehost-live&scope=site&type=1&db=e000xna&mode=or&lang=en&bquery=(TI+`%22%TITLENOPERCENT%`%22)+AND+(AU+%AUTHORPLUS%)

	
					
		else run http://mctproxy.mnpals.net/login?url=http://search.ebscohost.com/login.aspx?direct=true&site=ehost-live&scope=site&type=1&db=e000xna&mode=or&lang=en&bquery=(TI+%TITLENOPERCENT%)+AND+(AU+%AUTHORPLUS%)

	}

	
else if (!NUMBER and !TITLE and !AUTHOR)
	MsgBox No data entered!

else 
	MsgBox Check box to search both title and author!
	


return
}







CHOICE:
{
Gui, Submit, NoHide



if NUMBER

	{
			NUMBERTRIM := Trim(NUMBER)
			StringReplace, NUMBERNODASH, NUMBERTRIM, -, , All
			run http://www.choicereviews.org/search?p=1&totalPages=1&reviewer=&exactauthor=&q=&title=&author=&publisher=&lcstart=&yearstart=&and=&phrase=%NUMBERNODASH%&or=&not=&issueyr=&issuevol=&issuenum=&order1=
	
	}

else if TITLE and !AUTHOR
	{
		TITLETRIM := Trim(TITLE)
		StringReplace, TITLEPLUS, TITLETRIM, %A_SPACE%, +, All
		StringReplace, TITLENOPERCENT, TITLEPLUS, `%, "`%25", All
		
		If EXACT = 1
			run http://www.choicereviews.org/search?p=1&totalPages=1&reviewer=&exactauthor=&q=&title=&author=&publisher=&lcstart=&yearstart=&and=&phrase=%TITLENOPERCENT%&or=&not=&issueyr=&issuemo=&issuevol=&issuenum=&primary_sort=approvedForApiDate_dt&order1=1&secondary_sort=&rpp=25
		else run http://www.choicereviews.org/search?p=1&totalPages=1&reviewer=&exactauthor=&q=&title=%TITLENOPERCENT%&author=&publisher=&lcstart=&yearstart=&and=&phrase=&or=&not=&issueyr=&issuemo=&issuevol=&issuenum=&primary_sort=approvedForApiDate_dt&order1=1&secondary_sort=&rpp=25
		

	}
		
else if AUTHOR and !TITLE
	{
		AUTHORTRIM := Trim(AUTHOR)
		StringReplace, AUTHORPLUS, AUTHORTRIM, %A_SPACE%, +, All
		;StringReplace, AUTHORWITHCOMMA, AUTHORPLUS, `,, "`%2C", All
		
		If EXACTAUTH = 1
			run http://www.choicereviews.org/search?p=1&totalPages=1&reviewer=&exactauthor=&q=&title=&author=`%22%AUTHORPLUS%`%22&publisher=&lcstart=&yearstart=&and=&phrase=&or=&not=&issueyr=&issuemo=&issuevol=&issuenum=&primary_sort=approvedForApiDate_dt&order1=1&secondary_sort=&rpp=25
		else run http://www.choicereviews.org/search?p=1&totalPages=1&reviewer=&exactauthor=&q=&title=&author=%AUTHORPLUS%&publisher=&lcstart=&yearstart=&and=&phrase=&or=&not=&issueyr=&issuemo=&issuevol=&issuenum=&primary_sort=approvedForApiDate_dt&order1=1&secondary_sort=&rpp=25
		
		
	}

else if AUTH_TITLE
	{
		TITLETRIM := Trim(TITLE)
		StringReplace, TITLEPLUS, TITLETRIM, %A_SPACE%, +, All
		StringReplace, TITLENOPERCENT, TITLEPLUS, `%, "`%25", All
			
		
		AUTHORTRIM := Trim(AUTHOR)
		StringReplace, AUTHORPLUS, AUTHORTRIM, %A_SPACE%, +, All
		;StringReplace, AUTHORWITHCOMMA, AUTHORPLUS, `,, "`%2C", All
		
		if (EXACTAUTH = 1 and EXACT = 1) 
			run http://www.choicereviews.org/search?p=1&totalPages=1&reviewer=&exactauthor=&q=&title=`%22%TITLENOPERCENT%`%22&author=`%22%AUTHORPLUS%`%22&publisher=&lcstart=&yearstart=&and=&phrase=&or=&not=&issueyr=&issuemo=&issuevol=&issuenum=&primary_sort=approvedForApiDate_dt&order1=1&secondary_sort=&rpp=25

		else if (EXACTAUTH = 1 and EXACT = 0) 
			run http://www.choicereviews.org/search?p=1&totalPages=1&reviewer=&exactauthor=`%22%AUTHORPLUS%`%22&q=&title=%TITLENOPERCENT%&author=&publisher=&lcstart=&yearstart=&and=&phrase=&or=&not=&issueyr=&issuemo=&issuevol=&issuenum=&primary_sort=approvedForApiDate_dt&order1=1&secondary_sort=&rpp=25
	
		else if (EXACTAUTH = 0 and EXACT = 1) 
			run http://www.choicereviews.org/search?p=1&totalPages=1&reviewer=&exactauthor=&q=&title=`%22%TITLENOPERCENT%`%22&author=%AUTHORPLUS%&publisher=&lcstart=&yearstart=&and=&phrase=&or=&not=&issueyr=&issuemo=&issuevol=&issuenum=&primary_sort=approvedForApiDate_dt&order1=1&secondary_sort=&rpp=25

					
		else run http://www.choicereviews.org/search?p=1&totalPages=1&reviewer=&exactauthor=&q=&title=%TITLENOPERCENT%&author=%AUTHORPLUS%&publisher=&lcstart=&yearstart=&and=&phrase=&or=&not=&issueyr=&issuemo=&issuevol=&issuenum=&primary_sort=approvedForApiDate_dt&order1=1&secondary_sort=&rpp=25


	}

	
else if (!NUMBER and !TITLE and !AUTHOR)
	MsgBox No data entered!

else 
	MsgBox Check box to search both title and author!
	


return
}













CLEAR:

{

GuiControl,, NUMBER,
GuiControl,, TITLE,
GuiControl,, AUTHOR,
GuiControl,, EXACT,0
GuiControl,, EXACTAUTH,0
GuiControl,, AUTH_TITLE,0
GuiControl,, URLResources,0

return

}


EXIT:

{

GuiClose: 
ExitApp

}	


^!c::

#SingleInstance force


clipboard = ; Empty the clipboard
Send,^a
Sleep 100
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
			
				{
				
					if URLResources
						Run https://mctc.mplus.mnpals.net/vufind/Search/Results?lookfor= %FullSearchCallNumber%&type=CallNumber&submit=Find&limit=20&sort=relevance&mylocn=MCT&filter`%5B`%5D=format`%3A"URL+Resource"
			
					else Run https://mctc.mplus.mnpals.net/vufind/Search/Results?lookfor= %FullSearchCallNumber%&type=CallNumber&submit=Find&limit=20&sort=relevance&mylocn=MCT
				
				}
			
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



^!h::

#SingleInstance force

clipboard = ; Empty the clipboard
Send,^a
Sleep 100
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
	
			if URLResources
				{
					Run https://mctc.mplus.mnpals.net/vufind/Search/Results?lookfor=`%22%SubHeadText%`%22&type=Subject&submit=Find&limit=20&sort=relevance&mylocn=MCT&filter`%5B`%5D=format`%3A"URL+Resource"
					Sleep, 2000 
			
				}
		
			else 
				{
		    		Run https://mctc.mplus.mnpals.net/vufind/Search/Results?lookfor=`%22%SubHeadText%`%22&type=Subject&submit=Find&limit=20&sort=relevance&mylocn=MCT
					Sleep, 2000 
			
				}	
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



^!t::

#SingleInstance force

clipboard = ; Empty the clipboard
Send,^a
Sleep 100
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
			if URLResources
				{
		
					StringReplace, NoPercentTitle, CleanFullTitle, `%, "`%25", All
					Run https://mctc.mplus.mnpals.net/vufind/Search/Results?lookfor=`%22%NoPercentTitle%`%22&type=Title&submit=Find&limit=20&sort=relevance&mylocn=MCT&filter`%5B`%5D=format`%3A"URL+Resource"
					exit
				}
		
			else
				
				{
		
					StringReplace, NoPercentTitle, CleanFullTitle, `%, "`%25", All
					Run https://mctc.mplus.mnpals.net/vufind/Search/Results?lookfor=`%22%NoPercentTitle%`%22&type=Title&submit=Find&limit=20&sort=relevance&mylocn=MCT
					exit
				}
				
		}
		
	IfMsgBox No
		{
    			MsgBox You pressed No.		
				exit
	
		}

	IfMsgBox Cancel
		exit	


^!s::

#SingleInstance force


clipboard = ; Empty the clipboard
Send,^a
Sleep 100
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
	
