#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance force


!e::


InputBox, UserInput, Scan ISBN, , 640, 480
if ErrorLevel
    MsgBox, CANCEL was pressed.
else
    run http://classify.oclc.org/classify2/ClassifyDemo?search-standnum-txt=%UserInput%&startRec=0


clipboard =
ClipWait, 2



!r::	

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
	;MsgBox %LineNumber% %LineText%
	
	
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

		
		;MsgBox First Two Letters %FirstTwoLetters%
		;MsgBox First Position %FirstPosition%
		;MsgBox Second Position %SecondPosition%

;specific call number ranges tested first



		if FirstTwoLetters = BF 
		{

			MsgBox Call Number is: %CallNumberLineArray2%
			MsgBox jenny!
			break

		}

		if FirstTwoLetters = PN 
		{

			MsgBox Call Number is: %CallNumberLineArray2%
			MsgBox If about Theater or Cinema, then jenny! If about Journalism or Broadcasting, then TOM!
			break

		}

		if FirstTwoLetters in TT,TX
		{

			MsgBox Call Number is: %CallNumberLineArray2%
			MsgBox JANE!
			break

		}


		if FirstTwoLetters in GV,QM,QP,QR,TD,TS,TR
		{

			MsgBox Call Number is: %CallNumberLineArray2%
			MsgBox KATHLEEN!
			break

		}
		
		if FirstTwoLetters = HX 
		{

			MsgBox Call Number is: %CallNumberLineArray2%
			MsgBox TOM!
			break

		}



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


		if FirstTwoLetters between PA and PM 
		{

			MsgBox Call Number is: %CallNumberLineArray2%
			MsgBox jenny!
			break

		}

		if FirstTwoLetters between PQ and PZ 
		{

			MsgBox Call Number is: %CallNumberLineArray2%
			MsgBox jenny!
			break

		}



;bill

		
		if FirstPosition = B
		{
			MsgBox Call Number is: %CallNumberLineArray2%
			MsgBox BILL!
			break
			
		}

		if FirstTwoLetters between BA and BD 
		{

			MsgBox Call Number is: %CallNumberLineArray2%
			MsgBox BILL!
			break

		}

		if FirstTwoLetters between BH and BJ 
		{

			MsgBox Call Number is: %CallNumberLineArray2%
			MsgBox BILL!
			break

		}


		if FirstTwoLetters between BL and BX 
		{

			MsgBox Call Number is: %CallNumberLineArray2%
			MsgBox BILL!
			break

		}


		if FirstPosition = T
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
		

;jane

		if FirstPosition in C,D,E,F,U,V,Z
			
		{
			MsgBox Call Number is: %CallNumberLineArray2%
			MsgBox JANE!
			break
			
		}

		if FirstPosition = G
		{
			MsgBox Call Number is: %CallNumberLineArray2%
			MsgBox JANE!
			break
			
		}



		if FirstTwoLetters between GA and GF 
		{

			MsgBox Call Number is: %CallNumberLineArray2%
			MsgBox JANE!
			break

		}
		
		if FirstTwoLetters between GN and GT 
		{

			MsgBox Call Number is: %CallNumberLineArray2%
			MsgBox JANE!
			break

		}


		if FirstPosition = H
		{
			MsgBox Call Number is: %CallNumberLineArray2%
			MsgBox JANE!
			break
			
		}


		if FirstTwoLetters between HM and HV 
		{

			MsgBox Call Number is: %CallNumberLineArray2%
			MsgBox JANE!
			break

		}


		if FirstTwoLetters between HA and HJ 
		{

			MsgBox Call Number is: %CallNumberLineArray2%
			MsgBox JANE!
			break

		}



;kathleen





		if FirstPosition in A,K,N,Q,R,S
			
		{
			MsgBox Call Number is: %CallNumberLineArray2%
			MsgBox KATHLEEN!
			break
			
		}

		

;tom



		if FirstPosition in L,J
		{
			MsgBox Call Number is: %CallNumberLineArray2%
			MsgBox TOM!
			break
			
		}

		
;if all fails, then file under unknown selector	

		else MsgBox UNKNOWN SELECTOR!

	}


	


}

IfMsgBox, OK
	Send ^w	
