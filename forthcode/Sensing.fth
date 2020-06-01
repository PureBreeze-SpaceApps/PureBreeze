\          PureBreze Air Quality Manager
\ The following is prototype code for the PureBreze Air Quality
\ Manager systems. The functions are mainly to monitor the two
\ sensor packs, package the results for display and allow the
\ communication of those results.
\ 
\ Additionally, the software will compare the differential
\ trends between sensor packs, provide warnings and indicate
\ when the filter units require to be changed.
\ **************************************************************

\ **************************************************************
\ Sensor Inputs
\ **************************************************************
\
\ --------------------------------------------------------------
\ DHT 11 Humidity and Temperature Sensing
\ --------------------------------------------------------------
\ The DHT11 Humidity and Temperature Sensor produces a digital
\ output bit-stream that is encoded as follows:-
\
\ 8 bits Integral Relative Humidty Value (MSB first)
\ 8 bits Decimal Relative Humidity Value
\ 8 bits Integral Temperature Value
\ 8 bits Decimal Temperature Value
\ 8 bits Checksum (If the data transmission is right, the
\ check-sum should be the last 8bit of "8bit integral RH data
\ + 8bit decimal RH data + 8bit integral T data + 8bit decimal
\ T data".
\
\ Communication process should be 4ms total.
\ **************************************************************

  xx CONSTANT DHT11-Pin

\ --------------------------------------------------------------
\ START-DHT11 ( -- )
\ --------------------------------------------------------------

: START-DHT11 ( -- )
\ *G Send a low for 19ms to signal that DHT11 sensor should
\ ** emerge from low power mode and begin providing data.
  DHT11-PIN OUTPUT PinMode
  0 DHT11-PIN digitallWrite
  19 ms
  1 DHT11-PIN digitallWrite
  DHT11-PIN INPUT PinMode
;
\ --------------------------------------------------------------

\ --------------------------------------------------------------
\ After the above start pulse the DHT11 will respond within
\ 20-40us by pulling the bus low for 80us before allowing the
\ bus to be pulled high again for another 80us.
\ --------------------------------------------------------------

\ --------------------------------------------------------------
\ DHT-SENSE-START ( -- flag )
\ --------------------------------------------------------------

:  DHT-SENSE-START ( -- flag )
\ *G Sense the start signal from teh DHT11 sensor. Return a
\ ** true flag if a valid start signal is detected. If no
\ ** valid start signal is received, return a false flag.
  BEGIN DHT11-PIN digitallRead 0<>
  UNTIL utime
  BEGIN DHT11-PIN digitallRead 0=
  UNTIL utime SWAP D- 
  
  
;
\ --------------------------------------------------------------


