#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; capture title string from clipboard and replace spaces with + signs, then insert below for TITLE
; problem: % sign has special use in autohotkey (figure out how to hard code it?)

#SingleInstance force

;============================
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance force

; Alt t hotkey





!t::
clipboard = ; Empty the clipboard
Send,^a
Send,^c
ClipWait, 2
clip = %clipboard%
ClipWait, 2
Send {Click}


RclTitle = "null title" 
TitleStart = 0
TitleEnd = 0


;TitleStart:=InStr(clip, "Title:")

;MsgBox %TitleStart%

;TitleEnd:=InStr(clip, "Author:")

;MsgBox %TitleEnd%

;RclTitle:=SubStr(clip, TitleStart+7, TitleEnd-TitleStart-7)

;MsgBox %RclTitle%


;global RecLines

;Sort clip

;StringSplit, RecLines, clip, `n

;MsgBox %RecLines0% "Lines Split from Clipboard Text"

;MsgBox %clip%

;FindString="Stock Availability"

;global FindString
;global RclTitle

Loop, parse, clip, `n
{
	
	
	LineNumber = %A_Index% 
	LineText = %A_LoopField%
	;MsgBox %LineNumber% %LineText%
	
	
	FirstPosition := InStr(LineText, "Stock Availability")

	If FirstPosition <> 0
		
	{
		StringTrimLeft, RclTitle, LineText, 18
		MsgBox Full Title is: %RclTitle%
		
		SecondPosition := InStr(RclTitle, "Author")
		
		If SecondPosition <> 0

			{

				RclTitleMinusSub := SubStr(RclTitle, 1, SecondPosition-6)
				MsgBox Short Title is: %RclTitleMinusSub%
				
				
				TitleWithOutPlusSigns = %RclTitleMinusSub%
				TitleWithPlusSigns = %TitleWithOutPlusSigns%

				StringReplace, TitleWithPlusSigns, TitleWithOutPlusSigns, %A_SPACE%, +, All

					
				break
			}

		

		TitleWithOutPlusSigns = %RclTitle%
		TitleWithPlusSigns = %TitleWithOutPlusSigns%

		StringReplace, TitleWithPlusSigns, TitleWithOutPlusSigns, %A_SPACE%, +, All


		break
	}

}


url1 := "https://mnpals-mct.primo.exlibrisgroup.com/discovery/search?query=title,exact," . TitleWithPlusSigns . ",AND&tab=Physical_library_slot&search_scope=Physical_library_scope&sortby=rank&vid=01MNPALS_MCT`%3AMCT&mode=advanced&offset=0"
Run firefox.exe "%url1%"
			

clipboard =
ClipWait, 2



