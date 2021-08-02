# agetty(8) - alternative Linux getty

util-linux, February 2016

```
agetty [options] port [baud_rate...] [term]
```


<a name="description"></a>

# Description

**agetty** opens a tty port, prompts for a login name and invokes
the /bin/login command.  It is normally invoked by **init**(8).

**agetty** has several _non-standard_ features that are useful
for hardwired and for dial-in lines:

* ·  
  Adapts the tty settings to parity bits and to erase, kill,
  end-of-line and uppercase characters when it reads a login name.
  The program can handle 7-bit characters with even, odd, none or space
  parity, and 8-bit characters with no parity.  The following special
  characters are recognized: Control-U (kill); DEL and
  backspace (erase); carriage return and line feed (end of line).
  See also the **--erase-chars** and **--kill-chars** options.
* ·  
  Optionally deduces the baud rate from the CONNECT messages produced by
  Hayes(tm)-compatible modems.
* ·  
  Optionally does not hang up when it is given an already opened line
  (useful for call-back applications).
* ·  
  Optionally does not display the contents of the _/etc/issue_ file.
* ·  
  Optionally displays an alternative issue file or directory instead of _/etc/issue_ or _/etc/issue.d_.
* ·  
  Optionally does not ask for a login name.
* ·  
  Optionally invokes a non-standard login program instead of
  _/bin/login_.
* ·  
  Optionally turns on hardware flow control.
* ·  
  Optionally forces the line to be local with no need for carrier detect.

This program does not use the _/etc/gettydefs_ (System V) or
_/etc/gettytab_ (SunOS 4) files.

<a name="arguments"></a>

# Arguments

.na

* _port_  
  A path name relative to the _/dev_ directory.  If a "-" is
  specified, **agetty** assumes that its standard input is
  already connected to a tty port and that a connection to a
  remote user has already been established.

Under System V, a "-" _port_ argument should be preceded
by a "--".

* _baud_rate_,...  
  A comma-separated list of one or more baud rates.  Each time
  **agetty** receives a BREAK character it advances through
  the list, which is treated as if it were circular.

Baud rates should be specified in descending order, so that the
null character (Ctrl-@) can also be used for baud-rate switching.

This argument is optional and unnecessary for **virtual terminals**.

The default for **serial terminals** is keep the current baud rate
(see **--keep-baud**) and if unsuccessful then default to '9600'.

* _term_  
  The value to be used for the TERM environment variable.  This overrides
  whatever init(8) may have set, and is inherited by login and the shell.

The default is 'vt100', or 'linux' for Linux on a virtual terminal,
or 'hurd' for GNU Hurd on a virtual terminal.

<a name="options"></a>

# Options

.na

* -8, --8bits  
  Assume that the tty is 8-bit clean, hence disable parity detection.
* -a, --autologin _username_  
  Automatically log in the specified user without asking for a username or password.
  Using this option causes an **-f username** option and argument to be
  added to the **/bin/login** command line.  See **--login-options**, which
  can be used to modify this option's behavior.
  
  Note that **--autologin** may affect the way how agetty initializes the
  serial line, because on auto-login agetty does not read from the line and it
  has no opportunity optimize the line setting.
* -c, --noreset  
  Do not reset terminal cflags (control modes).  See **termios**(3) for more
  details.
* -E, --remote  
  Typically the **login**(1) command is given a remote hostname when
  called by something such as **telnetd**(8).  This option allows **agetty**
  to pass what it is using for a hostname to **login**(1) for use
  in **utmp**(5).  See **--host**, **login**(1), and **utmp**(5).
* If the **--host** _fakehost_ option is given, then an **-h**
  _fakehost_ option and argument are added to the **/bin/login**
  command line.
* If the **--nohostname** option is given, then an **-H** option
  is added to the **/bin/login** command line.
* See **--login-options**.
* -f, --issue-file _file|directory_  
  Display the contents of _file_ instead of _/etc/issue_.  If the
  specified path is a _directory_ then displays all files with .issue file
  extension in version-sort order from the directory.  This allows custom
  messages to be displayed on different terminals.  The
  --noissue option will override this option.
* -h, --flow-control  
  Enable hardware (RTS/CTS) flow control.  It is left up to the
  application to disable software (XON/XOFF) flow protocol where
  appropriate.
* -H, --host _fakehost_  
  Write the specified _fakehost_ into the utmp file.  Normally,
  no login host is given, since **agetty** is used for local hardwired
  connections and consoles.  However, this option can be useful for
  identifying terminal concentrators and the like.
* -i, --noissue  
  Do not display the contents of _/etc/issue_ (or other) before writing the
  login prompt.  Terminals or communications hardware may become confused
  when receiving lots of text at the wrong baud rate; dial-up scripts
  may fail if the login prompt is preceded by too much text.
* -I, --init-string _initstring_  
  Set an initial string to be sent to the tty or modem before sending
  anything else.  This may be used to initialize a modem.  Non-printable
  characters may be sent by writing their octal code preceded by a
  backslash (\.  For example, to send a linefeed character (ASCII 10,
  octal 012), write \\012.
* -J, --noclear  
  Do not clear the screen before prompting for the login name.
  By default the screen is cleared.
* -l, --login-program _login\_program_  
  Invoke the specified _login\_program_ instead of /bin/login.  This allows
  the use of a non-standard login program.  Such a program could, for example,
  ask for a dial-up password or use a different password file. See
  **--login-options**.
* -L, --local-line[=_mode_]  
  Control the CLOCAL line flag.  The optional _mode_ argument is 'auto', 'always' or 'never'.
  If the _mode_ argument is omitted, then the default is 'always'.  If the
  --local-line option is not given at all, then the default is 'auto'.


* _always_  
  Forces the line to be a local line with no need for carrier detect.  This
  can be useful when you have a locally attached terminal where the serial
  line does not set the carrier-detect signal.
* _never_  
  Explicitly clears the CLOCAL flag from the line setting and the
  carrier-detect signal is expected on the line.
* _auto_  
  The **agetty** default.  Does not modify the CLOCAL setting and follows
  the setting enabled by the kernel.

* -m, --extract-baud  
  Try to extract the baud rate from the CONNECT status message
  produced by Hayes(tm)-compatible modems.  These status
  messages are of the form: "&lt;junk&gt;&lt;speed&gt;&lt;junk&gt;".
  **agetty** assumes that the modem emits its status message at
  the same speed as specified with (the first) _baud\_rate_ value
  on the command line.

Since the **--extract-baud** feature may fail on heavily-loaded
systems, you still should enable BREAK processing by enumerating all
expected baud rates on the command line.

* --list-speeds  
  Display supported baud rates.  These are determined at compilation time.
* -n, --skip-login  
  Do not prompt the user for a login name.  This can be used in connection
  with the **--login-program** option to invoke a non-standard login
  process such as a BBS system.  Note that with the **--skip-login**
  option, **agetty** gets no input from the user who logs in and therefore
  will not be able to figure out parity, character size, and newline
  processing of the connection.  It defaults to space parity, 7 bit
  characters, and ASCII CR (13) end-of-line character.  Beware that the
  program that **agetty** starts (usually /bin/login) is run as root.
* -N, --nonewline  
  Do not print a newline before writing out /etc/issue.
* -o, --login-options "_login\_options_"  
  Options  and arguments that  are passed to **login**(1). Where \\u is
  replaced by the login name. For example:
    * ""  
      **--login-options '-h darkstar -- \\\u'**

See **--autologin**, **--login-program** and **--remote**.

Please read the SECURITY NOTICE below before using this option.

* -p, --login-pause  
  Wait for any key before dropping to the login prompt.  Can be combined
  with **--autologin** to save memory by lazily spawning shells.
* -r, --chroot _directory_  
  Change root to the specified directory.
* -R, --hangup  
  Call vhangup() to do a virtual hangup of the specified terminal.
* -s, --keep-baud  
  Try to keep the existing baud rate.  The baud rates from
  the command line are used when agetty receives a BREAK character.
* -t, --timeout _timeout_  
  Terminate if no user name could be read within _timeout_ seconds.
  Use of this option with hardwired terminal lines is not recommended.
* -U, --detect-case  
  Turn on support for detecting an uppercase-only terminal.  This setting
  will detect a login name containing only capitals as indicating an
  uppercase-only terminal and turn on some upper-to-lower case conversions.
  Note that this has no support for any Unicode characters.
* -w, --wait-cr  
  Wait for the user or the modem to send a carriage-return or a
  linefeed character before sending the _/etc/issue_ file (or others)
  and the login prompt.  This is useful with the **--init-string**
  option.
* --nohints  
  Do not print hints about Num, Caps and Scroll Locks.
* --nohostname  
  By default the hostname will be printed.  With this option enabled,
  no hostname at all will be shown.
* --long-hostname  
  By default the hostname is only printed until the first dot.  With
  this option enabled, the fully qualified hostname by **gethostname**(3P)
  or (if not found) by **getaddrinfo**(3) is shown.
* --erase-chars _string_  
  This option specifies additional characters that should be interpreted as a
  backspace ("ignore the previous character") when the user types the login name.
  The default additional \'erase\' has been \'#\', but since util-linux 2.23
  no additional erase characters are enabled by default.
* --kill-chars _string_  
  This option specifies additional characters that should be interpreted as a
  kill ("ignore all previous characters") when the user types the login name.
  The default additional \'kill\' has been \'@\', but since util-linux 2.23
  no additional kill characters are enabled by default.
* --chdir _directory_  
  Change directory before the login.
* --delay _number_  
  Sleep seconds before open tty.
* --nice _number_  
  Run login with this priority.
* --reload  
  Ask all running agetty instances to reload and update their displayed prompts,
  if the user has not yet commenced logging in.  After doing so the command will
  exit.  This feature might be unsupported on systems without Linux
  **inotify**(7).
* --version  
  Display version information and exit.
* --help  
  Display help text and exit.


<a name="examples"></a>

# Examples

This section shows examples for the process field of an entry in the
_/etc/inittab_ file.  You'll have to prepend appropriate values
for the other fields.  See _inittab(5)_ for more details.

For a hardwired line or a console tty:

**/sbin/agetty&nbsp;9600&nbsp;ttyS1**

For a directly connected terminal without proper carrier-detect wiring
(try this if your terminal just sleeps instead of giving you a password:
prompt):

**/sbin/agetty&nbsp;--local-line&nbsp;9600&nbsp;ttyS1&nbsp;vt100**

For an old-style dial-in line with a 9600/2400/1200 baud modem:

**/sbin/agetty&nbsp;--extract-baud&nbsp;--timeout&nbsp;60&nbsp;ttyS1&nbsp;9600,2400,1200**

For a Hayes modem with a fixed 115200 bps interface to the machine
(the example init string turns off modem echo and result codes, makes
modem/computer DCD track modem/modem DCD, makes a DTR drop cause a
disconnection, and turns on auto-answer after 1 ring):

.ie n .RS 0
.el .RS
**/sbin/agetty&nbsp;--wait-cr&nbsp;--init-string&nbsp;'ATE0Q1&D2&C1S0=1\\015'&nbsp;115200&nbsp;ttyS1**


<a name="security-notice"></a>

# Security Notice

If you use the **--login-program** and **--login-options** options,
be aware that a malicious user may try to enter lognames with embedded options,
which then get passed to the used login program.  Agetty does check
for a leading "-" and makes sure the logname gets passed as one parameter
(so embedded spaces will not create yet another parameter), but depending
on how the login binary parses the command line that might not be sufficient.
Check that the used login program cannot be abused this way.

Some  programs use "--" to indicate that the rest of the commandline should
not be interpreted as options.  Use this feature if available by passing "--"
before the username gets passed by \\u.


<a name="issue-files"></a>

# Issue Files

The default issue file is _/etc/issue_. If the file exists then agetty also
checks for _/etc/issue.d_ directory. The directory is optional extension to
the default issue file and content of the directory is printed after
_/etc/issue_ content. If the _/etc/issue_ does not exist than the
directory is ignored. All files with .issue extension from the directory are
printed in version-sort order. The directory allow to maintain 3rd-party
messages independently on the primary system _/etc/issue_ file.

The default path maybe overridden by **--issue-file** option. In this case
specified path has to be file or directory and the default _/etc/issue_ as
well as _/etc/issue.d_ are ignored.

The issue files may contain certain escape codes to display the system name, date, time
etcetera.  All escape codes consist of a backslash (\ immediately
followed by one of the characters listed below.


* 4 or 4{_interface_}  
  Insert the IPv4 address of the specified network interface (for example: \\4{eth0}).
  If the _interface_ argument is not specified, then select the first fully
  configured (UP, non-LOCALBACK, RUNNING) interface.  If not any configured
  interface is found, fall back to the IP address of the machine's hostname.
* 6 or 6{_interface_}  
  The same as \\4 but for IPv6.
* b  
  Insert the baudrate of the current line.
* d  
  Insert the current date.
* e or e{_name_}  
  Translate the human-readable _name_ to an escape sequence and insert it
  (for example: \\e{red}Alert text.\\e{reset}).  If the _name_ argument is
  not specified, then insert \\033.  The currently supported names are: black,
  blink, blue, bold, brown, cyan,
  darkgray, gray, green, halfbright, lightblue, lightcyan, lightgray, lightgreen,
  lightmagenta, lightred, magenta, red, reset, reverse, and yellow.  All unknown
  names are silently ignored.
* s  
  Insert the system name (the name of the operating system).  Same as 'uname -s'.
  See also the \\S escape code.
* S or S{VARIABLE}  
  Insert the VARIABLE data from _/etc/os-release_.  If this file does not exist
  then fall back to _/usr/lib/os-release_.  If the VARIABLE argument is not
  specified, then use PRETTY_NAME from the file or the system name (see \\s).
  This escape code allows to keep _/etc/issue_ distribution and release
  independent.  Note that \\S{ANSI_COLOR} is converted to the real terminal
  escape sequence.
* l  
  Insert the name of the current tty line.
* m  
  Insert the architecture identifier of the machine.  Same as 'uname -m'.
* n  
  Insert the nodename of the machine, also known as the hostname.  Same as 'uname -n'.
* o  
  Insert the NIS domainname of the machine.  Same as 'hostname -d'.
* O  
  Insert the DNS domainname of the machine.
* r  
  Insert the release number of the OS.  Same as 'uname -r'.
* t  
  Insert the current time.
* u  
  Insert the number of current users logged in.
* U  
  Insert the string "1 user" or "&lt;n&gt; users" where &lt;n&gt; is the number of current
  users logged in.
* v  
  Insert the version of the OS, that is, the build-date and such.

An example.  On my system, the following _/etc/issue_ file:

.na
    This is \n.\o (\s \m \r) \t

displays as:

    This is thingol.orcan.dk (Linux i386 1.1.9) 18:29:30


<a name="files"></a>

# Files

.na

* _/var/run/utmp_  
  the system status file.
* _/etc/issue_  
  printed before the login prompt.
* _/etc/os-release /usr/lib/os-release_  
  operating system identification data.
* _/dev/console_  
  problem reports (if syslog(3) is not used).
* _/etc/inittab_  
  _init_(8) configuration file for SysV-style init daemon.

<a name="bugs"></a>

# Bugs

The baud-rate detection feature (the **--extract-baud** option) requires that
**agetty** be scheduled soon enough after completion of a dial-in
call (within 30 ms with modems that talk at 2400 baud).  For robustness,
always use the **--extract-baud** option in combination with a multiple baud
rate command-line argument, so that BREAK processing is enabled.

The text in the _/etc/issue_ file (or other) and the login prompt
are always output with 7-bit characters and space parity.

The baud-rate detection feature (the **--extract-baud** option) requires that
the modem emits its status message _after_ raising the DCD line.

<a name="diagnostics"></a>

# Diagnostics

Depending on how the program was configured, all diagnostics are
written to the console device or reported via the **syslog**(3) facility.
Error messages are produced if the _port_ argument does not
specify a terminal device; if there is no utmp entry for the
current process (System V only); and so on.

<a name="authors"></a>

# Authors

.UR [werner@suse.de](mailto:werner@suse.de)
Werner Fink
.UE  
.UR [kzak@redhat.com](mailto:kzak@redhat.com)
Karel Zak
.UE

The original
**agetty**
for serial terminals was written by W.Z. Venema &lt;[wietse@wzv.win](mailto:wietse@wzv.win).tue.nl&gt;
and ported to Linux by Peter Orbaek &lt;[poe@daimi.aau](mailto:poe@daimi.aau).dk&gt;.


<a name="availability"></a>

# Availability

The agetty command is part of the util-linux package and is available from
https://www.kernel.org/pub/linux/utils/util-linux/.
