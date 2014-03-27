import turtle, datetime
from turtle import *

barThickness   = 1.5
spaceThickness = 0
lineCount      = 0
runningTotal   = 0
maxTemp        = 0
sampleRate     = 0
elapsed        = 0
angle          = 90
pencolour       = 'black'

turtle.bgcolor('black')
turtle.title('Reflow Oven Log')
file = open('memorable_dump.dat', 'r')
#date = file.readline()

def getTime():
    time = str(datetime.timedelta(seconds=lineCount))
    time = time.lstrip('0')
    time = time.lstrip(':')
    time = time.lstrip('0')
    return time

def nLine():
    right(90)
    forward(25)
    left(90)

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

setup( width = 1000, height = 500, startx = None, starty = None)

# set the graph in its starting spot
home()
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
    
for lines in file: # 54 fills sreen by default graphing incrementing up
    value = int(lines)
    runningTotal += value
    lineCount += 1        
        
    if value > maxTemp:
        maxTemp = value        
        
    if   value > 220: color(pencolour, '#FF0000') #red
    elif value > 210: color(pencolour, '#FF3300') #light red
    elif value > 200: color(pencolour, '#FF6600') #orange
    elif value > 180: color(pencolour, '#FF9900') #light orange
    elif value > 160: color(pencolour, '#FFCC00') #dark yellow
    elif value > 140: color(pencolour, '#FFFF00') #yellow
    elif value > 120: color(pencolour, '#99FF33') #green -- leave out?
    elif value > 100: color(pencolour, '#00FFFF') #baby blue
    elif value >  80: color(pencolour, '#00CCFF') #light blue
    elif value >  60: color(pencolour, '#0099FF') #blue
    elif value >  40: color(pencolour, '#0066FF') #darkish blue
    elif value >  20: color(pencolour, '#0033FF') #dark blue
    elif value >   0: color(pencolour, '#000066') #navy  
    
    barplot(value)
    turtle.update()

averageTemp = (runningTotal/lineCount)
elapsed = getTime()

color('white', 'white')

home()
backward(450)
right(90)
forward(100)
left(90)
#write('Date: ' + str(date), font=('Helvetica', 15, 'normal'))
#nLine()
write('Time Elapsed: ' + str(elapsed), font=('Helvetica', 15, 'bold'))
nLine()
write('Average Temp:' + str(averageTemp), font=('Helvetica', 15, 'normal'))
nLine()
write('Samples: ' + str(lineCount), font=('helvetica', 15, 'normal'))
exitonclick()
