### ntpd \- Network Time Protocol (NTP) Daemon

![gif](pic/wingdorothy.gif) [from _The Wizard of Oz_, L. Frank Baum](http://www.eecis.udel.edu/~mills/pictures.html)

You need help from the monkeys.

Last update:
10-Mar-2014 05:14
UTC

#### Related Links

#### Table of Contents

- [Synopsis](#synop)
- [Description](#descr)
- [Command Line Options](#cmd)
- [The Configuration File](#cfg)
- [Files](#files)

* * *

#### Synopsis

ntpd [ -46aAbdDgLmnNqx ] [ -c _conffile_ ] [ -f _driftfile_ ] [ -i _jaildir_ ] [ -I _InterfaceOrAddress_ ] [ -k _keyfile_ ] [ -l _logfile_ ] [ -p _pidfile_ ] [ -P _priority_ ] [ -r _broadcastdelay_ ] [ -s _statsdir_ ] [ -t _key_ ] [ -u _user_[: _group_] ] [ -U _interface\_update\_interval_ ] [ -v _variable_ ] [ -V _variable_ ]

#### Description

The ntpd program is an operating system daemon that synchronizes the system clock to remote NTP time servers or local reference clocks. It is a complete implementation of NTP version 4 defined by RFC-5905, but also retains compatible with version 3 defined by RFC-1305 and versions 1 and 2, defined by RFC-1059 and RFC-1119, respectively. The program can operate in any of several modes, including client/server, symmetric and broadcast modes, and with both symmetric-key and public key-cryptography

The ntpd program ordinarily requires a configuration file described on this page. It contains configuration commands described on the pages listed above. However a client can discover remote servers and configure them automatically. This makes it possible to deploy a fleet of workstations without specifying configuration details specific to the local environment. Further details are on the

The ntpd program normally operates continuously while adjusting the system time and frequency, but in some cases this might not be practical. With the -q option ntpd operates as in continuous mode, but exits just after setting the clock for the first time. Most applications will probably want to specify the iburst option with the server command. With this option a volley of messages is exchanged to groom the data and set the clock in about ten seconds. If nothing is heard after a few minutes, the daemon times out and exits without setting the clock.

#### Command Line Options

-4Force DNS resolution of host names to the IPv4 namespace.
 -6Force DNS resolution of host names to the IPv6 namespace.
 -aRequire cryptographic authentication for broadcast client, multicast client and symmetric passive associations. This is the same operation as the enable auth command and is the default.-ADo not require cryptographic authentication for broadcast client, multicast client and symmetric passive associations. This is the same operation as the disable auth command and almost never a good idea.-bEnable the client to synchronize to broadcast servers.-c _conffile_Specify the name and path of the configuration file. Without the option the default is /etc/ntp.conf.-d Disable switching into daemon mode, so ntpd stays attached to the starting terminal which will get all the debugging printout. Also, ^C will kill it. This option may occur more than once, with each occurrence indicating greater detail of display.-D _level_Specify debugging level directly, with level corresponding to the numbe of -d options..-f _driftfile_Specify the name and path of the frequency file. This is the same operation as the driftfile _driftfile_ configuration command.
 -gNormally, ntpd exits with a message to the system log if the offset exceeds the panic threshold, which is 1000 s by default. This option allows the time to be set to any value without restriction; however, this can happen only once. If the threshold is exceeded after that, ntpd will exit with a message to the system log. This option can be used with the -q and -x options. See the tinker command for other options.-i _jaildir_Chroot the server to the directory _jaildir_. This option also implies that the server attempts to drop root privileges at startup (otherwise, chroot gives very little additional security), and it is only available if the OS supports to run the server without full root privileges. You may need to also specify a -u option.-I [ _address_ \| _interface name_]Open the network address given, or all the addresses associated with the given interface name. This option may appear multiple times. This option also implies not opening other addresses, except wildcard and localhost. This option is deprecated. Please consider using the configuration file [interface](miscopt.html#interface) command, which is more versatile.-k _keyfile_Specify the name and path of the symmetric key file. This is the same operation as the keys _keyfile_ command.-l _logfile_Specify the name and path of the log file. The default is the system log file. This is the same operation as the logfile _logfile_ command.-mOnce the system clock is synchronized, register with mDNS as an available server.-LDo not listen to virtual interfaces, defined as those with names containing a colon. This option is deprecated. Please consider using the configuration file [interface](miscopt.html#interface) command, which is more versatile.-MRaise scheduler precision to its maximum (1 ms) using timeBeginPeriod. (Windows only)-nDon't fork.-NTo the extent permitted by the operating system, run the ntpd at the highest priority.-p _pidfile_Specify the name and path of the file used to record the ntpd process ID. This is the same operation as the pidfile _pidfile_ command.-P _priority_To the extent permitted by the operating system, run the ntpd at the specified priority.-qExit the ntpd just after the first time the clock is set. This behavior mimics that of the ntpdate program, which is to be retired. The -g and -x options can be used with this option. Note: The kernel time discipline is disabled with this option.-r _broadcastdelay_Specify the default propagation delay from the broadcast/multicast server to this client. This is necessary only if the delay cannot be computed automatically by the protocol.-s _statsdir_Specify the directory path for files created by the statistics facility. This is the same operation as the statsdir _statsdir_ command.-t _key_Add a key number to the trusted key list. This option can occur more than once. This is the same operation as the trustedkey _key_ command.-u _user[:group]_Specify a user, and optionally a group, to switch to. This option is only available if the OS supports running the server without full root privileges. Currently, this option is supported under NetBSD (configure with --enable-clockctl) and Linux (configure with --enable-linuxcaps).-U _interface update interval_Number of seconds to wait between interface list scans to pick up old and delete network interface. Set to 0 to disable dynamic interface list updating. The default is to scan every 5 minutes.-v _variable_

-V _variable_Add a system variable listed by default.-xNormally, the time is slewed if the offset is less than the step threshold, which is 128 ms by default, and stepped if above the threshold. This option sets the threshold to 600 s, which is well within the accuracy window to set the clock manually. Note: Since the slew rate of typical Unix kernels is limited to 0.5 ms/s, each second of adjustment requires an amortization interval of 2000 s. Thus, an adjustment as much as 600 s will take almost 14 days to complete. This option can be used with the -g and -q options. See the tinker command for other options. Note: The kernel time discipline is disabled with this option.--pccfreq _frequency_Substitute processor cycle counter for QueryPerformanceCounter unconditionally
 using the given frequency (in Hz). --pccfreq can be used on systems
 which do not use the PCC to implement QueryPerformanceCounter
 and have a fixed PCC frequency. The frequency specified must
 be accurate within 0.5 percent. --usepcc is equivalent on many systems and should
 be tried first, as it does not require determining the frequency
 of the processor cycle counter. For x86-compatible processors, the PCC is
 also referred to as RDTSC, which is the assembly-language instruction to retrieve
 the current value.  (Windows only)--usepccSubstitute processor cycle counter for QueryPerformanceCounter if they
 appear equivalent. This option should be used only if the PCC
 frequency is fixed. Power-saving functionality on many laptops varies the
 PCC frequency. (Windows only)

#### The Configuration File

Ordinarily, ntpd reads the ntp.conf configuration file at startup in order to determine the synchronization sources and operating modes. It is also possible to specify a working, although limited, configuration entirely on the command line, obviating the need for a configuration file. This may be particularly useful when the local host is to be configured as a broadcast client, with servers determined by listening to broadcasts at run time.

Usually, the configuration file is installed as/etc/ntp.conf, but could be installed elsewhere (see the -c _conffile_ command line option). The file format is similar to other Unix configuration files - comments begin with a # character and extend to the end of the line; blank lines are ignored.

Configuration commands consist of an initial command keyword followed by a list of option keywords separated by whitespace. Commands may not be continued over multiple lines. Options may be host names, host addresses written in numeric, dotted-quad form, integers, floating point numbers (when specifying times in seconds) and text strings. Optional arguments are delimited by [ ] in the options pages, while alternatives are separated by \|. The notation [ ... ] means an optional, indefinite repetition of the last item before the [ ... ].

#### Files

FileDefaultOptionOptionconfiguration file/etc/ntp.conf-cconffilefrequency filenone-fdriftfileleapseconds filenoneleapfileprocess ID filenone-ppidfilelog filesystem log-llogfileinclude filenonenoneincludefilestatistics path/var/NTP-sstatsdirkeys path/usr/local/etcnonekeysdir

* * *

