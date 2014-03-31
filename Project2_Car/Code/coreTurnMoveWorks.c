/*
	EECE 281 Project 2
	
	Core File
	Written for AT89LP51 on the LP51 microcontroller
	
	CodeName: Mr. Squiggles

	PINS:
		P2_0 = Green Led
		P2_1 = Yellow Led
		P2_2 = Red Led
	
		P0_0 = Left Wheel
		P0_1 = Left Wheel  
		P0_3 = Right Wheel
		P0_4 = Right wheel	
		
		P1_4 = MCP3004 pin 8
		P1_5 = MCP3004 pin 10
		P1_6 = MCP3004 pin 11
		P1_7 = MCP3004 pin 9
*/

//---Included Files---

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <at89lp51rd2.h>

//---Defined Macros---

#define CLK 22118400L
#define BAUD 115200L
#define BRG_VAL (0x100-(CLK/(32L*BAUD)))
#define TIMER0_RELOAD_VALUE (65536L-(CLK/(12L*FREQ)))
#define TIMER1_RELOAD_VALUE (65536L-(CLK/(12L*FREQ1)))
#define TIMER_2_RELOAD (0x10000L-(CLK/(32L*BAUD)))
#define FREQ 10000L
#define FREQ1 5000L
#define RED P0_0
#define GRN P0_1
#define YLW P0_2

/* Some ANSI escape sequences */
#define CURSOR_ON "\x1b[?25h"
#define CURSOR_OFF "\x1b[?25l"
#define CLEAR_SCREEN "\x1b[2J"
#define GOTO_YX "\x1B[%d;%dH"
#define CLR_TO_END_LINE "\x1B[K"
/* Black foreground, white background */
#define BKF_WTB "\x1B[0;30;47m"
#define FORE_BACK "\x1B[0;3%d;4%dm"
#define FONT_SELECT "\x1B[%dm"

//---Global Variables---

// speed to move and turn
const int MOVESPEED = 80; 
const int TURNSPEED = 100;

// buffers of error for aligning and distance
const float DISTANCEBUFFER = 20;
float ANGLEBUFFER = 20;

// preset distances
const int NSTAGES=12;
const int PRESETS[] = {600, 550, 500, 450, 400, 350, 300, 250, 200, 150, 100, 50};

// pwm modulation
volatile unsigned int pwmCount = 0;
volatile unsigned int distCount = 0;
volatile int pwmLeft;
volatile int pwmRight;
volatile int direction;
volatile int tether;
volatile unsigned int leftSensor = 0;
volatile unsigned int rightSensor = 0;
volatile int pwmLeftTemp = 0;
volatile int pwmRightTemp = 0;

//left and right coil distances
volatile int distanceLeft;
volatile int distanceRight;
volatile int tempL;
volatile int tempR;
volatile int tempTurn;

//current instruction
volatile unsigned int instruction;
volatile unsigned int gotInst;
volatile int good;

//Start up preset distance
volatile unsigned int Stage;

//---Function Prototypes---

void getDistance();							// get distance using sensors
void moveCar();								// turn and move back and forwards
void uTurn();								// turn 180 degrees
void parallelPark();						// parallel park...
unsigned int getSig();						// recieve signal from beacon
void wait1s();								// wait a sec
void waiths();								// wait half a sec
void SPIWrite(unsigned char value);			// send signals to MCP
unsigned int GetADC(unsigned char channel); // get distance value from sensor
void wait_bit_time();						// wait duration of one send bit
void wait_one_and_half_bit_time();			// wait duration of one and a half send bits

//---Interrupts---

// do pwm for wheels and printout using ET0
void pwmCounter() interrupt 1
{		
	if(++pwmCount > 99)
	{
		pwmCount = 0;
	}	
	
	// getprint stuff ever .1secc
	//if (++distCount > 999)
	//{
	//	distCount = 0;	
	//	Stage = 6;
	//	printf("DL %3d - DR %3d - Stage %3d(%d) - Inst %d\r", distanceLeft, distanceRight, PRESETS[Stage], Stage, instruction);
	//}
	
	//Left wheel
	if(pwmLeft > 0) //forwards
	{	
		P0_1 = (pwmLeft > pwmCount) ? 0:1;
		P0_0 = 1;
	}
	else if(pwmLeft < 0) //reverse
	{	

		P0_0 = ((-1) * pwmLeft > pwmCount) ? 0:1;
		P0_1 = 1;
	}
	else if(pwmLeft == 0) //stop
	{
		P0_1 = P0_0 = 1;
	}
	
	//Right wheel
	if(pwmRight > 0)   //forwards
	{	
		P0_4 = (pwmRight > pwmCount) ? 0:1;
		P0_3 = 1;
	}
	else if(pwmRight < 0) //reverse
	{	

		P0_3 = ((-1) * pwmRight > pwmCount) ? 0:1;
		P0_4 = 1;
	}
	else if(pwmRight == 0)   //stop
	{
		P0_4 = P0_3 = 1;
	}
}

// recieve signals from beacon using ET1
void beaconSignal() interrupt 3
{
	if (GetADC(0) < 10) 
	{
		pwmLeft = pwmRight = 0;
		
		ET0 = 0;                   //make sure pwm doesnt fuck anything up
		while(GetADC(0) < 10);
		instruction = getSig();
		ET0 =  1;
	}
}		

//---Boot---

unsigned char _c51_external_startup(void)
{
	// Configure ports as a bidirectional with internal pull-ups.
	P0M0 = 0;	P0M1 = 0;
	P1M0 = 0;	P1M1 = 0;
	P2M0 = 0;	P2M1 = 0;
	P3M0 = 0;	P3M1 = 0;
	AUXR = 0B_0001_0001; // 1152 bytes of internal XDATA, P4.4 is a general purpose I/O
	P4M0 = 0;	P4M1 = 0;
	
	// Instead of using a timer to generate the clock for the serial
    // port, use the built-in baud rate generator.
    PCON |= 0x80;
	SCON = 0x52;
    BDRCON = 0;
    BRL = BRG_VAL;
    BDRCON = BRR | TBCK | RBCK | SPD;
	
	TMOD = 0B_0001_0001;	// Timer 0 as 16-bit timer	
	TH0 = RH0 = TIMER0_RELOAD_VALUE / 0x100;
	TL0 = RL0 = TIMER0_RELOAD_VALUE % 0x100;
	TH1 = RH1 = TIMER1_RELOAD_VALUE / 0x100;
	TL1 = RL1 = TIMER1_RELOAD_VALUE % 0x100;
	TR0 = 1;
	TR1 = 0;
	ET0 = 1;	// Enable timer 0 interrupt
	EA = 1; 	// Enable global interrupts
	
	tether = 0;
	direction = 1;
	P2_2 = 1;
	P2_1 = 1;
	P2_0 = 1;
	printf(CLEAR_SCREEN);
    return 0;
}

//---MAIN---
int main()
{	

	pwmLeft = 0;
	pwmRight = 0;
	instruction = 0;
	
	while (1)
	{	
		//stay on tether until instruction is read
		while (instruction == 0)
		{	
			moveCar();
		}
		/*
		//get instruction and go back to tether
		if(instruction==1)                        //move forward
		{
			if(Stage!=0)
				Stage--;
			printf("\nMove forwrds");
		}
		else if(instruction==2)                  //move backwards
		{
			if(Stage!=NSTAGES)
				Stage++;
			printf("\n Move back");	
		}
		else if(instruction==3)                  //uturn
		{
			uTurn();
			printf("\nturned");
		}
		else if(instruction==4)                  //parralell park
		{
			//park
		}
		else if(instruction==5)
		{
			int i;
			//break tether	
			instruction=0;
			while(instruction!=5);
			
			//re-initiate tether at current distance
			for(i=0;i<NSTAGES;i++)
			{
				if(distanceLeft>PRESETS[i]-3 && distanceLeft<PRESETS[i]+3)
				{
					Stage=i;
				}
			}
		}
		else
		{
			P2_2=0;
			P2_1=1;
			P2_0=1;
		}*/
	}
	return 0;
}

//---Function Implementations---

/*	getDistance(): calculates the linear distance from the beacon using peak detectors
 *				   ANGLEBUFFER is altered to compensate for greater or lesser distances
 *	Requires: N/A
 *	Modify:	  distanceLeft, distanceRight, ANGLEBUFFER
 *	Returns:  N/A
 */
void getDistance() 
{
	EA = 0;                                     //make sure pwm doesnt fuck anything up
	tempL = GetADC(1);                     
	if (tempL > 10)                             //toss away very low reads and keep old
	{
		distanceLeft = tempL;
	}
		
	tempR = GetADC(0);                          //handle bad inductor angle with some offset
	if (tempR > 13 && tempR < 250)
	{
		distanceRight = tempR * 1.15;
		ANGLEBUFFER = 7;
	}
	else if(tempR >= 250)
	{
		distanceRight = tempR * 1.05;
		ANGLEBUFFER = 10;
	}	
	EA = 1;
}

/*	moveCar(): move the car towards the beacon if necessary by means of turning and accelerating
 *  Requires: N/A
 *  Modify:   pwmRight, pwmLeft
 *  Returns:  N/A
 */
void moveCar()
{	
	// see if edge sensors sense an object
	/*if (P1_1 == 0 || P1_2 == 0 || P1_3 == 0)
	{
		pwmLeft = pwmRight = 0;
		P2_2=0;
		P2_1=1;
		P2_0=1;
		return;
	}*/
	
	good = 0;
	
	getDistance();                                          //if there is no wave, turn on red and sit tight
	if(distanceLeft==0 && distanceRight==0)
	{
		pwmLeft=pwmRight=0;
		P2_2=0;
		P2_1=1;
		P2_0=1;
	}
	else                                                   //were getting a reading, move and turn
	{
		//turn towards beacon
		if(distanceRight > (distanceLeft+ANGLEBUFFER))
		{
			pwmLeft = (-TURNSPEED);
			pwmRight= (TURNSPEED);
		}
		else if(distanceLeft > (distanceRight+ANGLEBUFFER))
		{
			pwmLeft = (TURNSPEED);
			pwmRight = (-TURNSPEED);
		}
		else
		{
			good++;                                        //both angle tests passed 
		}
		
		getDistance();
		//move forward if too far and aligned
		if ((distanceRight+DISTANCEBUFFER) < PRESETS[Stage])
		{
			pwmLeft = (MOVESPEED);
			pwmRight = (MOVESPEED);
		}
		//move back if too close and aligned
		else if (distanceRight > (PRESETS[Stage]+DISTANCEBUFFER))
		{		
			pwmLeft = (-MOVESPEED);
			pwmRight = (-MOVESPEED);
		}
		else
		{
			good++;                                           //both distance tests passed
		}		
		// check to see if car is completely stable and ready to accept a signal
		if (good < 2)
		{
			P2_2=1;
			P2_1=0; // yellow
			P2_0=1;
			//ET1 = 0;
		}		
		else
		{
			pwmLeft=pwmRight=0;
			P2_2=1;
			P2_1=1; // blue
			P2_0=0;
			//ET1 = 1;
		}
	}		
	return;
}

// pull a uTurn obviously
void uTurn()
{
	P2_2=1;
	P2_1=0; // yellow
	P2_0=1;
	
	pwmLeft = TURNSPEED;
	pwmRight = (-TURNSPEED);
	wait1s();
	wait1s();
	P2_2=1;
	P2_1=1; // blue
	P2_0=0;
	
	pwmLeft = pwmRight = 0;
	return;
}

// park with the space on the right side of the car
void parallelPark()
{
	P2_2=1;
	P2_1=0; // yellow
	P2_0=1;
	
	// back up a bit
	pwmLeft = pwmRight = (-MOVESPEED);
	waiths();
	
	// turn to approach angle
	pwmLeft = (-TURNSPEED);
	pwmRight = TURNSPEED;
	waiths();
	
	// back into position
	pwmLeft = pwmRight = (-MOVESPEED);
	waiths();
	
	// turn into final angle
	pwmLeft = TURNSPEED;
	pwmRight = (-TURNSPEED);
	waiths();
	
	// back into final position
	pwmLeft = pwmRight = (-MOVESPEED);
	waiths();
}

// recieve a signal from the beacon
unsigned int getSig()
{
	unsigned int j, val;
	float v;
	
	// skip the start bit
	val = 0;
	wait_one_and_half_bit_time();
	
	// take in a signal LSB first
	for (j = 0; j < 3; j++) {
		v = GetADC(0);
		val |= (v > 10) ? (0x01 << j) : 0x00;
		wait_bit_time();
	}
	
	return val;
}

// wait for one second
void wait1s()
{
	_asm	
		;For a 22.1184MHz crystal one machine cycle 
		;takes 12/22.1184MHz=0.5425347us
	    mov R2, #10
	L3:	mov R1, #180
	L2:	mov R0, #180
	L1:	djnz R0, L1 ; 2 machine cycles-> 2*0.5425347us*184=200us
	    djnz R1, L2 ; 200us*250=0.05s
	    djnz R2, L3 ; 0.05s*20=1s
	    ret
    _endasm;
}

// wait for half a second
void waiths()
{
	_asm	
		;For a 22.1184MHz crystal one machine cycle 
		;takes 12/22.1184MHz=0.5425347us
	    mov R2, #10
	E3:	mov R1, #90
	E2:	mov R0, #180
	E1:	djnz R0, E1 ; 2 machine cycles-> 2*0.5425347us*184=200us
	    djnz R1, E2 ; 200us*250=0.05s
	    djnz R2, E3 ; 0.05s*20=1s
	    ret
    _endasm;
}

// communicate with MCP
void SPIWrite(unsigned char value)
{
	SPSTA&=(~SPIF); // Clear the SPIF flag in SPSTA
	SPDAT=value;
	while((SPSTA & SPIF)!=SPIF); //Wait for transmission to end
}

// Read 10 bits from the MCP3004 ADC converter
unsigned int GetADC(unsigned char channel)
{
	unsigned int adc;

	// initialize the SPI port to read the MCP3004 ADC attached to it.
	SPCON&=(~SPEN); // Disable SPI
	SPCON=MSTR|CPOL|CPHA|SPR1|SPR0|SSDIS;
	SPCON|=SPEN; // Enable SPI
	
	P1_4=0; // Activate the MCP3004 ADC.
	SPIWrite(channel|0x18);	// Send start bit, single/diff* bit, D2, D1, and D0 bits.
	for(adc=0; adc<10; adc++); // Wait for S/H to setup
	SPIWrite(0x55); // Read bits 9 down to 4
	adc=((SPDAT&0x3f)*0x100);
	SPIWrite(0x55);// Read bits 3 down to 0
	P1_4=1; // Deactivate the MCP3004 ADC.
	adc+=(SPDAT&0xf0); // SPDR contains the low part of the result. 
	adc>>=4;
		
	return adc;
}
//for the instruction reception
void wait_bit_time()
{
	_asm	
		;For a 22.1184MHz crystal one machine cycle 
		;takes 12/22.1184MHz=0.5425347us
	    mov R2, #2
	K3:	mov R1, #248
	K2:	mov R0, #184
	K1:	djnz R0, K1 ; 2 machine cycKes-> 2*0.5425347us*184=200us
	    djnz R1, K2 ; 200us*250=0.05s
	    djnz R2, K3 ; 0.05s*20=1s
	    ret
    _endasm;
}

void wait_one_and_half_bit_time()
{
	_asm	
		;For a 22.1184MHz crystal one machine cycle 
		;takes 12/22.1184MHz=0.5425347us
	    mov R2, #3
	J3:	mov R1, #248
	J2:	mov R0, #184
	J1:	djnz R0, J1 ; 2 machine cycJes-> 2*0.5425347us*184=200us
	    djnz R1, J2 ; 200us*250=0.05s
	    djnz R2, J3 ; 0.05s*20=1s
	    ret
    _endasm;
}