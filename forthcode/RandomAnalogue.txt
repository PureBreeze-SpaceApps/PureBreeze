\ Randomised Analogues
\ A Randomised analogue channel that varies within preset
\ parameters but acts like a normal variable to the program. The
\ value will change each and every time it is called.
\ **************************************************************

\ include Random.fth    \ Random Number Generator (in case)

\ --------------------------------------------------------------
\ Structure:-
\ Reported value (Cell)
\ Maximum Range (Cell)
\ Minimum Range (Cell)
\ Allowed Variance Limit + or - (Cell)
\ --------------------------------------------------------------

\ --------------------------------------------------------------
\ : SIM ( addr -- n )                                     MCC=1
\ --------------------------------------------------------------

: (SIM) ( addr -- n )         \ addr is of 4 cell array
\ *G Provide a random adjustment to the value stored at addr
\ ** with the range of the values specified in the associated
\ ** 3 other cells of the array pointed to by addr.
  RANDOM OVER               \ addr\#rand\addr
  3 CELLS + @ MOD           \ addr\n
  OVER @ +                  \ addr\'n
  OVER CELL+ @ MAX          \ addr\'n
  OVER 2 CELLS + MIN        \ addr\'n
  OVER !                    \ addr
;
\ --------------------------------------------------------------

\ --------------------------------------------------------------
\ : SIMULATE: ( -- )       Compiling                      MCC=1
\             ( -- addr )  Executing
\ --------------------------------------------------------------

: SIMULATE: ( -- )         \ Compiling
\ *G Created a child word that, when executed, provides the
\ ** address of its first storage location whose value has
\ ** randomly adjusted.
  CREATE
  0 , 0 , 0 , 3 ,          \ Reserve four cells
  DOES> (SIM) ( -- addr )  \ Executing
;
\ --------------------------------------------------------------

\ --------------------------------------------------------------
\ VARIANCE! ( n\addr -- )                                 MCC=1
\ --------------------------------------------------------------

: VARIANCE! ( n\addr -- )
\ *G Store the value n in the variance cell of the array pointed
\ ** to by addr. n is constrained to be a positive integer.
  >R ABS R>
  3 CELLS + !
;
\ --------------------------------------------------------------

\ --------------------------------------------------------------
\ MIN/MAX! ( min\max\addr -- )                            MCC=1
\ --------------------------------------------------------------

: MIN/MAX! ( min\max\addr -- )
\ *G Store the min and max values in the min and max cells of
\ ** the array pointed to by addr.
  TUCK 2 CELLS + !
  CELL+ !
;
\ --------------------------------------------------------------

\ **************************************************************
\ Some functional testing
\ **************************************************************
\
\ SIMULATE: POOL1
\ SIMULATE: POOL2

\ 200 300 POOL1 MIN/MAX!  250 POOL1 !
\ 180 400 POOL2 MIN/MAX!  220 POOL2 !
\ 4 POOL1 VARIANCE!
\ 6 POOL1 VARIANCE!
\
\ : TEST ( -- )
\   BEGIN cr ." pool1= " pool1 ?
\         5 spaces
\         ." pool2= " pool2 ?
\         100 MS KEY?
\   UNTIL KEY DROP
\ ;
