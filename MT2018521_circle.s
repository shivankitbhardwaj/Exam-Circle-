     area     circle, CODE, READONLY
	 IMPORT printMsg2p             
	 export __main	
	 ENTRY 
__main  function		
	    MOV R8, #40 ; value of radius
		VMOV.F32 S12,R8; moving the value of radius in floating register
        VCVT.F32.U32 S12,S12; Converting the value present in R8(radius) into unsigned fp Number 32 bit)
		VLDR.F32 S17,=45;Holding 'x' value(in degrees)
		BL SR ; call subroutine
		VMUL.F32 S13,S12,S9; x = r cos(theta)
		VMUL.F32 S14,S12,S0; y = r sin(theta)
		VCVT.S32.F32 S13,S13
		VCVT.S32.F32 S14,S14
		VCVT.U32.F32 S17,S17
		VMOV.F32 R0,S17
		VMOV.F32 R1,S13
		VMOV.F32 R2,S14
        BL printMsg2p	 ; Refer to ARM Procedure calling standards.
		VLDR.F32 S16,=380; max value of theta
		VMOV.F32 R10,S16
		VMOV.F32 R11,S17
		CMP R10,R11
  ;     VCMP.F32 S17,S16 ; compare with max
		MOVNE R0,#10 ; iteration value for expression expansion 'n'
        MOVNE R1,#1; counting Variable 'i'
		BEQ stop
stop    B stop;  goto stop

SR      MOV R0,#10 ; iteration value for expression expansion 'n'
        MOV R1,#1; counting Variable 'i'
        VLDR.F32 S0,=1;Holding the final value of sum of series elements 's' (sinx)
        VLDR.F32 S1,=1;Temp Variable to hold the intermediate series elements 't'	
        VLDR.F32 S17,=150;Holding 'x' value(in degrees)
	 	VLDR.F32 S7,=0.0174533; changing degress into radians 
		VMUL.F32 S2,S17,S7 ; changing degress into radians 
		VMOV.F32 S1,S2; t=x for sine
		VMOV.F32 S0,S2; sum=x for sine
		VLDR.F32 S8,=1; t=1 for cosine
		VLDR.F32 S9,=1; Holding the final value of sum of series elements 's' (cosx)
		
LOOP1   CMP R1,R0;Compare 'i' and 'n'
        BLE LOOP;if i < n goto LOOP  
;	 	VLDR.F32 S15,=20; theta increment
;	 	VADD.F32 S17,S15,S17; new theta
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