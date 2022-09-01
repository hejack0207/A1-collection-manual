### Generic NMEA GPS Receiver

Last update:
31-Mar-2014 03:55
UTC

* * *

#### Synopsis

Address: 127.127.20. _u_

Reference ID: GPS

Driver ID: GPS\_NMEA

Serial Port: /dev/gps _u_; 4800 - 115200 bps, 8-bits, no parity

Serial Port: /dev/gpspps _u_; for just the PPS signal (this
is tried first for PPS, before /dev/gps _u_)

Serial Port: /dev/gps _u_; symlink to server:port (for nmead)

Features: tty\_clk

#### Description

This driver supports GPS receivers with
the $GPRMC, $GPGLL, $GPGGA, $GPZDA
and $GPZDG NMEA sentences by default.  Note that Accord's
custom NMEA sentence $GPZDG reports using the GPS timescale,
while the rest of the sentences report UTC.  The difference between
the two is a whole number of seconds which increases with each leap
second insertion in UTC.  To avoid problems mixing UTC and GPS
timescales, the driver disables processing of UTC sentences
once $GPZDG is received.


The driver expects the receiver to be set up to transmit at least one
supported sentence every second.


The accuracy depends on the receiver used. Inexpensive GPS models are
available with a claimed PPS signal accuracy of
1 μs or better relative to the broadcast
signal. However, in most cases the actual accuracy is limited by the
precision of the timecode and the latencies of the serial interface and
operating system.


If the Operating System supports PPSAPI
( [RFC 2783](http://www.ietf.org/rfc/rfc2783.txt)), fudge flag1
1 enables its use.


The various GPS sentences that this driver recognises look like this:

(others quietly ignored)


Accepted NMEA sentencesSentenceVendor$GPRMC,UTC,POS\_STAT,LAT,LAT\_REF,LON,LON\_REF,SPD,HDG,DATE,MAG\_VAR,MAG\_REF\*CS<cr><lf>$GPGLL,LAT,LAT\_REF,LON,LON\_REF,UTC,POS\_STAT\*CS<cr><lf>$GPGGA,UTC,LAT,LAT\_REF,LON,LON\_REF,FIX\_MODE,SAT\_USED,HDOP,ALT,ALT\_UNIT,GEO,G\_UNIT,D\_AGE,D\_REF\*CS<cr><lf>$GPZDA,UTC,DD,MM,YYYY,TH,TM,\*CS<cr><lf>$GPZDG,GPSTIME,DD,MM,YYYY,AA.BB,V\*CS<cr><lf>Accord

NMEA data itemsSymbolMeaning and FormatUTCTime of day on UTC timescale. Hours, minutes and seconds [fraction (opt.)]. (hhmmss[.fff])POS\_STATPosition status. (A = Data valid, V = Data invalid)LATLatitude (llll.ll)LAT\_REFLatitude direction. (N = North, S = South)LONLongitude (yyyyy.yy)LON\_REFLongitude direction (E = East, W = West)SPDSpeed over ground. (knots) (x.x)HDGHeading/track made good (degrees True) (x.x)DATEDate (ddmmyy)MAG\_VARMagnetic variation (degrees) (x.x)MAG\_REFMagnetic variation (E = East, W = West)FIX\_MODEPosition Fix Mode (0 = Invalid, >0 = Valid)SAT\_USEDNumber of Satellites used in solutionHDOPHorizontal Dilution of PrecisionALTAntenna AltitudeALT\_UNITAltitude Units (Metres/Feet)GEOGeoid/Elipsoid separationG\_UNITGeoid units (M/F)D\_AGEAge of last DGPS FixD\_REFReference ID of DGPS stationGPSTIMETime of day on GPS timescale. Hours, minutes and seconds [fraction (opt.)]. (hhmmss[.f])DDDay of the month (1-31)MMMonth of the year (1-12)YYYYYearAA.BBDenotes the signal strength (should be < 05.00)VGPS sync status

   '0' => INVALID time,

   '1' => accuracy of +/- 20ms,

   '2' => accuracy of +/- 100nsCS Checksum<cr><lf>Sentence terminator.

#### The 'mode' byte

Specific GPS sentences and bitrates may be selected by setting bits of
the 'mode' in the server configuration line:

server
127.127.20.x mode X

mode byte bits and bit groupsBitDecimalHexMeaning011process $GPMRC122process $GPGGA244process $GPGLL388process $GPZDA or $GPZDG4-600linespeed 4800 bps160x10linespeed 9600 bps320x20linespeed 19200 bps480x30linespeed 38400 bps640x40linespeed 57600 bps800x50linespeed 115200 bps71280x80Write the sub-second fraction of the receive time stamp to the
 clockstat file for all recognised NMEA sentences. This can be used to
 get a useful value for fudge time2.

**Caveat:** This
 will fill your clockstat file rather fast. Use it only temporarily to
 get the numbers for the NMEA sentence of your choice.82560x100process $PGRMF9-150xFE00reserved - leave 016655360x10000Append extra statistics to the clockstats line.
 Details below.

The default (mode 0) is to process all supported sentences at a linespeed
of 4800 bps, which results in the first one received and recognised in
each cycle being used.  If only specific sentences should be
recognised, then the mode byte must be chosen to enable only the selected
ones.  Multiple sentences may be selected by adding their mode bit
values, but of those enabled still only the first received sentence in a
cycle will be used.  Using more than one sentence per cycle is
impossible, because


- there is only[fudge time2](#fudgetime2) available to
   compensate for transmission delays but every sentence would need a
   different one and

- using more than one sentence per cycle overstuffs the internal data
   filters.


 The driver uses 4800 bits per second by default, but faster bitrates can
 be selected using bits 4 to 6 of the mode field.


**Caveat:** Using higher line speeds does not necessarily
increase the precision of the timing device.  Higher line speeds are
not necessarily helpful for the NMEA driver, either.  They can be
used to accomodate for an amount of data that does not fit into a
1-second cycle at 4800 bps, but high-speed high-volume NMEA data is likely
to cause trouble with the serial line driver since NMEA supports no
protocol handshake.  Any device that is exclusively used for time
synchronisation purposes should be configured to transmit the relevant
data only, e.g. one $GPRMC or $GPZDA per second, at a
linespeed of 4800 bps or 9600 bps.


#### Monitor Data

The last GPS sentence that is accepted or rejected is written to the
clockstats file and available with `ntpq -c clockvar`.
(Logging the rejected sentences lets you see/debug why they were rejected.)
Filtered sentences are not logged.

If the 0x10000 mode bit is on and clockstats is enabled, several extra
counters will be appended to the NMEA sentence that gets logged.
For example:

```
56299 76876.691 127.127.20.20 $GPGGA,212116.000,3726.0785,N,12212.2605,W,1,05,2.0,17.0,M,-25.7,M,,0000*5C  228 64 0 0 64 0

```

ClockstatsColumnSampleMeaning156299MJD276876.691Time of day in seconds3127.127.20.20IP Address from server config line4$GPGGA,...0\*5CNMEA Sentence5228Number of sentences received664Number of sentences accepted and used for timekeeping70Number of sentences rejected because they were marked invalid (poor signal)80Number of sentences rejected because of bad checksum or invalid date/time964Number of sentences filtered by mode bits or same second100Number of PPS pulses used, overrides NMEA sentences

 Sentences like $GPGSV that don't contain the time will get
 counted in the total but otherwise ignored.



[Configuring\
NMEA Refclocks](https://support.ntp.org/bin/view/Support/ConfiguringNMEARefclocks) might give further useful hints for specific hardware
devices that exhibit strange or curious behaviour.


To make a specific setting, select the corresponding decimal values from
the mode byte table, add them all together and enter the resulting
decimal value into the clock configuration line.


#### Setting up the Garmin GPS-25XL

 Switch off all output with by sending it the following string.


```
"$PGRMO,,2<cr><lf>"
```

Now switch only $GPRMC on by sending it the following string.

```
"$PGRMO,GPRMC,1<cr><lf>"
```

On some systems the PPS signal isn't switched on by default. It can be
switched on by sending the following string.

```
"$PGRMC,,,,,,,,,,,,2<cr><lf>"
```

#### Fudge Factors

time1 _time_Specifies the PPS time offset calibration factor, in seconds and fraction, with default 0.0.time2 _time_Specifies the serial end of line time offset calibration factor, in seconds and fraction, with default
 0.0.stratum _number_Specifies the driver stratum, in decimal from 0 to 15, with default 0.refid _string_Specifies the driver reference identifier, an ASCII string from one to four characters, with
 default GPS.flag1 0 \| 1Disable PPS signal processing if 0 (default); enable PPS signal processing if 1.flag2 0 \| 1If PPS signal processing is enabled, capture the pulse on the rising edge if 0 (default); capture on the
 falling edge if 1.flag3 0 \| 1If PPS signal processing is enabled, use the ntpd clock discipline if 0 (default); use the kernel
 discipline if 1.flag4 0 \| 1Obscures location in timecode: 0 for disable (default), 1 for enable.

Additional Information

flag1, flag2, and flag3 are ignored under Windows.

[Reference Clock Drivers](../refclock.html)

* * *

