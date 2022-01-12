# tput(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

tput
— change terminal characteristics

<a name="synopsis"></a>

# Synopsis

```


```
    tput [(miT type] operand...

<a name="description"></a>

# Description

The
_tput_
utility shall display terminal-dependent information. The manner in
which this information is retrieved is unspecified. The information
displayed shall clear the terminal screen, initialize the user's
terminal, or reset the user's terminal, depending on the operand
given. The exact consequences of displaying this information are
unspecified.

<a name="options"></a>

# Options

The
_tput_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following option shall be supported:

* **\(miT&nbsp;type**  
  Indicate the type of terminal. If this option is not supplied and the
  _TERM_
  variable is unset or null, an unspecified default terminal type shall
  be used. The setting of
  _type_
  shall take precedence over the value in
  _TERM_.

<a name="operands"></a>

# Operands

The following strings shall be supported as operands by the
implementation in the POSIX locale:

* **clear**  
  Display the clear-screen sequence.
* **init**  
  Display the sequence that initializes the user's terminal in an
  implementation-defined manner.
* **reset**  
  Display the sequence that resets the user's terminal in an
  implementation-defined manner.

If a terminal does not support any of the operations described by these
operands, this shall not be considered an error condition.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_tput_:

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
  multi-byte characters in arguments).
* _LC\_MESSAGES_    
  Determine the locale that should be used to affect the format and
  contents of diagnostic messages written to standard error.
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.
* _TERM_  
  Determine the terminal type. If this variable is unset or null, and if
  the
  **\(miT**
  option is not specified, an unspecified default terminal type shall be
  used.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

If standard output is a terminal device, it may be used for writing the
appropriate sequence to clear the screen or reset or initialize the
terminal. If standard output is not a terminal device, undefined
results occur.

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
  The requested string was written successfully.
* \01  
  Unspecified.
* \02  
  Usage error.
* \03  
  No information is available about the specified terminal type.
* \04  
  The specified operand is invalid.
* &gt;4  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

If one of the operands is not available for the terminal,
_tput_
continues processing the remaining operands.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

The difference between resetting and initializing a terminal is left
unspecified, as they vary greatly based on hardware types. In general,
resetting is a more severe action.

Some terminals use control characters to perform the stated functions,
and on such terminals it might make sense to use
_tput_
to store the initialization strings in a file or environment variable
for later use. However, because other terminals might rely on system
calls to do this work, the standard output cannot be used in a portable
manner, such as the following non-portable constructs:

    
    ClearVar=`tput clear`
    tput reset | mailx (mis "Wake Up" ddg


<a name="examples"></a>

# Examples


*  1.  
  Initialize the terminal according to the type of terminal in the
  environmental variable
  _TERM_.
  This command can be included in a
  **.profile**
  file.

    
    tput init


*  2.  
  Reset a 450 terminal.

    
    tput (miT 450 reset


<a name="rationale"></a>

# Rationale

The list of operands was reduced to a minimum for the following
reasons:

*  *  
  The only features chosen were those that were likely to be used by
  human users interacting with a terminal.
*  *  
  Specifying the full
  _terminfo_
  set was not considered desirable, but the standard developers did not
  want to select among operands.
*  *  
  This volume of POSIX.1-2008 does not attempt to provide applications with sophisticated
  terminal handling capabilities, as that falls outside of its assigned
  scope and intersects with the responsibilities of other standards
  bodies.

The difference between resetting and initializing a terminal is left
unspecified as this varies greatly based on hardware types. In
general, resetting is a more severe action.

The exit status of 1 is historically reserved for finding out if a
Boolean operand is not set. Although the operands were reduced to a
minimum, the exit status of 1 should still be reserved for the Boolean
operands, for those sites that wish to support them.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__stty_\^_,
__tabs_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_

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
