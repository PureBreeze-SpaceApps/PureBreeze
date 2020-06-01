vocabulary test
only forth also test
test definitions

S" PureBreze - Air Quality Monitor" 2Constant $PureBreze
S" Measurements made on" 2CONSTANT $H1
S" Date" 2CONSTANT $DATE
S" Time" 2CONSTANT $TIME
S" Temperatures(C)" 2CONSTANT $TEMP
S" Rel Humidity(%)" 2CONSTANT $RH%
S" Air Flow(l/s)" 2CONSTANT $AF
S" Air Pressure(mB)" 2CONSTANT $AP
S" NO (ppm)" 2CONSTANT $NO
S" NO2 (ppm)" 2CONSTANT $NO2
S" CO (ppm)" 2CONSTANT $CO
S" CO2 (ppm)" 2CONSTANT $CO2
S" SO2 (ppm)" 2CONSTANT $SO2
S" H2S (ppm)" 2CONSTANT $H2S
S" PM1 (ppm)" 2CONSTANT $PM1
S" PM2.5 (ppm)" 2CONSTANT $PM2n5
S" PM4 (ppm)" 2CONSTANT $PM4
S" PM10 (ppm)" 2CONSTANT $PM10
S" Inlet" 2CONSTANT $INLET
S" Outlet" 2CONSTANT $OUTLET
\ --------------------------------------------------------------

Variable charcount

: +$C ( caddr\n -- )
  charcount +!
  DROP
;

\ --------------------------------------------------------------
\ Header Section
\ --------------------------------------------------------------

: <H1> ( -- )      \ Version for heading CSV reports.
  charcount off
  $PureBreze  +$C
\ Second Line Header
  $H1   +$C 16  charcount +!
  cr ." <H1> has " charcount ? ." characters"
;

: <H2>  
\   Third Line Header
  charcount off
  $DATE   +$C $TIME  +$C
  $INLET  +$C $TEMP  +$C
  $OUTLET +$C $TEMP  +$C
  $INLET  +$C $RH%   +$C
  $OUTLET +$C $RH%   +$C
  $INLET  +$C $AF    +$C
  $OUTLET +$C $AF    +$C
  $INLET  +$C $AP    +$C
  $OUTLET +$C $AP    +$C
  $INLET  +$C $NO    +$C
  $OUTLET +$C $NO    +$C
  $INLET  +$C $SO2   +$C
  $OUTLET +$C $SO2   +$C
  cr ." <H2> has " charcount ? ." characters"
;

: <H3>  
  charcount off
  $INLET  +$C $H2S   +$C
  $OUTLET +$C $H2S   +$C
  $INLET  +$C $CO    +$C
  $OUTLET +$C $CO    +$C
  $INLET  +$C $CO2   +$C
  $OUTLET +$C $CO2   +$C
  $INLET  +$C $PM1   +$C
  $OUTLET +$C $PM1   +$C
  $INLET  +$C $PM2N5 +$C
  $OUTLET +$C $PM2N5 +$C
  $INLET  +$C $PM4   +$C
  $OUTLET +$C $PM4   +$C
  $INLET  +$C $PM10  +$C
  $OUTLET +$C $PM10  +$C
  cr ." <H3> has " charcount ? ." characters"
;
