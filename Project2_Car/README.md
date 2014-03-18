Car Project
===========
CodeName: Mr. Squiggles
=======================

Components we will use: LM339, MC3004, and an OP-AMP.
We will get the phase from the LM339. We will get 2-4 voltage values. 

Distance
-----------
We will get the distance: Two of the voltages squared and then use the distance formula. 
The formula to calculate the distance is: sqrt((V_x)^2+(V_y)^2)=k/d^3

Angle
------------
We will get the angle: arctan(V_x/V_y)
We want to isolate the voltages from the rest of the code, we just want distance and angle. 



**Minimum Requirements**
- **Follow** The car needs to be able to follow the beacon and maintain a set distance.
- **Move closer.** When the user presses a button in the transmitter, it commands
the robot to move closer.
- **Move farther** When the user presses a button in the transmitter, it commands
the robot to move farther.
- **Rotate 180** . When the user presses a button in the transmitter, it commands
the robot to rotate 180.
- **Parallel park.** When the user presses a button in the transmitter, it commands
the robot to parallel park in a space that is 1.5 times the length of the robot.
