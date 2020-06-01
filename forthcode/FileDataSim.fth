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
\ File Buffer
\ **************************************************************

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



\ **************************************************************
\ Data Presentation - number formatting for display.
\ **************************************************************

\ --------------------------------------------------------------
\ #. ( n -- caddr\count )                                 MCC=1
\ --------------------------------------------------------------

: #. ( n -- caddr\count )
  s>d <# #s #>
;
\ --------------------------------------------------------------

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

: +BL ( $addr -- )
\ *G Append a comma to the counted string at $addr.
  DUP >R        \ $addr            ( $addr )
  COUNT TUCK +  \ n\caddr          ( $addr )
  BL            \ n\caddr\char     ( $addr )
  SWAP C!       \ n                ( $addr )
  1+ R> C!      \ --
;

: +CR ( $addr -- )
\ *G Append a comma to the counted string at $addr.
  DUP >R        \ $addr            ( $addr )
  COUNT TUCK +  \ n\caddr          ( $addr )
  10            \ n\caddr\char     ( $addr )
  SWAP C!       \ n                ( $addr )
  1+ R> C!      \ --
;

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

S" SunMonTueWedThuFriSat" 2constant $days

: <day> $days drop dow 3 * + 3 ;

: .day <day> type ;

\ --------------------------------------------------------------
\ MONTHS ( -- caddr )                                     MCC=1
\ --------------------------------------------------------------

S" JanFebMarAprMayJunJulAugSepOctNovDec" 2constant $month

: <month> ( month -- caddr\n )
  1- >R $month drop r> 3 * + 3
;

\ --------------------------------------------------------------
\  .MONTH ( month -- )                                    MCC=1
\ --------------------------------------------------------------

: .MONTH ( month -- )
\ *G Based on the month number, print the day of the week from
\ ** the array established in MONTHS. All month names are
\ ** constrained to 3 characters.
  <month> TYPE
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

: <.DATE> ( -- )
  <DAY> file-buff append  \ Day of Week
  file-buff +BL
  TIME&DATE               \ Get current date and time data
  ROT #.
  file-buff append 
  file-buff +BL
  SWAP <MONTH>
  file-buff append        \ Display the month
  file-buff +BL 
  #. file-buff append     \ Display the year
  2DROP DROP              \ Discard the time
;
\ --------------------------------------------------------------

\ --------------------------------------------------------------
\ <DATE> ( -- caddr\n )
\ --------------------------------------------------------------

: <DATE> ( -- caddr\n )
\ *G Date formatted as a single value yyyymmdd.
  TIME&DATE 100 * +
  100 * + S>D <# #S #> 2>R
  DROP 2DROP 2R>
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

\ **************************************************************
\ Data Formatting
\ **************************************************************

: +COMMA ( $addr -- )
\ *G Append a comma to the counted string at $addr.
  DUP >R        \ $addr            ( $addr )
  COUNT TUCK +  \ n\caddr          ( $addr )
  [CHAR] ,      \ n\caddr\char     ( $addr )
  SWAP C!       \ n                ( $addr )
  1+ R> C!      \ --
;

: +,ITEM
  file-buff append
  file-buff +COMMA
;

: +BL-ITEM
   file-buff append
   file-buff +BL
;

: +Last-ITEM ( caddr\n -- )
  file-buff append
  file-buff +CR
;

\ --------------------------------------------------------------
\ Text Banners
\ --------------------------------------------------------------

S" PureBreze - Air Quality Monitor" 2Constant $PureBreze
S" Measurements made on" 2CONSTANT $H1
S" Date" 2CONSTANT $DATE
S" Time" 2CONSTANT $TIME
S" Temperatures(C)" 2CONSTANT $TEMP
S" Rel Humidity(%)" 2CONSTANT $RH%
S" Air Flow(l/s)" 2CONSTANT $AF
S" Air Pressure(mB)" 2CONSTANT $AP
S" NO (ppm)" 2CONSTANT $NO
S" O3 (ppm)" 2CONSTANT $O3
S" NO2 (ppm)" 2CONSTANT $NO2
S" CO (ppm)" 2CONSTANT $CO
S" SO2 (ppm)" 2CONSTANT $SO2
S" H2S (ppm)" 2CONSTANT $H2S
S" CO2 (ppm)" 2CONSTANT $CO2
S" PM1 (ppm)" 2CONSTANT $PM1
S" PM2.5 (ppm)" 2CONSTANT $PM2n5
S" PM4 (ppm)" 2CONSTANT $PM4
S" PM10 (ppm)" 2CONSTANT $PM10
S" Inlet" 2CONSTANT $INLET
S" Outlet" 2CONSTANT $OUTLET
\ --------------------------------------------------------------

\ --------------------------------------------------------------
\ Header Section
\ --------------------------------------------------------------

: <H1> ( -- )      \ Version for heading CSV reports.
  $PureBreze  +LAST-ITEM
\ Second Line Header
  $H1 +,ITEM <.DATE> file-buff +CR
; \ 60 characters

: <H2>  
\   Third Line Header
  $DATE  +,ITEM   $TIME  +,ITEM
  $INLET +BL-ITEM $TEMP  +,ITEM $OUTLET +BL-ITEM $TEMP  +,ITEM
  $INLET +BL-ITEM $RH%   +,ITEM $OUTLET +BL-ITEM $RH%   +,ITEM
  $INLET +BL-ITEM $AF    +,ITEM $OUTLET +BL-ITEM $AF    +,ITEM
  $INLET +BL-ITEM $AP    +,ITEM $OUTLET +BL-ITEM $AP    +,ITEM
;  \ 188 characters

: <H3>
  $INLET +BL-ITEM $NO    +,ITEM $OUTLET +BL-ITEM $NO    +,ITEM
  $INLET +BL-ITEM $NO2   +,ITEM $OUTLET +BL-ITEM $NO2   +,ITEM
  $INLET +BL-ITEM $O3    +,ITEM $OUTLET +BL-ITEM $O3    +,ITEM
  $INLET +BL-ITEM $CO    +,ITEM $OUTLET +BL-ITEM $CO    +,ITEM
  $INLET +BL-ITEM $SO2   +,ITEM $OUTLET +BL-ITEM $SO2   +,ITEM
  $INLET +BL-ITEM $H2S   +,ITEM $OUTLET +BL-ITEM $H2S   +,ITEM
; \ 192 characters

: <H4>  
  $INLET +BL-ITEM $CO2   +,ITEM $OUTLET +BL-ITEM $CO2   +,ITEM
  $INLET +BL-ITEM $PM1   +,ITEM $OUTLET +BL-ITEM $PM1   +,ITEM
  $INLET +BL-ITEM $PM2N5 +,ITEM $OUTLET +BL-ITEM $PM2N5 +,ITEM
  $INLET +BL-ITEM $PM4   +,ITEM $OUTLET +BL-ITEM $PM4   +,ITEM
  $INLET +BL-ITEM $PM10  +,ITEM $OUTLET +BL-ITEM $PM10
  +LAST-ITEM
\   file-buff +cr 
; \ 171 characters.
\ --------------------------------------------------------------

\ --------------------------------------------------------------
\ Data Line  
\ --------------------------------------------------------------

: <DL>
  <DATE> file-buff append file-buff +COMMA
  TIME@ #TIME file-buff append file-buff +COMMA
  IN-TEMP @ #.#  +,ITEM OUT-TEMP @ #.#  +,ITEM
  IN-RH% @ #.##  +,ITEM OUT-RH% @ #.##  +,ITEM
  IN-FLOW @ #.#  +,ITEM OUT-FLOW @ #.#  +,ITEM
  IN-PRES @ #.#  +,ITEM OUT-PRES @ #.#  +,ITEM
  IN-NO @ #.#    +,ITEM OUT-NO @ #.#    +,ITEM
  IN-NO2 @ #.#   +,ITEM OUT-NO2 @ #.#   +,ITEM
  IN-O3 @ #.#    +,ITEM OUT-O3 @ #.#    +,ITEM
  IN-CO2 @ #.#   +,ITEM OUT-CO2 @ #.#   +,ITEM
  IN-SO2 @ #.#   +,ITEM OUT-SO2 @ #.#   +,ITEM
  IN-H2S @ #.#   +,ITEM OUT-H2S @ #.#   +,ITEM
  IN-CO @ #.#    +,ITEM OUT-CO2 @ #.#   +,ITEM
  IN-PM1 @ #.#   +,ITEM OUT-PM1 @ #.#   +,ITEM
  IN-PM2N5 @ #.# +,ITEM OUT-PM2N5 @ #.# +,ITEM
  IN-PM4 @ #.#   +,ITEM OUT-PM4 @ #.#   +,ITEM
  IN-PM10 @ #.#  +,ITEM OUT-PM10 @ #.#  +LAST-ITEM
;
\ --------------------------------------------------------------

\ --------------------------------------------------------------
\ Buffer Prep
\ --------------------------------------------------------------

: CLEAR-BUFF ( -- )
  FILE-BUFF #BUFFCELLS CELLS 0 FILL
;

: ?BUFF ( -- )
  FILE-BUFF #BUFFCELLS CELLS DUMP
;

: INIT-BUFF
  SET-BUFF CLEAR-BUFF
;

: .BUFF ( -- )
  FILE-BUFF COUNT TYPE 
;

0 VALUE LOGFIL



S" PureBreze20200530-01.csv" 2value $LogFile

: Newfile $logfile r/w create-file 
  0<> ABORT" File Creation Error"
  to logfil
;

: >LOG
  file-buff count
  logfil write-file
  0<> ABORT" File Write Error"
;

: ENDLOG
  logfil close-file
  0<> ABORT" File Close Error"
;

: >>HEADINGS
  clear-buff <H1> >log 100 ms
  clear-buff <H2> >log 100 ms
  clear-buff <h3> >log 100 ms
  clear-buff <h4> >log 100 ms
;  

: >>DATA
  clear-buff <DL> >log
;  

\ --------------------------------------------------------------
\ SECS
\ --------------------------------------------------------------

: SECS
  1000 * MS KEY?
  IF   KEY DROP ENDLOG
       ABORT" User Aborted"
  THEN
;

: MINS 60 SECS ;

: MIN-LOG-5s
  >>DATA 5 secs  
;

: LOG-ON
  Newfile
  >>HEADINGS
;

: lines
  0
  do   min-log-5s
  loop endlog
;

\ : HOUR-LOG
\  <HEADER> 60 0
\  DO  MIN-LOG
\  LOOP
\ ;


: MIN-LOG-30s
  >>DATA 30 secs
;


: lines-30s
  0
  do   min-log-30s
  loop endlog
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


init-buff
?buff
