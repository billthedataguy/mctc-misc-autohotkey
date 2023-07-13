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

Send {Click}

RclTitle := 0 

TitleStart := 0
TitleEnd := 0


TitleStart:=InStr(clip, "Title:", Occurrence=1)

MsgBox %TitleStart%

;TitleEnd:=InStr(clip, "Author:")

TitleEnd:=InStr(clip, StartingPos=TitleStart, `r)


;If TitleEnd=0

	;TitleEnd:=InStr(clip, "Editor:")


MsgBox %TitleEnd%

RclTitle:=SubStr(clip, TitleStart+7, TitleEnd-TitleStart-7)

;ColonVariable:=" : "

;Position:=InStr(RclTitle, %ColonVariable%)

;If Position<>0
	;RclTitle:=SubStr(clip, TitleStart+7, Position-1)
	

MsgBox %RclTitle% 

clipboard =

clipboard := RclTitle
ClipWait, 2


;============================

TitleWithOutPlusSigns := RclTitle

;MsgBox %TitleWithOutPlusSigns%

TitleWithPlusSigns = %TitleWithOutPlusSigns%

StringReplace, TitleWithPlusSigns, TitleWithOutPlusSigns, %A_SPACE%, +, All


Run http://minneapolis.mnpals.net/F/?func=find-c&local_base=mct_cat&ccl_term=wti`%3D%TitleWithPlusSigns%


clipboard =
ClipWait, 2


