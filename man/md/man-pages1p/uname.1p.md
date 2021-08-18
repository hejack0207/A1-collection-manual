# uname(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

uname
— return system name

<a name="synopsis"></a>

# Synopsis

```


```
    uname [(miamnrsv]

<a name="description"></a>

# Description

By default, the
_uname_
utility shall write the operating system name to standard output. When
options are specified, symbols representing one or more system
characteristics shall be written to the standard output. The format
and contents of the symbols are implementation-defined. On systems
conforming to the System Interfaces volume of POSIX.1-2008, the symbols written shall be those supported
by the
_uname_()
function as defined in the System Interfaces volume of POSIX.1-2008.

<a name="options"></a>

# Options

The
_uname_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(mia**  
  Behave as though all of the options
  **\(mimnrsv**
  were specified.
* **\(mim**  
  Write the name of the hardware type on which the system is running to
  standard output.
* **\(min**  
  Write the name of this node within an implementation-defined
  communications network.
* **\(mir**  
  Write the current release level of the operating system
  implementation.
* **\(mis**  
  Write the name of the implementation of the operating system.
* **\(miv**  
  Write the current version level of this release of the operating system
  implementation.

If no options are specified, the
_uname_
utility shall write the operating system name, as if the
**\(mis**
option had been specified.

<a name="operands"></a>

# Operands

None.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_uname_:

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

By default, the output shall be a single line of the following form:

    
    "%sen", <sysname>


If the
**\(mia**
option is specified, the output shall be a single line of the following
form:

    
    "%s %s %s %s %sen", <sysname>, <nodename>, <release>,
        <version>, <machine>


Additional implementation-defined symbols may be written; all such
symbols shall be written at the end of the line of output before the
&lt;newline&gt;.

If options are specified to select different combinations of the
symbols, only those symbols shall be written, in the order shown above
for the
**\(mia**
option. If a symbol is not selected for writing, its corresponding
trailing
&lt;blank&gt;
characters also shall not be written.

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
  The requested information was successfully written.
* &gt;0  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

Note that any of the symbols could include embedded
&lt;space&gt;
characters, which may affect parsing algorithms if multiple options are
selected for output.

The node name is typically a name that the system uses to identify
itself for inter-system communication addressing.

<a name="examples"></a>

# Examples

The following command:

    
    uname (misr


writes the operating system name and release level, separated by one or
more
&lt;blank&gt;
characters.

<a name="rationale"></a>

# Rationale

It was suggested that this utility cannot be used portably since the
format of the symbols is implementation-defined. The POSIX.1 working
group could not achieve consensus on defining these formats in the
underlying
_uname_()
function, and there was no expectation that this volume of POSIX.1-2008 would be any more
successful. Some applications may still find this historical utility of
value. For example, the symbols could be used for system log entries or
for comparison with operator or user input.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_

The System Interfaces volume of POSIX.1-2008,
__uname_\^(\|)_

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
