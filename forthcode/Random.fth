\ Francois Laagel's Random Number Generator based on a wikipedia
\ article "linear congruential pseudo random number generators".
\ **************************************************************

VARIABLE seed  4931 seed !    \ A starting point.

: random ( -- N )
\ *G Generate a random number. The seed value is changed for
\ ** each generation of a number.
  seed @ 613 * 5179 +  
  DUP seed ! 
;
