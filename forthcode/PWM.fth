\ 8-bit PWM wordset for the control of mini-servo
\ modules of the modellers style.
\
\ *********************************************************
\ * Written by Paul E. Bennett IEng MIET                  *
\ *            HIDECS Consultancy                         *
\ *              Tel: +441392426688                       *
\ *              Mob: +447811639972                       *
\ *            email: <Paul_E.Bennett@topmail.co.uk>      *
\ *              web: <http://www.hidecs.co.uk/>          *
\ *********************************************************
\
\ **************************************************************
\ History
\ **************************************************************
\
\ Issue 0.C Monday 1st December 2014
\ **************************************************************
\ Change PEB20141201/1 PWM word to include new ?-? word instead 
\ of the IF..ELSE...THEN structure. This was to improve ease of 
\ use.
\ Change PEB20141201/2 Included the ?-? word in this lexicon.
\
\ Issue 0.B Friday 11th July 2014 16:25
\ **************************************************************
\ Change PEB20140711/4 Added PWM-RESET to header examples
\ Change PEB20140711/3 Added Certification Sign-Off boxes.
\ Change PEB20140711/2 Added CHANNEL-RESET definition along 
\ with correcting action of PWM to stay at zero once reached. 
\ This provides a deadband period of atleast 0.5ms after the 
\ PWM words hit zero (ie: the 400Hz servo rate).
\ Change PEB20140711/1 Added variable [PWM-ENABLE] and 
\ definition PWM-ENABLE? to code section and added the latter to
\ example text.
\
\ Initial Issue 0.A Wednesday 9th July 2014 14:35
\ **************************************************************
\
\ This code was originally designed for a wheel-chair controller
\ but has been modified from that original application to apply 
\ to Radio Control Servos. This incarnation was planned during
\ the design of a walking robit using just three servo-motors. 
\ The wheel-chair controllers processr did not have a built in 
\ timer but the cycle time was reasonably stable. Hence, this 
\ cycle based approach. The words can exist in a separate task
\ thread or within the main-body. It is suggested that other code 
\ be timed to ensure the ability to set the appropriate timing 
\ values in these routines.
\
\ The RC model control servos that are widely available from
\ model shops have a standard three wire interface. The 
\ standard is followed by three of the four big names of servo
\ manufacturers and the majority of smaller suppliers. Only the
\ Airtronics servos seem to be wired differently.
\
\ These connections are:-
\   Black Wire                   = -ve supply
\   Red wire                     = +ve supply
\   Yellow, Orange or White wire = Signal
\
\ The Airtronics connections are:-
\   Black&White wire  = Signal
\   Black wire        = -ve supply
\   Red wire          = +ve supply
\
\ The PWM waveform is 1ms minimum pulse length, 2ms maximum 
\ pulse length and a median pulse of 1.5ms.
\
\ Rate of call for the following functions should be fixed
\ at a frequency of 256kHz (for 8 bit PWM ranges). This will
\ keep the operation of the servos smoother. If this rate of
\ call is not feasible then a lesser number of bits can be used
\ for the PWM code. The words CENTRE, PWM, PWM! and PWM@ will
\ then need appropriate adjustment.
\
\ If the pre-determined delay time is not required, then this
\ factor can be eliminated from PWM! and PWM@.
\
\ Usage:
\ The usage of the word-set is as follows (for a three servo
\ walking robot).
\ 
\ Creation of PWM items
\ ---------------------
\ PWM: Left-Foot
\ PWM: Right-Foot
\ PWM: Wobble
\ 
\ In the regularly run code segment
\ ---------------------------------
\ HEX
\ : PWM-RESET ( S: -- )  \ Actions to reset the countdown
\   ' Left-Foot CHANNEL-RESET
\   ' Right-Foot CHANNEL-RESET
\   ' Wobble  CHANNEL-RESET
\   180 PWM-ENABLE
\ ;
\
\ : PWM-Actions ( S: -- ) \ Actions to resolvee the PWM delay
\   Left-Foot LF-Bit AND      \ Pick up bit to set for 
\   Right-Foot RF-Bit AND OR  \ output to the selected
\   Wobble W-Bit AND OR       \ port output for the servo
\   PWM-Output !              \ Send output bits to port
\   [PWM-Enable] ?-? 0=       \ Are we at end of pulse cycle?
\   IF PWM-RESET THEN         \ Reset to go again.
\ ;
\ DECIMAL
\
\ To get values to the servos
\ ---------------------------
\ ( S: n -- ) ' Left-Foot PWM!
\ ( S: n -- ) ' Right-Foot PWM!
\ ( S: n -- ) ' Wobble PWM!
\
\ The word PWM@ will allow read-back of the current setting.
\
\ CENTRE - keeps the range of values fed to the servo within
\ the one byte range of operation if using positive and
\ negative number for position about a central zero.
\ **************************************************************

\ **************************************************************
\ Make the working vocabulary PWM (during initial development)
\ **************************************************************

\ Vocabulary PWM only forth also PWM
\ PWM definitions

\ **************************************************************
\ ?-? - Decrement a value on each pass. Do not decrement if value
\       is already zero. Return a flag to show state of variable. 
\ **************************************************************

: ?-? ( S: addr -- flag )
\ *G Check the value at addr and if non-zero decrement the value
\ ** and return a TRUE flag if the variable remains non-zero, or 
\ ** FALSE if the variable reaches zero. If the value is already 
\ ** zero just return a FALSE flag. Note that the TRUE flag must 
\ ** be a wellformed Boolean.
  dup @ 0<>   
  over +! 
  @ 0<> ;

\ **************************************************************
\ Static Analysis .. Signature...............  Date..........
\
\ Functional Test .. Signature...............  Date..........
\
\ Limits Test     .. Signature...............  Date..........
\ 
\ **************************************************************

\ **************************************************************
\ PWM - creates an active array word which performs a 
\       count-down decrement on each pass through the word.
\
\ **************************************************************

: PWM:  ( S: “<spaces> name” -- )
\ *G Create an active array with the identity of "name" in
\ ** which is reserved two cells of data space. Each pass
\ ** through "name" shall decrement the second cell and return
\ ** a TRUE flag. If the second cell reaches zero the returned
\ ** flag shall be FALSE, the second cell is reloaded with the
\ ** value contained in the first cell during a PWM-RESET that
\ ** is aware of the storage structure. The first cell is the 
\ ** desired value of delay for the channel.
   CREATE 0 , 0 ,            \ S: “ spaces name”
   DOES>  CELL+ ?-?
;

\ **************************************************************
\ Static Analysis .. Signature...............  Date..........
\
\ Functional Test .. Signature...............  Date..........
\
\ Limits Test     .. Signature...............  Date..........
\ 
\ **************************************************************

\ **************************************************************
\ PWM@
\ **************************************************************

HEX
: PWM@ ( S: 'addr -- n )
\ *G Extracts the value from the first cell of an active array
\ ** created by PWM then subtract the preset timer value before
\ ** leaving the value n on the stack.
   >BODY @
\   FF AND
;
DECIMAL

\ **************************************************************
\ Static Analysis .. Signature...............  Date..........
\
\ Functional Test .. Signature...............  Date..........
\
\ Limits Test     .. Signature...............  Date..........
\ 
\ **************************************************************

\ **************************************************************
\ PWM! - Store a value into the first cell of the active array
\        created by PWM. 
\ **************************************************************

HEX
: PWM! ( S: n\'addr -- )
\ *G Takes the value n, adds the preset delay time to the value
\ ** and places the value into the first cell of an active 
\ ** array created by PWM.
\   >R 100 OR R>
   >BODY !
;
DECIMAL

\ **************************************************************
\ Static Analysis .. Signature...............  Date..........
\
\ Functional Test .. Signature...............  Date..........
\
\ Limits Test     .. Signature...............  Date..........
\ 
\ **************************************************************

\ **************************************************************
\ CHANNEL-RESET - the address provided apply the value in the 
\                 first address to the second address
\ **************************************************************

: CHANNEL-RESET \ S: 'addr -- )
\ *G Take the cell value stored in the provided 'addr
\ ** and place it in the next cell address.
  >BODY DUP @ SWAP CELL+ !
;

\ **************************************************************
\ Static Analysis .. Signature...............  Date..........
\
\ Functional Test .. Signature...............  Date..........
\
\ Limits Test     .. Signature...............  Date..........
\ 
\ **************************************************************

\ **************************************************************
\ PWM-ENABLE -  Checks the variable [PWM-ENABLE] for a value 
\               above HEX 7F and returns a flag to enable PWM 
\               words to be activated during a scan.
\ **************************************************************
\
\ HEX
\ VARIABLE [PWM-ENABLE] 180 [PWM-ENABLE] !
\
\ : PWM-ENABLE  ( S: val -- )
\ *G Set the [PWM-ENABLE] with the value of the number of 
\ ** cycles that the PWM words may operate for. 
\   [PWM-ENABLE] !
\ ;
\ DECIMAL
\
\ **************************************************************
\ Static Analysis .. Signature...............  Date..........
\
\ Functional Test .. Signature...............  Date..........
\
\ Limits Test     .. Signature...............  Date..........
\ 
\ **************************************************************

\ **************************************************************
\ CENTRE - keeps the range of values fed to the servo within
\          the one byte range of operation.
\ **************************************************************
\
\ HEX
\ : CENTRE ( S: +/-n -- adj )
\ *G Convert the input signed value to a number
\ ** centred around the maximum negative value
\ ** for a single byte. Range -FF to +7F.
\   -100 MAX 100 MIN
\   80 - FF AND
\ ;
\
\ DECIMAL
\
\ **************************************************************
\ Static Analysis .. Signature...............  Date..........
\
\ Functional Test .. Signature...............  Date..........
\
\ Limits Test     .. Signature...............  Date..........
\ 
\ **************************************************************
\
\ **************************************************************
\ END
\ **************************************************************
