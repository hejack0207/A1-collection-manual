# MX4200 Receiver Data Format

Last update:
21-Oct-2010 23:44
UTC

* * *

## Table of Contents

- [Control Port Sentences](#control)
- [Control Port Input Sentences](#input)
  - [$PMVXG,000](#input_000) Initialization/Mode Control - Part A

  - [$PMVXG,001](#input_001) Initialization/Mode Control - Part B

  - [$PMVXG,007](#input_007) Control Port Configuration

  - [$PMVXG,023](#input_023) Time Recovery Configuration

  - [$CDGPQ,YYY](#input_gpq) Query From a Remote Device / Request to Output a Sentence
- [Control Port Output Sentences](#output)
  - [$PMVXG,000](#output_000) Receiver Status

  - [$PMVXG,021](#output_021) Position, Height, Velocity

  - [$PMVXG,022](#output_022) DOPs

  - [$PMVXG,030](#output_030) Software Configuration

  - [$PMVXG,101](#output_101) Control Sentence Accept/Reject

  - [$PMVXG,523](#output_523) Time Recovery Configuration

  - [$PMVXG,830](#output_830) Time Recovery Results

* * *

## Control Port Sentences

The Control (CDU) Port is used to initialize, monitor, and control the receiver. The structure of the control port sentences is based on the NMEA-0183 Standard for Interfacing Marine Electronics Navigation Devices (version 1.5). For more details, please refer to the NMEA-0183 Specification available from the [National Marine Electronics Association](http://www.nmea.org/).

Reserved characters are used to indicate the beginning and the end of records in the data stream, and to delimit data fields within a sentence. Only printable ASCII characters (Hex 20 through 7F) may be used in a sentence. [Table 2](#table_2) lists the reserved characters and defines their usage. [Table 1](#table_1) illustrates the general Magnavox proprietary NMEA sentence format.

#### Table 1. Magnavox Proprietary NMEA Sentence Format

 `$PMVXG,XXX,...................*CK `

CharacterMeaning`$`Sentence Start Character`P`Special ID (P = Proprietary)`MVX`Originator ID (MVX = Magnavox)`G`Interface ID (G = GPS)`XXX`Sentence Type`...`Data`*`Optional Checksum Field Delimiter`CK`Optional Checksum

#### Table 2. NMEA Sentence Reserved Characters

CharacterHex ValueUsage`$`24Start of Sentence Identifier`{cr}{lf}`0D 0AEnd of Sentence Identifier`,`2CSentence Delimiter`*`2AOptional Checksum Field Delimiter

Following the start character `$`, are five characters which constitute the block label of the sentence. For Magnavox proprietary sentences, this label is always `PMVXG`. The next field after the block label is the sentence type, consisting of three decimal digits.

The data, delimited by commas, follows the sentence type. Note that the receiver uses a free-format parsing algorithm, so you need not send the exact number of characters shown in the examples. You will need to use the commas to determine how many bytes of data need to be retrieved.

The notation `CK` shown in [Table 1](#table_1) symbolically indicates the optional checksum in the examples. The checksum is computed by exclusive-ORing all of the bytes between the `$` and the `*` characters. The `$`, `*` and the checksum are not included in the checksum computation.

Checksums are optional for Control Port input sentences, but are highly recommended to limit the effects of communication errors. Magnavox receivers always generate checksums for Control Port output sentences.

ASCII data characters are transmitted in the following format:

Data Bits8 (msb always 0)ParityNoneStop Bits1

NULL fields are fields which do not contain any data. They would appear as two commas together in the sentence format, except for the final field. Some Magnavox proprietary sentences require that the format contain NULL fields. mandatory NULL fields are identified by an '\*' next to the respective field.

* * *

## Control Port Input Sentences

 These are the subset of the MX4200 control port input sentences sent by the NTP driver to the GPS receiver.


* * *

### $PMVXG,000

#### Initialization/Mode Control - Part A

 Initializes the time, position and antenna height of the MX4200.


FieldDescriptionUnitsFormatDefaultRange1DayInt1-312MonthInt1-123YearInt1991-99994GMT TimeHHMMSSInt000000-2359595WGS-84 LatitudeDDMM.MMMMFloat0.00 - 8959.99996North/South IndicatorCharNN,S7WGS-84 LongitudeDDDMM.MMMMFloat0.00 - 17959.99998East/West IndicatorCharEE,W9Altitude (height above Mean Sea Level) in meters (WGS-84)MetersFloat0.0+/-99999.010Not Used
 Example:

`$PMVXG,000,,,,,,,,,,*48`

`$PMVXG,000,,,,,5128.4651,N,00020.0715,W,58.04,*4F`

* * *

### $PMVXG,001

#### Initialization/Mode Control - Part B

 Specifies various navigation parameters: Altitude aiding, acceleration DOP limits, and satellite elevation limits.


FieldDescriptionUnitsFormatDefaultRange\*1Constrain AltitudeInt10=3D Only

 1=Auto

 2=2D Only2Not Used\*3Horizontal Acceleration Factorm/sec^2Float1.00.5-10.0\*4Not Used\*5VDOP LimitInt101-9999\*6HDOP LimitInt101-99997Elevation LimitDegInt50-908Time Output ModeCharUU=UTC

 L=Local Time9Local Time OffsetHHMMInt0\+/\- 0-2359
 Example:

`$PMVXG,001,3,,0.1,0.1,10,10,5,U,0*06`

* * *

### $PMVXG,007

#### Control Port Output Configuration

 This message enables or disables output of the specified sentence and defines the output rate. The user sends this message for each sentence that the receiver is to output.


FieldDescriptionUnitsFormatDefaultRange1Control Port Output Block LabelChar2Clear Current Output ListInt0=No

 1=Yes3Add/Delete Sentence from ListInt1=Append

 2=Delete4Not Used5Sentence Output RateSecInt1-99996\# digits of Precision for CGA and GLL sentencesInt22-47Not Used8Not Used
 Example:

`$PMVXG,007,022,0,1,,1,,,*4F`

* * *

### $PMVXG,023

#### Time Recovery Configuration

 This message is used to enable/disable the time recovery feature of the receiver. The time synchronization for the 1PPS output is specified in addition to a user time bias and an error tolerance for a valid pulse. This record is accepted in units configured for time recovery. If the back panel contains a 1PPS outlet, the receiver is a time recovery unit.


FieldDescriptionUnitsFormatDefaultRange\*1Time Recovery ModeCharDD=Dynamic

 S=Static

 K=Known Position

 N=No Time Recovery2Time SynchronizationCharGU=UTC

 G=GPS3Time Mark ModeCharAA=Always

 V=Valid Pulses Only4Maximum Time ErrorNsecInt10050-10005User Time BiasNsecInt0\+/\- 999996ASCII Time Message ControlInt00=No Output

 1=830 to Control Port

 2=830 to Equipment Port7Known Pos PRNInt01-32

 0=Track All Sats
 Example:

`$PMVXG,023,S,U,A,500,0,1,*16`

* * *

### $CDGPQ,YYY

#### Query From a Remote Device / Request to Output a Sentence

 Enables the controller to request a one-time transmission of a specific block label. To output messages at a periodic rate, refer to input sentence [$PMVXG,007](#input_007).


FieldDescriptionUnitsFormatDefaultRange1:CDID of Remote DeviceChar(See NMEA-0183)2:GPGPSChar(See NMEA-0183)3:QQueryChar(See NMEA-0183)4:YYYLabel of Desired SentenceCharAny Valid NMEA or Magnavox Sentence Type
 Example:

`$CDGPQ,030*5E`

* * *

## Control Port Output Sentences

 These are the subset of the MX4200 control port output sentences recognized by the NTP driver.


* * *

### $PMVXG,000

#### Receiver Status

 Returns the current status of the receiver including the operating mode, number of satellites visible, and the number of satellites being tracked.


FieldDescriptionUnitsFormatRange1Current Receiver StatusCharACQ=Reacquisition

 ALT=Constellation Selection

 IAC=Initial Acquisition

 IDL=Idle, No Satellites

 NAV=Navigating

 STS=Search The Sky

 TRK=Tracking2Number of Satellites that should be VisibleInt0-123Number of Satellites being TrackedInt0-124Time since Last NavigationHHMMInt0-23595Initialization StatusInt0=Waiting for Initialization

 1=Initialization Complete
 Example:

`$PMVXG,000,TRK,3,3,0122,1*19`

* * *

### $PMVXG,021

#### Position, Height, Velocity

 This sentence gives the receiver position, height, navigation mode and velocity north/east. _This sentence is intended for post analysis applications._

FieldDescriptionUnitsFormatRange1UTC Measurement TimeSeconds into the weekFloat0-604800.002WGS-84 LatitudeDDMM.MMMMFloat0-89.99993North/South IndicatorCharN, S4WGS-84 LongitudeDDDMM.MMMMFloat0-179.99995East/West IndicatorCharE, W6Altitude (MSL)MetersFloat7Geoidal HeightMetersFloat8Velocity EastM/SecFloat9Velocity NorthM/SecFloat10Navigation ModeInt_Navigating_

 1=Position From a Remote Device

 2=2D

 3=3D

 4=2D differential

 5=3D differential

_Not Navigating_

 51=Too Few Satellites

 52=DOPs too large

 53=Position STD too large

 54=Velocity STD too large

 55=Too many iterations for velocity

 56=Too many iterations for position

 57=3 Sat Startup failed
 Example:

`$PMVXG,021,142244.00,5128.4744,N,00020.0593,W,00054.4,0047.4,0000.1,-000.2,03*66`

* * *

### $PMVXG,022

#### DOPs

 This sentence reports the DOP (Dilution Of Precision) values actually used in the measurement processing corresponding to the satellites listed. The satellites are listed in receiver channel order. Fields 11-16 are output only on 12-channel receivers.


FieldDescriptionUnitsFormatRange1UTC Measurement TimeSeconds into the weekFloat0-604800.002East DOP (EDOP)Float3North DOP (NDOP)Float4Vertical DOP (VDOP)Float5PRN on Channel #1Int1-326PRN on Channel #2Int1-327PRN on Channel #3Int1-328PRN on Channel #4Int1-329PRN on Channel #5Int1-3210PRN on Channel #6Int1-3211PRN on Channel #7Int1-3212PRN on Channel #8Int1-3213PRN on Channel #9Int1-3214PRN on Channel #10Int1-3215PRN on Channel #11Int1-3216PRN on Channel #12Int1-32
 Example:

`$PMVXG,022,142243.00,00.7,00.8,01.9,27,26,10,09,13,23*77`

* * *

### $PMVXG,030

#### Software Configuration

 This sentence contains the navigation processor and baseband firmware version numbers.


FieldDescriptionUnitsFormatRange1Nav Processor Version NumberChar2Baseband Firmware Version NumberChar
 Example:

`$PMVXG,030,DA35,015`

* * *

### $PMVXG,101

#### Control Sentence Accept/Reject

 This sentence is returned (on the Control Port) for every **$PMVXG** and **$XXGPQ** sentence that is received.


FieldDescriptionUnitsFormatRange1Sentence IDChar2Accept/Reject StatusInt0=Sentence Accepted

 1=Bad Checksum

 2=Illegal Value

 3=Unrecognized ID

 4=Wrong # of fields

 5=Required Data Field Missing

 6=Requested Sentence Unavailable3Bad Field IndexInt4Requested Sentence ID (If field #1 = GPQ)Char
 Example:

`$PMVXG,101,GPQ,0,,030*0D`

* * *

### $PMVXG,523

#### Time Recovery Configuration

 This sentence contains the configuration of the time recovery function of the receiver.


FieldDescriptionUnitsFormatRange1Time Recovery ModeCharD=Dynamic

 S=Static

 K=Known Position

 N=No Time Recovery2Time SynchronizationCharU=UTC Time

 G=GPS Time3Time Mark ModeCharA=Always Output Time Pulse

 V=Only when Valid4Maximum Time Error for which a time mark will be considered validNsecInt5User Time BiasNsecInt6Time Message ControlInt0=No Message

 1=830 to Control Port

 2=830 to Equipment Port7Not Used
 Example:

`$PMVXG,523,S,U,A,0500,000000,1,0*23`

* * *

### $PMVXG,830

#### Time Recovery Results

 This sentence is output approximately 1 second preceding the 1PPS output. It indicates the exact time of the next pulse, whether or not the time mark will be valid (based on operator-specified error tolerance), the time to which the pulse is synchronized, the receiver operating mode, and the time error of the **last** 1PPS output. The leap second flag (Field #11) is not output by older receivers.


FieldDescriptionUnitsFormatRange1Time Mark ValidCharT=Valid

 F=Not Valid2YearInt1993-3MonthInt1-124DayNsecInt1-315TimeHH:MM:SSInt00:00:00-23:59:596Time SynchronizationCharU=UTC

 G=GPS7Operating ModeCharD=Dynamic

 S=Static

 K=Known Position8Oscillator Offset - estimate of oscillator frequency errorPPBInt9Time Mark Error of last pulseNsecInt10User Time BiasNsecInt11Leap Second Flag - indicates that a leap second will occur. This value is usually zero except during the week prior to a leap second occurrence, when this value will be set to +/-1. A value of +1 indicates that GPS time will be 1 second further ahead of UTC time.Int-1,0,1
 Example:

`$PMVXG,830,T,1998,10,12,15:30:46,U,S,000298,00003,000000,01*02`

* * *

