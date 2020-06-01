\ **************************************************************
\                   Raspberry Pi GPIO Access
\
\ This is file should be inlcuded in GForth programmes on the
\ Raspberry Pi computer to enable access to the GPIO pins. This
\ file loads the wiringPi.fs file and then sets it up.
\
\ Including this file requires the inclusion of:-
\
\  include GPIO.fth
\
\ as a non-comment line.
\
\ **************************************************************

\ --------------------------------------------------------------
\ Include Library Functions
\ --------------------------------------------------------------

include wiringPi.fs		\ include teh wiringPi library

wiringPiSetupGpio drop		\ Set up wiringPi in GForth.

\ --------------------------------------------------------------

\ **************************************************************
\ Core Functions
\ **************************************************************
\
\ These functions work directly on the Raspberry Pi and also
\ with external GPIO modules such as GPIO expanders and so on,
\ although not all modules support all functions – e.g. the
\ PiFace is pre-configured for its fixed inputs and outputs,
\ and the Raspberry Pi has no on-board analog hardware.
\
\ --------------------------------------------------------------
\
\ pinMode (int pin\int mode -- )
\
\ This sets the mode of a pin to either INPUT, OUTPUT,
\ PWM_OUTPUT or GPIO_CLOCK. Note that only wiringPi pin 1
\ (BCM_GPIO 18) supports PWM output and only wiringPi
\ pin 7 (BCM_GPIO 4) supports CLOCK output modes.
\
\ This function has no effect when in Sys mode.
\ --------------------------------------------------------------

\ --------------------------------------------------------------
\
\ pullUpDnControl (int pin\int pud -- )
\ 
\ This sets the pull-up or pull-down resistor mode on the given
\ pin, which should be set as an input. Unlike the Arduino, the
\ BCM2835 has both pull-up an down internal resistors. The 
\ parameter pud should be; PUD_OFF, (no pull up/down), PUD_DOWN
\ (pull to ground) or PUD_UP (pull to 3.3v) The internal pull
\ up/down resistors have a value of approximately 50KΩ on the
\ Raspberry Pi.
\ --------------------------------------------------------------

\ --------------------------------------------------------------
\
\ digitalWrite (int pin\int value -- )
\ 
\ Writes the value HIGH or LOW (1 or 0) to the given pin which
\ must have been previously set as an output.
\
\ WiringPi treats any non-zero number as HIGH, however 0 is
\ the only representation of LOW.
\ --------------------------------------------------------------

\ --------------------------------------------------------------
\
\ pwmWrite (int pin\int value -- )
\
\ Writes the value to the PWM register for the given pin. The
\ Raspberry Pi has one on-board PWM pin, pin 1 (BMC_GPIO 18,
\ Phys 12) and the range is 0-1024. Other PWM devices may have
\ other PWM ranges.
\
\ This function is not able to control the Pi’s on-board PWM
\ when in Sys mode.
\ --------------------------------------------------------------

\ --------------------------------------------------------------
\
\ digitalRead (int pin -- state )
\
\ This function returns the value read at the given pin. It
\ will be HIGH or LOW (1 or 0) depending on the logic level at
\ the pin.
\ --------------------------------------------------------------

\ --------------------------------------------------------------
\
\ analogRead (int pin -- value )
\
\ This returns the value read on the supplied analog input pin.
\ You will need to register additional analog modules to enable
\ this function for devices such as the Gertboard, quick2Wire
\ analog board, etc.
\ --------------------------------------------------------------

\ --------------------------------------------------------------
\
\ analogWrite (int pin\int value -- )
\
\ This writes the given value to the supplied analog pin. You
\ will need to register additional analog modules to enable
\ this function for devices such as the Gertboard.
\ --------------------------------------------------------------

\ **************************************************************
\ Raspberry Pi Specifics
\ **************************************************************
\
\ These functions are not part of the core wiringPi set, but
\ act specifically on the Raspberry Pi hardware itself. Some
\ external hardware driver modules may provide some of this
\ functionality though.
\ --------------------------------------------------------------
\
\ digitalWriteByte (int value -- )
\
\ This writes the 8-bit byte supplied to the first 8 GPIO pins.
\ It’s the fastest way to set all 8 bits at once to a particular
\ value, although it still takes two write operations to the
\ Pi’s GPIO hardware.
\ --------------------------------------------------------------

\ --------------------------------------------------------------
\
\ pwmSetMode (int mode)
\
\ The PWM generator can run in 2 modes – “balanced” and
\ “mark:space”. The mark:space mode is traditional, however the
\ default mode in the Pi is “balanced”. You can switch modes by
\ supplying the parameter: PWM_MODE_BAL or PWM_MODE_MS.
\ --------------------------------------------------------------

\ --------------------------------------------------------------
\
\ pwmSetRange (u-int)
\
\ This sets the range register in the PWM generator. The default
\ is 1024.
\ --------------------------------------------------------------

\ --------------------------------------------------------------
\
\ pwmSetClock (int divisor) ;
\
\ This sets the divisor for the PWM clock.
\
\ Note: The PWM control functions can not be used when in Sys
\ mode. To understand more about the PWM system, you’ll need to
\ read the Broadcom ARM peripherals manual.
\ --------------------------------------------------------------

\ --------------------------------------------------------------
\
\ piBoardRev ( -- int )
\
\ This returns the board revision of the Raspberry Pi. It will
\ be either 1 or 2. Some of the BCM_GPIO pins changed number
\ and function when moving from board revision 1 to 2, so if
\ you are using BCM_GPIO pin numbers, then you need to be aware
\ of the differences.
\ --------------------------------------------------------------

\ --------------------------------------------------------------
\
\ wpiPinToGpio ( -- int-wPiPin)
\
\ This returns the BCM_GPIO pin number of the supplied wiringPi
\ pin. It takes the board revision into account.
\ --------------------------------------------------------------

\ --------------------------------------------------------------
\
\ physPinToGpio ( -- int physPin)
\
\ This returns the BCM_GPIO pin number of the supplied physical
\ pin on the P1 connector.
\ --------------------------------------------------------------

\ --------------------------------------------------------------
\
\ setPadDrive (int group\int value)
\
\ This sets the “strength” of the pad drivers for a particular
\ group of pins. There are 3 groups of pins and the drive
\ strength is from 0 to 7. Do not use this unless you know
\ what you are doing.
\ --------------------------------------------------------------
\ **************************************************************

\ **************************************************************
\ Timing
\ **************************************************************
\
\ While Linux provides a multitude of system calls and functions
\ to providing various timing and sleeping functions, sometimes
\ it can be quite confusing, especially if you are new to Linux,
\ so the ones presented here mimic those available on the
\ Arduino platform, making porting code and writing new code
\ somewhat easier.
\
\ Note: Even if you are not using any of the input/output
\ functions you still need to call one of the wiringPi setup
\ functions – just use wiringPiSetupSys() if you don’t need
\ root access in your program and remember to #include
\ <wiringPi.h>
\ --------------------------------------------------------------
\
\ millis ( -- milliseconds)
\
\ This returns a number representing the number of milliseconds
\ since your program called one of the wiringPiSetup functions.
\ It returns an unsigned 32-bit number which wraps after 49
\ days.
\ --------------------------------------------------------------
\
\ micros ( -- microseconds)
\
\ This returns a number representing the number of microseconds
\ since your program called one of the wiringPiSetup functions.
\ It returns an unsigned 32-bit number which wraps after
\ approximately 71 minutes.
\ --------------------------------------------------------------
\
\ delay (u-int milliseconds -- )
\
\ This causes program execution to pause for at least the number 
\ of milliseconds. Due to the multi-tasking nature of Linux it
\ could be longer. Note that the maximum delay is an unsigned
\ 32-bit integer or approximately 49 days.
\ --------------------------------------------------------------
\
\ delayMicroseconds (unsigned int howLong)
\ 
\ This causes program execution to pause for at least the number
\ of microseconds. Due to the multi-tasking nature of Linux it
\ could be longer. Note that the maximum delay is an unsigned
\ 32-bit integer microseconds or approximately 71 minutes.
\
\ Delays under 100 microseconds are timed using a hard-coded
\ loop \ continually polling the system time, Delays over 100
\ microseconds are done using the system nanosleep() function
\ – You may need to consider the implications of very short
\ delays on the overall performance of the system, especially
\ if using threads.
\ --------------------------------------------------------------
\ **************************************************************

\ **************************************************************
\ Priority, Interrupts and Threads
\ **************************************************************
\
\ WiringPi provides some helper functions to allow you to manage
\ your program (or thread) priority and to help launch a new
\ thread from inside your program. Threads run concurrently with
\ your main program and can be used for a variety of purposes.
\ To learn more about threads, search for “Posix Threads”
\ Program or Thread Priority
\
\ --------------------------------------------------------------
\
\ piHiPri (int priority -- ior )
\
\ This attempts to shift your program (or thread in a multi-
\ threaded program) to a higher priority and enables a real-
\ time scheduling. The priority parameter should be from 0 (the
\ default) to 99 (the maximum). This won’t make your program go
\ any faster, but it will give it a bigger slice of time when
\ other programs are running. The priority parameter works
\ relative to others – so you can make one program priority 1
\ and another priority 2 and it will have the same effect as
\ setting one to 10 and the other to 90 (as long as no other
\ programs are running with elevated priorities)
\
\ The return value is 0 for success and -1 for error. If an
\ error is returned, the program should then consult the
\ errno global variable, as per the usual conventions.
\ Note: Only programs running as root can change their
\ priority. If called from a non-root program then nothing
\ happens.
\ --------------------------------------------------------------

\ --------------------------------------------------------------
\ Interrupts
\ --------------------------------------------------------------
\
\ With a newer kernel patched with the GPIO interrupt handling
\ code, you can now wait for an interrupt in your program. This
\ frees up the processor to do other tasks while you’re waiting
\ for that interrupt. The GPIO can be set to interrupt on a
\ rising, falling or both edges of the incoming signal.
\
\ Note: Jan 2013: The waitForInterrupt() function is deprecated
\ – you should use the newer and easier to use wiringPiISR()
\ function below.
\ --------------------------------------------------------------

\ --------------------------------------------------------------
\ waitForInterrupt (int pin, int timeOut -- flag )
\ 
\ When called, it will wait for an interrupt event to happen on
\ that pin and your program will be stalled. The timeOut
\ parameter is given in milliseconds, or can be -1 which means
\ to wait forever.
\ 
\ The return value is -1 if an error occurred (and errno will be
\ set appropriately), 0 if it timed out, or 1 on a successful
\ interrupt event.
\
\ Before you call waitForInterrupt, you must first initialise
\ the GPIO pin and at present the only way to do this is to use
\ the gpio program, either in a script, or using the system()
\ call from inside your program.
\
\ e.g. We want to wait for a falling-edge interrupt on GPIO
\ pin 0, so to setup the hardware, we need to run:
\ 
\ gpio edge 0 falling
\
\ before running the program.
\
\    int wiringPiISR (int pin, int edgeType,  void (*function)(void)) ;
\ ** Ned to convert the above into Forth format.
\
\ This function registers a function to received interrupts on
\ the specified pin. The edgeType parameter is either
\ INT_EDGE_FALLING, INT_EDGE_RISING, INT_EDGE_BOTH or
\ INT_EDGE_SETUP. If it is INT_EDGE_SETUP then no initialisation
\ of the pin will happen – it’s assumed that you have already
\ setup the pin elsewhere (e.g. with the gpio program), but if
\ you specify one of the other types, then the pin will be
\ exported and initialised as specified. This is accomplished
\ via a suitable call to the gpio utility program, so it need
\ to be available.
\
\ The pin number is supplied in the current mode – native
\ wiringPi, BCM_GPIO, physical or Sys modes.
\
\ This function will work in any mode, and does not need root
\ privileges to work.
\
\ The function will be called when the interrupt triggers. When
\ it is triggered, it’s cleared in the dispatcher before
\ calling your function, so if a subsequent interrupt fires
\ before you finish your handler, then it won’t be missed.
\ (However it can only track one more interrupt, if more than
\ one interrupt fires while one is being handled then they will
\ be ignored)
\
\ This function is run at a high priority (if the program is
\ run using sudo, or as root) and executes concurrently with
\ the main program. It has full access to all the global
\ variables, open file handles and so on.
\
\ See the isr.c example program for more details on how to use
\ this feature.
\ --------------------------------------------------------------

\ --------------------------------------------------------------
\ Concurrent Processing (multi-threading)
\ --------------------------------------------------------------
\ 
\ wiringPi has a simplified interface to the Linux
\ implementation of Posix threads, as well as a (simplified)
\ mechanisms to access mutex’s (Mutual exclusions)
\
\ Using these functions you can create a new process (a
\ function inside your main program) which runs concurrently
\ with your main program and using the mutex mechanisms,
\ safely pass variables between them.
\ --------------------------------------------------------------
\
\ piThreadCreate (int -- ) <name>
\
\ This function creates a thread which is another function in
\ your program previously declared using the PI_THREAD
\ declaration. This function is then run concurrently with your
\ main program. An example may be to have this function wait
\ for an interrupt while your program carries on doing other
\ tasks. The thread can indicate an event, or action by using
\ global variables to communicate back to the main program, or
\ other threads.
\
\ Thread functions are declared as follows:
\ ** Convert following to Forth format**
\ PI_THREAD (myThread)
\ {
\  .. code here to run concurrently with
\        the main program, probably in an
\        infinite loop
\ }
\
\ and would be started in the main program with:
\
\ x = piThreadCreate (myThread) ;
\ if (x != 0)
\   printf ("it didn't start")
\
\ This is really nothing more than a simplified interface to
\ the Posix threads mechanism that Linux supports. See the
\ manual pages on Posix threads (man pthread) if you need more
\ control over them.
\ --------------------------------------------------------------
\ ** Convert following to Forth format**
\    piLock (int keyNum) ;
\    piUnlock (int keyNum) ;
\
\ These allow you to synchronise variable updates from your
\ main program to any threads running in your program. keyNum
\ is a number from 0 to 3 and represents a “key”. When another
\ process tries to lock the same key, it will be stalled until
\ the first process has unlocked the same key.
\
\ You may need to use these functions to ensure that you get
\ valid data when exchanging data between your main program
\ and a thread – otherwise it’s possible that the thread
\ could wake-up halfway during your data copy and change the
\ data – so the data you end up copying is incomplete, or
\ invalid. See the wfi.c program in the examples directory
\ for an example.
\ --------------------------------------------------------------
