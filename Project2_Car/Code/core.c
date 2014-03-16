/*
	EECE 281 Project 2
	
	Core File
	Written for AT89LP51
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

//---Global Variables---

static const int TOO_FAR   = 10;
static const int TOO_CLOSE = 5;
static const int DISTANCE_CONSTANT = 0.0036;

struct voltage
{
	float peak;
	float RMS;
	float phase;
};


volatile unsigned int pwmCount = 0;
volatile unsigned int leftPwm = 0;
volatile unsigned int rightPwm = 0;
volatile unsigned int leftSensor = 0;
volatile unsigned int rightSensor = 0;
unsigned int distance;
char turnDirection;
float angle;

//---Function Prototypes---

unsigned int getDistance();
float getAngle();
char getDirection(float angle);
void turnCar(unsigned int Lwheel, unsigned int Rwheel, unsigned char turnDirection);
void moveCar(unsigned int dist);
void wait2ms();
void wait1s();
float voltage (unsigned char channel);
void SPIWrite(unsigned char value);
unsigned int GetADC(unsigned char channel);

//---Interrupts---

void beaconSignal() interrupt 0
{
	// TODO
}

void pwmCounter() interrupt 1
{
	if(++pwmCount>99)
	{
		pwmCount = 0;
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
    
    // Initialize the serial port and baud rate generator
    PCON |= 0x80;
	SCON = 0x53;
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
		distance = getDistance();
		angle = getAngle();
		turnDirection = getDirection(angle);
		
		turnCar(leftPwm, rightPwm, turnDirection);
		moveCar(distance);
	}
	
	return 0;
}

//---Function Implementations---

/*	getDistance(): calculates the linear distance from the beacon using
 *				   the EXT interrupt to interpret the beacon's signal
 *	Requires: external interrupt 0
 *	Modify:	  distance
 *	Returns:  distance to beacon   
 */
unsigned int getDistance(struct voltage x, struct voltage y) 
{
	int distance = pow( (DISTANCE_CONSTANT / (sqrtf(x.peak*x.peak + y.peak*y.peak))) , 1/3); //maybe this should be a float
	
	//from the formula: pythagoras(Vx,Vy) = K/d^3 -> d = (K/pyth)^(1/3)
	
	return distance;
}

/*	getAngle(): computes the angle that the car must turn to align with
 *              the beacon
 *	Requires: leftSensor, rightSensor
 *  Modify:   angle
 *  Returns:  angle to turn car chassis in degrees 
 */
float getAngle(struct voltage x, struct voltage y)
{
	float angle    = atanf(x.peak / y.peak);

	return angle;
}

/*	getDirection(): find which the direction the car need turn L/R
 *	Requires: angle
 *	Modify:   turnDirection
 *	Returns:  direction to turn car, left or right
 */
char getDirection(float angle, struct voltage forward, struct voltage back)
{
	
	//calculate which of four angles is correct (incomplete)
	//instead of using a second set of sensors (forward and back)
	//we could use x.phase and y.phase, I'll work on it
	
	if(forward.peak > back.peak)
		angle = angle; //turn left
	else if(back.peak < forward.peak)
		angle = angle; //turn right
	else
		angle = angle; //test by changing direction and get new values (or something else?)
	return 'd';
}

/*	turnCar(): turn both wheels individually to align vehicle with angle
 *	Requires: leftPwm, rightPwm, turnDirection
 *	Modify:	 n/a
 *	Returns:  n/a
 */
void turnCar(unsigned int Lwheel, unsigned int Rwheel, unsigned char turnDirection, struct voltage x)
{
	//turn towards beacon until parallel voltage becomes weakest and starts to rise
	
	float min;
	
	do
	{
		//continue to turn
		if(x.peak < min) min = x.peak;
		
	}while(x.peak <= min);
}

/*	moveCar(): move the car towards the beacon if neccessarry
 *  Requires: distance
 *  Modify:   n/a
 *  Returns:  n/a
 */
void moveCar(unsigned int dist)
{
	if(distance > TOO_CLOSE)
		//move back
	
	if(distance < TOO_FAR)
		//move forward
	
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
