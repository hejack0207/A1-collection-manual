# strings(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

strings
— find printable strings in files

<a name="synopsis"></a>

# Synopsis

```


```
    strings [(mia] [(mit format] [(min number] [file...]

<a name="description"></a>

# Description

The
_strings_
utility shall look for printable strings in regular files and shall
write those strings to standard output. A printable string is any
sequence of four (by default) or more printable characters terminated
by a
&lt;newline&gt;
or NUL character. Additional implementation-defined strings may be
written; see
_localedef_.

If the first argument is
**'\(mi'**,
the results are unspecified.

<a name="options"></a>

# Options

The
_strings_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_,
except for the unspecified usage of
**'\(mi'**.

The following options shall be supported:

* **\(mia**  
  Scan files in their entirety. If
  **\(mia**
  is not specified, it is implementation-defined what portion of each
  file is scanned for strings.
* **\(min&nbsp;number**  
  Specify the minimum string length, where the
  _number_
  argument is a positive decimal integer. The default shall be 4.
* **\(mit&nbsp;format**  
  Write each string preceded by its byte offset from the start of the
  file. The format shall be dependent on the single character used as
  the
  _format_
  option-argument:
    * d  
      The offset shall be written in decimal.
    * The offset shall be written in octal.
    * x  
      The offset shall be written in hexadecimal.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _file_  
  A pathname of a regular file to be used as input. If no
  _file_
  operand is specified, the
  _strings_
  utility shall read from the standard input.

<a name="stdin"></a>

# Stdin

See the INPUT FILES section.

<a name="input-files"></a>

# Input Files

The input files named by the utility arguments or the standard input
shall be regular files of any format.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_strings_:

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
  multi-byte characters in arguments and input files) and to identify
  printable strings.
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

Strings found shall be written to the standard output, one per line.

When the
**\(mit**
option is not specified, the format of the output shall be:

    
    "%s", <string>


With the
**\(mit&nbsp;o**
option, the format of the output shall be:

    
    "%o %s", <byte offset>, <string>


With the
**\(mit&nbsp;x**
option, the format of the output shall be:

    
    "%x %s", <byte offset>, <string>


With the
**\(mit&nbsp;d**
option, the format of the output shall be:

    
    "%d %s", <byte offset>, <string>


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
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

By default the data area (as opposed to the text, \`\`bss'', or header
areas) of a binary executable file is scanned. Implementations
document which areas are scanned.

Some historical implementations do not require NUL or
&lt;newline&gt;
terminators for strings to permit those languages that do not use NUL
as a string terminator to have their strings written.

<a name="examples"></a>

# Examples

None.

<a name="rationale"></a>

# Rationale

Apart from rationalizing the option syntax and slight difficulties with
object and executable binary files,
_strings_
is specified to match historical practice closely. The
**\(mia**
and
**\(min**
options were introduced to replace the non-conforming
**\(mi**
and
**\(mi**\c
_number_
options. These options are no longer specified by POSIX.1-2008 but
may be present in some implementations.

The
**\(mio**
option historically means different things on different
implementations. Some use it to mean \`\`\c
_offset_
in decimal'', while others use it as \`\`\c
_offset_
in octal''. Instead of trying to decide which way would be least
objectionable, the
**\(mit**
option was added. It was originally named
**\(miO**
to mean \`\`offset'', but was changed to
**\(mit**
to be consistent with
_od_.

The ISO&nbsp;C standard function
_isprint_()
is restricted to a domain of
**unsigned char**.
This volume of POSIX.1-2008 requires implementations to write strings as defined by the
current locale.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__localedef_\^_,
__nm_\^_

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
