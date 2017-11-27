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

P_0 EQU 11H
P_1 EQU 12H
P_2 EQU 13H 
P_3 EQU 14H
P_4 EQU 15H
P_5 EQU 16H
P_6 EQU 17H
P_7 EQU 18H

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
		MOV C, ACC.0 
		ANL C, B_0
		MOV G0, C
;   bit 2
		CLR C
		MOV C, ACC.1 
		ANL C, B_1
		MOV G1, C
;   bit 3
		CLR C
		MOV C, ACC.2 
		ANL C, B_2
		MOV G2, C
;   bit 4
		CLR C
		MOV C, ACC.3
		ANL C, B_3
		MOV G3, C
;   bit 5
		CLR C
		MOV C, ACC.4 
		ANL C, B_4
		MOV G4, C
;   bit 6
		CLR C
		MOV C, ACC.5 
		ANL C, B_5
		MOV G5, C
;   bit 7
		CLR C
		MOV C, ACC.6
		ANL C, B_6
		MOV G6, C
;   bit 8
		CLR C
		MOV C, ACC.7
		ANL C, B_7
		MOV G7, C


		
;calculates carry propagate term
; bit 1
		CLR C
		MOV C, ACC.0
		JNB B_0, OVER1
		CPL C
OVER1:  MOV P_0, C
; bit 2
		CLR C
		MOV C, ACC.1
		JNB B_1, OVER2
		CPL C
OVER2: 	MOV P_1, C
; bit 3
		CLR C
		MOV C, ACC.2
		JNB B_2, OVER3
		CPL C
OVER3:  MOV P_2, C
; bit 4
		CLR C
		MOV C, ACC.3
		JNB B_3, OVER4
		CPL C
OVER4: 	MOV P_3, C
; bit 5
		CLR C
		MOV C, ACC.4
		JNB B_4, OVER5
		CPL C
OVER5:  MOV P_4, C
; bit 6
		CLR C
		MOV C, ACC.5
		JNB B_5, OVER6
		CPL C
OVER6: 	MOV P_5, C
; bit 7
		CLR C
		MOV C, ACC.6
		JNB B_6, OVER7
		CPL C
OVER7:  MOV P_6, C
; bit 8
		CLR C
		MOV C, ACC.7
		JNB B_7, OVER8
		CPL C
OVER8: 	MOV P_7, C

		
;calculates carry terms
/////////////C0 is 0 to add
        CLR C
		MOV C0, C
		
; C1 term = G0 + P_0C0
    	CLR C
		MOV C, G0
		MOV C1, C
		CLR C
		MOV C, P_0
		ANL C, C0
		ORL C, C1
		MOV C1, C

;C2 term = G1 + G0P_1 + C0P_0P_1
		CLR C
		MOV C, G1
		MOV C2, C
		CLR C
		MOV C, G0
		ANL C, P_1
		ORL C, C2
		MOV C2, C
		CLR C
		MOV C, P_0
		ANL C, P_1
		ANL C, C0
		ORL C, C2
		MOV C2, C
		
;C3 term = G2 + G1P_2 + G0P_1P_2 + C0P_0P_1P_2
		CLR C
		MOV C, G2
		MOV C3, C
		CLR C
		MOV C, G1
		ANL C, P_2
		ORL C, C3
		MOV C3, C
		CLR C
		MOV C, P_1
		ANL C, P_2
		ANL C, G0
		ORL C, C3
		MOV C3, C
		CLR C
		MOV C, P_0
		ANL C, P_1
		ANL C, P_2
		ANL C, C0
		ORL C, C3
		MOV C3, C
		
;C4 term = G3 + G2P_3 + G1P_2P_3 + G0P_1P_2P_3 + C0P_0P_1P_2P_3
		CLR C
		MOV C, G3
		MOV C4, C
		CLR C
		MOV C, G2
		ANL C, P_3
		ORL C, C4
		MOV C4, C
		CLR C
		MOV C, P_2
		ANL C, P_3
		ANL C, G1
		ORL C, C4
		MOV C4, C
		CLR C
		MOV C, P_1
		ANL C, P_2
		ANL C, P_3
		ANL C, G0
		ORL C, C4
		MOV C4, C
		CLR C		
		MOV C, P_0
		ANL C, P_1
		ANL C, P_2
		ANL C, P_3
		ANL C, C0
		ORL C, C4
		MOV C4, C
		
;C5 term = G4 + G3P_4 + G2P_3P_4 + G1P_2P_3P_4 + G0P_1P_2P_3P_4 + C0P_0P_1P_2P_3P_4P_5
		CLR C
		MOV C, G4
		MOV C5, C
		CLR C
		MOV C, G3
		ANL C, P_4
		ORL C, C5
		MOV C5, C
		CLR C
		MOV C, P_3
		ANL C, P_4
		ANL C, G2
		ORL C, C5
		MOV C5, C
		CLR C
		MOV C, P_2
		ANL C, P_3
		ANL C, P_4
		ANL C, G1
		ORL C, C5
		MOV C5, C
		CLR C		
		MOV C, P_0
		ANL C, P_1
		ANL C, P_2
		ANL C, P_3
		ANL C, P_4
		ANL C, C0
		ORL C, C5
		MOV C5, C
		
;C6 term = G5 + G4P_5 + G3P_4P_5 + G2P_3P_4P_5 + G1P_2P_3P_4P_5 + G0P_1P_2P_3P_4P_5 + C0P_0P_1P_2P_3P_4P_5
		CLR C
		MOV C, G5
		MOV C6, C
		CLR C
		MOV C, G4
		ANL C, P_5
		ORL C, C6
		MOV C6, C
		CLR C
		MOV C, P_4
		ANL C, P_5
		ANL C, G3
		ORL C, C6
		MOV C6, C
		CLR C
		MOV C, P_3
		ANL C, P_4
		ANL C, P_5
		ANL C, G2
		ORL C, C6
		MOV C6, C
		CLR C		
		MOV C, P_2
		ANL C, P_3
		ANL C, P_4
		ANL C, P_5
		ANL C, G1
		ORL C, C6
		MOV C6, C
		CLR C
		MOV C, P_0
		ANL C, P_1
		ANL C, P_2
		ANL C, P_3
		ANL C, P_4
		ANL C, P_5
		ANL C, C0
		ORL C, C6
		MOV C6, C
		
;C7 term = G6 + G5P_6 + G4P_5P_6 + G3P_4P_5P_6 + G2P_3P_4P_5P_6 + G1P_2P_3P_4P_5P_6 + G0P_1P_2P_3P_4P_5P_6 + C0P_0P_1P_2P_3P_4P_5P_6
		CLR C
		MOV C, G6
		MOV C7, C
		CLR C
		MOV C, G5
		ANL C, P_6
		ORL C, C7
		MOV C7, C
		CLR C
		MOV C, P_5
		ANL C, P_6
		ANL C, G4
		ORL C, C7
		MOV C7, C
		CLR C
		MOV C, P_4
		ANL C, P_5
		ANL C, P_6
		ANL C, G3
		ORL C, C7
		MOV C7, C
		CLR C		
		MOV C, P_3
		ANL C, P_4
		ANL C, P_5
		ANL C, P_6
		ANL C, G2
		ORL C, C7
		MOV C7, C
		CLR C
		MOV C, P_2
		ANL C, P_3
		ANL C, P_4
		ANL C, P_5
		ANL C, P_6
		ANL C, G1
		ORL C, C7
		MOV C7, C
		CLR C
		MOV C, P_0
		ANL C, P_1
		ANL C, P_2
		ANL C, P_3
		ANL C, P_4
		ANL C, P_5
		ANL C, P_6
		ANL C, C0
		ORL C, C7
		MOV C7, C
		
		
;///////////////SMASH THAT SUM BUTTON/////////////////////////////////////
;XOR P_0 with Cin to generate sum	
;store C0 to RAM location 20H(bit address 00H)
		MOV C, P_0
		
		; C0 XOR P_0
		JNB C0 , NEXT0
		CPL C

;Moves Sum into bit 0 of A
NEXT0:   MOV ACC.0, C

;XOR P_1 with Cin to generate sum	
;store C1 to RAM location 20H(bit address 00H)
		MOV C, P_1
		
		; C1 XOR P_1
		JNB C1 , NEXT1
		CPL C

;Moves Sum into bit 1 of A
NEXT1:   MOV ACC.1, C

;XOR P_2 with Cin to generate sum	
;store C2 to RAM location 20H(bit address 00H)
		MOV C, P_2
		
		; C2 XOR P_2
		JNB C2, NEXT2
		CPL C

;Moves Sum into bit 2 of A
NEXT2:   MOV ACC.2, C

;XOR P_3 with Cin to generate sum	
;store C3 to RAM location 20H(bit address 00H)
		MOV C, P_3
		
		; C3 XOR P_3
		JNB C3, NEXT3
		CPL C

;Moves Sum into bit 3 of A
NEXT3:   MOV ACC.3, C

;XOR P_4 with Cin to generate sum	
;store C4 to RAM location 20H(bit address 00H)
		MOV C, P_4
		
		; C4 XOR P_4
		JNB C4, NEXT4
		CPL C

;Moves Sum into bit 4 of A
NEXT4:   MOV ACC.4, C

;XOR P_5 with Cin to generate sum	
;store C5 to RAM location 20H(bit address 00H)
		MOV C, P_5
		
		; C5 XOR P_5
		JNB C5, NEXT5
		CPL C

;Moves Sum into bit 5 of A
NEXT5:   MOV ACC.5, C

;XOR P_6 with Cin to generate sum	
;store C0 to RAM location 20H(bit address 00H)
		MOV C, P_6
		
		; C6 XOR P_6
		JNB C6 , NEXT6
		CPL C

;Moves Sum into bit 6 of A
NEXT6:   MOV ACC.6, C

;XOR P_7 with Cin to generate sum	
;store C7 to RAM location 20H(bit address 00H)
		MOV C, P_7
		
		; C7 XOR P_7
		JNB C7, NEXT7
		CPL C

;Moves Sum into bit 7 of A
NEXT7:   MOV ACC.7, C
END