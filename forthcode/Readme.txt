The PureBreze SpaceApps Challenge Entry 2020.
*********************************************

Acknowledgements to the team members I had the privildige of working with 
during this special edition of the NASA SpaceApps Challenge.

Trevor Sharp (Exeter, UK)
Charlie Harrison (Exeter, UK)
Paul E. Bennett IEng MIET (Exeter, UK)
Askabio (Albania)
Wendy Edwards (Illinois)
Liam Pingree (NY,NY, USA).

History
-------
The team accepted the challenge of Purifying the Air Supply. We did not 
remain satisfield to filter and disinfect, but began to think we should 
add monitoring of the atmosphere in the homes into which the product would 
find itself. With the Covid-19 pandemic keeping many locked down in their 
homes for extensive durations, their air was likely getting a little stale.

Such thinking, of course spawns more ideas. Over the challenge weekend 
(30th to 31st May 2020) we could only rely on what we had to hand. Much
as the brave astronauts of Apollo 13, who would have suffocated with out 
the helpful, if somewhat remote, team of engineers on the ground. Like 
them, we performed our tasks without physically meeting the other team 
members. We allocated the tasks amongst us, and we gelled together as a 
cohesive cooperative. Despite that between Albania and Illinois there is a 
time difference of some 7 hours. Still, we managed through the established 
NASA Spacechat rooms, and the facilities of WebEx we were able to 
effectively coordinate our activity.

                      **********||**********

The Software Sources
--------------------
The other files here are those that we ran on either vfxlin (a Linux 
version of VFx Forth from MPE's stable) or on the GForth v0.7.9 running
on the Raspberry Pi. Both Forth environments will accept the software with 
little change. There are some very specific differences in the way each 
system deals with time functions. Otherwise, the software should run on 
either system with very few changes.

Functions in the uploaded files.
--------------------------------
Utilising the multi-tasking capabilities of GForth on the Pi, and the 
easily linked in wiringPi library, makes a number of small control 
projects very feasible.

PWM Control
-----------
This is a fully software generated waveform from a selected GPIO pin that 
is switched on and off at a rate that is able to vary teh aggregate power 
applied to the fan motor. It is based on a decrementing counter that turns 
the output off when it reaches zero. The higher the number it is fed, the 
longer the ON state of the pulse. This runs in the background task 
established for the task. You can see the set-up in Fancontrol.fth.

Simulated Analogues
-------------------
So, what do you do when the specific sensors you need are not available to 
allow you to start with the real thing? Simulate of course. The file 
RandomAnalogues.fth contains a simple analogue channel simulator that uses 
random number generation and some parameters to adjust the minimum and 
maximum values and the amount of variance that is applied to the signal 
data generated. Each time the child-word is called to action (named for 
the sensor it represents) you will likely get a different value. The 
adjustment is applied like a trend.

The FileDataSim.fth file is able to write a large number of samples to a 
data file in csv format. Such formats are easily picked up by popular 
speadsheets. The program that generates the data allows the 
column headings to be listed also.

Paul E. Bennett IEng MIET
31 May 2020
