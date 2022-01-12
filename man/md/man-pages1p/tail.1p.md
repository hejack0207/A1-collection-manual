# tail(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

tail
— copy the last part of a file

<a name="synopsis"></a>

# Synopsis

```


```
    tail [(mif] [(mic number|(min number] [file]

<a name="description"></a>

# Description

The
_tail_
utility shall copy its input file to the standard output beginning at a
designated place.

Copying shall begin at the point in the file indicated by the
**\(mic**
_number_
or
**\(min**
_number_
options. The option-argument
_number_
shall be counted in units of lines or bytes, according to the options
**\(min**
and
**\(mic**.
Both line and byte counts start from 1.

Tails relative to the end of the file may be saved in an internal
buffer, and thus may be limited in length. Such a buffer, if any,
shall be no smaller than
{LINE_MAX}*10
bytes.

<a name="options"></a>

# Options

The
_tail_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_,
except that
**'\(pl'**
may be recognized as an option delimiter as well as
**'\(mi'**.

The following options shall be supported:

* **\(mic&nbsp;number**  
  The application shall ensure that the
  _number_
  option-argument is a decimal integer, optionally including a sign.
  The sign shall affect the location in the file, measured in bytes,
  to begin the copying:
  .TS
  center tab(@) box;
  cB | cB
  cf5 | l.
  Sign@Copying Starts
  _
  +@Relative to the beginning of the file.
  \(mi@Relative to the end of the file.
  _none_@Relative to the end of the file.
  .TE

The application shall ensure that if the sign of the
_number_
option-argument is
**'\(pl'**,
the
_number_
option-argument is a non-zero decimal integer.

The origin for counting shall be 1; that is,
**\(mic**
+1 represents the first byte of the file,
**\(mic**
\(mi1 the last.

* **\(mif**  
  If the input file is a regular file or if the
  _file_
  operand specifies a FIFO, do not terminate after the last line of the
  input file has been copied, but read and copy further bytes from the
  input file when they become available. If no
  _file_
  operand is specified and standard input is a pipe or FIFO, the
  **\(mif**
  option shall be ignored. If the input file is not a FIFO, pipe, or
  regular file, it is unspecified whether or not the
  **\(mif**
  option shall be ignored.
* **\(min&nbsp;number**  
  This option shall be equivalent to
  **\(mic**
  _number_,
  except the starting location in the file shall be measured in lines
  instead of bytes. The origin for counting shall be 1; that is,
  **\(min**
  +1 represents the first line of the file,
  **\(min**
  \(mi1 the last.

If neither
**\(mic**
nor
**\(min**
is specified,
**\(min**
10 shall be assumed.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _file_  
  A pathname of an input file. If no
  _file_
  operand is specified, the standard input shall be used.

<a name="stdin"></a>

# Stdin

The standard input shall be used if no
_file_
operand is specified, and shall be used if the
_file_
operand is
**'\(mi'**
and the implementation treats the
**'\(mi'**
as meaning standard input.
Otherwise, the standard input shall not be used.
See the INPUT FILES section.

<a name="input-files"></a>

# Input Files

If the
**\(mic**
option is specified, the input file can contain arbitrary data;
otherwise, the input file shall be a text file.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_tail_:

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
  multi-byte characters in arguments and input files).
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

The designated portion of the input file shall be written to standard
output.

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

The
**\(mic**
option should be used with caution when the input is a text file
containing multi-byte characters; it may produce output that does not
start on a character boundary.

Although the input file to
_tail_
can be any type, the results might not be what would be expected on
some character special device files or on file types not described by
the System Interfaces volume of POSIX.1-2008. Since this volume of POSIX.1-2008 does not specify the block size used when doing
input,
_tail_
need not read all of the data from devices that only perform block
transfers.

<a name="examples"></a>

# Examples

The
**\(mif**
option can be used to monitor the growth of a file that is being
written by some other process. For example, the command:

    
    tail (mif fred


prints the last ten lines of the file
**fred**,
followed by any lines that are appended to
**fred**
between the time
_tail_
is initiated and killed. As another example, the command:

    
    tail (mif (mic 15 fred


prints the last 15 bytes of the file
**fred**,
followed by any bytes that are appended to
**fred**
between the time
_tail_
is initiated and killed.

<a name="rationale"></a>

# Rationale

This version of
_tail_
was created to allow conformance to the Utility Syntax Guidelines. The
historical
**\(mib**
option was omitted because of the general non-portability of block-sized
units of text. The
**\(mic**
option historically meant \`\`characters'', but this volume of POSIX.1-2008 indicates
that it means \`\`bytes''. This was selected to allow reasonable
implementations when multi-byte characters are possible; it was not
named
**\(mib**
to avoid confusion with the historical
**\(mib**.

The origin of counting both lines and bytes is 1, matching all
widespread historical implementations. Hence
_tail_
**\(min**
+0 is not conforming usage because it attempts to output line zero; but
note that
_tail_
**\(min**
0 does conform, and outputs nothing.

Earlier versions of this standard allowed the following forms in the
SYNOPSIS:

    
    tail (mi[number][b|c|l][f] [file]
    tail (pl[number][b|c|l][f] [file]


These forms are no longer specified by POSIX.1-2008, but may be
present in some implementations.

The restriction on the internal buffer is a compromise between the
historical System V implementation of 4\|096 bytes and the BSD 32\|768
bytes.

The
**\(mif**
option has been implemented as a loop that sleeps for 1 second and
copies any bytes that are available. This is sufficient, but if more
efficient methods of determining when new data are available are
developed, implementations are encouraged to use them.

Historical documentation indicates that
_tail_
ignores the
**\(mif**
option if the input file is a pipe (pipe and FIFO on systems that
support FIFOs). On BSD-based systems, this has been true; on System
V-based systems, this was true when input was taken from standard
input, but it did not ignore the
**\(mif**
flag if a FIFO was named as the
_file_
operand. Since the
**\(mif**
option is not useful on pipes and all historical implementations ignore
**\(mif**
if no
_file_
operand is specified and standard input is a pipe, this volume of POSIX.1-2008 requires this
behavior. However, since the
**\(mif**
option is useful on a FIFO, this volume of POSIX.1-2008 also requires that
if a FIFO is named, the
**\(mif**
option shall not be ignored. Earlier versions of this standard did
not state any requirement for the case where no
_file_
operand is specified and standard input is a FIFO. The standard has
been updated to reflect current practice which is to treat this case
the same as a pipe on standard input.
Although historical behavior does not ignore the
**\(mif**
option for other file types, this is unspecified so that
implementations are allowed to ignore the
**\(mif**
option if it is known that the file cannot be extended.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__head_\^_

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
