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
CleanRclTitle = "null title"

TitleStart:=InStr(clip, "About the Author")

MsgBox Title start position is %TitleStart%

TitleEnd:=InStr(clip, "Reader Reviews")

MsgBox TItle end position is %TitleEnd%

RclTitle:=SubStr(clip, TitleStart+16, TitleEnd-TitleStart-16)

;CleanRclTitle:=TRIM(RclTitle)

MsgBox %RclTitle%

StringReplace, RclTitleWithPlusSigns, CleanRclTitle, %A_SPACE%, +, All

;url1 := "https://mnpals-mct.primo.exlibrisgroup.com/discovery/search?query=title,exact," . RclTitleWithPlusSigns . ",AND&tab=Physical_library_slot&search_scope=Physical_library_scope&sortby=rank&vid=01MNPALS_MCT`%3AMCT&mode=advanced&offset=0"
;Run firefox.exe "%url1%"
			

clipboard =
ClipWait, 2



