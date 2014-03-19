/*
	EECE 281 Project 2
	
	Core File
	Written for AT89LP51 on the LP51 microcontroller
	
	CodeName: Mr. Squiggles
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
#define TIMER_2_RELOAD (0x10000L-(CLK/(32L*BAUD)))
#define FREQ 10000L
#define RED P0_0
#define GRN P0_1
#define YLW P0_2

//---Global Variables---

const int TOO_FAR   = 10;
const int TOO_CLOSE = 5;
const int DISTANCE_CONSTANT = 0.0036;
const unsigned int PRESETS[] = {5,10,15,20,25,30,35,40,45,50,55,60};

volatile int pwmCount = 0;
volatile int pwmLeft = 0;
volatile int pwmRight = 0;
volatile unsigned int leftSensor = 0;
volatile unsigned int rightSensor = 0;

//left and right coil distances
unsigned int distanceLeft = 40;
unsigned int distanceRight = 50;

//current instruction
unsigned int instruction = 0;

//current preset distance
unsigned int Stage = 2;

//---Function Prototypes---

void getDistance();
void turnCar();
void moveCar();
void wait2ms();
void wait1s();
float voltage (unsigned char channel);
void SPIWrite(unsigned char value);
unsigned int GetADC(unsigned char channel);

//---Interrupts---

void beaconSignal() interrupt 0
{
	// TODO
	// quickly check if signal is zero, if not, return
	// if it is zero, get the new instruction and allocate
	//
	// -if volatge(0)< min??
	//   -get message
	// -else
	//  -return
	//	
}

void pwmCounter() interrupt 1
{
	
	if(++pwmCount > 99)
		pwmCount = 0;
		
	//Get left and right distances
	//if they arent equal, stop moving and re-align
	getDistance();
	
		
	//Left wheel
	if(pwmLeft > 0)
	{	
		P1_1 = (pwmLeft > pwmCount) ? 0:1;
		P1_0 = 1;
	}
	if(pwmLeft < 0)
	{	
		P1_0 = ((-1) * pwmLeft > pwmCount) ? 0:1;
		P1_1 = 1;
	}
	
	//Right wheel
	if(pwmRight > 0)
	{	
		P1_4 = (pwmRight > pwmCount) ? 0:1;
		P1_3 = 1;
	}
	if(pwmRight < 0)
	{	
		P1_3 = ((-1) * pwmRight > pwmCount) ? 0:1;
		P1_4 = 1;
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
	
	TMOD = 0x01;	// Timer 0 as 16-bit timer	
	TH0 = RH0 = TIMER0_RELOAD_VALUE / 0x100;
	TL0 = RL0 = TIMER0_RELOAD_VALUE % 0x100;
	TR0 = 1;
	ET0 = 1;	// Enable timer 0 interrupt
	EX0 = 1;	// Enable external interrupt 0
	IT0 = 1;
	EA = 1; 	// Enable global interrupts
	
    return 0;
}

//---MAIN---
int main (void)
{		
	while (1)
	{	
		//stay on tether until instruction is read
		while (instruction == 0)
		{
			moveCar();
			//inplace turning if car is not aligned
			if(distanceLeft != distanceRight)
			{	
				P3_3 = 1;
				turnCar();
			}
		}
		
		//get instruction and go back to tether
		switch (instruction)
		{
			case 1: //Move Forward
				if(Stage != 0)
					Stage--;
				P3_3 = 0;
				break;
			case 2: //Move Backwards
				if(Stage != 7)
					Stage++;
				P3_3 = 0;	
				break;
			case 3: //180 Turn
				P3_3 = 0;
				break;
			case 4: //Park
				P3_3 = 0;
				break;
			case 5:
				P3_3 = 0;
				break;
			default: //Turn on LED for bad instrucion	
			
		}
		instruction = 0;
	}
	return 0;
}

//---Function Implementations---

/*	getDistance(): calculates the linear distance from the beacon using peak detectors
 *				 
 *	Requires: nada
 *	Modify:	  distance(L and R)
 *	Returns:  nothing, changes global variables left and right distance  
 */
void getDistance() 
{
	// TODO
	//get distance left and right and store to global variables
}

/*	turnCar(): turn both wheels individually to align vehicle with angle
 *	Requires: nada, looks at globals
 *	Modify:	 n/a
 *	Returns:  n/a
 */
void turnCar()
{
	//turn towards beacon
	while(distanceLeft < distanceRight)
	{
		pwmLeft = 50;
		pwmRight = (-50);
	}
	while(distanceLeft > distanceRight)
	{
		pwmLeft = (-50);
		pwmRight = 50;
	}
}

/*	moveCar(): move the car towards the beacon if neccessarry
 *  Requires: distanceRight, distanceLeft
 *  Modify:   pwmRight, pwmLeft
 *  Returns:  n/a
 */
void moveCar()
{	
	//move forward or back as long as aligned and not at right distance
	while (distanceRight > PRESETS[Stage] && distanceLeft==distanceRight)
	{
		pwmLeft = 50;
		pwmRight = 50;
	}
	//while(distanceRight > PRESETS[Stage] && distanceLeft==distanceRight)
	//{
	//	pwmLeft = pwmRight = (-75);		
	//}
	//done, stop
	pwmLeft=pwmRight=0;
	return;
}

// wait for 2 milliseconds
void wait2ms (void)
{
	_asm	
		;For a 22.1184MHz crystal one machine cycle 
		;takes 12/22.1184MHz=0.5425347us
	J3:	mov R4, #10
	J2:	mov R3, #184
	J1:	djnz R3, J1 ; 2 machine cycles-> 2*0.5425347us*184=200us
	    djnz R4, J2 ; 200us*250=0.05s
	    ret
    _endasm;
}

// wait for one second
void wait1s (void)
{
	_asm	
		;For a 22.1184MHz crystal one machine cycle 
		;takes 12/22.1184MHz=0.5425347us
	    mov R2, #20
	L3:	mov R1, #248
	L2:	mov R0, #184
	L1:	djnz R0, L1 ; 2 machine cycles-> 2*0.5425347us*184=200us
	    djnz R1, L2 ; 200us*250=0.05s
	    djnz R2, L3 ; 0.05s*20=1s
	    ret
    _endasm;
}

/*	voltage(): returns the voltage read by the MCP3004
 *	Requires:  channel
 *  Modifies:  n/a
 *  Returns:   voltage in channel specified
 */
float voltage (unsigned char channel)
{
	return ((GetADC(channel) * 4.84) / 1023.0); // VCC=4.84V (measured)
}

void SPIWrite(unsigned char value)
{
	SPSTA &= (~SPIF); // Clear the SPIF flag in SPSTA
	SPDAT = value;
	while ((SPSTA & SPIF) != SPIF); //Wait for transmission to end
}

// Read 10 bits from the MCP3004 ADC converter
unsigned int GetADC(unsigned char channel)
{
	unsigned int adc;

	// initialize the SPI port to read the MCP3004 ADC attached to it.
	SPCON &= (~SPEN); // Disable SPI
	SPCON = MSTR | CPOL | CPHA | SPR1 | SPR0 | SSDIS;
	SPCON |= SPEN; // Enable SPI
	
	P1_4 = 0; // Activate the MCP3004 ADC.
	SPIWrite(channel | 0x18);	// Send start bit, single/diff* bit, D2, D1, and D0 bits.
	for (adc=0; adc < 10; adc++); // Wait for S/H to setup
	SPIWrite(0x55); // Read bits 9 down to 4
	adc=((SPDAT & 0x3f) * 0x100);
	SPIWrite(0x55);// Read bits 3 down to 0
	P1_4 = 1; // Deactivate the MCP3004 ADC.
	adc += (SPDAT & 0xf0); // SPDR contains the low part of the result. 
	adc >>= 4;
		
	return adc;
}
