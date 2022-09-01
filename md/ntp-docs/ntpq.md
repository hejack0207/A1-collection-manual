### ntpq \- standard NTP query program

![gif](pic/bustardfly.gif) [from _Pogo_, Walt Kelly](http://www.eecis.udel.edu/~mills/pictures.html)

A typical NTP monitoring packet

Last update:
24-Jan-2018 08:35
UTC

#### More Help

* * *

#### Synopsis

ntpq [-46dinp] [-c _command_] [ _host_] [...]

#### Description

The ntpq utility program is used to monitor NTP daemon ntpd operations
and determine performance. It uses the standard NTP mode 6 control
message formats defined in Appendix B of the NTPv3 specification
RFC1305. The same formats are used in NTPv4, although some of the
variable names have changed and new ones added. The description
on this page is for the NTPv4 variables.

The program can be run either in interactive mode or controlled using command line arguments. Requests to read and write arbitrary variables can be assembled, with raw and pretty-printed output options being available. The ntpq can also obtain and print a list of peers in a common format by sending multiple queries to the server.

If one or more request options is included on the command line when ntpq is executed, each of the requests will be sent to the NTP servers running on each of the hosts given as command line arguments, or on localhost by default. If no request options are given, ntpq will attempt to read commands from the standard input and execute these on the NTP server running on the first host given on the command line, again defaulting to localhost when no other host is specified. ntpq will prompt for commands if the standard input is a terminal device.

ntpq uses NTP mode 6 packets to communicate with the NTP server, and hence can be used to query any compatible server on the network which permits it. Note that since NTP is a UDP protocol this communication will be somewhat unreliable, especially over large distances in terms of network topology. ntpq makes one attempt to retransmit requests, and will time requests out if the remote host is not heard from within a suitable timeout time.

Note that in contexts where a host name is expected, a -4 qualifier preceding the host name forces DNS resolution to the IPv4 namespace, while a -6 qualifier forces DNS resolution to the IPv6 namespace.

For examples and usage, see the [NTP Debugging Techniques](debug.html) page.

Command line options are described following. Specifying a command line option other than -i or -n will cause the specified query (queries) to be sent to the indicated host(s) immediately. Otherwise, ntpq will attempt to read interactive format commands from the standard input.

-4Force DNS resolution of following host names on the command line to the IPv4 namespace.-6Force DNS resolution of following host names on the command line to the IPv6 namespace.-cThe following argument is interpreted as an interactive format command and is added to the list of commands to be executed on the specified host(s). Multiple -c options may be given.-dTurn on debugging mode.-iForce ntpq to operate in interactive mode. Prompts will be written to the standard output and commands read from the standard input.-nOutput all host addresses in dotted-quad numeric format rather than converting to the canonical host names.-pPrint a list of the peers known to the server as well as a summary of their state. This is equivalent to the peers interactive command.

#### Internal Commands

Interactive format commands consist of a keyword followed by zero to four arguments. Only enough characters of the full keyword to uniquely identify the command need be typed. The output of a command is normally sent to the standard output, but optionally the output of individual commands may be sent to a file by appending a >, followed by a file name, to the command line. A number of interactive format commands are executed entirely within the ntpq program itself and do not result in NTP mode-6 requests being sent to a server. These are described following.

? [ _command\_keyword_]

help [ _command\_keyword_]A ? by itself will print a list of all the command keywords known to ntpq. A ? followed by a command keyword will print function and usage information about the command.addvars _name_ [ = _value_] [...]

rmvars _name_ [...]

clearvarsThe arguments to this command consist of a list of items of the form _name_ = _value_, where the = _value_ is ignored, and can be omitted in read requests. ntpq maintains an internal list in which data to be included in control messages can be assembled, and sent using the readlist and writelist commands described below. The addvars command allows variables and optional values to be added to the list. If more than one variable is to be added, the list should be comma-separated and not contain white space. The rmvars command can be used to remove individual variables from the list, while the clearlist command removes all variables from the list.cookedDisplay server messages in prettyprint format.debug more \| less \| offTurns internal query program debugging on and off.delay _milliseconds_Specify a time interval to be added to timestamps included in requests which require authentication. This is used to enable (unreliable) server reconfiguration over long delay network paths or between machines whose clocks are unsynchronized. Actually the server does not now require timestamps in authenticated requests, so this command may be obsolete.host _name_Set the host to which future queries will be sent. The name may be either a DNS name or a numeric address.hostnames [yes \| no]If yes is specified, host names are printed in information displays. If no is specified, numeric addresses are printed instead. The default is yes, unless modified using the command line -n switch.keyid _keyid_This command specifies the key number to be used to authenticate configuration requests. This must correspond to a key ID configured in ntp.conf for this purpose.keytypeSpecify the digest algorithm to use for authenticated requests, with default MD5. If the OpenSSL library is installed, digest can be be any message digest algorithm supported by the library. The current selections are: MD2, MD4, MD5, MDC2, RIPEMD160, SHA, SHA1, and AES128CMAC.ntpversion 1 \| 2 \| 3 \| 4Sets the NTP version number which ntpq claims in packets. Defaults to 2, Note that mode-6 control messages (and modes, for that matter) didn't exist in NTP version 1.passwdThis command prompts for a password to authenticate requests. The password must correspond to the key ID configured in ntp.conf for this purpose.quitExit ntpq.rawDisplay server messages as received and without reformatting.timeout _millseconds_Specify a timeout period for responses to server queries. The default is about 5000 milliseconds. Note that since ntpq retries each query once after a timeout, the total waiting time for a timeout will be twice the timeout value set.

#### Control Message Commands

Association IDs are used to identify system, peer and clock variables. System variables are assigned an association ID of zero and system name space, while each association is assigned a nonzero association ID and peer namespace. Most control commands send a single mode-6 message to the server and expect a single response message. The exceptions are the peers command, which sends a series of messages, and the mreadlist and mreadvar commands, which iterate over a range of associations.

associationsDisplay a list of mobilized associations in the formind assid status conf reach auth condition last\_event cntVariableDescriptionindindex on this listassidassociation IDstatus[peer status word](decode.html#peer)confyes: persistent, no: ephemeralreachyes: reachable, no: unreachableauthok, yes, bad and noneconditionselection status (see the select field of the [peer status word](decode.html#peer))last\_eventevent report (see the event field of the [peer status word](decode.html#peer))cntevent count (see the count field of the [peer status word](decode.html#peer))clockvar _assocID_ [ _name_ [ = _value_ [...]] [...]

cv _assocID_ [ _name_ [ = _value_ [...] ][...]Display a list of [clock variables](#clock) for those associations supporting a reference clock.:config [...]Send the remainder of the command line, including whitespace, to the server as a run-time configuration command in the same format as the configuration file. This command is experimental until further notice and clarification. Authentication is of course required.config-from-file _filename_Send the each line of _filename_ to the server as run-time configuration commands in the same format as the configuration file. This command is experimental until further notice and clarification. Authentication is required.ifstatsDisplay statistics for each local network address. Authentication is required.iostatsDisplay network and reference clock I/O statistics.kerninfoDisplay kernel loop and PPS statistics. As with other ntpq output, times are in milliseconds. The precision value displayed is in milliseconds as well, unlike the precision system variable.lassociationsPerform the same function as the associations command, except display mobilized and unmobilized associations.monstatsDisplay monitor facility statistics.mrulist [limited \| kod \| mincount= _count_ \| laddr= _localaddr_ \| sort= _sortorder_ \| resany= _hexmask_ \| resall= _hexmask_]Obtain and print traffic counts collected and maintained by the monitor facility. With the exception of sort= _sortorder_, the options filter the list returned by ntpd. The limited and kod options return only entries representing client addresses from which the last packet received triggered either discarding or a KoD response. The mincount= _count_ option filters entries representing less than _count_ packets. The laddr= _localaddr_ option filters entries for packets received on any local address other than _localaddr_. resany= _hexmask_ and resall= _hexmask_ filter entries containing none or less than all, respectively, of the bits in _hexmask_, which must begin with 0x.The _sortorder_ defaults to lstint and may be any of addr, count, avgint, lstint, or any of those preceded by a minus sign (hyphen) to reverse the sort order. The output columns are:
 ColumnDescriptionlstintInterval in s between the receipt of the most recent packet from this address and the completion of the
 retrieval of the MRU list by ntpq.avgintAverage interval in s between packets from this address.rstrRestriction flags associated with this address. Most are copied unchanged from the matching restrict command, however 0x400 (kod) and 0x20 (limited) flags are cleared unless the last packet from this
 address triggered a rate control response.rRate control indicator, either a period, L or K for no rate control response,
 rate limiting by discarding, or rate limiting with a KoD response, respectively.mPacket mode.vPacket version number.countPackets received from this address.rportSource port of last packet from this address.remote addressDNS name, numeric address, or address followed by claimed DNS name which
 could not be verified in parentheses.mreadvar _assocID_ _assocID_ [ _variable\_name_ [ = _value_[ ... ]mrv _assocID_ _assocID_ [ _variable\_name_ [ = _value_[ ... ]Perform the same function as the readvar command, except for a range of association IDs. This range is determined from the association list cached by the most recent associations command.passociationsPerform the same function as the associations command, except that it uses previously stored data rather than making a new query.peersDisplay a list of peers in the form[tally]remote refid st t when pool reach delay offset jitterVariableDescription[tally]single-character code indicating current value of the select field of the [peer status word](decode.html#peer)remotehost name (or IP number) of peerrefidassociation ID or [kiss code](decode.html#kiss)ststratumtu: unicast or manycast client,
 b: broadcast or multicast client,
 p: pool source,
 l: local (reference clock),
 s: symmetric (peer),
 A: manycast server,
 B: broadcast server,
 M: multicast server
 whensec/min/hr since last received packetpollpoll interval (log2 s)reachreach shift register (octal)delayroundtrip delayoffsetoffset of server relative to this hostjitterjitterreadvar _assocID_ _name_ [ = _value_ ] [,...]

rv _assocID_ [ _name_ ] [,...]Display the specified variables. If _assocID_ is zero, the
 variables are from the [system variables](#system) name space,
 otherwise they are from the [peer variables](#peer) name space.
 The _assocID_ is required, as the same name can occur in both spaces. If no _name_ is
 included, all operative variables in the name space are displayed.
 In this case only, if the _assocID_ is omitted, it is assumed zero. Multiple
 names are specified with comma separators and without whitespace.
 Note that time values are represented in milliseconds and frequency
 values in parts-per-million (PPM). Some NTP timestamps are represented
 in the format YYYYMMDDTTTT, where YYYY is the year, MM the month
 of year, DD the day of month and TTTT the time of day.saveconfig _filename_Write the current configuration, including any runtime modifications given with :config or config-from-file, to the ntpd host's file _filename_. This command will be rejected by the server unless [saveconfigdir](miscopt.html#saveconfigdir) appears in the ntpd configuration file. _filename_ can use strftime() format specifies to substitute the current date and time, for example, saveconfig ntp-%Y%m%d-%H%M%S.conf. The filename used is stored in system variable savedconfig. Authentication is required.writevar _assocID_ _name_ = _value_ [,...]Write the specified variables. If the _assocID_ is zero, the variables are from the [system variables](#system) name space, otherwise they are from the [peer variables](#peer) name space. The _assocID_ is required, as the same name can occur in both spaces.sysinfoDisplay operational summary.sysstatsPrint statistics counters maintained in the protocol module.

#### Status Words and Kiss Codes

The current state of the operating program is shown in a set of status words maintained by the system and each association separately. These words are displayed in the rv and as commands both in hexadecimal and decoded short tip strings. The codes, tips and short explanations are on the [Event Messages and Status Words](decode.html) page. The page also includes a list of system and peer messages, the code for the latest of which is included in the status word.

Information resulting from protocol machine state transitions is displayed using an informal set of ASCII strings called [kiss codes](decode.html#kiss). The original purpose was for kiss-o'-death (KoD) packets sent by the server to advise the client of an unusual condition. They are now displayed, when appropriate, in the reference identifier field in various billboards.

#### System Variables

The following system variables appear in the rv billboard. Not all variables are displayed in some configurations.

VariableDescriptionstatus[system status word](decode.html#sys)versionNTP software version and build timeprocessorhardware platform and versionsystemoperating system and versionleapleap warning indicator (0-3)stratumstratum (1-15)precisionprecision (log2 s)rootdelaytotal roundtrip delay to the primary reference clockrootdisptotal dispersion to the primary reference clockpeersystem peer association IDtctime constant and poll exponent (log2 s) (3-17)mintcminimum time constant (log2 s) (3-10)clockdate and time of dayrefidreference ID or [kiss code](decode.html#kiss)reftimereference timeoffsetcombined offset of server relative to this hostsys\_jittercombined system jitterfrequency frequency offset (PPM) relative to hardware clockclk\_wanderclock frequency wander (PPM)clk\_jitterclock jittertaiTAI-UTC offset (s)leapsecNTP seconds when the next leap second is/was insertedexpireNTP seconds when the NIST leapseconds file expiresThe jitter and wander statistics are exponentially-weighted RMS averages.
 The system jitter is defined in the NTPv4 specification; the
 clock jitter statistic is computed by the clock discipline module.When the NTPv4 daemon is compiled with the OpenSSL software library, additional
 system variables are displayed, including some or all of the following, depending
 on the particular Autokey dance:VariableDescriptionhostAutokey host name for this hostidentAutokey group name for this hostflagshost flags (see Autokey specification)digestOpenSSL message digest algorithmsignatureOpenSSL digest/signature schemeupdateNTP seconds at last signature updatecertcertificate subject, issuer and certificate flagsuntilNTP seconds when the certificate expires

#### Peer Variables

The following peer variables appear in the rv billboard for each association. Not all variables are displayed in some configurations.

VariableDescriptionassocidassociation IDstatus[peer status word](decode.html#peer)srcadr

 srcportsource (remote) IP address and portdstadr

 dstportdestination (local) IP address and portleapleap indicator (0-3)stratumstratum (0-15)precisionprecision (log2 s)rootdelaytotal roundtrip delay to the primary reference clockrootdisptotal root dispersion to the primary reference clockrefidreference ID or [kiss code](decode.html#kiss)reftimereference timereachreach register (octal)unreachunreach counterhmodehost mode (1-6)pmodepeer mode (1-5)hpollhost poll exponent (log2 s) (3-17)ppollpeer poll exponent (log2 s) (3-17)headwayheadway (see [Rate Management and the Kiss-o'-Death Packet)](rate.html)flash[flash status word](decode.html#flash)offsetfilter offsetdelayfilter delaydispersionfilter dispersionjitterfilter jitteridentAutokey group name for this associationbiasunicast/broadcast biasxleaveinterleave delay (see [NTP Interleaved Modes](xleave.html))

The bias variable is calculated when the first broadcast packet is received
after the calibration volley. It represents the offset of the broadcast
subgraph relative to the unicast subgraph. The xleave variable appears
only the interleaved symmetric and interleaved modes. It represents
the internal queuing, buffering and transmission delays for the preceding
packet.

When the NTPv4 daemon is compiled with the OpenSSL software library, additional peer variables are displayed, including the following:

VariableDescriptionflagspeer flags (see Autokey specification)hostAutokey server nameflagspeer flags (see Autokey specification)signatureOpenSSL digest/signature schemeinitsequenceinitial key IDinitkeyinitial key indextimestampAutokey signature timestamp

#### Clock Variables

The following clock variables appear in the cv billboard for each association with a reference clock. Not all variables are displayed in some configurations.

VariableDescriptionassocidassociation IDstatus[clock status word](decode.html#clock)devicedevice descriptiontimecodeASCII time code string (specific to device)pollpoll messages sentnoreplyno replybadformatbad formatbaddatabad date or timefudgetime1fudge time 1fudgetime2fudge time 2stratumdriver stratumrefiddriver reference IDflagsdriver flags

* * *

