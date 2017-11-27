;Carry Propagate, Carry Generate, and C1 Terms
;A and B register bits
C0 EQU 00H
C1 EQU 01H
C2 EQU 02h
C3 EQU 03H
C4 EQU 04H
C5 EQU 05H
C6 EQU 06H
C7 EQU 07H
C8 EQU 08H

G0 EQU 09H
G1 EQU 0AH
G2 EQU 0BH
G3 EQU 0CH 
G4 EQU 0DH
G5 EQU 0EH 
G6 EQU 0FH 
G7 EQU 10H

P0 EQU 11H
P1 EQU 12H
P2 EQU 13H 
P3 EQU 14H
P4 EQU 15H
P5 EQU 16H
P6 EQU 17H
P7 EQU 18H
P8 EQU 19H

A_0 EQU 0EOH
A_1 EQU 0E1H
A_2 EQU 0E2H
A_3 EQU 0E3H
A_4 EQU 0E4H
A_5 EQU 0E5H
A_6 EQU 0E6H
A_7 EQU 0E7H

B_0 EQU 0F0H
B_1 EQU 0F1H
B_2 EQU 0F2H
B_3 EQU 0F3H
B_4 EQU 0F4H
B_5 EQU 0F5H
B_6 EQU 0F6H
B_7 EQU 0F7H

;placeholder values for now
MOV A, #69H
MOV B, #42H

///////////////sets registers to hold address values

;/////////Carry Generation/////////////////////////////////
;calculates carry generate terms
;   bit 1
		CLR C
		MOV C, A_0 
		ANL C, B_0
		MOV G0, C
;   bit 2
		CLR C
		MOV C, A_1 
		ANL C, B_1
		MOV G1, C
;   bit 3
		CLR C
		MOV C, A_2 
		ANL C, B_2
		MOV G2, C
;   bit 4
		CLR C
		MOV C, A_3
		ANL C, B_3
		MOV G3, C
;   bit 5
		CLR C
		MOV C, A_4 
		ANL C, B_4
		MOV G4, C
;   bit 6
		CLR C
		MOV C, A_5 
		ANL C, B_5
		MOV G5, C
;   bit 7
		CLR C
		MOV C, A_6
		ANL C, B_6
		MOV G6, C
;   bit 8
		CLR C
		MOV C, A_7
		ANL C, B_7
		MOV G7, C


		
;calculates carry propagate term
; bit 1
		CLR C
		MOV C, A_0
		JNB B_0, OVER1
		CPL C
OVER1:  MOV P0, C
; bit 2
		CLR C
		MOV C, A_1
		JNB B_1, OVER2
		CPL C
OVER2: 	MOV P1, C
; bit 3
		CLR C
		MOV C, A_2
		JNB B_2, OVER3
		CPL C
OVER3:  MOV P2, C
; bit 4
		CLR C
		MOV C, A_3
		JNB B_3, OVER4
		CPL C
OVER4: 	MOV P3, C
; bit 5
		CLR C
		MOV C, A_4
		JNB B_4, OVER5
		CPL C
OVER5:  MOV P4, C
; bit 6
		CLR C
		MOV C, A_5
		JNB B_5, OVER6
		CPL C
OVER6: 	MOV P5, C
; bit 7
		CLR C
		MOV C, A_6
		JNB B_6, OVER7
		CPL C
OVER7:  MOV P6, C
; bit 8
		CLR C
		MOV C, A_7
		JNB B_7, OVER8
		CPL C
OVER8: 	MOV P7, C

		
;calculates carry terms
/////////////C0 is 0 to add
        MOV C, #0H
		MOV C0, C
		
; C1 term = G0 + P0C0
    	CLR C
		MOV C, G0
		MOV C1, C
		CLR C
		MOV C, P0
		ANL C, C0
		ORL C, C1
		MOV C1, C

;C2 term = G1 + G0P1 + C0P0P1
		CLR C
		MOV C, G1
		MOV C2, C
		CLR C
		MOV C, G0
		ANL C, P1
		ORL C, C2
		MOV C2, C
		CLR C
		MOV C, P0
		ANL C, P1
		ANL C, C0
		ORL C, C2
		MOV C2, C
		
;C3 term = G2 + G1P2 + G0P1P2 + C0P0P1P2
		CLR C
		MOV C, G2
		MOV C3, C
		CLR C
		MOV C, G1
		ANL C, P2
		ORL C, C3
		MOV C3, C
		CLR C
		MOV C, P1
		ANL C, P2
		ANL C, G0
		ORL C, C3
		MOV C3, C
		CLR C
		MOV C, P0
		ANL C, P1
		ANL C, P2
		ANL C, C0
		ORL C, C3
		MOV C3, C
		
;C4 term = G3 + G2P3 + G1P2P3 + G0P1P2P3 + C0P0P1P2P3
		CLR C
		MOV C, G3
		MOV C4, C
		CLR C
		MOV C, G2
		ANL C, P3
		ORL C, C4
		MOV C4, C
		CLR C
		MOV C, P2
		ANL C, P3
		ANL C, G1
		ORL C, C4
		MOV C4, C
		CLR C
		MOV C, P1
		ANL C, P2
		ANL C, P3
		ANL C, G0
		ORL C, C4
		MOV C4, C
		CLR C		
		MOV C, P0
		ANL C, P1
		ANL C, P2
		ANL C, P3
		ANL C, C0
		ORL C, C4
		MOV C4, C
		
;C5 term = G4 + G3P4 + G2P3P4 + G1P2P3P4 + G0P1P2P3P4 + C0P0P1P2P3P4P5
		CLR C
		MOV C, G4
		MOV C5, C
		CLR C
		MOV C, G3
		ANL C, P4
		ORL C, C5
		MOV C5, C
		CLR C
		MOV C, P3
		ANL C, P4
		ANL C, G2
		ORL C, C5
		MOV C5, C
		CLR C
		MOV C, P2
		ANL C, P3
		ANL C, P4
		ANL C, G1
		ORL C, C5
		MOV C5, C
		CLR C		
		MOV C, P0
		ANL C, P1
		ANL C, P2
		ANL C, P3
		ANL C, P4
		ANL C, C0
		ORL C, C5
		MOV C5, C
		
;C6 term = G5 + G4P5 + G3P4P5 + G2P3P4P5 + G1P2P3P4P5 + G0P1P2P3P4P5 + C0P0P1P2P3P4P5
		CLR C
		MOV C, G5
		MOV C6, C
		CLR C
		MOV C, G4
		ANL C, P5
		ORL C, C6
		MOV C6, C
		CLR C
		MOV C, P4
		ANL C, P5
		ANL C, G3
		ORL C, C6
		MOV C6, C
		CLR C
		MOV C, P3
		ANL C, P4
		ANL C, P5
		ANL C, G2
		ORL C, C6
		MOV C6, C
		CLR C		
		MOV C, P2
		ANL C, P3
		ANL C, P4
		ANL C, P5
		ANL C, G1
		ORL C, C6
		MOV C6, C
		CLR C
		MOV C, P0
		ANL C, P1
		ANL C, P2
		ANL C, P3
		ANL C, P4
		ANL C, P5
		ANL C, C0
		ORL C, C6
		MOV C6, C
		
;C7 term = G6 + G5P6 + G4P5P6 + G3P4P5P6 + G2P3P4P5P6 + G1P2P3P4P5P6 + G0P1P2P3P4P5P6 + C0P0P1P2P3P4P5P6
		CLR C
		MOV C, G6
		MOV C7, C
		CLR C
		MOV C, G5
		ANL C, P6
		ORL C, C7
		MOV C7, C
		CLR C
		MOV C, P5
		ANL C, P6
		ANL C, G4
		ORL C, C7
		MOV C7, C
		CLR C
		MOV C, P4
		ANL C, P5
		ANL C, P6
		ANL C, G3
		ORL C, C7
		MOV C7, C
		CLR C		
		MOV C, P3
		ANL C, P4
		ANL C, P5
		ANL C, P6
		ANL C, G2
		ORL C, C7
		MOV C7, C
		CLR C
		MOV C, P2
		ANL C, P3
		ANL C, P4
		ANL C, P5
		ANL C, P6
		ANL C, G1
		ORL C, C7
		MOV C7, C
		CLR C
		MOV C, P0
		ANL C, P1
		ANL C, P2
		ANL C, P3
		ANL C, P4
		ANL C, P5
		ANL C, P6
		ANL C, C0
		ORL C, C7
		MOV C7, C
		
		
;///////////////SUM/////////////////////////////////////
		CLR COUNT
		MOV COUNT, #8
START:	MOV C, P0
		
;XOR P1 with Cin to generate sum	
;store C0 to RAM location 20H(bit address 00H)
SKIP:	JNB C0 , NEXT
		CPL C

;Moves Sum into bit 1 of A
NEXT:   MOV A_0, C

		INC P0
		INC A_0
		DJNZ COUNT, START
