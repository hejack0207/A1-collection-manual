# ulimit(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

ulimit
— set or report file size limit

<a name="synopsis"></a>

# Synopsis

```


```
    ulimit [(mif] [blocks]

<a name="description"></a>

# Description

The
_ulimit_
utility shall set or report the file-size writing limit imposed on
files written by the shell and its child processes (files of any size
may be read). Only a process with appropriate privileges can increase
the limit.

<a name="options"></a>

# Options

The
_ulimit_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following option shall be supported:

* **\(mif**  
  Set (or report, if no
  _blocks_
  operand is present), the file size limit in blocks. The
  **\(mif**
  option shall also be the default case.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _blocks_  
  The number of 512-byte blocks to use as the new file size limit.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_ulimit_:

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

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

The standard output shall be used when no
_blocks_
operand is present. If the current number of blocks is limited, the
number of blocks in the current limit shall be written in the following
format:

    
    "%den", <number of 512-byte blocks>


If there is no current limit on the number of blocks, in the POSIX
locale the following format shall be used:

    
    "unlimiteden"


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
  Successful completion.
* &gt;0  
  A request for a higher limit was rejected or an error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

Since
_ulimit_
affects the current shell execution environment, it is always provided
as a shell regular built-in. If it is called in a separate utility
execution environment, such as one of the following:

    
    nohup ulimit (mif 10000
    env ulimit 10000


it does not affect the file size limit of the caller's environment.

Once a limit has been decreased by a process, it cannot be increased
(unless appropriate privileges are involved), even back to the original
system limit.

<a name="examples"></a>

# Examples

Set the file size limit to 51\|200 bytes:

    
    ulimit (mif 100


<a name="rationale"></a>

# Rationale

None.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_

The System Interfaces volume of POSIX.1-2008,
__ulimit_\^(\|)_

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
