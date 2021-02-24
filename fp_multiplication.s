; Name:        Floating point multiplication
; Author:      Julian Gherghel

; This program uses single-precision floating-point operations to multiply a 4x2 matrix with a 2x4 matrix, resulting in a 4x4 matrix.
	THUMB
	AREA RESET, DATA, READONLY
	EXPORT  __Vectors
	EXPORT Reset_Handler
__Vectors 
	DCD 0x20001000     ; top of the stack 
	DCD Reset_Handler  ; reset vector - where the program starts
	  
	AREA Task4Code, CODE, READONLY ; start of floating point code
	ENTRY
Reset_Handler
CoProcessor_Setup
	LDR.W R0, = 0xE000ED88 ; address of co-processor register
	LDR R1, [R0]  ; Read CPACR - the co-processor register
	ORR R1, R1, #(0xF << 20)  ; bits 20-23 to enable CP10 and CP11 coprocessors
	STR R1, [R0]  ; write back updated value to CPACR
	DSB   ; wait for trnsfer to complete
LoadAddresses
	LDR R2,=matrix1		; get the location of the start of the first data area
	LDR R3,=matrix2		; get the location of the start of the second data area
	LDR R4,=matrix3		; get the location of the start of the resulting data area
LoadM					; load the matrices	
	VLDMFD.F R7!,{s0-s7}  ; load from first data area
	VLDMFD.F R8!,{s8-s15} ; load from second data area
ConvMatrices			; convert matrix elements from signed to floating-point
	VCVT.F32.S32 s0,s0
	VCVT.F32.S32 s1,s1
	VCVT.F32.S32 s2,s2
	VCVT.F32.S32 s3,s3
	VCVT.F32.S32 s4,s4
	VCVT.F32.S32 s5,s5
	VCVT.F32.S32 s6,s6
	VCVT.F32.S32 s7,s7
	VCVT.F32.S32 s8,s8
	VCVT.F32.S32 s9,s9
	VCVT.F32.S32 s10,s10
	VCVT.F32.S32 s11,s11
	VCVT.F32.S32 s12,s12
	VCVT.F32.S32 s13,s13
	VCVT.F32.S32 s14,s14
	VCVT.F32.S32 s15,s15
MulMatrices 			; multiply first row by each column of matrix1 and matrix2
	VMUL.F s16,s0,s8   	; VMUL performs multiplication of vector floating-points
	VMLA.F s16, s1, s12 ; VMLA performs multiplication and addition of vector floating-points in one instruction
	VMUL.F s17,s0,s9   
	VMLA.F s17, s1, s13 
	VMUL.F s18,s0,s10   
	VMLA.F s18, s1, s14 
	VMUL.F s19,s0,s11   
	VMLA.F s19, s1, s15 
	VMUL.F s20,s2,s8   
	VMLA.F s20, s3, s12 
	VMUL.F s21,s2,s9   
	VMLA.F s21, s3, s13 
	VMUL.F s22,s2,s10   
	VMLA.F s22, s3, s14 
	VMUL.F s23,s2,s11   
	VMLA.F s23, s3, s15 
	VMUL.F s24,s4,s8   
	VMLA.F s24, s5, s12 
	VMUL.F s25,s4,s9   
	VMLA.F s25, s5, s13 
	VMUL.F s26,s4,s10   
	VMLA.F s26, s5, s14 
	VMUL.F s27,s4,s11   
	VMLA.F s27, s5, s15 
	VMUL.F s28,s6,s8   
	VMLA.F s28, s7, s12 
	VMUL.F s29,s6,s9   
	VMLA.F s29, s7, s13 
	VMUL.F s30,s6,s10   
	VMLA.F s30, s7, s14 
	VMUL.F s31,s6,s11   
	VMLA.F s31, s7, s15 

	VSTMEA.F R9!,{s16-s31}	; constructs a matrix and stores it in R4
terminateM  ; sit in an endless loop
	B terminateM
	ALIGN 4
	AREA Task4DataRO, DATA, READONLY	; matrix data
matrix1
	DCD 3,4,5,4,3,2,5,6 ; example 4x2 matrix
matrix2
	DCD 3,4,5,6,7,8,9,1 ; example 2x4 matrix

	AREA Task4DataRW, DATA, READWRITE	; resulting matrix stored here
matrix3
	SPACE 16*4
	END