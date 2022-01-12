# uudecode(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

uudecode
— decode a binary file

<a name="synopsis"></a>

# Synopsis

```


```
    uudecode [(mio outfile] [file]

<a name="description"></a>

# Description

The
_uudecode_
utility shall read a file, or standard input if no file is specified,
that includes data created by the
_uuencode_
utility. The
_uudecode_
utility shall scan the input file, searching for data compatible with
one of the formats specified in
_uuencode_,
and attempt to create or overwrite the file described by the data (or
overridden by the
**\(mio**
option). The pathname shall be contained in the data or specified by
the
**\(mio**
option. The file access permission bits and contents for the file to be
produced shall be contained in that data. The mode bits of the created
file (other than standard output) shall be set from the file access
permission bits contained in the data; that is, other attributes of the
mode, including the file mode creation mask (see
_umask_),
shall not affect the file being produced. If either of the
_op_
characters
**'\(pl'**
and
**'\(mi'**
(see
_chmod_)
are specified in symbolic mode, the initial mode on which those
operations are based is unspecified.

If the pathname of the file to be produced exists, and the user does
not have write permission on that file,
_uudecode_
shall terminate with an error. If the pathname of the file to be
produced exists, and the user has write permission on that file, the
existing file shall be overwritten.

If the input data was produced by
_uuencode_
on a system with a different number of bits per byte than on the target
system, the results of
_uudecode_
are unspecified.

<a name="options"></a>

# Options

The
_uudecode_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following option shall be supported by the implementation:

* **\(mio&nbsp;outfile**  
  A pathname of a file that shall be used instead of any pathname
  contained in the input data. Specifying an
  _outfile_
  option-argument of
  **/dev/stdout**
  shall indicate standard output.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _file_  
  The pathname of a file containing the output of
  _uuencode_.

<a name="stdin"></a>

# Stdin

See the INPUT FILES section.

<a name="input-files"></a>

# Input Files

The input files shall be files containing the output of
_uuencode_.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_uudecode_:

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

If the file data header encoded by
_uuencode_
is
**\(mi**
or
**/dev/stdout**,
or the
**\(mio**
**/dev/stdout**
option overrides the file data, the standard output shall be in the
same format as the file originally encoded by
_uuencode_.
Otherwise, the standard output shall not be used.

<a name="stderr"></a>

# Stderr

The standard error shall be used only for diagnostic messages.

<a name="output-files"></a>

# Output Files

The output file shall be in the same format as the file originally
encoded by
_uuencode_.

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

The user who is invoking
_uudecode_
must have write permission on any file being created.

The output of
_uuencode_
is essentially an encoded bit stream that is not cognizant of byte
boundaries. It is possible that a 9-bit byte target machine can
process input from an 8-bit source, if it is aware of the requirement,
but the reverse is unlikely to be satisfying. Of course, the only data
that is meaningful for such a transfer between architectures is
generally character data.

<a name="examples"></a>

# Examples

None.

<a name="rationale"></a>

# Rationale

Input files are not necessarily text files, as stated by an early
proposal. Although the
_uuencode_
output is a text file, that output could have been wrapped within
another file or mail message that is not a text file.

The
**\(mio**
option is not historical practice, but was added at the request of WG15
so that the user could override the target pathname without having to
edit the input data itself.

In early drafts, the [\c
**\(mio**
_outfile_]
option-argument allowed the use of
**\(mi**
to mean standard output. The symbol
**\(mi**
has only been used previously in POSIX.1-2008 as a standard input indicator.
The standard developers did not wish to overload the meaning of
**\(mi**
in this manner. The
**/dev/stdout**
concept exists on most modern systems. The
**/dev/stdout**
syntax does not refer to a new special file. It is just a magic cookie
to specify standard output.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__chmod_\^_,
__umask_\^_,
__uuencode_\^_

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
