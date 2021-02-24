; Name:        Subroutines
; Author:      Julian Gherghel

; Program to extract all vowels from a string and produce a new string without any vowels.
	THUMB
	AREA RESET, DATA, READONLY
	EXPORT  __Vectors
	EXPORT Reset_Handler
__Vectors 
	DCD 0x20001000    
	DCD Reset_Handler
	AREA Task3Code, CODE, READONLY ; extract vowels from the string
	ENTRY
Reset_Handler
	LDR R1, =input_string		; load the address of string containing vowels
	LDR R4, =output_string		; laod the address of new string not containing vowels
    B stringvowel
stringvowel						; accepts the adress of a string 
	MOV R9, #0					; intialize the string's character counter at the start of the input_string
LoopS							; evaluates each character in input_string to look for vowels
	LDRB R8, [R1, R9]			; load a character's address
	ADD R9, R9, #1 				; increase counter by 1
	TEQ R8, #0
	BEQ terminateS
	B charvowel
CharStop						; stops if end of string 
	TEQ R3, #0
	BNE VowelChar		
	STRB R8, [R4]
	ADD R4, R4, #1
	B LoopS
VowelChar						
	B LoopS
terminateS
	B terminateS
charvowel						
	MOV R5, #0
	LDR R7, =vowel_string
LoopChar
	LDRB R2,[R7, R5]
	ADD R5, R5, #1
	TEQ R2, #0
	BEQ terminateCHAR
	TEQ R2, R8
	BNE LoopChar
	MOV R3, #1
	B CharStop
terminateCHAR
	MOV R3, #0
	B CharStop
	
vowel_string		;define vowel_string - contains both lower and upper case vowels in English alphabet
	DCB "aAeEiIoOuU",0	
	
	AREA Task3DataRO, DATA, READONLY; input string data (constant)
input_string
	DCB "Input String",0 ; example string to have vowels removed
	
	AREA Task3DataRW, DATA, READWRITE; result of operation stored here
output_string
	DCB "",0
	END