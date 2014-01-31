putchar:
    JNB TI, putchar
    CLR TI
    MOV SBUF, a
    RET
SendTemp:
	mov x, Oven_Temp
	lcall Hex2Bcd
	mov A, bcd+1
    anl a, #0fh
    add a, #48  
    lcall putchar	 
	mov A, bcd+0
	swap a
    anl a, #0fh
    add a, #48
    lcall putchar
    mov A, bcd+0
    anl a, #0fh
    add a, #48
    lcall putchar
    mov a, #'\n'
    lcall putchar
    mov a, #'\r'
    lcall putchar
	ret	
	
END	