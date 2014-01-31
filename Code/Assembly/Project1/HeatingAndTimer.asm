
XTAL           EQU 33333333                     ;Clock Frequency
FREQ           EQU 100                          
HERTZ          EQU 2000                         ;Buzzer Frequency
BAUD   		   EQU 115200                       ;Baud Rate
T2LOAD 		   EQU 65536-(XTAL/(32*BAUD))
TIMER0_RELOAD  EQU 65538-(XTAL/(12*FREQ))
BUZZER_RELOAD  EQU 65538-(XTAL/(12*HERTZ))       
TURNONOVEN     EQU P0.0                         ;Controls oven
BUZZER         EQU P0.3                          ; buzzer pin
SERIALRATE     EQU 10                            ; Readings sent to comp per second

myLUT:
    DB 0C0H, 0F9H, 0A4H, 0B0H, 099H        ; 0 TO 4
    DB 092H, 082H, 0F8H, 080H, 090H        ; 4 TO 9
;------------------------------
; Set up timers, 
; Does not start them or enable INT
;------------------------------
Initialize_Timer:
	mov TMOD,  #00010001B ; 16-bit timers
	clr TR0
	clr TR1
	clr TF0
	clr TF1
	clr TR2 ; Disable timer 2
	mov T2CON, #30H ; RCLK=1, TCLK=1 
	mov RCAP2H, #high(T2LOAD)  
	mov RCAP2L, #low(T2LOAD)
	setb TR2 ; Enable timer 2
	mov SCON, #52H
    mov TH0, #high(TIMER0_RELOAD)
    mov TL0, #low(TIMER0_RELOAD)
    mov TH1, #high(BUZZER_RELOAD)
    mov TL1, #low(BUZZER_RELOAD)
    setb TR0
    Setb TR1
    ret
;Buzzer Noise    
Interupt1:
	mov TH1, #high(BUZZER_RELOAD)
    mov TL1, #low(BUZZER_RELOAD)
    cpl BUZZER
	reti    
 

      
;--------------------------------
;Decrements Timer Every 1 second
;Checks Oven Temperature ever 1s
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
   	lcall display_temp
   	inc count5ms
   	mov a, count5ms
   	cjne a, #SerialRate, NoSend
   	mov count5ms, #0
    lcall SendTemp	
NoSend:   	
   	; Increment the counter and check if a second has passed
    inc count10ms
    mov a, count10ms 
    cjne A, #100, Return_int
    mov count10ms, #0 
    clr c
    ;seconds has passed
    
    ;checks if oven is greater or equal to target (can be moved to adjust rate)
    mov a, Target_Temp
    Subb a, Oven_Temp        
    jc NoHeat
    jz NoHeat
    ;activate oven
    setb TurnOnOven
;--------------------------------------------    
    inc Oven_Temp
;-----------------------------------------------    
    clr Ready
    sjmp Heat
NoHeat:    
	setb Ready  
	;turn off oven
	clr TurnOnOven
;-----------------------------------------  	
    dec Oven_Temp
;-------------------------------------------
Heat:
	;if timer is active    
	jb finished, Return_int
    mov a, seconds
    dec a
    mov seconds, a
    cjne A, #00, Return_int ;FFH is -1 in two's complement
    mov seconds, #00
    setb finished
Return_int:
	pop dpl
    pop dph
    pop acc
    pop psw    
 	reti
   
end
	 	
