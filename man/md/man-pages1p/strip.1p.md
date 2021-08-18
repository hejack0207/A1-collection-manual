# strip(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

strip
— remove unnecessary information from strippable files
(**DEVELOPMENT**)

<a name="synopsis"></a>

# Synopsis

```


```
    strip file...

<a name="description"></a>

# Description

A strippable file is defined as a relocatable, object, or executable
file.
On XSI-conformant systems, a strippable file can also be an archive
of object or relocatable files.

The
_strip_
utility shall remove from strippable files named by the
_file_
operands any information the implementor deems unnecessary for
execution of those files. The nature of that information is
unspecified. The effect of
_strip_
on object and executable files shall be similar to the use of the
**\(mis**
option to
_c99_
or
_fort77_.
The effect of
_strip_
on an archive of object files shall be similar to the use of the
**\(mis**
option to
_c99_
or
_fort77_
for each object file in the archive.

<a name="options"></a>

# Options

None.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _file_  
  A pathname referring to a strippable file.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

The input files shall be in the form of strippable files successfully
produced by any compiler defined by this volume of POSIX.1-2008
or produced by creating or updating an archive of such files
using the
_ar_
utility.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_strip_:

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

Not used.

<a name="stderr"></a>

# Stderr

The standard error shall be used only for diagnostic messages.

<a name="output-files"></a>

# Output Files

The
_strip_
utility shall produce strippable files of unspecified format.

<a name="extended-description"></a>

# Extended Description

None.

<a name="exit-status"></a>

# Exit Status

The following exit values shall be returned:

* \00  
  Successful completion.
* &gt;0  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

None.

<a name="examples"></a>

# Examples

None.

<a name="rationale"></a>

# Rationale

Historically, this utility has been used to remove the symbol table
from a strippable file. It was included since it is known that the
amount of symbolic information can amount to several megabytes; the
ability to remove it in a portable manner was deemed important,
especially for smaller systems.

The behavior of
_strip_
on object and executable files is said to be the same as the
**\(mis**
option to a compiler. While the end result is essentially the same,
it is not required to be identical.

XSI-conformant systems support use of
_strip_
on archive files containing object files or relocatable files.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__ar_\^_,
__c99_\^_,
__fort77_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_

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
