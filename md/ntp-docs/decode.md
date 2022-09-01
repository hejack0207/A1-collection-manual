### Event Messages and Status Words

![gif](pic/alice47.gif) [from _Alice's Adventures in Wonderland_, Lewis Carroll](http://www.eecis.udel.edu/%7emills/pictures.html)

Caterpillar knows all the error codes, which is more than most of us do.

Last update:
26-Jul-2015 06:26
UTC

#### Related Links

#### Table of Contents

- [Introduction](#intro)
- [System Status Word](#sys)
- [Peer Status Word](#peer)
- [Clock Status Word](#clock)
- [Flash Status Word](#flash)
- [Kiss Codes](#kiss)
- [Crypto Messages](#crypto)

* * *

#### Introduction

This page lists the status words, event messages and error codes used for ntpd reporting and monitoring. Status words are used to display the current status of the running program. There is one system status word and a peer status word for each association. There is a clock status word for each association that supports a reference clock. There is a flash code for each association which shows errors found in the last packet received (pkt) and during protocol processing (peer). These are commonly viewed using the ntpq program.

Significant changes in program state are reported as events. There is one
set of system events and a set of peer events for each association. In addition,
there is a set of clock events for each association that supports a reference
clock. Events are normally reported to the protostats monitoring file
and optionally to the system log. In addition, if the trap facility is configured,
events can be reported to a remote program that can page an administrator.

This page also includes a description of the error messages produced by the Autokey protocol. These messages are normally sent to the cryptostats monitoring file.

In the following tables the Event Field is the status or event code assigned and the Message Field a short string used for display and event reporting. The Description field contains a longer explanation of the status or event. Some messages include additional information useful for error diagnosis and performance assessment.

#### System Status Word

The system status word consists of four fields LI (0-1), Source (2-7), Count (8-11) and Event (12-15). It is reported in the first line of the rv display produced by the ntpq program.

Leap

Source

Count

Event

The Leap Field displays the system leap indicator bits coded as follows:

CodeMessageDescription0leap\_nonenormal synchronized state1leap\_add\_secinsert second after 23:59:59 of the current day2leap\_del\_secdelete second 23:59:59 of the current day3leap\_alarmnever synchronized

The Source Field displays the current synchronization source coded as follows:

CodeMessageDescription0sync\_unspecnot yet synchronized1sync\_ppspulse-per-second signal (Cs, Ru, GPS, etc.)2sync\_lf\_radioVLF/LF radio (WWVB, DCF77, etc.)3sync\_hf\_radioMF/HF radio (WWV, etc.)4sync\_uhf\_radioVHF/UHF radio/satellite (GPS, Galileo, etc.)5sync\_locallocal timecode (IRIG, LOCAL driver, etc.)6sync\_ntpNTP7sync\_otherother (IEEE 1588, openntp, crony, etc.)8sync\_wristwatcheyeball and wristwatch9sync\_telephonetelephone modem (ACTS, PTB, etc.)

The Count Field displays the number of events since the last time the code changed. Upon reaching 15, subsequent events with the same code are ignored.

The Event Field displays the most recent event message coded as follows:

CodeMessageDescription00unspecifiedunspecified01freq\_not\_setfrequency file not available02freq\_setfrequency set from frequency file03spike\_detectspike detected04freq\_modeinitial frequency training mode05clock\_syncclock synchronized06restartprogram restart07panic\_stopclock error more than 600 s08no\_system\_peerno system peer09leap\_armedleap second armed from file or Autokey0aleap\_disarmedleap second disarmed0bleap\_eventleap event0cclock\_stepclock stepped0dkernkernel information message0eTAI...leapsecond values update from file0fstale leapsecond valuesnew NIST leapseconds file needed

#### Peer Status Word

The peer status word consists of four fields: Status (0-4), Select (5-7), Count (8-11) and Code (12-15). It is reported in the first line of the rv _associd_ display produced by the ntpq program.

Status

Select

Count

Code

The Status Field displays the peer status code bits in hexadecimal; each bit is an independent flag. (Note this field is 5 bits wide, and combines with the the 3-bit-wide Select Field to create the first full byte of the peer status word.) The meaning of each bit in the Status Field is listed in the following table:

CodeMessageDescription08bcstbroadcast association10reachhost reachable20authauthentication ok40authenbauthentication enabled80configpersistent association

The Select Field displays the current selection status. (The T Field in the following table gives the corresponding tally codes used in the ntpq peers display.) The values are coded as follows:

CodeMessageTDescription0sel\_rejectdiscarded as not valid (TEST10-TEST13)1sel\_falsetickxdiscarded by intersection algorithm2sel\_excess.discarded by table overflow (not used)3sel\_outlier-discarded by the cluster algorithm4sel\_candidate+included by the combine algorithm5sel\_backup#backup (more than tos maxclock sources)6sel\_sys.peer\*system peer7sel\_pps.peeroPPS peer (when the prefer peer is valid)

The Count Field displays the number of events since the last time the code changed. Upon reaching 15, subsequent events with the same code are ignored.

The Event Field displays the most recent event message coded as follows:

CodeMessageDescription01mobilizeassociation mobilized02demobilizeassociation demobilized03unreachableserver unreachable04reachableserver reachable05restartassociation restart06no\_replyno server found (ntpdate mode)07rate\_exceededrate exceeded (kiss code RATE)08access\_deniedaccess denied (kiss code DENY)09leap\_armedleap armed from server LI code0asys\_peerbecome system peer0bclock\_eventsee clock status word0cbad\_authauthentication failure0dpopcornpopcorn spike suppressor0einterleave\_modeentering interleave mode0finterleave\_errorinterleave error (recovered)

#### Clock Status Word

The clock status word consists of four fields: Unused (0-7), Count (8-11) and Code (12-15). It is reported in the first line of the clockvar _associd_ display produced by the ntpq program.

Unused

Count

Code

The Count Field displays the number of events since the last lockvar command, while the Event Field displays the most recent event message coded as follows:

CodeMessageDescription00clk\_unspenominal01clk\_noreplyno reply to poll02clk\_badformatbad timecode format03clk\_faulthardware or software fault04clk\_bad\_signalsignal loss05clk\_bad\_datebad date format06clk\_bad\_timebad time format

When the clock driver sets the code to a new value, a clock\_alarm (11) peer event is reported.

#### Flash Status Word

The flash status word is displayed by the ntpq program rv command. It consists of a number of bits coded in hexadecimal as follows:

CodeTagMessageDescription0001TEST1pkt\_dupduplicate packet0002TEST2pkt\_bogusbogus packet0004TEST3pkt\_unsyncserver not synchronized0008TEST4pkt\_deniedaccess denied0010TEST5pkt\_auth authentication failure0020TEST6pkt\_stratuminvalid leap or stratum0040TEST7pkt\_header header distance exceeded0080TEST8pkt\_autokeyAutokey sequence error0100TEST9pkt\_cryptoAutokey protocol error0200TEST10peer\_stratum invalid header or stratum0400TEST11peer\_dist distance threshold exceeded0800TEST12peer\_loop synchronization loop1000TEST13peer\_unreach unreachable or nonselect

#### Kiss Codes

Kiss codes are used in kiss-o'-death (KoD) packets, billboard displays and log messages. They consist of a string of four zero-padded ASCII charactes. In practice they are informal and tend to change with time and implementation. Some of these codes can appear in the reference identifier field in ntpq billboards. Following is the current list:

CodeDescriptionACSTmanycast serverAUTHauthentication errorAUTOAutokey sequence errorBCSTbroadcast serverCRYPTAutokey protocol errorDENYaccess denied by serverINITassociation initializedMCSTmulticast serverRATErate exceededTIMEassociation timeoutSTEPstep time change

#### Crypto Messages

These messages are sent to the cryptostats file when an error is detected in the Autokey protocol.

CodeMessageDescription01bad\_formatbad extension field format or length02bad\_timestampbad timestamp03bad\_filestampbad filestamp04bad\_public\_keybad or missing public key05bad\_digestunsupported digest type06bad\_identityunsupported identity type07bad\_siglengthbad signature length08bad signatureextension field signature not verified09cert\_not\_verifiedcertificate signature not verified0acert\_expiredhost certificate expired0bbad\_cookiebad or missing cookie0cbad\_leapsecondsbad or missing leapseconds values0dcert\_missingbad or missing certificate0ebad\_group\_keybad or missing group key0fproto\_errorprotocol error

* * *

