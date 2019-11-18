     area     circle, CODE, READONLY
	 IMPORT printMsg2p             
	 export __main	
	 ENTRY 
__main  function	
		VLDR.F32 S23,=0 ; initialising theta value
		VLDR.F32 S16,=360; max value of theta
	 	VLDR.F32 S15,=5; theta increment		
INIT    MOV R8, #40 ; value of radius
		MOV R0, #80 ; x coordinate
		MOV R1, #60 ; y coordinate
		VMOV.F32 S19,R0; moving the value of x coordinate in floating register
        VCVT.F32.U32 S19,S19; Converting the value present in R0(x coordinate) into unsigned fp Number 32 bit)
		VMOV.F32 S20,R1; moving the value of y coordinate in floating register
        VCVT.F32.U32 S20,S20; Converting the value present in R8(y coordinate) into unsigned fp Number 32 bit)
		VMOV.F32 S12,R8; moving the value of radius in floating register
        VCVT.F32.U32 S12,S12; Converting the value present in R8(radius) into unsigned fp Number 32 bit)
		VMOV.F32 S17,S23
	;	VLDR.F32 S17,=45;Holding 'x' value(in degrees)
		BL SR ; call subroutine
		VMUL.F32 S13,S12,S9; x = r cos(theta)
		VMUL.F32 S14,S12,S0; y = r sin(theta)
		VADD.F32 S21,S13,S19; x' acc to VGA display
		VADD.F32 S22,S14,S20 ; y' acc to VGA display
		VCVT.S32.F32 S21,S21
		VCVT.S32.F32 S22,S22
		VCVT.U32.F32 S17,S17
		VMOV.F32 R0,S17
		VMOV.F32 R1,S21
		VMOV.F32 R2,S22
        BL printMsg2p	 ; Refer to ARM Procedure calling standards.
		VCMP.F32 S23, S16
		vmrs APSR_nzcv, FPSCR
		BEQ stop
		VADD.F32 S23, S15, S23
		B INIT
stop    B stop;  goto stop

SR      MOV R0,#10 ; iteration value for expression expansion 'n'
        MOV R1,#1; counting Variable 'i'
        VLDR.F32 S0,=1;Holding the final value of sum of series elements 's' (sinx)
        VLDR.F32 S1,=1;Temp Variable to hold the intermediate series elements 't'	
	 	VLDR.F32 S7,=0.0174533; changing degress into radians 
		VMUL.F32 S2,S17,S7 ; changing degress into radians 
		VMOV.F32 S1,S2; t=x for sine
		VMOV.F32 S0,S2; sum=x for sine
		VLDR.F32 S8,=1; t=1 for cosine
		VLDR.F32 S9,=1; Holding the final value of sum of series elements 's' (cosx)
		
LOOP1   CMP R1,R0;Compare 'i' and 'n'
        BLE LOOP;if i < n goto LOOP  
		BX lr ; else return from subroutine	


LOOP  	VMOV.F32 S3,R1; moving the value of 'i' in floating register
        VCVT.F32.U32 S3,S3; Converting the value present in R1(i) into unsigned fp Number 32 bit
		VNMUL.F32 S4,S2,S2; -1*x*x
		MOV R5,#2
		MUL R2,R1,R5; 2i
		ADD R3,R2,#1; 2i+1 for sine
		SUB R6,R2,#1; 2i-1 for cosine
		MUL R3,R2,R3; 2i*(2i+1)  for sine
		MUL R7,R2,R6; 2i*(2i-1) for cosine
        VMOV.F32 S5,R3; moving the value of '2i*(2i+1)' in floating register
		VMOV.F32 S10,R7; moving the value of '2i*(2i-1)' in floating register
        VCVT.F32.U32 S5,S5; Converting the value present in R3(2i*(2i+1)) into unsigned fp Number 32 bit)
		VCVT.F32.U32 S10,S10; Converting the value present in R7(2i*(2i-1)) into unsigned fp Number 32 bit)
		VDIV.F32 S6,S4,S5 ; -(x*x)/2i*(2i+1)
		VDIV.F32 S11,S4,S10 ; -(x*x)/2i*(2i-1)
 		VMUL.F32 S1,S1,S6; t=t*(-1)*(x*x)/2i*(2i+1)
		VMUL.F32 S8,S8,S11; t=t*(-1)*(x*x)/2i*(2i-1)
		VADD.F32 S0,S0,S1;Finally add 's' to 't'(S1) and store it in 's' Sinx series
		VADD.F32 S9,S9,S8;Finally add 's' to 't'(S8) and store it in 's' Cosx series
		ADD R1,R1,#1; increment the value of i by 1
		B LOOP1;;Again goto comparision
		
		endfunc
        end
