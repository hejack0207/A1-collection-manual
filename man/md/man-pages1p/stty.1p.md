# stty(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

stty
— set the options for a terminal

<a name="synopsis"></a>

# Synopsis

```


```
    stty [(mia|(mig]
    
    stty operand...

<a name="description"></a>

# Description

The
_stty_
utility shall set or report on terminal I/O characteristics for the
device that is its standard input. Without options or operands
specified, it shall report the settings of certain characteristics,
usually those that differ from implementation-defined defaults.
Otherwise, it shall modify the terminal state according to the
specified operands. Detailed information about the modes listed in the
first five groups below are described in the Base Definitions volume of POSIX.1-2008,
_Chapter 11_, _General Terminal Interface_.
Operands in the Combination Modes group (see
_Combination Modes_)
are implemented using operands in the previous groups. Some
combinations of operands are mutually-exclusive on some terminal types;
the results of using such combinations are unspecified.

Typical implementations of this utility require a communications line
configured to use the
**termios**
interface defined in the System Interfaces volume of POSIX.1-2008. On systems where none of these lines
are available, and on lines not currently configured to support the
**termios**
interface, some of the operands need not affect terminal
characteristics.

<a name="options"></a>

# Options

The
_stty_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(mia**  
  Write to standard output all the current settings for the terminal.
* **\(mig**  
  Write to standard output all the current settings in an unspecified
  form that can be used as arguments to another invocation of the
  _stty_
  utility on the same system. The form used shall not contain any
  characters that would require quoting to avoid word expansion by the
  shell; see
  _Section 2.6_, _Word Expansions_.

<a name="operands"></a>

# Operands

The following operands shall be supported to set the terminal
characteristics.

<a name="control-modes"></a>

### Control Modes


* **parenb&nbsp;**(**\(miparenb**)  
  Enable (disable) parity generation and detection. This shall have
  the effect of setting (not setting) PARENB in the
  **termios**
  _c_cflag_
  field, as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.
* **parodd&nbsp;**(**\(miparodd**)    
  Select odd (even) parity. This shall have the effect of setting (not
  setting) PARODD in the
  **termios**
  _c_cflag_
  field, as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.
* **cs5&nbsp;cs6&nbsp;cs7&nbsp;cs8**  
  Select character size, if possible. This shall have the effect of
  setting CS5, CS6, CS7, and CS8, respectively, in the
  **termios**
  _c_cflag_
  field, as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.
* _number_  
  Set terminal baud rate to the number given, if possible. If the baud
  rate is set to zero, the modem control lines shall no longer be
  asserted. This shall have the effect of setting the input and output
  **termios**
  baud rate values as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.
* **ispeed&nbsp;number**  
  Set terminal input baud rate to the number given, if possible. If the
  input baud rate is set to zero, the input baud rate shall be specified
  by the value of the output baud rate. This shall have the effect of
  setting the input
  **termios**
  baud rate values as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.
* **ospeed&nbsp;number**  
  Set terminal output baud rate to the number given, if possible. If the
  output baud rate is set to zero, the modem control lines shall no
  longer be asserted. This shall have the effect of setting the output
  **termios**
  baud rate values as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.
* **hupcl&nbsp;**(**\(mihupcl**)  
  Stop asserting modem control lines (do not stop asserting modem control
  lines) on last close. This shall have the effect of setting (not
  setting) HUPCL in the
  **termios**
  _c_cflag_
  field, as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.
* **hup&nbsp;**(**\(mihup**)  
  Equivalent to
  **hupcl**(\c
  **\(mihupcl**).
* **cstopb&nbsp;**(**\(micstopb**)  
  Use two (one) stop bits per character. This shall have the effect of
  setting (not setting) CSTOPB in the
  **termios**
  _c_cflag_
  field, as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.
* **cread&nbsp;**(**\(micread**)  
  Enable (disable) the receiver. This shall have the effect of setting
  (not setting) CREAD in the
  **termios**
  _c_cflag_
  field, as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.
* **clocal&nbsp;**(**\(miclocal**)  
  Assume a line without (with) modem control. This shall have the effect
  of setting (not setting) CLOCAL in the
  **termios**
  _c_cflag_
  field, as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.

It is unspecified whether
_stty_
shall report an error if an attempt to set a Control Mode fails.

<a name="input-modes"></a>

### Input Modes


* **ignbrk&nbsp;**(**\(miignbrk**)  
  Ignore (do not ignore) break on input. This shall have the effect of
  setting (not setting) IGNBRK in the
  **termios**
  _c_iflag_
  field, as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.
* **brkint&nbsp;**(**\(mibrkint**)  
  Signal (do not signal) INTR on break. This shall have the effect of
  setting (not setting) BRKINT in the
  **termios**
  _c_iflag_
  field, as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.
* **ignpar&nbsp;**(**\(miignpar**)  
  Ignore (do not ignore) bytes with parity errors. This shall have the
  effect of setting (not setting) IGNPAR in the
  **termios**
  _c_iflag_
  field, as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.
* **parmrk&nbsp;**(**\(miparmrk**)    
  Mark (do not mark) parity errors. This shall have the effect of
  setting (not setting) PARMRK in the
  **termios**
  _c_iflag_
  field, as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.
* **inpck&nbsp;**(**\(miinpck**)  
  Enable (disable) input parity checking. This shall have the effect of
  setting (not setting) INPCK in the
  **termios**
  _c_iflag_
  field, as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.
* **istrip&nbsp;**(**\(miistrip**)  
  Strip (do not strip) input characters to seven bits. This shall have
  the effect of setting (not setting) ISTRIP in the
  **termios**
  _c_iflag_
  field, as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.
* **inlcr&nbsp;**(**\(miinlcr**)  
  Map (do not map) NL to CR on input. This shall have the effect of
  setting (not setting) INLCR in the
  **termios**
  _c_iflag_
  field, as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.
* **igncr&nbsp;(\(miigncr)**  
  Ignore (do not ignore) CR on input. This shall have the effect of
  setting (not setting) IGNCR in the
  **termios**
  _c_iflag_
  field, as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.
* **icrnl&nbsp;**(**\(miicrnl**)  
  Map (do not map) CR to NL on input. This shall have the effect of
  setting (not setting) ICRNL in the
  **termios**
  _c_iflag_
  field, as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.
* **ixon&nbsp;**(**\(miixon**)  
  Enable (disable) START/STOP output control. Output from the system is
  stopped when the system receives STOP and started when the system
  receives START. This shall have the effect of setting (not setting)
  IXON in the
  **termios**
  _c_iflag_
  field, as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.
* **ixany&nbsp;**(**\(miixany**)  
  Allow any character to restart output. This shall have the effect of
  setting (not setting) IXANY in the
  **termios**
  _c_iflag_
  field, as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.
* **ixoff&nbsp;**(**\(miixoff**)  
  Request that the system send (not send) STOP characters when the input
  queue is nearly full and START characters to resume data transmission.
  This shall have the effect of setting (not setting) IXOFF in the
  **termios**
  _c_iflag_
  field, as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.

<a name="output-modes"></a>

### Output Modes


* **opost&nbsp;**(**\(miopost**)  
  Post-process output (do not post-process output; ignore all other
  output modes). This shall have the effect of setting (not setting)
  OPOST in the
  **termios**
  _c_oflag_
  field, as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.
* **ocrnl&nbsp;**(**\(miocrnl**)  
  Map (do not map) CR to NL on output This shall have the effect of
  setting (not setting) OCRNL in the
  **termios**
  _c_oflag_
  field, as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.
* **onocr&nbsp;**(**\(mionocr**)  
  Do not (do) output CR at column zero. This shall have the effect of
  setting (not setting) ONOCR in the
  **termios**
  _c_oflag_
  field, as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.
* **onlret&nbsp;**(**\(mionlret**)  
  The terminal newline key performs (does not perform) the CR function.
  This shall have the effect of setting (not setting) ONLRET in the
  **termios**
  _c_oflag_
  field, as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.
* **ofill&nbsp;**(**\(miofill**)  
  Use fill characters (use timing) for delays. This shall have the
  effect of setting (not setting) OFILL in the
  **termios**
  _c_oflag_
  field, as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.
* **ofdel&nbsp;**(**\(miofdel**)  
  Fill characters are DELs (NULs). This shall have the effect of setting
  (not setting) OFDEL in the
  **termios**
  _c_oflag_
  field, as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.
* **cr0&nbsp;cr1&nbsp;cr2&nbsp;cr3**  
  Select the style of delay for CRs. This shall have the effect of
  setting CRDLY to CR0, CR1, CR2, or CR3, respectively, in the
  **termios**
  _c_oflag_
  field, as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.
* **nl0&nbsp;nl1**  
  Select the style of delay for NL. This shall have the effect of
  setting NLDLY to NL0 or NL1, respectively, in the
  **termios**
  _c_oflag_
  field, as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.
* **tab0&nbsp;tab1&nbsp;tab2&nbsp;tab3**    
  Select the style of delay for horizontal tabs. This shall have the
  effect of setting TABDLY to TAB0, TAB1, TAB2, or TAB3, respectively,
  in the
  **termios**
  _c_oflag_
  field, as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.
  Note that TAB3 has the effect of expanding
  &lt;tab&gt;
  characters to
  &lt;space&gt;
  characters.
* **tabs&nbsp;**(**\(mitabs**)  
  Synonym for
  **tab0**
  (\c
  **tab3**).
* **bs0&nbsp;bs1**  
  Select the style of delay for
  &lt;backspace&gt;
  characters. This shall have the effect of setting BSDLY to BS0 or BS1,
  respectively, in the
  **termios**
  _c_oflag_
  field, as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.
* **ff0&nbsp;ff1**  
  Select the style of delay for
  &lt;form-feed&gt;
  characters. This shall have the effect of setting FFDLY to FF0 or FF1,
  respectively, in the
  **termios**
  _c_oflag_
  field, as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.
* **vt0&nbsp;vt1**  
  Select the style of delay for
  &lt;vertical-tab&gt;
  characters. This shall have the effect of setting VTDLY to VT0 or VT1,
  respectively, in the
  **termios**
  _c_oflag_
  field, as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.

<a name="local-modes"></a>

### Local Modes


* **isig&nbsp;**(**\(miisig**)  
  Enable (disable) the checking of characters against the special control
  characters INTR, QUIT, and SUSP. This shall have the effect of setting
  (not setting) ISIG in the
  **termios**
  _c_lflag_
  field, as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.
* **icanon&nbsp;**(**\(miicanon**)  
  Enable (disable) canonical input (ERASE and KILL processing). This
  shall have the effect of setting (not setting) ICANON in the
  **termios**
  _c_lflag_
  field, as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.
* **iexten&nbsp;**(**\(miiexten**)  
  Enable (disable) any implementation-defined special control
  characters not currently controlled by
  **icanon**,
  **isig**,
  **ixon**,
  or
  **ixoff**.
  This shall have the effect of setting (not setting) IEXTEN in the
  **termios**
  _c_lflag_
  field, as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.
* **echo&nbsp;**(**\(miecho**)  
  Echo back (do not echo back) every character typed. This shall have
  the effect of setting (not setting) ECHO in the
  **termios**
  _c_lflag_
  field, as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.
* **echoe&nbsp;**(**\(miechoe**)  
  The ERASE character visually erases (does not erase) the last character
  in the current line from the display, if possible. This shall have the
  effect of setting (not setting) ECHOE in the
  **termios**
  _c_lflag_
  field, as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.
* **echok&nbsp;**(**\(miechok**)  
  Echo (do not echo) NL after KILL character. This shall have the effect
  of setting (not setting) ECHOK in the
  **termios**
  _c_lflag_
  field, as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.
* **echonl&nbsp;**(**\(miechonl**)  
  Echo (do not echo) NL, even if
  **echo**
  is disabled. This shall have the effect of setting (not setting)
  ECHONL in the
  **termios**
  _c_lflag_
  field, as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.
* **noflsh&nbsp;**(**\(minoflsh**)  
  Disable (enable) flush after INTR, QUIT, SUSP. This shall have the
  effect of setting (not setting) NOFLSH in the
  **termios**
  _c_lflag_
  field, as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.
* **tostop&nbsp;**(**\(mitostop**)  
  Send SIGTTOU for background output. This shall have the effect of
  setting (not setting) TOSTOP in the
  **termios**
  _c_lflag_
  field, as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.

<a name="special-control-character-assignments"></a>

### Special Control Character Assignments


* &lt;_control_&gt;-_character&nbsp;string_    
  Set &lt;_control_&gt;-_character_ to
  _string_.
  If &lt;_control_&gt;-_character_ is one of the character sequences
  in the first column of the following table, the corresponding the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_
  control character from the second column shall be recognized. This has
  the effect of setting the corresponding element of the
  **termios**
  _c_cc_
  array (see the Base Definitions volume of POSIX.1-2008,
  _Chapter 13_, _Headers_,
  _&lt;termios.h&gt;_).  

.ce 1
**Table: Control Character Names in stty**
.TS
center tab(@) box;
cB | cB | cB
lB | l | l.
Control Character@c_cc Subscript@Description
_
eof@VEOF@EOF character
eol@VEOL@EOL character
erase@VERASE@ERASE character
intr@VINTR@INTR character
kill@VKILL@KILL character
quit@VQUIT@QUIT character
susp@VSUSP@SUSP character
start@VSTART@START character
stop@VSTOP@STOP character
.TE

If
_string_
is a single character, the control character shall be set to that
character. If
_string_
is the two-character sequence
**"^\(mi"**
or the string
_undef_,
the control character shall be set to _POSIX_VDISABLE , if it is in
effect for the device; if _POSIX_VDISABLE is not in effect for the
device, it shall be treated as an error. In the POSIX locale, if
_string_
is a two-character sequence beginning with
&lt;circumflex&gt;
(\c
**'^'**),
and the second character is one of those listed in the
**"^c"**
column of the following table, the control character shall be set to
the corresponding character value in the Value column of the table.

.ce 1
**Table: Circumflex Control Characters in stty**
.TS
center tab(@) box;
cB cB | cB cB | cB cB
lf5 2 l 6 | lf5 2 l 6 | lf5 2 l.
^c@Value@^c@Value@^c@Value
_
a, A@&lt;SOH&gt;@l, L@&lt;FF&gt;@w, W@&lt;ETB&gt;
b, B@&lt;STX&gt;@m, M@&lt;CR&gt;@x, X@&lt;CAN&gt;
c, C@&lt;ETX&gt;@n, N@&lt;SO&gt;@y, Y@&lt;EM&gt;
d, D@&lt;EOT&gt;@o, O@&lt;SI&gt;@z, Z@&lt;SUB&gt;
e, E@&lt;ENQ&gt;@p, P@&lt;DLE&gt;@[@&lt;ESC&gt;
f, F@&lt;ACK&gt;@q, Q@&lt;DC1&gt;@\e@&lt;FS&gt;
g, G@&lt;BEL&gt;@r, R@&lt;DC2&gt;@]@&lt;GS&gt;
h, H@&lt;BS&gt;@s, S@&lt;DC3&gt;@^@&lt;RS&gt;
i, I@&lt;HT&gt;@t, T@&lt;DC4&gt;@_@&lt;US&gt;
j, J@&lt;LF&gt;@u, U@&lt;NAK&gt;@?@&lt;DEL&gt;
k, K@&lt;VT&gt;@v, V@&lt;SYN&gt;
.TE

* **min&nbsp;number**    
  Set the value of MIN to
  _number_.
  MIN is used in non-canonical mode input processing (\c
  **icanon**).
* **time&nbsp;number**    
  Set the value of TIME to
  _number_.
  TIME is used in non-canonical mode input processing (\c
  **icanon**).

<a name="combination-modes"></a>

### Combination Modes


* _saved&nbsp;settings_    
  Set the current terminal characteristics to the saved settings produced
  by the
  **\(mig**
  option.
* **evenp**&nbsp;or&nbsp;**parity**    
  Enable
  **parenb**
  and
  **cs7**;
  disable
  **parodd**.
* **oddp**    
  Enable
  **parenb**,
  **cs7**,
  and
  **parodd**.
* **\(miparity**, **\(mievenp**, or **\(mioddp**    
  Disable
  **parenb**,
  and set
  **cs8**.
* **raw&nbsp;**(**\(miraw**&nbsp;or&nbsp;**cooked**)    
  Enable (disable) raw input and output. Raw mode shall be equivalent to
  setting:

    
    stty cs8 erase ^(mi kill ^(mi intr ^(mi e
        quit ^(mi eof ^(mi eol ^(mi (mipost (miinpck


* **nl&nbsp;**(**\(minl**)    
  Disable (enable)
  **icrnl**.
  In addition,
  **\(minl**
  unsets
  **inlcr**
  and
  **igncr**.
* **ek**  
  Reset ERASE and KILL characters back to system defaults.
* **sane**    
  Reset all modes to some reasonable, unspecified, values.

<a name="stdin"></a>

# Stdin

Although no input is read from standard input, standard input shall be
used to get the current terminal I/O characteristics and to set new
terminal I/O characteristics.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_stty_:

* _LANG_  
  Provide a default value for the internationalization variables that are
  unset or null. (See the Base Definitions volume of POSIX.1-2008,
  _Section 8.2_, _Internationalization Variables_
  for the precedence of internationalization variables used to determine
  the values of locale categories.)
* _LC\_ALL_  
  If set to a non-empty string value, override the values of all the
  other internationalization variables.
* _LC\_CTYPE_  
  This variable determines the locale for the interpretation of sequences
  of bytes of text data as characters (for example, single-byte as
  opposed to multi-byte characters in arguments) and which characters are
  in the class
  **print**.
* _LC\_MESSAGES_    
  Determine the locale that should be used to affect the format and
  contents of diagnostic messages written to standard error.
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

If operands are specified, no output shall be produced.

If the
**\(mig**
option is specified,
_stty_
shall write to standard output the current settings in a form that can
be used as arguments to another instance of
_stty_
on the same system.

If the
**\(mia**
option is specified, all of the information as described in the
OPERANDS section shall be written to standard output. Unless otherwise
specified, this information shall be written as
&lt;space&gt;-separated
tokens in an unspecified format, on one or more lines, with an
unspecified number of tokens per line. Additional information may be
written.

If no options or operands are specified, an unspecified subset of the
information written for the
**\(mia**
option shall be written.

If speed information is written as part of the default output, or if
the
**\(mia**
option is specified and if the terminal input speed and output speed
are the same, the speed information shall be written as follows:

    
    "speed %d baud;", <speed>


Otherwise, speeds shall be written as:

    
    "ispeed %d baud; ospeed %d baud;", <ispeed>, <ospeed>


In locales other than the POSIX locale, the word
**baud**
may be changed to something more appropriate in those locales.

If control characters are written as part of the default output, or if
the
**\(mia**
option is specified, control characters shall be written as:

    
    "%s = %s;", <control-character name>, <value>


where &lt;_value_&gt; is either the character, or some visual
representation of the character if it is non-printable, or the string
_undef_
if the character is disabled.

<a name="stderr"></a>

# Stderr

The standard error shall be used only for diagnostic messages.

<a name="output-files"></a>

# Output Files

None.

<a name="extended-description"></a>

# Extended Description

None.

<a name="exit-status"></a>

# Exit Status

The following exit values shall be returned:

* \00  
  The terminal options were read or set successfully.
* &gt;0  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

The
**\(mig**
flag is designed to facilitate the saving and restoring of terminal
state from the shell level. For example, a program may:

    
    saveterm="$(stty (mig)"       # save terminal state
    stty (new settings)         # set new state
    ...                         # ...
    stty $saveterm              # restore terminal state


Since the format is unspecified, the saved value is not portable across
systems.

Since the
**\(mia**
format is so loosely specified, scripts that save and restore terminal
settings should use the
**\(mig**
option.

<a name="examples"></a>

# Examples

None.

<a name="rationale"></a>

# Rationale

The original
_stty_
description was taken directly from System V and reflected the System V
terminal driver
**termio**.
It has been modified to correspond to the terminal driver
**termios**.

Output modes are specified only for XSI-conformant systems. All
implementations are expected to provide
_stty_
operands corresponding to all of the output modes they support.

The
_stty_
utility is primarily used to tailor the user interface of the terminal,
such as selecting the preferred ERASE and KILL characters. As an
application programming utility,
_stty_
can be used within shell scripts to alter the terminal settings for the
duration of the script.

The
**termios**
section states that individual disabling of control characters is
possible through the option _POSIX_VDISABLE.
If enabled, two conventions currently exist for specifying this: System
V uses
**"^\(mi"**,
and BSD uses
_undef_.
Both are accepted by
_stty_
in this volume of POSIX.1-2008. The other BSD convention of using the letter
**'u'**
was rejected because it conflicts with the actual letter
**'u'**,
which is an acceptable value for a control character.

Early proposals did not specify the mapping of
**"^c"**
to control characters because the control characters were not specified
in the POSIX locale character set description file requirements. The
control character set is now specified in the Base Definitions volume of POSIX.1-2008,
_Chapter 3_, _Definitions_,
so the historical mapping is specified. Note that although the mapping
corresponds to control-character key assignments on many terminals that
use the ISO/IEC&nbsp;646:\|1991 standard (or ASCII) character encodings, the mapping specified
here is to the control characters, not their keyboard encodings.

Since
**termios**
supports separate speeds for input and output, two new options were
added to specify each distinctly.

Some historical implementations use standard input to get and set
terminal characteristics; others use standard output. Since input from
a login TTY is usually restricted to the owner while output to a TTY is
frequently open to anyone, using standard input provides fewer chances
of accidentally (or maliciously) altering the terminal settings of
other users. Using standard input also allows
_stty_
**\(mia**
and
_stty_
**\(mig**
output to be redirected for later use. Therefore, usage of standard
input is required by this volume of POSIX.1-2008.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Chapter 2_, _Shell Command Language_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Chapter 11_, _General Terminal Interface_,
_Section 12.2_, _Utility Syntax Guidelines_,
_**&lt;termios.h&gt;**_

<a name="copyright"></a>

# Copyright

Portions of this text are reprinted and reproduced in electronic form
from IEEE Std 1003.1, 2013 Edition, Standard for Information Technology
-- Portable Operating System Interface (POSIX), The Open Group Base
Specifications Issue 7, Copyright (C) 2013 by the Institute of
Electrical and Electronics Engineers, Inc and The Open Group.
(This is POSIX.1-2008 with the 2013 Technical Corrigendum 1 applied.) In the
event of any discrepancy between this version and the original IEEE and
The Open Group Standard, the original IEEE and The Open Group Standard
is the referee document. The original Standard can be obtained online at
http://www.unix.org/online.html .

Any typographical or formatting errors that appear
in this page are most likely
to have been introduced during the conversion of the source files to
man page format. To report such errors, see
https://www.kernel.org/doc/man-pages/reporting_bugs.html .
