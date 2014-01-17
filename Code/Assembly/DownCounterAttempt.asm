$MODDE2
XTAL           EQU 33333333
FREQ           EQU 100
TIMER0_RELOAD  EQU 65538-(XTAL/(12*FREQ))

;-----------------------
;Kill this later
;----------------------


org 000BH
ljmp Interupt0

BSEG
finished: db 1

DSEG at 30H
count10ms: ds 1
seconds:   ds 1
minutes:   ds 1
hours:     ds 1
CSEG

;------------------------------
; Set up timer to interupt 10ms
;------------------------------
InitializeTimer:
	clr LEDRA.0
	mov TMOD,  #00000001B ; GATE=0, C/T*=0, M1=0, M0=1: 16-bit timer
	clr TR0 ; Disable timer 0
	clr TF0
    mov TH0, #high(TIMER0_RELOAD)
    mov TL0, #low(TIMER0_RELOAD)
    setb TR0 ; Enable timer 0
    setb ET0 ; Enable timer 0 interrupt
    ret
;--------------------------------
;Decrements Timer Every 1 second
;--------------------------------
Interupt0:    
	; Reload the timer
    mov TH0, #high(TIMER0_RELOAD)
    mov TL0, #low(TIMER0_RELOAD)
 
    ; Save used register into the stack
    push psw
    push acc
    push dph
    push dpl
    
    ; Increment the counter and check if a second has passed
    inc count10ms
    mov a, count10ms
    cjne A, #100, Return_int
    mov count10ms, #0
    
    mov a, seconds
    dec a
    mov seconds, a
    cjne A, #0FFH, Return_int ;FFH is -1 in two's complement
    mov seconds, #59

    mov a, minutes
    dec a
    mov minutes, a
    cjne A, #0FFH, Return_int
    mov minutes, #59
    
    mov a, hours
    dec a
    mov hours, a
    cjne A, #0FFH, Return_int
    ;Timer Done
    setb finished

Return_int:
	pop dpl
    pop dph
    pop acc
    pop psw    
 	reti


display2 mac
	mov dptr, #Size60LookUp
; Display Digit 1
    mov A, %0
    mov b, #2
    mul ab  
    movc A, @A+dptr
    mov HEX1, A
; Display Digit 0
    mov a, %0
    mov b, #2
    mul ab
    inc a
    movc A, @A+dptr
    mov	 HEX0, A
    
    mov A, %1
    mov b, #2
    mul ab  
    movc A, @A+dptr
    mov HEX3, A
; Display Digit 0
    mov a, %1
    mov b, #2
    mul ab
    inc a
    movc A, @A+dptr
    mov	 HEX2, A
    
    
    mov A, %2
    mov b, #2
    mul ab  
    movc A, @A+dptr
    mov HEX5, A
; Display Digit 0
    mov a, %2
    mov b, #2
    mul ab
    inc a
    movc A, @A+dptr
    mov	 HEX4, A

endmac

	
    
   
end
	 	