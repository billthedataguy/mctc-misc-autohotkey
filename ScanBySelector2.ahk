#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.

:ScanBySelector V.2 Bill Vann April 2019


SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.





#SingleInstance force

!r::	

clipboard = ; Empty the clipboard
Send,^a
Send,^c
ClipWait, 2
clip = %clipboard%
Send {Click}


CallNumber = "null call number" 
AbortLoop := 
Position := 

Loop, parse, clip, `n
{
	
	
	LineNumber = %A_Index% 
	LineText = %A_LoopField%
	;MsgBox %LineNumber% %LineText%
	
	
	Position := InStr(LineText, "ClassWeb")
	AbortLoop := InStr(LineText, "Sorry, your current search did not return any results")

	If AbortLoop <> 0

	{
		MsgBox No Record in OCLC. File under Unknown Selector!
		clipboard = 
		break
	}

	If Position <> 0
		
	{
		
		StringSplit, CallNumberLineArray, LineText, %A_Tab%

		;MsgBox %LineText%
		;MsgBox %CallNumberLineArray1%
		;MsgBox %CallNumberLineArray2%
		;MsgBox %CallNumberLineArray3%
		;MsgBox %CallNumberLineArray4%
		
		CallNumber = %CallNumberLineArray2%		
		;MsgBox Call number = %CallNumber%
	
		FirstTwoLetters := SubStr(CallNumber, 1, 2)
		FirstPosition := SubStr(CallNumber, 1, 1)		
		SecondPosition := SubStr(CallNumber, 2, 1)

		If SecondPosition is digit
		
		{
			OneLetterOnly = 1
			;MsgBox One Letter Only Asshat! Call # is: %CallNumber%
		}		
		
		Else 

		{
			OneLetterOnly = 0
		}
		
		
		
		
		;MsgBox First Two Letters %FirstTwoLetters%
		;MsgBox First Position %FirstPosition%
		;MsgBox Second Position %SecondPosition%

		

		


;jenny

		

		if FirstPosition = M
		{
			MsgBox Call Number is: %CallNumberLineArray2%
			MsgBox jenny!
			break
			
		}

		
		if FirstPosition = P
		{
			MsgBox Call Number is: %CallNumberLineArray2%
			MsgBox jenny!
			break
			
		}


		if FirstTwoLetters in TT, TX
		{

			MsgBox Call Number is: %CallNumberLineArray2%
			MsgBox jenny!
			break

		}

		if FirstTwoLetters = TR
		{

			MsgBox Call Number is: %CallNumberLineArray2%
			MsgBox TR848 - TR861 (Cinematography) goes to jenny - any other TR goes to KATHLEEN!
			break

		}
		
		



;bill

		
		if FirstPosition = B
		{
			MsgBox Call Number is: %CallNumberLineArray2%
			MsgBox BILL!
			break
			
		}

		
		if FirstPosition = L
		{
			MsgBox Call Number is: %CallNumberLineArray2%
			MsgBox BILL!
			break
			
		}

		
		if FirstPosition = T
		{
			
			if OneLetterOnly = 1
			
			{
			
				MsgBox Call Number is: %CallNumberLineArray2%
				MsgBox BILL!
				break
			}
						
		}

		
		
		if FirstPosition = Z
		{
			MsgBox Call Number is: %CallNumberLineArray2%
			MsgBox BILL!
			break
			
		}



		if FirstTwoLetters between TA and TC 
		{

			MsgBox Call Number is: %CallNumberLineArray2%
			MsgBox BILL!
			break

		}

		if FirstTwoLetters between TE and TP 
		{

			MsgBox Call Number is: %CallNumberLineArray2%
			MsgBox BILL!
			break

		}
		
		if FirstTwoLetters = QA
		{

			MsgBox Call Number is: %CallNumberLineArray2%
			MsgBox BILL!
			break

		}

		
		
		



;kathleen


		if FirstTwoLetters = TD
		{

			MsgBox Call Number is: %CallNumberLineArray2%
			MsgBox KATHLEEN!
			break

		}
		


		if FirstTwoLetters = TS
		{

			MsgBox Call Number is: %CallNumberLineArray2%
			MsgBox KATHLEEN!
			break

		}
		


		if FirstPosition in K,N,R,S
			
		{
			MsgBox Call Number is: %CallNumberLineArray2%
			MsgBox KATHLEEN!
			break
			
		}

		if FirstTwoLetters = GV
		{

			MsgBox Call Number is: %CallNumberLineArray2%
			MsgBox KATHLEEN!
			break

		}
		
		if (FirstPosition = Q and FirstTwoLetters <> QA)
		{

			MsgBox Call Number is: %CallNumberLineArray2%
			MsgBox KATHLEEN!
			break

		}
		
		
		
		
		

;tom



		if FirstPosition in C,D,E,F,H,J
		{
			MsgBox Call Number is: %CallNumberLineArray2%
			MsgBox TOM!
			break
			
		}
		
		
		if FirstPosition = G 
		{
			
			if FirstTwoLetters <> GV
			{
				MsgBox Call Number is: %CallNumberLineArray2%
				MsgBox TOM!
				break
			}
			
			
		}
		
		
		

		
;if all fails, then file under unknown selector	

		else MsgBox UNKNOWN SELECTOR!

	}


	


}

IfMsgBox, OK
	Send ^w	
