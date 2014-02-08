# -*- coding: utf-8 -*-
#
# Created on Thu Feb  6 20:35:03 2014
#
# ReflowStripChart: classic strip chart
#
# @author: Addison BG
#
import time, sys, serial, time, subprocess
import matplotlib.pyplot as plt
import matplotlib.animation as animation

# Global Variables
xsize=100
file = open('log_dump.dat', 'w')
start = time.time()
file.write(str(start) + '\n')
    
# configure the serial port
ser = serial.Serial(
    port='/dev/ttyUSB0',
    baudrate=115200,
    parity=serial.PARITY_NONE,
    stopbits=serial.STOPBITS_TWO,
    bytesize=serial.EIGHTBITS
)
ser.isOpen()
   
# generator object for animator source, runs
#  concurrently with the run function
def data_gen():
    t = data_gen.t
    while True: 
       t+=1
       temp = ser.readline()
       val = temp[:3]
       file.write(val+'\n')
       val = float(val)
       yield t, val
       
# extracts data from data_gen and sends to animator
def run(data):
    # update the data
    t, y = data
    if t>-1:        
        xdata.append(t)
        ydata.append(y)                
        if t>xsize:     # Scroll to the left.
            ax.set_xlim(t-xsize, t)
        line.set_data(xdata, ydata)
    return line,

def onclose():
    end = time.time()
    elapsed = (end - start)    
    file.write(str(elapsed) + '\n')
    #subprocess.call('python GraphTurtle.py')
    sys.exit(0)

def onclick(event):
    global txt
    global currentState
    global word				
    x, y = event.xdata, event.ydata				
    goal = ser.readline()
    goal = goal[3:]

    state = ax.axhline(goal, lw=2, color='darkgoldenrod')
    plt.show()         

def offclick(event):
    ax.lines[-1].remove()     
    fig.canvas.draw
				
data_gen.t = -1
fig = plt.figure()
fig.canvas.mpl_connect('close_event', onclose)
fig.canvas.mpl_connect('button_press_event', onclick)
fig.canvas.mpl_connect('button_release_event', offclick)
ax = fig.add_subplot(111)
line, = ax.plot([], [], lw=2)
line2, = ax.plot([], [], lw=3)
ax.set_ylabel(r'$Temp (celcius)$', fontsize=18)
ax.set_xlabel(r'$Time (seconds)$', fontsize=18)
ax.set_title(r'$Reflow Oven$', fontsize=20)
ax.set_ylim(-10, 250)
ax.set_xlim(0, xsize)
ax.grid()

xdata, ydata = [], []

line.set_label('Current Temp')
line2.set_label('Goal Temp')
ax.legend([line, line2], [r'$Current Temp$', r'$Goal Temp$'], loc='upper left', prop={'size':13})

ani = animation.FuncAnimation(fig, run, data_gen, blit=False, interval=100, repeat=False)

plt.show()
