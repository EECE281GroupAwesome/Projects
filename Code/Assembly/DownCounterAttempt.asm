$MODDE2
XTAL           EQU 33333333
FREQ           EQU 100
TIMER0_RELOAD  EQU 65538-(XTAL/(12*FREQ))

;-----------------------
;Kill this later
;----------------------
org 0000H
ljmp MyProgram

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
Interupt1:    
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
    cjne A, #0, Return_int
    mov seconds, #60

    mov a, minutes
    dec a
    mov minutes, a
    cjne A, #0, Return_int
    mov minutes, #60
    
    mov a, hours
    dec a
    mov hours, a
    cjne A, #0H, Return_int
    ;Timer Done
    sjmp Done
Return_int:
	pop dpl
    pop dph
    pop acc
    pop psw    
 	reti
;---------------------
;Test Part Loops
;---------------------
MyProgram:
	lcall InitializeTimer
	setb EA
	lcall Display
	sjmp Myprogram	
Done:
	clr ET0
	mov LEDG, #0		
	sjmp done
;----------------------------------
;Display onto Hex displays 0 and 1
;----------------------------------
Display:
mov dptr, #Size60LookUp
; Display Digit 0
    mov A, seconds
    rl a
    movc A, @A+dptr
    mov HEX0, A
; Display Digit 1
    mov a, seconds
    rl a
    inc a
    movc A, @A+dptr
    mov	 HEX1, A
    ret
end
	 	