### Monitoring Commands and Options

![gif](pic/pogo8.gif) from _Pogo_, Walt Kelly

Pig was hired to watch the logs.

Last update:
7-Dec-2017 10:17
UTC

#### Related Links

#### Table of Contents

- [Naming Conventions](#intro)
- [Monitoring Commands and Options](#cmd)
- [File Set Types](#types)

* * *

#### Naming Conventions

The ntpd includes a comprehensive monitoring facility which collects
statistical data of various types and writes the data to files associated with
each type at defined events or intervals. The files associated with a particular
type are collectively called the generation file set for that type. The files
in the file set are the members of that set.

File sets have names specific to the type and generation epoch. The names
are constructed from three concatenated elements _prefix_, _filename_ and _suffix_:

_prefix_The directory path specified in the statsdir command._name_The name specified by the file option of the filegen command._suffix_A string of elements bdginning with . (dot) followed by a number of elements
 depending on the file set type.

Statistics files can be managed using scripts, examples of which are in the ./scripts directory.
Using these or similar scripts and Unix cron jobs, the files can be
automatically summarized and archived for retrospective analysis.

#### Monitoring Commands and Options

Unless noted otherwise, further information about these commands is on the [Event Messages and Status Codes](decode.html) page.

 page.

filegen _name_ [file _filename_] [type _type_]
 [link \| nolink] [enable \| disable]_name_Specifies the file set type from the list in the next section.file _filename_Specifies the filename prefix. The default is the file set type, such as "loopstats".type _typename_Specifies the file set interval. The following intervals are supported
 with default day:noneThe file set is actually a single plain file.pidOne file set member is created for every incarnation of ntpd.
 The file name suffix is the string .n, where n is the
 process ID of the ntpd server process.dayOne file set member is created per day. A day is defined as the period
 between 00:00 and 23:59 UTC. The file name suffix is the string .yyyymmdd,
 where yyyy is the year, mm the month of the year and dd the
 day of the month. Thus, member created on 10 December 1992 would have suffix .19921210.weekOne file set member is created per week. The week is defined as the
 day of year modulo 7. The file name suffix is the string .yyyyWww,
 where yyyy is the year, W stands for itself and ww the
 week number starting from 0. For example, The member created on 10 January
 1992 would have suffix .1992W1.monthOne file set member is created per month. The file name suffix is the
 string .yyyymm, where yyyy is the year and mm the
 month of the year starting from 1. For example, The member created on 10
 January 1992 would have suffix .199201.yearOne file set member is generated per year. The file name suffix is the
 string .yyyy, where yyyy is the year. For example, The
 member created on 1 January 1992 would have suffix .1992.ageOne file set member is generated every 24 hours of ntpd operation.
 The filename suffix is the string .adddddddd, where a stands
 for itself and dddddddd is the ntpd running time in seconds
 at the start of the corresponding 24-hour period.link \| nolinkIt is convenient to be able to access the current file set members by
 file name, but without the suffix. This feature is enabled by link and
 disabled by nolink. If enabled, which is the default, a hard link
 from the current file set member to a file without suffix is created. When
 there is already a file with this name and the number of links to this file
 is one, it is renamed by appending a dot, the letter C, and the
 pid of the ntpd server process. When the number of links is greater
 than one, the file is unlinked. This allows the current file to be accessed
 by a constant name.enable \| disableEnable or disable the recording function, with default enable.
 These options are intended for remote configuration commands.statistics _name_...Enables writing of statistics records. Currently, eight kinds of
 statistics are supported: _name_ s specify the file set type(s) from
 the list in the next section.statsdir _directory\_path_Specify the directory path prefix for statistics file names.

#### File Set Types

clockstatsRecord reference clock statistics. Each update received from a reference
 clock driver appends one line to the clockstats file set:49213 525.624 127.127.4.1 93 226 00:08:29.606 DItemUnitsDescription49213MJDdate525.624stime past midnight127.127.4.1IPreference clock address_message_textlog messageThe _message_ field includes the last timecode received in
 decoded ASCII format, where meaningful. In some cases a good deal of additional
 information is displayed. See information specific to each reference clock
 for further details.cryptostatsRecord significant events in the Autokey protocol. This option requires
 the OpenSSL cryptographic software library. Each event appends one line to
 the cryptostats file set:49213 525.624 128.4.1.1 _message_ItemUnitsDescription49213MJDdate525.624stime past midnight128.4.1.1IPsource address (0.0.0.0 for system)_message_textlog messageThe _message_ field includes the message type and certain
 ancillary information. See the [Authentication Options](authopt.html) page
 for further information.loopstatsRecord clock discipline loop statistics. Each system clock update appends
 one line to the loopstats file set:50935 75440.031 0.000006019 13.778 0.000351733 0.013380 6ItemUnitsDescription50935MJDdate75440.031stime past midnight0.000006019sclock offset13.778PPMfrequency offset0.000351733sRMS jitter0.013380PPMRMS frequency jitter (aka wander)6 log2 sclock discipline loop time constantpeerstatsRecord peer statistics. Each NTP packet or reference clock update received
 appends one line to the peerstats file set:48773 10847.650 127.127.4.1 9714 -0.001605376 0.000000000 0.001424877
 0.000958674ItemUnitsDescription48773MJDdate10847.650stime past midnight127.127.4.1IPsource address9714hexstatus word-0.001605376sclock offset0.000000000 sroundtrip delay0.001424877sdispersion0.000958674sRMS jitterThe status field is encoded in hex format as described in Appendix B of
 the NTP specification RFC 1305.protostatsRecord significant peer, system and protocol events. Each significant event
 appends one line to the protostats file set:49213 525.624 128.4.1.1 963a 8a _message_ItemUnitsDescription49213MJDdate525.624stime past midnight128.4.1.1IPsource address (0.0.0.0 for system)963acodestatus word8acodeevent message code_message_textevent messageThe event message code and _message_ field are described on
 the [Event Messages and Status Words](decode.html) page.rawstatsRecord timestamp statistics. Each NTP packet received appends one line to
the rawstats file set. As of ntp-4.2.8p11, each NTP packet written appends one line to the rawstats file set, as well. The format of this line is:56285 54575.160 128.4.1.1 192.168.1.5 3565350574.400229473 3565350574.442385200 3565350574.442436000 3565350575.154505763 0 4 4 1 8 -21 0.000000 0.000320 .PPS.56285 54575.160 128.4.1.1 192.168.1.5 3565350574.400229473 3565350574.442385200 3565350574.442436000 3565350575.154505763 0 4 4 1 8 -21 0.000000 0.000320 .PPS. 4: 0000ItemUnitsDescription56285MJDdate54575.160stime past midnight128.4.1.1IPsource address192.168.1.5IPdestination address3565350574.400229473NTP sorigin timestamp3565350574.442385200NTP sreceive timestamp3565350574.442436000NTP stransmit timestamp3565350575.154505763NTP sdestination timestamp00: OK, 1: insert pending,

2: delete pending, 3: not syncedleap warning indicator44 was current in 2012NTP version43: client, 4: server, 5: broadcastmode11-15, 16: not syncedstratum8log2 secondspoll-21log2 secondsprecision0.000000secondstotal roundtrip delay to the primary reference clock0.000320secondstotal dispersion to the primary reference clock.PPS.REFIDsystem peer, association IDIf there is data beyond the base packet:4:IntegerLength, in bytes0000Hex datasysstatsRecord system statistics. Each hour one line is appended to the sysstats file
 set in the following format:50928 2132.543 3600 81965 0 9546 56 512 540 10 4 147 1ItemUnitsDescription50928MJDdate2132.543stime past midnight3600stime since reset81965#packets received0#packets for this host9546#current versions56#old version512#access denied540#bad length or format10#bad authentication4#declined147#rate exceeded1#kiss-o'-death packets senttimingstats(Only available when the daemon is compiled with process time debugging
 support (--enable-debug-timing - costs performance). Record processing time
 statistics for various selected code paths.53876 36.920 10.0.3.5 1 0.000014592 input processing delayItemUnitsDescription53876MJDdate36.920stime past midnight10.0.3.5IPserver address1#event count0.000014592stotal time_message_textcode path description (see source)

* * *

