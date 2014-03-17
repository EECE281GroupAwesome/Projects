;--------------------------------------------------------
; File Created by C51
; Version 1.0.0 #1034 (Dec 12 2012) (MSVC)
; This file was generated Mon Mar 17 11:50:07 2014
;--------------------------------------------------------
$name Movement_Simulator
$optc51 --model-small
	R_DSEG    segment data
	R_CSEG    segment code
	R_BSEG    segment bit
	R_XSEG    segment xdata
	R_PSEG    segment xdata
	R_ISEG    segment idata
	R_OSEG    segment data overlay
	BIT_BANK  segment data overlay
	R_HOME    segment code
	R_GSINIT  segment code
	R_IXSEG   segment xdata
	R_CONST   segment code
	R_XINIT   segment code
	R_DINIT   segment code

;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	public _turnCar_PARM_2
	public _main
	public __c51_external_startup
	public _pwmCounter
	public _beaconSignal
	public _angle
	public _turnDirection
	public _distance
	public _instruction
	public _rightSensor
	public _leftSensor
	public _pwmLeft
	public _pwmRight
	public _pwmCount
	public _Stage
	public _getDistance
	public _getAngle
	public _getDirection
	public _turnCar
	public _moveCar
	public _adjustAngle
	public _wait2ms
	public _wait1s
;--------------------------------------------------------
; Special Function Registers
;--------------------------------------------------------
_ACC            DATA 0xe0
_B              DATA 0xf0
_PSW            DATA 0xd0
_SP             DATA 0x81
_SPX            DATA 0xef
_DPL            DATA 0x82
_DPH            DATA 0x83
_DPLB           DATA 0xd4
_DPHB           DATA 0xd5
_PAGE           DATA 0xf6
_AX             DATA 0xe1
_BX             DATA 0xf7
_DSPR           DATA 0xe2
_FIRD           DATA 0xe3
_MACL           DATA 0xe4
_MACH           DATA 0xe5
_PCON           DATA 0x87
_AUXR           DATA 0x8e
_AUXR1          DATA 0xa2
_DPCF           DATA 0xa1
_CKRL           DATA 0x97
_CKCKON0        DATA 0x8f
_CKCKON1        DATA 0xaf
_CKSEL          DATA 0x85
_CLKREG         DATA 0xae
_OSCCON         DATA 0x85
_IE             DATA 0xa8
_IEN0           DATA 0xa8
_IEN1           DATA 0xb1
_IPH0           DATA 0xb7
_IP             DATA 0xb8
_IPL0           DATA 0xb8
_IPH1           DATA 0xb3
_IPL1           DATA 0xb2
_P0             DATA 0x80
_P1             DATA 0x90
_P2             DATA 0xa0
_P3             DATA 0xb0
_P4             DATA 0xc0
_P0M0           DATA 0xe6
_P0M1           DATA 0xe7
_P1M0           DATA 0xd6
_P1M1           DATA 0xd7
_P2M0           DATA 0xce
_P2M1           DATA 0xcf
_P3M0           DATA 0xc6
_P3M1           DATA 0xc7
_P4M0           DATA 0xbe
_P4M1           DATA 0xbf
_SCON           DATA 0x98
_SBUF           DATA 0x99
_SADEN          DATA 0xb9
_SADDR          DATA 0xa9
_BDRCON         DATA 0x9b
_BRL            DATA 0x9a
_TCON           DATA 0x88
_TMOD           DATA 0x89
_TCONB          DATA 0x91
_TL0            DATA 0x8a
_TH0            DATA 0x8c
_TL1            DATA 0x8b
_TH1            DATA 0x8d
_RL0            DATA 0xf2
_RH0            DATA 0xf3
_RTL1           DATA 0xf4
_RH1            DATA 0xf5
_WDTRST         DATA 0xa6
_WDTPRG         DATA 0xa7
_T2CON          DATA 0xc8
_T2MOD          DATA 0xc9
_RCAP2H         DATA 0xcb
_RCAP2L         DATA 0xca
_TH2            DATA 0xcd
_TL2            DATA 0xcc
_SPCON          DATA 0xc3
_SPSTA          DATA 0xc4
_SPDAT          DATA 0xc5
_SSCON          DATA 0x93
_SSCS           DATA 0x94
_SSDAT          DATA 0x95
_SSADR          DATA 0x96
_KBLS           DATA 0x9c
_KBE            DATA 0x9d
_KBF            DATA 0x9e
_KBMOD          DATA 0x9f
_BMSEL          DATA 0x92
_FCON           DATA 0xd2
_EECON          DATA 0xd2
_ACSRA          DATA 0xa3
_ACSRB          DATA 0xab
_AREF           DATA 0xbd
_DADC           DATA 0xa4
_DADI           DATA 0xa5
_DADL           DATA 0xac
_DADH           DATA 0xad
_CCON           DATA 0xd8
_CMOD           DATA 0xd9
_CL             DATA 0xe9
_CH             DATA 0xf9
_CCAPM0         DATA 0xda
_CCAPM1         DATA 0xdb
_CCAPM2         DATA 0xdc
_CCAPM3         DATA 0xdd
_CCAPM4         DATA 0xde
_CCAP0H         DATA 0xfa
_CCAP1H         DATA 0xfb
_CCAP2H         DATA 0xfc
_CCAP3H         DATA 0xfd
_CCAP4H         DATA 0xfe
_CCAP0L         DATA 0xea
_CCAP1L         DATA 0xeb
_CCAP2L         DATA 0xec
_CCAP3L         DATA 0xed
_CCAP4L         DATA 0xee
;--------------------------------------------------------
; special function bits
;--------------------------------------------------------
_ACC_0          BIT 0xe0
_ACC_1          BIT 0xe1
_ACC_2          BIT 0xe2
_ACC_3          BIT 0xe3
_ACC_4          BIT 0xe4
_ACC_5          BIT 0xe5
_ACC_6          BIT 0xe6
_ACC_7          BIT 0xe7
_B_0            BIT 0xf0
_B_1            BIT 0xf1
_B_2            BIT 0xf2
_B_3            BIT 0xf3
_B_4            BIT 0xf4
_B_5            BIT 0xf5
_B_6            BIT 0xf6
_B_7            BIT 0xf7
_P              BIT 0xd0
_F1             BIT 0xd1
_OV             BIT 0xd2
_RS0            BIT 0xd3
_RS1            BIT 0xd4
_F0             BIT 0xd5
_AC             BIT 0xd6
_CY             BIT 0xd7
_EX0            BIT 0xa8
_ET0            BIT 0xa9
_EX1            BIT 0xaa
_ET1            BIT 0xab
_ES             BIT 0xac
_ET2            BIT 0xad
_EC             BIT 0xae
_EA             BIT 0xaf
_PX0            BIT 0xb8
_PT0            BIT 0xb9
_PX1            BIT 0xba
_PT1            BIT 0xbb
_PS             BIT 0xbc
_PT2            BIT 0xbd
_IP0D           BIT 0xbf
_PPCL           BIT 0xbe
_PT2L           BIT 0xbd
_PLS            BIT 0xbc
_PT1L           BIT 0xbb
_PX1L           BIT 0xba
_PT0L           BIT 0xb9
_PX0L           BIT 0xb8
_P0_0           BIT 0x80
_P0_1           BIT 0x81
_P0_2           BIT 0x82
_P0_3           BIT 0x83
_P0_4           BIT 0x84
_P0_5           BIT 0x85
_P0_6           BIT 0x86
_P0_7           BIT 0x87
_P1_0           BIT 0x90
_P1_1           BIT 0x91
_P1_2           BIT 0x92
_P1_3           BIT 0x93
_P1_4           BIT 0x94
_P1_5           BIT 0x95
_P1_6           BIT 0x96
_P1_7           BIT 0x97
_P2_0           BIT 0xa0
_P2_1           BIT 0xa1
_P2_2           BIT 0xa2
_P2_3           BIT 0xa3
_P2_4           BIT 0xa4
_P2_5           BIT 0xa5
_P2_6           BIT 0xa6
_P2_7           BIT 0xa7
_P3_0           BIT 0xb0
_P3_1           BIT 0xb1
_P3_2           BIT 0xb2
_P3_3           BIT 0xb3
_P3_4           BIT 0xb4
_P3_5           BIT 0xb5
_P3_6           BIT 0xb6
_P3_7           BIT 0xb7
_RXD            BIT 0xb0
_TXD            BIT 0xb1
_INT0           BIT 0xb2
_INT1           BIT 0xb3
_T0             BIT 0xb4
_T1             BIT 0xb5
_WR             BIT 0xb6
_RD             BIT 0xb7
_P4_0           BIT 0xc0
_P4_1           BIT 0xc1
_P4_2           BIT 0xc2
_P4_3           BIT 0xc3
_P4_4           BIT 0xc4
_P4_5           BIT 0xc5
_P4_6           BIT 0xc6
_P4_7           BIT 0xc7
_RI             BIT 0x98
_TI             BIT 0x99
_RB8            BIT 0x9a
_TB8            BIT 0x9b
_REN            BIT 0x9c
_SM2            BIT 0x9d
_SM1            BIT 0x9e
_SM0            BIT 0x9f
_IT0            BIT 0x88
_IE0            BIT 0x89
_IT1            BIT 0x8a
_IE1            BIT 0x8b
_TR0            BIT 0x8c
_TF0            BIT 0x8d
_TR1            BIT 0x8e
_TF1            BIT 0x8f
_CP_RL2         BIT 0xc8
_C_T2           BIT 0xc9
_TR2            BIT 0xca
_EXEN2          BIT 0xcb
_TCLK           BIT 0xcc
_RCLK           BIT 0xcd
_EXF2           BIT 0xce
_TF2            BIT 0xcf
_CF             BIT 0xdf
_CR             BIT 0xde
_CCF4           BIT 0xdc
_CCF3           BIT 0xdb
_CCF2           BIT 0xda
_CCF1           BIT 0xd9
_CCF0           BIT 0xd8
;--------------------------------------------------------
; overlayable register banks
;--------------------------------------------------------
	rbank0 segment data overlay
;--------------------------------------------------------
; overlayable bit register bank
;--------------------------------------------------------
	rseg BIT_BANK
bits:
	ds 1
	b0 equ  bits.0 
	b1 equ  bits.1 
	b2 equ  bits.2 
	b3 equ  bits.3 
	b4 equ  bits.4 
	b5 equ  bits.5 
	b6 equ  bits.6 
	b7 equ  bits.7 
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	rseg R_DSEG
_Stage:
	ds 2
_pwmCount:
	ds 2
_pwmRight:
	ds 2
_pwmLeft:
	ds 2
_leftSensor:
	ds 2
_rightSensor:
	ds 2
_instruction:
	ds 2
_distance:
	ds 2
_turnDirection:
	ds 1
_angle:
	ds 4
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	rseg	R_OSEG
_turnCar_PARM_2:
	ds 2
;--------------------------------------------------------
; indirectly addressable internal ram data
;--------------------------------------------------------
	rseg R_ISEG
;--------------------------------------------------------
; absolute internal ram data
;--------------------------------------------------------
	DSEG
;--------------------------------------------------------
; bit data
;--------------------------------------------------------
	rseg R_BSEG
_pwmCounter_sloc0_1_0:
	DBIT	1
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	rseg R_PSEG
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	rseg R_XSEG
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	XSEG
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	rseg R_IXSEG
	rseg R_HOME
	rseg R_GSINIT
	rseg R_CSEG
;--------------------------------------------------------
; Reset entry point and interrupt vectors
;--------------------------------------------------------
	CSEG at 0x0000
	ljmp	_crt0
	CSEG at 0x000b
	ljmp	_pwmCounter
	CSEG at 0x001b
	ljmp	_beaconSignal
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	rseg R_HOME
	rseg R_GSINIT
	rseg R_GSINIT
;--------------------------------------------------------
; data variables initialization
;--------------------------------------------------------
	rseg R_DINIT
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:35: volatile unsigned int Stage = 0;
	clr	a
	mov	_Stage,a
	mov	(_Stage + 1),a
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:36: volatile unsigned int pwmCount = 0;
	clr	a
	mov	_pwmCount,a
	mov	(_pwmCount + 1),a
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:37: volatile int pwmRight = 0;
	clr	a
	mov	_pwmRight,a
	mov	(_pwmRight + 1),a
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:38: volatile int pwmLeft = 0;
	clr	a
	mov	_pwmLeft,a
	mov	(_pwmLeft + 1),a
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:39: volatile unsigned int leftSensor = 0;
	clr	a
	mov	_leftSensor,a
	mov	(_leftSensor + 1),a
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:40: volatile unsigned int rightSensor = 0;
	clr	a
	mov	_rightSensor,a
	mov	(_rightSensor + 1),a
	; The linker places a 'ret' at the end of segment R_DINIT.
;--------------------------------------------------------
; code
;--------------------------------------------------------
	rseg R_CSEG
;------------------------------------------------------------
;Allocation info for local variables in function 'beaconSignal'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:59: void beaconSignal() interrupt 3
;	-----------------------------------------
;	 function beaconSignal
;	-----------------------------------------
_beaconSignal:
	using	0
	push	acc
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:61: instruction=0;
	clr	a
	mov	_instruction,a
	mov	(_instruction + 1),a
	pop	acc
	reti
;	eliminated unneeded push/pop psw
;	eliminated unneeded push/pop dpl
;	eliminated unneeded push/pop dph
;	eliminated unneeded push/pop b
;------------------------------------------------------------
;Allocation info for local variables in function 'pwmCounter'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:64: void pwmCounter() interrupt 1
;	-----------------------------------------
;	 function pwmCounter
;	-----------------------------------------
_pwmCounter:
	push	bits
	push	acc
	push	b
	push	dpl
	push	dph
	push	(0+2)
	push	(0+3)
	push	(0+4)
	push	(0+5)
	push	(0+6)
	push	(0+7)
	push	(0+0)
	push	(0+1)
	push	psw
	mov	psw,#0x00
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:66: angle = getAngle();
	lcall	_getAngle
	mov	_angle,dpl
	mov	(_angle + 1),dph
	mov	(_angle + 2),b
	mov	(_angle + 3),a
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:67: distance = getDistance();
	lcall	_getDistance
	mov	_distance,dpl
	mov	(_distance + 1),dph
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:68: if(++pwmCount>99)
	mov	a,#0x01
	add	a,_pwmCount
	mov	_pwmCount,a
	clr	a
	addc	a,(_pwmCount + 1)
	mov	(_pwmCount + 1),a
	clr	c
	mov	a,#0x63
	subb	a,_pwmCount
	clr	a
	subb	a,(_pwmCount + 1)
	jnc	L003002?
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:69: pwmCount = 0;
	clr	a
	mov	_pwmCount,a
	mov	(_pwmCount + 1),a
L003002?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:71: if(pwmLeft>0)
	clr	c
	clr	a
	subb	a,_pwmLeft
	clr	a
	xrl	a,#0x80
	mov	b,(_pwmLeft + 1)
	xrl	b,#0x80
	subb	a,b
	jnc	L003004?
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:73: P0_0 =(pwmLeft>pwmCount)?0:1;
	mov	r2,_pwmLeft
	mov	r3,(_pwmLeft + 1)
	clr	c
	mov	a,_pwmCount
	subb	a,r2
	mov	a,(_pwmCount + 1)
	subb	a,r3
	mov  _pwmCounter_sloc0_1_0,c
	cpl	c
	mov	_P0_0,c
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:74: P0_2 =1;
	setb	_P0_2
L003004?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:76: if(pwmLeft<0)
	mov	a,(_pwmLeft + 1)
	jnb	acc.7,L003006?
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:78: P0_2=(pwmLeft>pwmCount)?0:1;
	mov	r2,_pwmLeft
	mov	r3,(_pwmLeft + 1)
	clr	c
	mov	a,_pwmCount
	subb	a,r2
	mov	a,(_pwmCount + 1)
	subb	a,r3
	mov  _pwmCounter_sloc0_1_0,c
	cpl	c
	mov	_P0_2,c
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:79: P0_0=1;
	setb	_P0_0
L003006?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:82: if(pwmRight>0)
	clr	c
	clr	a
	subb	a,_pwmRight
	clr	a
	xrl	a,#0x80
	mov	b,(_pwmRight + 1)
	xrl	b,#0x80
	subb	a,b
	jnc	L003008?
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:84: P0_4=(pwmRight>pwmCount)?0:1;
	mov	r2,_pwmRight
	mov	r3,(_pwmRight + 1)
	clr	c
	mov	a,_pwmCount
	subb	a,r2
	mov	a,(_pwmCount + 1)
	subb	a,r3
	mov  _pwmCounter_sloc0_1_0,c
	cpl	c
	mov	_P0_4,c
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:85: P0_6=1;
	setb	_P0_6
L003008?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:87: if(pwmRight<0)
	mov	a,(_pwmRight + 1)
	jnb	acc.7,L003011?
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:89: P0_6=(pwmRight>pwmCount)?0:1;
	mov	r2,_pwmRight
	mov	r3,(_pwmRight + 1)
	clr	c
	mov	a,_pwmCount
	subb	a,r2
	mov	a,(_pwmCount + 1)
	subb	a,r3
	mov  _pwmCounter_sloc0_1_0,c
	cpl	c
	mov	_P0_6,c
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:90: P0_4=1;
	setb	_P0_4
L003011?:
	pop	psw
	pop	(0+1)
	pop	(0+0)
	pop	(0+7)
	pop	(0+6)
	pop	(0+5)
	pop	(0+4)
	pop	(0+3)
	pop	(0+2)
	pop	dph
	pop	dpl
	pop	b
	pop	acc
	pop	bits
	reti
;------------------------------------------------------------
;Allocation info for local variables in function '_c51_external_startup'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:98: unsigned char _c51_external_startup(void)
;	-----------------------------------------
;	 function _c51_external_startup
;	-----------------------------------------
__c51_external_startup:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:101: P0M0 = 0;	P0M1 = 0;
	mov	_P0M0,#0x00
	mov	_P0M1,#0x00
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:102: P1M0 = 0;	P1M1 = 0;
	mov	_P1M0,#0x00
	mov	_P1M1,#0x00
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:103: P2M0 = 0;	P2M1 = 0;
	mov	_P2M0,#0x00
	mov	_P2M1,#0x00
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:104: P3M0 = 0;	P3M1 = 0;
	mov	_P3M0,#0x00
	mov	_P3M1,#0x00
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:105: AUXR = 0B_0001_0001; // 1152 bytes of internal XDATA, P4.4 is a general purpose I/O
	mov	_AUXR,#0x11
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:106: P4M0 = 0;	P4M1 = 0;
	mov	_P4M0,#0x00
	mov	_P4M1,#0x00
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:109: PCON|=0x80;
	orl	_PCON,#0x80
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:110: SCON = 0x52;
	mov	_SCON,#0x52
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:111: BDRCON =0;
	mov	_BDRCON,#0x00
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:112: BRL=BRG_VAL;
	mov	_BRL,#0xFA
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:113: BDRCON=BRR|TBCK|RBCK|SPD;
	mov	_BDRCON,#0x1E
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:115: TMOD = 0x01;	// Timer 0 as 16-bit timer	
	mov	_TMOD,#0x01
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:116: TH0 = RH0 = TIMER0_RELOAD_VALUE / 0x100;
	mov	_RH0,#0xFF
	mov	_TH0,#0xFF
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:117: TL0 = RL0 = TIMER0_RELOAD_VALUE % 0x100;
	mov	_RL0,#0x48
	mov	_TL0,#0x48
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:118: TR0 = 1;
	setb	_TR0
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:119: ET0 = 1;	// Enable timer 0 interrupt
	setb	_ET0
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:120: EX0 = 1;	// Enable external interrupt 0
	setb	_EX0
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:121: IT0 = 1;
	setb	_IT0
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:122: EA = 1; 	// Enable global interrupts
	setb	_EA
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:125: pwmRight=0;
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:126: pwmLeft=0;
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:127: instruction=0;
	clr	a
	mov	_pwmRight,a
	mov	(_pwmRight + 1),a
	mov	_pwmLeft,a
	mov	(_pwmLeft + 1),a
	mov	_instruction,a
	mov	(_instruction + 1),a
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:128: Stage=3;
	mov	_Stage,#0x03
	clr	a
	mov	(_Stage + 1),a
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:129: return 0;
	mov	dpl,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:133: int main (void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:137: while (instruction==0)
L005001?:
	mov	a,_instruction
	orl	a,(_instruction + 1)
	jnz	L005003?
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:139: moveCar();
	lcall	_moveCar
	sjmp	L005001?
L005003?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:142: switch (instruction)
	mov	r2,_instruction
	mov	r3,(_instruction + 1)
	cjne	r2,#0x01,L005030?
	cjne	r3,#0x00,L005030?
	sjmp	L005004?
L005030?:
	cjne	r2,#0x02,L005031?
	cjne	r3,#0x00,L005031?
	sjmp	L005007?
L005031?:
	cjne	r2,#0x03,L005032?
	cjne	r3,#0x00,L005032?
	sjmp	L005010?
L005032?:
	cjne	r2,#0x04,L005033?
	cjne	r3,#0x00,L005033?
	sjmp	L005014?
L005033?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:144: case 1: //Move Forward to Next Node
	cjne	r2,#0x05,L005013?
	cjne	r3,#0x00,L005013?
	sjmp	L005014?
L005004?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:145: if(Stage!=0)
	mov	a,_Stage
	orl	a,(_Stage + 1)
	jz	L005014?
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:146: Stage--;
	dec	_Stage
	mov	a,#0xff
	cjne	a,_Stage,L005036?
	dec	(_Stage + 1)
L005036?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:147: break;
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:148: case 2: //Move Backwards to Next Node
	sjmp	L005014?
L005007?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:149: if(Stage!=5)
	mov	a,#0x05
	cjne	a,_Stage,L005037?
	clr	a
	cjne	a,(_Stage + 1),L005037?
	sjmp	L005014?
L005037?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:150: Stage++;
	mov	a,#0x01
	add	a,_Stage
	mov	_Stage,a
	clr	a
	addc	a,(_Stage + 1)
	mov	(_Stage + 1),a
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:151: break;
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:152: case 3: //180 Turn
	sjmp	L005014?
L005010?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:153: pwmLeft=50;
	mov	_pwmLeft,#0x32
	clr	a
	mov	(_pwmLeft + 1),a
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:154: pwmRight=(-50);
	mov	_pwmRight,#0xCE
	mov	(_pwmRight + 1),#0xFF
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:155: wait1s();
	lcall	_wait1s
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:156: pwmLeft=pwmRight=0;
	clr	a
	mov	_pwmRight,a
	mov	(_pwmRight + 1),a
	mov	_pwmLeft,a
	mov	(_pwmLeft + 1),a
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:157: break;
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:164: default: //Turn on LED for bad instrucion
	sjmp	L005014?
L005013?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:165: RED=1;
	setb	_P0_0
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:166: GRN=0;
	clr	_P0_1
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:167: YLW=0;
	clr	_P0_2
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:169: }
L005014?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:171: instruction=0;
	clr	a
	mov	_instruction,a
	mov	(_instruction + 1),a
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:173: return 0;
	ljmp	L005001?
;------------------------------------------------------------
;Allocation info for local variables in function 'getDistance'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:184: unsigned int getDistance() 
;	-----------------------------------------
;	 function getDistance
;	-----------------------------------------
_getDistance:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:186: return 0;
	mov	dptr,#0x0000
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'getAngle'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:195: float getAngle()
;	-----------------------------------------
;	 function getAngle
;	-----------------------------------------
_getAngle:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:198: return angle;
	mov	dpl,_angle
	mov	dph,(_angle + 1)
	mov	b,(_angle + 2)
	mov	a,(_angle + 3)
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'getDirection'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:206: char getDirection()
;	-----------------------------------------
;	 function getDirection
;	-----------------------------------------
_getDirection:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:210: return 0;
	mov	dpl,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'turnCar'
;------------------------------------------------------------
;Rwheel                    Allocated with name '_turnCar_PARM_2'
;Lwheel                    Allocated to registers 
;------------------------------------------------------------
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:218: void turnCar(unsigned int Lwheel, unsigned int Rwheel)
;	-----------------------------------------
;	 function turnCar
;	-----------------------------------------
_turnCar:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:223: return;
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'moveCar'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:231: void moveCar()
;	-----------------------------------------
;	 function moveCar
;	-----------------------------------------
_moveCar:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:233: if(distance > PRESETS[Stage])
	mov	a,_Stage
	add	a,acc
	mov	r2,a
	mov	a,(_Stage + 1)
	rlc	a
	mov	r3,a
	mov	a,r2
	add	a,#_PRESETS
	mov	dpl,a
	mov	a,r3
	addc	a,#(_PRESETS >> 8)
	mov	dph,a
	clr	a
	movc	a,@a+dptr
	mov	r2,a
	inc	dptr
	clr	a
	movc	a,@a+dptr
	mov	r3,a
	clr	c
	mov	a,r2
	subb	a,_distance
	mov	a,r3
	subb	a,(_distance + 1)
	jnc	L010005?
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:235: pwmLeft=pwmRight=(75);
	mov	_pwmRight,#0x4B
	clr	a
	mov	(_pwmRight + 1),a
	mov	_pwmLeft,#0x4B
	clr	a
	mov	(_pwmLeft + 1),a
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:236: while(distance > PRESETS[Stage])
L010001?:
	mov	a,_Stage
	add	a,acc
	mov	r2,a
	mov	a,(_Stage + 1)
	rlc	a
	mov	r3,a
	mov	a,r2
	add	a,#_PRESETS
	mov	dpl,a
	mov	a,r3
	addc	a,#(_PRESETS >> 8)
	mov	dph,a
	clr	a
	movc	a,@a+dptr
	mov	r2,a
	inc	dptr
	clr	a
	movc	a,@a+dptr
	mov	r3,a
	clr	c
	mov	a,r2
	subb	a,_distance
	mov	a,r3
	subb	a,(_distance + 1)
	jnc	L010005?
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:238: adjustAngle();
	lcall	_adjustAngle
	sjmp	L010001?
L010005?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:241: if(distance < PRESETS[Stage])
	mov	a,_Stage
	add	a,acc
	mov	r2,a
	mov	a,(_Stage + 1)
	rlc	a
	mov	r3,a
	mov	a,r2
	add	a,#_PRESETS
	mov	dpl,a
	mov	a,r3
	addc	a,#(_PRESETS >> 8)
	mov	dph,a
	clr	a
	movc	a,@a+dptr
	mov	r2,a
	inc	dptr
	clr	a
	movc	a,@a+dptr
	mov	r3,a
	clr	c
	mov	a,_distance
	subb	a,r2
	mov	a,(_distance + 1)
	subb	a,r3
	jnc	L010010?
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:243: pwmLeft=pwmRight=(-75);
	mov	_pwmRight,#0xB5
	mov	(_pwmRight + 1),#0xFF
	mov	_pwmLeft,#0xB5
	mov	(_pwmLeft + 1),#0xFF
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:244: while(distance < PRESETS[Stage])
L010006?:
	mov	a,_Stage
	add	a,acc
	mov	r2,a
	mov	a,(_Stage + 1)
	rlc	a
	mov	r3,a
	mov	a,r2
	add	a,#_PRESETS
	mov	dpl,a
	mov	a,r3
	addc	a,#(_PRESETS >> 8)
	mov	dph,a
	clr	a
	movc	a,@a+dptr
	mov	r2,a
	inc	dptr
	clr	a
	movc	a,@a+dptr
	mov	r3,a
	clr	c
	mov	a,_distance
	subb	a,r2
	mov	a,(_distance + 1)
	subb	a,r3
	jnc	L010010?
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:246: adjustAngle();
	lcall	_adjustAngle
	sjmp	L010006?
L010010?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:249: pwmLeft=pwmRight=0;
	clr	a
	mov	_pwmRight,a
	mov	(_pwmRight + 1),a
	mov	_pwmLeft,a
	mov	(_pwmLeft + 1),a
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:251: return;
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'adjustAngle'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:253: void adjustAngle()
;	-----------------------------------------
;	 function adjustAngle
;	-----------------------------------------
_adjustAngle:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:255: if (angle < -2)
	clr	a
	push	acc
	push	acc
	push	acc
	mov	a,#0xC0
	push	acc
	mov	dpl,_angle
	mov	dph,(_angle + 1)
	mov	b,(_angle + 2)
	mov	a,(_angle + 3)
	lcall	___fslt
	mov	r2,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,r2
	jz	L011002?
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:257: pwmLeft=+5;
	mov	_pwmLeft,#0x05
	clr	a
	mov	(_pwmLeft + 1),a
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:258: pwmRight=-5;
	mov	_pwmRight,#0xFB
	mov	(_pwmRight + 1),#0xFF
L011002?:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:260: if (angle > 2)
	clr	a
	push	acc
	push	acc
	push	acc
	mov	a,#0x40
	push	acc
	mov	dpl,_angle
	mov	dph,(_angle + 1)
	mov	b,(_angle + 2)
	mov	a,(_angle + 3)
	lcall	___fsgt
	mov	r2,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,r2
	jz	L011005?
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:262: pwmLeft=-5;
	mov	_pwmLeft,#0xFB
	mov	(_pwmLeft + 1),#0xFF
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:263: pwmRight=+5;
	mov	_pwmRight,#0x05
	clr	a
	mov	(_pwmRight + 1),a
L011005?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'wait2ms'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:267: void wait2ms (void)
;	-----------------------------------------
;	 function wait2ms
;	-----------------------------------------
_wait2ms:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:277: _endasm;
	
  ;For a 22.1184MHz crystal one machine cycle
  ;takes 12/22.1184MHz=0.5425347us
	 J3:
	mov R4, #10
	 J2:
	mov R3, #184
	 J1:
	djnz R3, J1 ; 2 machine cycles-> 2*0.5425347us*184=200us
	     djnz R4, J2 ; 200us*250=0.05s
	     ret
	    
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'wait1s'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:281: void wait1s (void)
;	-----------------------------------------
;	 function wait1s
;	-----------------------------------------
_wait1s:
;	C:\Users\q9x8\Documents\GitHub\Projects\Project2_Car\Code\Movement Simulator.c:293: _endasm;
	
  ;For a 22.1184MHz crystal one machine cycle
  ;takes 12/22.1184MHz=0.5425347us
	     mov R2, #20
	 L3:
	mov R1, #248
	 L2:
	mov R0, #184
	 L1:
	djnz R0, L1 ; 2 machine cycles-> 2*0.5425347us*184=200us
	     djnz R1, L2 ; 200us*250=0.05s
	     djnz R2, L3 ; 0.05s*20=1s
	     ret
	    
	ret
	rseg R_CSEG

	rseg R_XINIT

	rseg R_CONST
_PRESETS:
	db 0x05,0x00	;  5
	db 0x0A,0x00	;  10
	db 0x0F,0x00	;  15
	db 0x14,0x00	;  20
	db 0x19,0x00	;  25
	db 0x1E,0x00	;  30

	CSEG

end
