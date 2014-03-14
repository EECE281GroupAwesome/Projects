# -*- coding: utf-8 -*-
#
# Created on Thu Feb  7 20:35:03 2014
#
# GraphLog: reads in from data dump file, then displays turtle graph 
#
# @author: Addison BG
#

import turtle, datetime
from turtle import *

# global vars
barThickness   = 1.5
spaceThickness = 0
lineCount      = 0
runningTotal   = 0
maxTemp        = 0
sampleRate     = 0
elapsed        = 0
angle          = 90
pencolour       = 'grey'

# core settings and file read selection
turtle.bgcolor('grey')
turtle.title('Reflow Oven Log')
file = open('brad_log_dump.dat', 'r')
theDate = file.readline()
theDate = theDate[:10]

# gets the current time and crops any leading zeroes
def getTime():
    time = str(datetime.timedelta(seconds=lineCount))
    time = time.lstrip('0')
    time = time.lstrip(':')
    time = time.lstrip('0')
    return time

# make newline when using turtle
def nLine():
    right(90)
    forward(25)
    left(90)

# definition of each sub bar within the bar graph
def barplot(pixelsHigh):
    begin_fill()
    forward(pixelsHigh)
    right(90)
    forward(barThickness)
    right(angle) #-160
    forward(pixelsHigh)
    left(90) #180
    forward(spaceThickness)
    left(90)
    end_fill()

# set the turtle in its starting spot
setup( width = 1000, height = 500, startx = None, starty = None)

# set the graph in its starting spot
home()
color(pencolour, pencolour)
backward(120)
right(90)
forward(80)
left(90)
turtle.tracer(0)
turtle.hideturtle()
turtle.speed(0)
# create the pattern for the bars of the graph
color(pencolour, pencolour)
left(90)
forward(10)
right(90)
color(pencolour, pencolour)
backward(350)
left(90)

pencolour       = 'black'
    
for lines in file: # 54 fills sreen by default graphing incrementing up
    value = int(lines)
    runningTotal += value
    lineCount += 1        
        
    if value > maxTemp:
        maxTemp = value        
        
    if   value > 225: color(pencolour, '#FF0000') #red
    elif value > 165: color(pencolour, '#FFCC00') #dark yellow
    elif value > 150: color(pencolour, '#FFFF00') #yellow
    elif value >  60: color(pencolour, '#0099FF') #blue
    elif value >   0: color(pencolour, '#000066') #navy  
    
    barplot(value)
    turtle.update()

# calculate elapsed time
averageTemp = (runningTotal/lineCount)
elapsed = getTime()

color('black', 'white')

# display statistics
home()
backward(450)
right(90)
forward(100)
left(90)
nLine()
write('Date: ' + str(theDate), font=('Helvetica', 15, 'normal'))
nLine()
write('Time Elapsed: ' + str(elapsed), font=('Helvetica', 15, 'bold'))
nLine()
write('Average Temp: ' + str(averageTemp)+u'\u00b0' + 'C', font=('Helvetica', 15, 'normal'))
nLine()
write('Samples: ' + str(lineCount), font=('helvetica', 15, 'normal'))
exitonclick()
