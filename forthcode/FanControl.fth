\             Fan PWM Speed Control
\    Fan connected to a GPIO pin on a Raspberry Pi.
\
\   Author:- Paul E. Bennett IEng MIET
\     Date:- 25th May 2020
\ **************************************************************

CR ." Loading Fan PWM Speed Control"

\ **************************************************************
\ Fan Speed Control
\ **************************************************************

1280 CONSTANT #FANLOOPS
   4 CONSTANT FAN-PIN
  
VARIABLE FANTASK
PWM:     FANLOOP
PWM:     FAN

\ --------------------------------------------------------------
\ FAN-PIN-INIT ( -- )
\ --------------------------------------------------------------
: FAN-PIN-INIT ( -- )
\ *G Initialise Fan GPIO Pin for Output
\  FAN-PIN OUTPUT PinMode
;
\ --------------------------------------------------------------

\ --------------------------------------------------------------
\ FAN-SPEED! ( fanspeed% -- )
\ --------------------------------------------------------------

: FAN-SPEED! ( fanspeed% -- )
\ *G Set the fan speed to the demand percentage of full speed.
  #FANLOOPS 100 */
  ['] FAN PWM!
;
\ --------------------------------------------------------------

\ --------------------------------------------------------------
\ FAN-SPEED@ ( -- fanspeed% )
\ --------------------------------------------------------------

: FAN-SPEED@ ( -- fanspeed% )
\ *G Get the fan speed demand as a percentage of full speed.
  ['] FAN PWM@
  100 #FANLOOPS */
;
\ --------------------------------------------------------------

\ --------------------------------------------------------------
\ >FAN ( flag -- )
\ --------------------------------------------------------------

: >FAN ( flag -- )
\ *G Convey the sense of the flag to the GPIO pin selected for
\ ** the fan driver output.
\  1 AND FAN-PIN SWAP digitalWrite
  DROP                 \ For VFX-Testing
;
\ --------------------------------------------------------------

\ --------------------------------------------------------------
\ LOOP-RESETS ( -- )
\ --------------------------------------------------------------

: LOOP-RESETS ( -- )
\ *G Reset and restart each PWM loop.
  ['] FAN CHANNEL-RESET
  ['] FANLOOP CHANNEL-RESET
;
\ --------------------------------------------------------------

0 VALUE FAN-TASK
VARIABLE FANTASK-ENABLE

\ --------------------------------------------------------------
\ FAN-DRIVE ( -- )                                        MCC=3
\ --------------------------------------------------------------

: FAN-DRIVE ( -- )
\ *G The background task loop for fan control.
  #FANLOOPS ['] FANLOOP PWM!
  LOOP-RESETS
  BEGIN BEGIN FAN >FAN
              FANLOOP 0=
        UNTIL LOOP-RESETS
        1 FANTASK +!
        FANTASK-ENABLE @ 0=
  UNTIL
;
\ --------------------------------------------------------------


\ --------------------------------------------------------------
\ START-FAN-TASK ( -- )
\ --------------------------------------------------------------

: START-FAN-TASK
\ *G Begin the FAN-DRIVE as a background task.
\  ['] FAN-DRIVE EXECTUTE-TASK TO FAN-TASK
;
\ --------------------------------------------------------------

\ **************************************************************

\ Simple Fan Speed Test Sweep
\ : Fantest 100 0 do i fan-speed! 100 ms loop 10 fan-speed! ;
