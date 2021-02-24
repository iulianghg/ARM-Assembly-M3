; Name:        Counting characters
; Author:      Julian Gherghel

; --- Counting characters ---
; This program calculates the number of occurrences of a specified character in a
; given string and stores the result in register R5.
 THUMB
 AREA RESET, CODE, READONLY
 EXPORT __Vectors
 EXPORT Reset_Handler
__Vectors
 DCD 0x20001000 ; top of the stack
 DCD Reset_Handler ; reset vector - where the program starts

	AREA Task1Code, CODE, READONLY
	ENTRY
Reset_Handler
	LDR R0, =input_string			; the address location of input_string
	LDR R1, =character_to_find		; the address location of character_to_find
	LDRB R1,[R1, #0]
charCount							; progress through the string to look for character_to_find
	LDRB R2,[R0], #1 				; loads next character in string to be evaluated
	TEQ R2, #0						; checks if the program has reached the end of the string
	BEQ terminate
	TEQ R2, R1						; test equality (compare) numerical value against loaded string character 
	BNE charCount
	ADD R5, R5, #1					; store result in R5 - if an S is found, increase by 1.
	B charCount
terminate
	B terminate

input_string
	DCB "she sells sea shells",0	; string to be evaluated
character_to_find
	DCB "s" 						; find the number of occurrences of this character
	END