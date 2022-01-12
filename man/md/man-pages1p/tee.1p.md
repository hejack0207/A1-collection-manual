# tee(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

tee
— duplicate standard input

<a name="synopsis"></a>

# Synopsis

```


```
    tee [(miai] [file...]

<a name="description"></a>

# Description

The
_tee_
utility shall copy standard input to standard output, making a copy in
zero or more files. The
_tee_
utility shall not buffer output.

If the
**\(mia**
option is not specified, output files shall be written (see
_Section 1.1.1.4_, _File Read_, _Write_, _and Creation_.

<a name="options"></a>

# Options

The
_tee_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(mia**  
  Append the output to the files.
* **\(mii**  
  Ignore the SIGINT signal.

<a name="operands"></a>

# Operands

The following operands shall be supported:

* _file_  
  A pathname of an output file. If a
  _file_
  operand is
  **'\(mi'**,
  it shall refer to a file named
  **\(mi**;
  implementations shall not treat it as meaning standard output.
  Processing of at least 13
  _file_
  operands shall be supported.

<a name="stdin"></a>

# Stdin

The standard input can be of any type.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_tee_:

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

Default, except that if the
**\(mii**
option was specified, SIGINT shall be ignored.

<a name="stdout"></a>

# Stdout

The standard output shall be a copy of the standard input.

<a name="stderr"></a>

# Stderr

The standard error shall be used only for diagnostic messages.

<a name="output-files"></a>

# Output Files

If any
_file_
operands are specified, the standard input shall be copied to each
named file.

<a name="extended-description"></a>

# Extended Description

None.

<a name="exit-status"></a>

# Exit Status

The following exit values shall be returned:

* \00  
  The standard input was successfully copied to all output files.
* &gt;0  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

If a write to any successfully opened
_file_
operand fails, writes to other successfully opened
_file_
operands and standard output shall continue, but the exit status shall
be non-zero. Otherwise, the default actions specified in
_Section 1.4_, _Utility Description Defaults_
apply.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

The
_tee_
utility is usually used in a pipeline, to make a copy of the output of
some utility.

The
_file_
operand is technically optional, but
_tee_
is no more useful than
_cat_
when none is specified.

<a name="examples"></a>

# Examples

Save an unsorted intermediate form of the data in a pipeline:

    
    ... | tee unsorted | sort > sorted


<a name="rationale"></a>

# Rationale

The buffering requirement means that
_tee_
is not allowed to use ISO&nbsp;C standard fully buffered or line-buffered writes. It
does not mean that
_tee_
has to do 1-byte reads followed by 1-byte writes.

It should be noted that early versions of BSD ignore any invalid
options and accept a single
**'\(mi'**
as an alternative to
**\(mii**.
They also print a message if unable to open a file:

    
    "tee: cannot access %sen", <pathname>


Historical implementations ignore write errors. This is explicitly not
permitted by this volume of POSIX.1-2008.

Some historical implementations use O_APPEND when providing append
mode; others use the
_lseek_()
function to seek to the end-of-file after opening the file without
O_APPEND. This volume of POSIX.1-2008 requires functionality equivalent to using O_APPEND;
see
_Section 1.1.1.4_, _File Read_, _Write_, _and Creation_.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Chapter 1_, _Introduction_,
__cat_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_

The System Interfaces volume of POSIX.1-2008,
__lseek_\^(\|)_

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
