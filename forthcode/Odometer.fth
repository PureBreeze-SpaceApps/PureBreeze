\ **************************************************************
\ Odometer functions
\
\ Written by Paul E. Bennett IEng MIET
\ 11 November 2019
\
\ This file contains functions useful for providing components 
\ for odometer functionality. 
\
\ **************************************************************
\
\ --------------------------------------------------------------
\ Test Pulse Generator
\ --------------------------------------------------------------

: PULSE:
\ *G Generate a Child word that provides an inverting boolean
\ ** flag that is the inverse of the previous state.
  CREATE 0 ,		\ Compiling: ( S -- )
  DOES>  DUP @ INVERT	\ Execution: ( S -- flag )
  TUCK SWAP !
;

\ --------------------------------------------------------------
\ EDGE? 					MCC = 1
\ --------------------------------------------------------------
: EDGE?:
\ *G Compile a child function that on each call assesses the
\ ** state of an input that may be presented as a single bit
\ ** or a well formed boolean. Convert to Boolean as required
\ ** and compare current input state with previous state. On
\ ** a change of state between last and current, increment a
\ ** counter. The counter is the first cell in the created
\ ** structure. The second cell is the record of the previous
\ ** state. Primarily for use in speed measurement.
\ **
\ ** Usage:
\ ** EDGE? <name> where <name> is the name of the child
\ ** function.
\ **
\ ** Calling the childe function will increment the counter
\ ** cell within the child function. Accessing the count may
\ ** be achieved by using
\ **
\ **    ['] <name> PWM@      
\ **
\ ** As EDGE?: children and PWM children share same structure
\ **
  CREATE 0 , 0 ,	\ Compiling: ( S -- )
  DOES> dup CELL+	\ Executing: ( S state -- )
  ROT 0<> OVER @
  XOR TUCK OVER @
  XOR SWAP !
  NEGATE SWAP +!
;
\ --------------------------------------------------------------
