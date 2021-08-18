# cxref(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

cxref
— generate a C-language program cross-reference table
(**DEVELOPMENT**)

<a name="synopsis"></a>

# Synopsis

```


```
    cxref [(mics] [(mio file] [(miw num] [(miD name[=def]]... [(miI dir]...
        [(miU name]... file...

<a name="description"></a>

# Description

The
_cxref_
utility shall analyze a collection of C-language
_file_s
and attempt to build a cross-reference table. Information from
**#define**
lines shall be included in the symbol table. A sorted listing shall be
written to standard output of all symbols (auto, static, and global) in
each
_file_
separately, or with the
**\(mic**
option, in combination. Each symbol shall contain an
&lt;asterisk&gt;
before the declaring reference.

<a name="options"></a>

# Options

The
_cxref_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_,
except that the order of the
**\(miD**,
**\(miI**,
and
**\(miU**
options (which are identical to their interpretation by
_c99_)
is significant. The following options shall be supported:

* **\(mic**  
  Write a combined cross-reference of all input files.
* **\(mis**  
  Operate silently; do not print input filenames.
* **\(mio&nbsp;file**  
  Direct output to named
  _file_.
* **\(miw&nbsp;num**  
  Format output no wider than
  _num_
  (decimal) columns. This option defaults to 80 if
  _num_
  is not specified or is less than 51.
* **\(miD**  
  Equivalent to
  _c99_.
* **\(miI**  
  Equivalent to
  _c99_.
* **\(miU**  
  Equivalent to
  _c99_.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _file_  
  A pathname of a C-language source file.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

The input files are C-language source files.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_cxref_:

* _LANG_  
  Provide a default value for the internationalization variables that are
  unset or null. (See the Base Definitions volume of POSIX.1-2008,
  _Section 8.2_, _Internationalization Variables_
  for the precedence of internationalization variables used to determine
  the values of locale categories.)
* _LC\_ALL_  
  If set to a non-empty string value, override the values of all the
  other internationalization variables.
* _LC\_COLLATE_    
  Determine the locale for the ordering of the output.
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

The standard output shall be used for the cross-reference listing,
unless the
**\(mio**
option is used to select a different output file.

The format of standard output is unspecified, except that the following
information shall be included:

*  *  
  If the
  **\(mic**
  option is not specified, each portion of the listing shall start
  with the name of the input file on a separate line.
*  *  
  The name line shall be followed by a sorted list of symbols, each with
  its associated location pathname, the name of the function in which it
  appears (if it is not a function name itself), and line number
  references.
*  *  
  Each line number may be preceded by an
  &lt;asterisk&gt;
  (\c
  **'*'**)
  flag, meaning that this is the declaring reference. Other
  single-character flags, with implementation-defined meanings, may be
  included.

<a name="stderr"></a>

# Stderr

The standard error shall be used only for diagnostic messages.

<a name="output-files"></a>

# Output Files

The output file named by the
**\(mio**
option shall be used instead of standard output.

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

None.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__c99_\^_

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
