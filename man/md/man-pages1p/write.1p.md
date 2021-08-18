# write(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

write
— write to another user

<a name="synopsis"></a>

# Synopsis

```


```
    write user_name [terminal]

<a name="description"></a>

# Description

The
_write_
utility shall read lines from the standard input and write them
to the terminal of the specified user. When first invoked, it shall
write the message:

    
    Message from sender-login-id (sending-terminal) [date]...


to
_user_name_.
When it has successfully completed the connection, the sender's
terminal shall be alerted twice to indicate that what the sender is
typing is being written to the recipient's terminal.

If the recipient wants to reply, this can be accomplished by typing:

    
    write sender-login-id [sending-terminal]


upon receipt of the initial message. Whenever a line of input as
delimited by an NL, EOF, or EOL special character (see the Base Definitions volume of POSIX.1-2008,
_Chapter 11_, _General Terminal Interface_)
is accumulated while in canonical input mode, the accumulated data shall
be written on the other user's terminal. Characters shall be processed
as follows:

*  *  
  Typing
  &lt;alert&gt;
  shall write the
  &lt;alert&gt;
  character to the recipient's terminal.
*  *  
  Typing the erase and kill characters shall affect the sender's terminal
  in the manner described by the
  **termios**
  interface in the Base Definitions volume of POSIX.1-2008,
  _Chapter 11_, _General Terminal Interface_.
*  *  
  Typing the interrupt or end-of-file characters shall cause
  _write_
  to write an appropriate message (\c
  **"EOT\en"**
  in the POSIX locale) to the recipient's terminal and exit.
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
  special control characters and multi-byte or single-byte functions is
  implementation-defined.
*  *  
  Typing other non-printable characters shall cause
  implementation-defined sequences of printable characters to be
  written to the recipient's terminal.

To write to a user who is logged in more than once, the
_terminal_
argument can be used to indicate which terminal to write to; otherwise,
the recipient's terminal is selected in an implementation-defined
manner and an informational message is written to the sender's standard
output, indicating which terminal was chosen.

Permission to be a recipient of a
_write_
message can be denied or granted by use of the
_mesg_
utility. However, a user's privilege may further constrain the domain
of accessibility of other users' terminals. The
_write_
utility shall fail when the user lacks appropriate privileges to
perform the requested action.

<a name="options"></a>

# Options

None.

<a name="operands"></a>

# Operands
  
The following operands shall be supported:

* _user\_name_  
  Login name of the person to whom the message shall be written. The
  application shall ensure that this operand is of the form returned by
  the
  _who_
  utility.
* _terminal_  
  Terminal identification in the same format provided by the
  _who_
  utility.

<a name="stdin"></a>

# Stdin

Lines to be copied to the recipient's terminal are read from standard
input.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_write_:

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

<a name="asynchronous-events"></a>

# Asynchronous Events

If an interrupt signal is received,
_write_
shall write an appropriate message on the recipient's terminal and
exit with a status of zero. It shall take the standard action for all
other signals.

<a name="stdout"></a>

# Stdout

An informational message shall be written to standard output if a
recipient is logged in more than once.

<a name="stderr"></a>

# Stderr

The standard error shall be used only for diagnostic messages.

<a name="output-files"></a>

# Output Files

The recipient's terminal is used for output.

<a name="extended-description"></a>

# Extended Description

None.

<a name="exit-status"></a>

# Exit Status

The following exit values shall be returned:

* \00  
  Successful completion.
* &gt;0  
  The addressed user is not logged on or the addressed user denies
  permission.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

The
_talk_
utility is considered by some users to be a more usable utility on
full-screen terminals.

<a name="examples"></a>

# Examples

None.

<a name="rationale"></a>

# Rationale

The
_write_
utility was included in this volume of POSIX.1-2008 since it can be implemented on all
terminal types. The standard developers considered the
_talk_
utility, which cannot be implemented on certain terminals, to be a
\`\`better'' communications interface. Both of these programs are in
widespread use on historical implementations. Therefore, the standard
developers decided that both utilities should be specified.

The format of the terminal name is unspecified, but the descriptions of
_ps_,
_talk_,
_who_,
and
_write_
require that they all use or accept the same format.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__mesg_\^_,
__talk_\^_,
__who_\^_

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
