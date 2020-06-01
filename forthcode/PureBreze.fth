\      PureBreze Air Quality Manager
\ The following is prototype code for the PureBreze Air Quality
\ Manager systems. The functions are mainly to monitor the two
\ sensor packs, package the results for display and allow the
\ communication of those results.
\ 
\ Additionally, the software will compare the differential
\ trends between sensor packs, provide warnings and indicate
\ when the filter units require to be changed.
\ **************************************************************

needs unix/pthread.fs   \ Load up the Unix Pthreads functions.

\ --------------------------------------------------------------
\ CLS routine for use in GForth
\ --------------------------------------------------------------

: CLS ( S -- )
\ *G Clear the system display screen.
   S" clear" system
;
\ --------------------------------------------------------------

 include GPIO.fth               \ include GPIO Library Functions
 include PWM.fth                \ include PWM library
VOCABULARY PUREBREZE
ONLY FORTH ALSO PUREBREZE
PUREBREZE DEFINITIONS

include FanControl.fth
include RandomAnalogue.fth


\ **************************************************************
\ Initialisation
\ **************************************************************

\ --------------------------------------------------------------
\ INIT ( -- )
\ --------------------------------------------------------------

: INIT ( -- )
\ *G Initialise the system.
  FAN-PIN-INIT  START-FAN-TASK
;
\ --------------------------------------------------------------

\ **************************************************************

