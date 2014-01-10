$MODDE2

org 000BH
    ljmp Timer0_Interupt
;variables for timer
DSEG at 30H
seconds:   ds 1
minutes:   ds 1
hours:     ds 1
CSEG   
overflow:  db 1 

;------------------------------------
;Sets up Timer Zero as 16 bit counter
;------------------------------------
Initialize_Timer:
	mov TMOD,  #00000001B             ; GATE=0, C/T*=0, M1=0, M0=1: 16-bit timer
    clr TR0                           ; Disable timer 0
    clr TF0
    mov TH0, #0
    mov TL0, #0
    setb TR0                          ; Enable timer 0
    setb ET0                          ; Enable timer 0 interrupt
    ret
	
;---------------------------------------
;Timer Interrupt
;  flashes LEDG.0 every 1s right now
;  Goal:
;  Decrements [Seconds] every one second
;  Handles Rollover of time as well
;---------------------------------------
Timer0_Interupt:
	mov TH0, #0                       	;Reload Timer
	mov TL0, #0
	push acc                            ;Save Used Registers

	mov a, Overflow                     ;Count Overflow (43 times = 1s)
	inc acc 
	cjne a, #43, Return_Interupt
	mov OverFlow, #0

	cpl LEDG.0                          ;Count Overflow (43 times = 1s)
	
Return_Interupt:
	pop acc                           	;restore used registers
	reti		
END	