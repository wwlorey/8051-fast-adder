		ORG 0000H

		MOV A, #0
		MOV P1, A		; Set Port 1 to output

		MOV A, #0FFH
		MOV P1, A

LOOP:	SJMP LOOP		; Infinite loop prevents program from reading forbidden memory

		END