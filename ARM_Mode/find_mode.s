; Name:        Find the mode
; Author:      Julian Gherghel

; Program to find the mode of a given set of data and save the result in R8.
	THUMB
	AREA RESET, DATA, READONLY
	EXPORT  __Vectors
	EXPORT Reset_Handler
__Vectors 
	DCD 0x20001000     ; top of the stack 
	DCD Reset_Handler  ; reset vector - where the program starts

	AREA Task2Code, CODE, READONLY ; find the mode of a set of data
	ENTRY
Reset_Handler
	LDR R0, =data_values
	LDR R10, =data_values
	LDR R1, =result
	MOV R2, #0 ; primary counter
	MOV R3, #0 ; secondary counter
	MOV R4, #0 ; temporary storage register
	MOV R8, #0 ; final output storage
	LDR R9, =LastData
	SUB R11, R9, R0
	MOV R12, #4
	UDIV R11, R11, R12
Loop1
	LDR R5,[R10], #4
Loop2
	TEQ R3, R11
	BEQ terminateLoop2
	LDR R6,[R0], #4
	ADD R3, R3, #1
	TEQ R6, R5
	BNE LOOP2
	ADD R4, R4, #1 ;increase temporary storage counter by 1
	B LOOP2
terminateLoop2	
	TEQ R2, R11
	BEQ terminateLoop1
	CMP R4, R8
	BLT Pass
	MOV R8, #0
	MOV R8, R4
	STR R5, [R1]
	MOV R1, R5
	B Pass
Pass
	ADD R2, R2, #1
	MOV R4, #0
	MOV R3, #0
	LDR R0, =data_values
	B LOOP1
terminateLoop1
	B terminateLoop1
	
	AREA Task2DataRO, DATA, READONLY
data_values
	DCD 45,-18,64,-23,-3,0,12,45,64,-3,64 ; example values
LastData
	AREA Task2DataRW, DATA, READWRITE
result
	DCD 0 ; result to be stored here
	END