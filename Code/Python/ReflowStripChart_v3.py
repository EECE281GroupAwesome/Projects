# -*- coding: utf-8 -*-
"""
Created on Thu Feb  6 20:37:51 2014

ReflowStripChart_v3: react to draw_event to produce goal temp

@author: champ
"""

import sys, serial
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation

xsize=30

# configure the serial port
ser = serial.Serial(
    port='/dev/ttyUSB0',
    baudrate=115200,
    parity=serial.PARITY_NONE,
    stopbits=serial.STOPBITS_TWO,
    bytesize=serial.EIGHTBITS
)
ser.isOpen()
    
def data_gen():
    t = data_gen.t
    while True: 
       t+=1
       temp = ser.readline()
       val = temp[:3]       
       yield t, val
       
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

def on_close_figure():
    sys.exit(0)

def on_click(event):
    global txt
    degree = u'\N{DEGREE SIGN}' + ' C'
    readIn = ser.readline()
    readIn = readIn.strip('\n')
    readIn = readIn.lstrip('0')  
    txt = plt.text(event.xdata, event.ydata, readIn + degree, fontsize=14)          
    fig.canvas.draw()       

def on_draw(event):
	line2.remove() #OR del line2 OR ax.lines.remove(line2)
	temp = ser.readline()
	temp = temp[3:]
	line2, = ax.plot(0, temp, lw=3)

def off_click(event):
    txt.remove()

data_gen.t = -1
fig = plt.figure()
fig.canvas.mpl_connect('close_event', on_close_figure)
fig.canvas.mpl_connect('button_press_event', on_click)
fig.canvas.mpl_connect('button_release_event', off_click)
fig.canvas.mpl_connect('draw_event', on_draw)
ax = fig.add_subplot(111)
line, = ax.plot([], [], lw=2)
line2, = ax.plot([], [], lw=3)
ax.set_ylabel('Temp (Celcius)')
ax.set_xlabel('Time (Seconds)')
ax.set_title('Reflow Oven Temp')
ax.set_ylim(-10, 250)
ax.set_xlim(0, xsize)
ax.grid()

xdata, ydata = [], []

line.set_label('Current Temp')
line2.set_label('Goal Temp')
ax.legend([line, line2], ['Current Temp', 'Goal Temp'], loc='upper left', prop={'size':10})

ani = animation.FuncAnimation(fig, run, data_gen, blit=False, interval=100, repeat=False)

plt.show()
