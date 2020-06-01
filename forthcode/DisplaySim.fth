\                Simulated Data Presentation
\ This file is intended only as a demonstration of the type of
\ displayed data that could be presented. The data sources are
\ all simulated by the RandomAnalogue.fth library module and
\ this file uses that facility to produce a data display.
\ **************************************************************

Vocabulary PureBreze
Only Forth also PureBreze
PureBreze definitions


include PWM.fth               \ PWM Library
include FanControl.fth        \ Fan Control Task
include RandomAnalogue.fth    \ Sensor Data Simulator


\ **************************************************************
\ Data Presentation - number formatting for display.
\ **************************************************************

\ --------------------------------------------------------------
\ #.# ( n -- )                                            MCC=1
\ --------------------------------------------------------------

: #.# ( n -- caddr\count )
\ *G Print the number n with one decimal place.
  s>d <# #
  [char] . hold
  #s #>
;
\ --------------------------------------------------------------
\ #.## ( n -- )                                           MCC=1
\ --------------------------------------------------------------

: #.## ( n -- caddr\count )
\ *G Print the number n with two decimal places.
  s>d <# # #
  [char] . hold
  #s #>
;
\ --------------------------------------------------------------

\ **************************************************************
\ Setting up Sensors
\ **************************************************************

\ --------------------------------------------------------------
\ Temperature (selectable Fahrenheit, Celsius and Kelvin)
\ --------------------------------------------------------------
\ Inlet Temperature Probe                        Parameter (3)
\ --------------------------------------------------------------

SIMULATE: IN-TEMP
160 300 IN-TEMP  MIN/MAX!
185 IN-TEMP !
10 IN-TEMP VARIANCE!

\ --------------------------------------------------------------
\ Outlet Temperature Probe                       Parameter (4)
\ --------------------------------------------------------------

SIMULATE: OUT-TEMP
160 300 OUT-TEMP MIN/MAX!
185 OUT-TEMP !
10 OUT-TEMP VARIANCE!

\ --------------------------------------------------------------
\ RH% - Relative Humidity
\ --------------------------------------------------------------
\ Inlet Relative Humidity                        Parameter (5)
\ --------------------------------------------------------------

SIMULATE: IN-RH%
3000 9500 IN-RH%  MIN/MAX!
6000 IN-RH% !
50 IN-RH% VARIANCE!

\ --------------------------------------------------------------
\ Outlet Relative Humidity                       Parameter (6)
\ --------------------------------------------------------------

SIMULATE: OUT-RH%
3000 9500 OUT-RH%  MIN/MAX!
6000 OUT-RH% !
50 OUT-RH% VARIANCE!

\ --------------------------------------------------------------

\ --------------------------------------------------------------
\ Airflow (l/s)
\ --------------------------------------------------------------
\ Input Airflow (l/s)                            Parameter (7)
\ --------------------------------------------------------------

SIMULATE: IN-FLOW
0 100 IN-FLOW  MIN/MAX!
35 IN-FLOW !
1 IN-FLOW VARIANCE!

\ --------------------------------------------------------------
\ Output Airflow (l/s)                           Parameter (8)
\ --------------------------------------------------------------

SIMULATE: OUT-FLOW
0 100 OUT-FLOW  MIN/MAX!
35 OUT-FLOW !
1 OUT-FLOW VARIANCE!

\ --------------------------------------------------------------

\ --------------------------------------------------------------
\ Atmospheric Pressure (in millibar)
\ --------------------------------------------------------------
\ Input Pressure (mB)                            Parameter (9)
\ --------------------------------------------------------------

SIMULATE: IN-PRES
2000 12500 IN-PRES  MIN/MAX!
9800 IN-PRES !
30 IN-PRES VARIANCE!

\ --------------------------------------------------------------
\ Output Pressure (mB)                           Parameter (10)
\ --------------------------------------------------------------

SIMULATE: OUT-PRES
2000 12500 OUT-PRES MIN/MAX!
9800 OUT-PRES !
30 OUT-PRES VARIANCE!

\ --------------------------------------------------------------

\ --------------------------------------------------------------
\ NO Nitric Oxide
\ --------------------------------------------------------------
\ Input NO (ppm)                                 Parameter (11)
\ --------------------------------------------------------------

SIMULATE: IN-NO
200 9500 IN-NO  MIN/MAX!
6000 IN-NO !
50 IN-NO VARIANCE!

\ --------------------------------------------------------------
\ Output NO (ppm)                               Parameter (12)
\ --------------------------------------------------------------

SIMULATE: OUT-NO
200 9500 OUT-NO  MIN/MAX!
6000 OUT-NO !
50 OUT-NO VARIANCE!

\ --------------------------------------------------------------

\ --------------------------------------------------------------
\ NO2 Nitrogen Dioxide
\ --------------------------------------------------------------
\ Input NO2 (ppm)                               Parameter (13)
\ --------------------------------------------------------------

SIMULATE: IN-NO2
200 9500 IN-NO2  MIN/MAX!
6000 IN-NO2 !
50 IN-NO2 VARIANCE!


\ --------------------------------------------------------------
\ Output NO2 (ppm)                              Parameter (14)
\ --------------------------------------------------------------
SIMULATE: OUT-NO2
200 9500 OUT-NO2  MIN/MAX!
6000 OUT-NO2 !
50 OUT-NO2 VARIANCE!

\ --------------------------------------------------------------

\ --------------------------------------------------------------
\ O3 Ozone (Trioxide)
\ --------------------------------------------------------------
\ Input O3 (ppm)                                 Parameter (15)
\ --------------------------------------------------------------

SIMULATE: IN-O3
200 9500 IN-O3  MIN/MAX!
6000 IN-O3 !
50 IN-O3 VARIANCE!

\ --------------------------------------------------------------
\ Output NO2 (ppm)                               Parameter (16)
\ --------------------------------------------------------------

SIMULATE: OUT-O3
200 9500 OUT-O3  MIN/MAX!
6000 OUT-O3 !
50 OUT-O3 VARIANCE!

\ --------------------------------------------------------------



\ --------------------------------------------------------------
\ CO Carbon Monoxide
\ --------------------------------------------------------------
\ Input CO (ppm)                                 Parameter (17)
\ --------------------------------------------------------------

SIMULATE: IN-CO
200 9500 IN-CO  MIN/MAX!
6000 IN-CO !
50 IN-CO VARIANCE!


\ --------------------------------------------------------------
\ Output CO (ppm)                                Parameter (18)
\ --------------------------------------------------------------

SIMULATE: OUT-CO
200 9500 OUT-CO  MIN/MAX!
6000 OUT-CO !
50 OUT-CO VARIANCE!

\ --------------------------------------------------------------


\ --------------------------------------------------------------
\ SO2 Sulphur Dioxide
\ --------------------------------------------------------------
\ --------------------------------------------------------------
\ Input SO2 (ppm)                                Parameter (19)
\ --------------------------------------------------------------

SIMULATE: IN-SO2
200 9500 IN-SO2  MIN/MAX!
6000 IN-SO2 !
50 IN-SO2 VARIANCE!

\ --------------------------------------------------------------
\ Output SO2 (ppm)                               Parameter (20)
\ --------------------------------------------------------------

SIMULATE: OUT-SO2
200 9500 OUT-SO2  MIN/MAX!
6000 OUT-SO2 !
50 OUT-SO2 VARIANCE!

\ --------------------------------------------------------------

\ --------------------------------------------------------------
\ H2S Hydrogen Sulphide
\ --------------------------------------------------------------
\ Input H2S (ppm)                                Parameter (21)
\ --------------------------------------------------------------

SIMULATE: IN-H2S
200 9500 IN-H2S  MIN/MAX!
6000 IN-H2S !
50 IN-H2S VARIANCE!

\ --------------------------------------------------------------
\ Output H2S (ppm)                               Parameter (22)
\ --------------------------------------------------------------

SIMULATE: OUT-H2S
200 9500 OUT-H2S  MIN/MAX!
6000 OUT-H2S !
50 OUT-H2S VARIANCE!

\ --------------------------------------------------------------

\ --------------------------------------------------------------
\ CO2 Carbon Dioxide
\ --------------------------------------------------------------
\ Input CO2 (ppm)                                Parameter (23)
\ --------------------------------------------------------------

SIMULATE: IN-CO2
200 9500 IN-CO2  MIN/MAX!
6000 IN-CO2 !
50 IN-CO2 VARIANCE!

\ --------------------------------------------------------------
\ Output CO2 (ppm)                               Parameter (24)
\ --------------------------------------------------------------

SIMULATE: OUT-CO2
200 9500 OUT-CO2  MIN/MAX!
6000 OUT-CO2 !
50 OUT-CO2 VARIANCE!

\ --------------------------------------------------------------

\ --------------------------------------------------------------
\ PM1 - 1 micron particulate
\ --------------------------------------------------------------
\ Input PM1 (ppm)                                Parameter (25)
\ --------------------------------------------------------------

SIMULATE: IN-PM1
200 9500 IN-PM1  MIN/MAX!
6000 IN-PM1 !
50 IN-PM1 VARIANCE!

\ --------------------------------------------------------------
\ Output PM1 (ppm)                               Parameter (26)
\ --------------------------------------------------------------

SIMULATE: OUT-PM1
200 9500 OUT-PM1  MIN/MAX!
6000 OUT-PM1 !
50 OUT-PM1 VARIANCE!

\ --------------------------------------------------------------

\ --------------------------------------------------------------
\ PM2.5 - 2.5 micron particulate
\ --------------------------------------------------------------
\ Input PM2n5 (ppm)                              Parameter (27)
\ --------------------------------------------------------------

SIMULATE: IN-PM2n5
200 9500 IN-PM2n5  MIN/MAX!
6000 IN-PM2n5 !
50 IN-PM2n5 VARIANCE!

\ --------------------------------------------------------------
\ Output PM2n5 (ppm)                             Parameter (28)
\ --------------------------------------------------------------

SIMULATE: OUT-PM2n5
200 9500 OUT-PM2n5  MIN/MAX!
6000 OUT-PM2n5 !
50 OUT-PM2n5 VARIANCE!

\ --------------------------------------------------------------

\ --------------------------------------------------------------
\ PM4 - 4 micron particulate
\ --------------------------------------------------------------
\ Input PM4 (ppm)                                Parameter (29)
\ --------------------------------------------------------------

SIMULATE: IN-PM4
200 9500 IN-PM4  MIN/MAX!
6000 IN-PM4 !
50 IN-PM4 VARIANCE!

\ --------------------------------------------------------------
\ Output PM4 (ppm)                               Parameter (30)
\ --------------------------------------------------------------

SIMULATE: OUT-PM4
200 9500 OUT-PM4  MIN/MAX!
6000 OUT-PM4 !
50 OUT-PM4 VARIANCE!

\ --------------------------------------------------------------

\ --------------------------------------------------------------
\ PM10 - 10 micron particulate
\ --------------------------------------------------------------
\ Input PM10 (ppm)                               Parameter (31)
\ --------------------------------------------------------------

SIMULATE: IN-PM10
200 9500 IN-PM10  MIN/MAX!
6000 IN-PM10 !
50 IN-PM10 VARIANCE!

\ --------------------------------------------------------------
\ Output PM10 (ppm)                              Parameter (32)
\ --------------------------------------------------------------

SIMULATE: OUT-PM10
200 9500 OUT-PM10  MIN/MAX!
6000 OUT-PM10 !
50 OUT-PM10 VARIANCE!

\ --------------------------------------------------------------


\ **************************************************************
\ Data Display
\ **************************************************************


\ --------------------------------------------------------------
\ Time & Date                                 Parameter (1 & 2)
\ --------------------------------------------------------------
\ Number format as 'yyyymmdd'
\ --------------------------------------------------------------


\ --------------------------------------------------------------
\ DAYS ( -- caddr )                                       MCC=1
\ --------------------------------------------------------------

CREATE DAYS ( -- caddr )
CHAR S C, CHAR u C, CHAR n C, \ SUN
CHAR M C, CHAR o C, CHAR n C, \ MON
CHAR T C, CHAR u C, CHAR e C, \ TUE
CHAR W C, CHAR e C, CHAR d C, \ WED
CHAR T C, CHAR h C, CHAR u C, \ THU
CHAR F C, CHAR r C, CHAR i C, \ FRI
CHAR S C, CHAR a C, CHAR t C, \ SAT
\ --------------------------------------------------------------

\ --------------------------------------------------------------
\  .DAY ( -- )                                            MCC=1
\ --------------------------------------------------------------

: .DAY ( -- )
\ *G Based on the DOW value, print the day of the week from the
\ ** array established in DAYS. All day names constrained to 3
\ ** characters.
  DAYS DOW 3 * + 3 TYPE
;

\ --------------------------------------------------------------
\ MONTHS ( -- caddr )                                     MCC=1
\ --------------------------------------------------------------

CREATE MONTHS ( -- caddr )
CHAR J C, CHAR a C, CHAR n C, \ JAN
CHAR F C, CHAR e C, CHAR b C, \ FEB
CHAR M C, CHAR a C, CHAR r C, \ MAR
CHAR A C, CHAR p C, CHAR r C, \ APR
CHAR M C, CHAR a C, CHAR y C, \ MAY
CHAR J C, CHAR u C, CHAR n C, \ JUN
CHAR J C, CHAR u C, CHAR l C, \ JUL
CHAR A C, CHAR u C, CHAR g C, \ AUG
CHAR S C, CHAR e C, CHAR p C, \ SEP
CHAR O C, CHAR c C, CHAR t C, \ OCT
CHAR N C, CHAR o C, CHAR v C, \ NOV
CHAR D C, CHAR e C, CHAR c C, \ DEC
\ --------------------------------------------------------------

\ --------------------------------------------------------------
\  .MONTH ( month -- )                                    MCC=1
\ --------------------------------------------------------------

: .MONTH ( month -- )
\ *G Based on the month number, print the day of the week from
\ ** the array established in MONTHS. All month names are
\ ** constrained to 3 characters.
  1- >R MONTHS R> 3 * + 3 TYPE
;
\ --------------------------------------------------------------

\ --------------------------------------------------------------
\  .DATE ( -- )                                           MCC=1
\ --------------------------------------------------------------

: .DATE ( -- )
\ *G Display the current date. Discard the time portion gathered
\ ** by TIME&DATE.
  TIME&DATE          \ Get current date and time data
  .DAY SPACE ROT .   \ Display day of week and the date
  SWAP .MONTH        \ Display the month
  SPACE .            \ Display the year
  2DROP DROP         \ Discard the time
;
\ --------------------------------------------------------------

\ --------------------------------------------------------------
\ TIME@ ( -- sec )                                        MCC=1
\ --------------------------------------------------------------

: TIME@ ( -- sec )
  TIME&DATE DROP 2DROP
  60 * +
  60 * +
;
\ --------------------------------------------------------------

\ --------------------------------------------------------------
\ SEXTAL ( -- )                                           MCC=1
\ --------------------------------------------------------------

: SEXTAL ( -- )
\ *G Change number base to six
  6 BASE !
;
\ --------------------------------------------------------------

\ --------------------------------------------------------------
\ :00 ( ud -- ?? )
\ --------------------------------------------------------------

: :00
\ *G Present two digits of the time into the output string.
  # SEXTAL
  # DECIMAL
  [CHAR] : HOLD
;
\ --------------------------------------------------------------

\ --------------------------------------------------------------
\ .TIME ( sec -- )                                        MCC=1
\ --------------------------------------------------------------

: #TIME ( sec -- caddr\u )
\ *G Display sec in time display format ##:##:##.
  s>d <# :00 :00 #S #>
;
\ --------------------------------------------------------------


\ --------------------------------------------------------------
\ Text Banners
\ --------------------------------------------------------------

S" Pressure Temperature and Humidity & Flow " 2CONSTANT $H1
S" Date" 2CONSTANT $DATE
S" Time" 2CONSTANT $TIME
S" Temperatures(C)" 2CONSTANT $TEMP
S" Rel Humidity(%)" 2CONSTANT $RH%
S" Air Flow(l/s)" 2CONSTANT $AF
S" Air Pressure(mB)" 2CONSTANT $AP
S" Inlet" 2CONSTANT $INLET
S" Outlet" 2CONSTANT $OUTLET

: Table1 ( -- )
  CR
  16 SPACES $H1 TYPE
   5 SPACES .DATE CR
\ Second Line Header   
  9 SPACES $TEMP TYPE
  1 SPACES $RH% TYPE
  1 SPACES $AF TYPE
  1 SPACES $AP TYPE CR
\ Third Row Header
  2 SPACES $TIME TYPE      \ Time of Reading Header
  4 SPACES $INLET TYPE     \ Temperature
  2 SPACES $OUTLET TYPE
  3 SPACES $INLET TYPE     \ Relative Humidity
  2 SPACES $OUTLET TYPE
  2 SPACES $INLET TYPE     \ Air Flow
  2 SPACES $OUTLET TYPE
  3 SPACES $INLET TYPE     \ Air Pressure
  2 SPACES $OUTLET TYPE
  CR
;

: COMMA [CHAR] , EMIT ;

: <Header> ( -- )   \ Version for heading CSV reports.
  $H1 TYPE 2 SPACES .DATE CR
\ Second Line Header
  $DATE TYPE COMMA
  $TIME TYPE COMMA
  $INLET TYPE SPACE $TEMP TYPE COMMA
  $OUTLET TYPE SPACE $TEMP TYPE COMMA
  $INLET TYPE SPACE $RH% TYPE COMMA
  $OUTLET TYPE SPACE $RH% TYPE COMMA
  $INLET TYPE SPACE $AF TYPE COMMA
  $OUTLET TYPE SPACE $AF TYPE COMMA
  $INLET TYPE SPACE $AP TYPE COMMA
  $OUTLET TYPE SPACE $AP TYPE CR
\ Third Row Header
\  2 SPACES $TIME TYPE      \ Time of Reading Header
\  4 SPACES $INLET TYPE     \ Temperature
\  2 SPACES $OUTLET TYPE
\  3 SPACES $INLET TYPE     \ Relative Humidity
\  2 SPACES $OUTLET TYPE
\  2 SPACES $INLET TYPE     \ Air Flow
\  2 SPACES $OUTLET TYPE
\  3 SPACES $INLET TYPE     \ Air Pressure
\  2 SPACES $OUTLET TYPE
\  CR
;

\ Data Line  
: .DL
  TIME@ #TIME TYPE 
  2 SPACES IN-TEMP @ #.# TYPE
  3 SPACES OUT-TEMP @ #.# TYPE
  5 SPACES IN-RH% @ #.## TYPE
  3 SPACES OUT-RH% @ #.## TYPE
  3 SPACES IN-FLOW @ #.# TYPE
  4 SPACES OUT-FLOW @ #.# TYPE
  5 SPACES IN-PRES @ #.# TYPE
  3 SPACES OUT-PRES @ #.# TYPE
\  
  CR
;

: <DATE> ( -- caddr\n )
  TIME&DATE 100 * +
  100 * + S>D <# #S #> 2>R
  DROP 2DROP 2R>
;

0 VALUE File-Buff
128 value #buffcells

: Set-Buff 
  HERE #buffcells
  dup UNUSED <
  IF   CELLS ALLOT
       TO File-Buff
  ELSE ABORT" Not enough space"
  THEN
;

: RESET-BUFF
  #buffcells
  negate allot
  here to File-Buff
;

: +COMMA ( $addr -- )
\ *G Append a comma to the counted string at $addr.
  DUP >R        \ $addr            ( $addr )
  COUNT TUCK +  \ n\caddr          ( $addr )
  [CHAR] ,      \ n\caddr\char     ( $addr )
  SWAP C!       \ n                ( $addr )
  1+ R> C!      \ --
;

: +CR ( $addr -- )
  DUP >R        \ $addr            ( $addr )
  COUNT TUCK +  \ n\caddr          ( $addr )
  10            \ n\caddr\char     ( $addr )
  SWAP C!       \ n                ( $addr )
  1+ R> C!      \ --
;
  

\ Data Line  
: <DL>
  <DATE> file-buff append file-buff +COMMA
  TIME@ #TIME file-buff append file-buff +COMMA
  IN-TEMP @ #.# file-buff append file-buff +COMMA
  OUT-TEMP @ #.# file-buff append file-buff +COMMA
  IN-RH% @ #.## file-buff append file-buff +COMMA
  OUT-RH% @ #.## file-buff append file-buff +COMMA
  IN-FLOW @ #.# file-buff append file-buff +COMMA
  OUT-FLOW @ #.# file-buff append file-buff +COMMA
  IN-PRES @ #.# file-buff append file-buff +COMMA
  OUT-PRES @ #.# file-buff append file-buff +COMMA
;

: SECS
  1000 * MS KEY?
  IF   KEY DROP ABORT" User Aborted"
  THEN 
;

: MINS 60 SECS ;

: MIN-LOG
  <DL> 60 secs
;

: LOGGING
  BEGIN MIN-LOG
        KEY?
  UNTIL KEY DROP
;  

: HOUR-LOG
  <HEADER> 60 0
  DO  MIN-LOG
  LOOP
;


\ 10 Rows
\ : Ten-Rows
\  10 0
\  DO   .DL
\       1000 MS
\  LOOP
\ ;
\
\ CLS TABLE1 TEN-ROWS 1000 MS TEN-ROWS

