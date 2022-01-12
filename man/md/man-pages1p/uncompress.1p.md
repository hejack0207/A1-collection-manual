# uncompress(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

uncompress
— expand compressed data

<a name="synopsis"></a>

# Synopsis

```


```
    uncompress [(micfv] [file...]

<a name="description"></a>

# Description

The
_uncompress_
utility shall restore files to their original state after they have
been compressed using the
_compress_
utility. If no files are specified, the standard input shall be
uncompressed to the standard output. If the invoking process has
appropriate privileges, the ownership, modes, access time, and
modification time of the original file shall be preserved.

This utility shall support the uncompressing of any files produced by
the
_compress_
utility on the same implementation. For files produced by
_compress_
on other systems,
_uncompress_
supports 9 to 14-bit compression (see
__compress_\^_,
**\(mib**);
it is implementation-defined whether values of
**\(mib**
greater than 14 are supported.

<a name="options"></a>

# Options

The
_uncompress_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_,
except that Guideline 1 does apply since the utility name has ten letters.

The following options shall be supported:

* **\(mic**  
  Write to standard output; no files are changed.
* **\(mif**  
  Do not prompt for overwriting files. Except when run in the
  background, if
  **\(mif**
  is not given the user shall be prompted as to whether an existing file
  should be overwritten. If the standard input is not a terminal and
  **\(mif**
  is not given,
  _uncompress_
  shall write a diagnostic message to standard error and exit with a
  status greater than zero.
* **\(miv**  
  Write messages to standard error concerning the expansion of each file.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _file_  
  A pathname of a file. If
  _file_
  already has the
  **.Z**
  suffix specified, it shall be used as the input file and the output
  file shall be named
  **file**
  with the
  **.Z**
  suffix removed. Otherwise,
  _file_
  shall be used as the name of the output file and
  **file**
  with the
  **.Z**
  suffix appended shall be used as the input file.

<a name="stdin"></a>

# Stdin

The standard input shall be used only if no
_file_
operands are specified, or if a
_file_
operand is
**'\(mi'**.

<a name="input-files"></a>

# Input Files

Input files shall be in the format produced by the
_compress_
utility.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_uncompress_:

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

When there are no
_file_
operands or the
**\(mic**
option is specified, the uncompressed output is written to standard
output.

<a name="stderr"></a>

# Stderr

Prompts shall be written to the standard error output under the
conditions specified in the DESCRIPTION and OPTIONS sections. The
prompts shall contain the
_file_
pathname, but their format is otherwise unspecified. Otherwise, the
standard error output shall be used only for diagnostic messages.

<a name="output-files"></a>

# Output Files

Output files are the same as the respective input files to
_compress_.

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

The input file remains unmodified.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

The limit of 14 on the
_compress_
**\(mib**
_bits_
argument is to achieve portability to all systems (within the
restrictions imposed by the lack of an explicit published file
format). Some implementations based on 16-bit architectures cannot
support 15 or 16-bit uncompression.

<a name="examples"></a>

# Examples

None.

<a name="rationale"></a>

# Rationale

None.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__compress_\^_,
__zcat_\^_

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
