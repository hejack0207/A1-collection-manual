# talk(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

talk
— talk to another user

<a name="synopsis"></a>

# Synopsis

```


```
    talk address [terminal]

<a name="description"></a>

# Description

The
_talk_
utility is a two-way, screen-oriented communication program.

When first invoked,
_talk_
shall send a message similar to:

    
    Message from <unspecified string>
    talk: connection requested by your_address
    talk: respond with: talk your_address


to the specified
_address_.
At this point, the recipient of the message can reply by typing:

    
    talk your_address


Once communication is established, the two parties can type
simultaneously, with their output displayed in separate regions of the
screen. Characters shall be processed as follows:

*  *  
  Typing the
  &lt;alert&gt;
  character shall alert the recipient's terminal.
*  *  
  Typing &lt;control&gt;-L shall cause the sender's screen regions to be
  refreshed.
*  *  
  Typing the erase and kill characters shall affect the sender's terminal
  in the manner described by the
  **termios**
  interface in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.
*  *  
  Typing the interrupt or end-of-file characters shall terminate the
  local
  _talk_
  utility. Once the
  _talk_
  session has been terminated on one side, the other side of the
  _talk_
  session shall be notified that the
  _talk_
  session has been terminated and shall be able to do nothing except
  exit.
*  *  
  Typing characters from
  _LC_CTYPE_
  classifications
  **print**
  or
  **space**
  shall cause those characters to be sent to the recipient's terminal.
*  *  
  When and only when the
  _stty_
  **iexten**
  local mode is enabled, the existence and processing of additional
  special control characters and multi-byte or single-byte functions
  shall be implementation-defined.
*  *  
  Typing other non-printable characters shall cause
  implementation-defined sequences of printable characters to be sent
  to the recipient's terminal.

Permission to be a recipient of a
_talk_
message can be denied or granted by use of the
_mesg_
utility. However, a user's privilege may further constrain the domain
of accessibility of other users' terminals. The
_talk_
utility shall fail when the user lacks appropriate privileges to
perform the requested action.

Certain block-mode terminals do not have all the capabilities necessary
to support the simultaneous exchange of messages required for
_talk_.
When this type of exchange cannot be supported on such terminals, the
implementation may support an exchange with reduced levels of
simultaneous interaction or it may report an error describing the
terminal-related deficiency.

<a name="options"></a>

# Options

None.

<a name="operands"></a>

# Operands

The following operands shall be supported:

* _address_  
  The recipient of the
  _talk_
  session. One form of
  _address_
  is the &lt;_user&nbsp;name_&gt;, as returned by the
  _who_
  utility. Other address formats and how they are handled are
  unspecified.
* _terminal_  
  If the recipient is logged in more than once, the
  _terminal_
  argument can be used to indicate the appropriate terminal name. If
  _terminal_
  is not specified, the
  _talk_
  message shall be displayed on one or more accessible terminals in use
  by the recipient. The format of
  _terminal_
  shall be the same as that returned by the
  _who_
  utility.

<a name="stdin"></a>

# Stdin

Characters read from standard input shall be copied to the recipient's
terminal in an unspecified manner. If standard input is not a
terminal, talk shall write a diagnostic message and exit with a
non-zero status.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_talk_:

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
  Determine the locale for the interpretation of sequences of bytes of
  text data as characters (for example, single-byte as opposed to
  multi-byte characters in arguments and input files). If the
  recipient's locale does not use an
  _LC_CTYPE_
  equivalent to the sender's, the results are undefined.
* _LC\_MESSAGES_    
  Determine the locale that should be used to affect the format and
  contents of diagnostic messages written to standard error and
  informative messages written to standard output.
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.
* _TERM_  
  Determine the name of the invoker's terminal type. If this variable is
  unset or null, an unspecified default terminal type shall be used.

<a name="asynchronous-events"></a>

# Asynchronous Events

When the
_talk_
utility receives a SIGINT signal, the utility shall terminate and exit
with a zero status. It shall take the standard action for all other
signals.

<a name="stdout"></a>

# Stdout

If standard output is a terminal, characters copied from the
recipient's standard input may be written to standard output. Standard
output also may be used for diagnostic messages. If standard output is
not a terminal,
_talk_
shall exit with a non-zero status.

<a name="stderr"></a>

# Stderr

None.

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
  Successful completion.
* &gt;0  
  An error occurred or
  _talk_
  was invoked on a terminal incapable of supporting it.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

Because the handling of non-printable, non-\c
&lt;space&gt;
characters is tied to the
_stty_
description of
**iexten**,
implementation extensions within the terminal driver can be accessed.
For example, some implementations provide line editing functions with
certain control character sequences.

<a name="examples"></a>

# Examples

None.

<a name="rationale"></a>

# Rationale

The
_write_
utility was included in this volume of POSIX.1-2008 since it can be implemented on all
terminal types. The
_talk_
utility, which cannot be implemented on certain terminals, was
considered to be a \`\`better'' communications interface. Both of these
programs are in widespread use on historical implementations.
Therefore, both utilities have been specified.

All references to networking abilities (_talk_ing to a user on
another system) were removed as being outside the scope of this volume of POSIX.1-2008.

Historical BSD and System V versions of
_talk_
terminate both of the conversations when either user breaks out of the
session. This can lead to adverse consequences if a user unwittingly
continues to enter text that is interpreted by the shell when the other
terminates the session. Therefore, the version of
_talk_
specified by this volume of POSIX.1-2008 requires both users to terminate their end of the
session explicitly.

Only messages sent to the terminal of the invoking user can be
internationalized in any way:

*  *  
  The original \`\`Message from &lt;_unspecified string_&gt; .\|.\|.''
  message sent to the terminal of the recipient cannot be
  internationalized because the environment of the recipient is as yet
  inaccessible to the
  _talk_
  utility. The environment of the invoking party is irrelevant.
*  *  
  Subsequent communication between the two parties cannot be
  internationalized because the two parties may specify different
  languages in their environment (and non-portable characters cannot be
  mapped from one language to another).
*  *  
  Neither party can be required to communicate in a language other than C
  and/or the one specified by their environment because unavailable
  terminal hardware support (for example, fonts) may be required.

The text in the STDOUT section reflects the usage of the verb
\`\`display'' in this section; some
_talk_
implementations actually use standard output to write to the terminal,
but this volume of POSIX.1-2008 does not require that to be the case.

The format of the terminal name is unspecified, but the descriptions of
_ps_,
_talk_,
_who_,
and
_write_
require that they all use or accept the same format.

The handling of non-printable characters is partially
implementation-defined
because the details of mapping them to printable sequences is not
needed by the user. Historical implementations, for security reasons,
disallow the transmission of non-printable characters that may send
commands to the other terminal.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__mesg_\^_,
__stty_\^_,
__who_\^_,
__write_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Chapter 11_, _General Terminal Interface_

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
