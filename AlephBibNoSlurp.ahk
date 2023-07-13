#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; capture title string from clipboard and replace spaces with + signs, then insert below for TITLE
; problem: % sign has special use in autohotkey (figure out how to hard code it?)

#SingleInstance force

#c::


TitleWithOutPlusSigns = %clipboard%
TitleWithPlusSigns = %TitleWithOutPlusSigns%

StringReplace, TitleWithPlusSigns, TitleWithOutPlusSigns, %A_SPACE%, +, All


Run http://minneapolis.mnpals.net/F/?func=find-c&local_base=mct_cat&ccl_term=wti`%3D%TitleWithPlusSigns%


clipboard =
ClipWait, 2

