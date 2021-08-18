# comm(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

comm
— select or reject lines common to two files

<a name="synopsis"></a>

# Synopsis

```


```
    comm [(mi123] file1 file2

<a name="description"></a>

# Description

The
_comm_
utility shall read
_file1_
and
_file2_,
which should be ordered in the current collating sequence, and produce
three text columns as output: lines only in
_file1_,
lines only in
_file2_,
and lines in both files.

If the lines in both files are not ordered according to the collating
sequence of the current locale, the results are unspecified.

<a name="options"></a>

# Options

The
_comm_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(mi1**  
  Suppress the output column of lines unique to
  _file1_.
* **\(mi2**  
  Suppress the output column of lines unique to
  _file2_.
* **\(mi3**  
  Suppress the output column of lines duplicated in
  _file1_
  and
  _file2_.

<a name="operands"></a>

# Operands

The following operands shall be supported:

* _file1_  
  A pathname of the first file to be compared. If
  _file1_
  is
  **'\(mi'**,
  the standard input shall be used.
* _file2_  
  A pathname of the second file to be compared. If
  _file2_
  is
  **'\(mi'**,
  the standard input shall be used.

If both
_file1_
and
_file2_
refer to standard input or to the same FIFO special, block special, or
character special file, the results are undefined.

<a name="stdin"></a>

# Stdin

The standard input shall be used only if one of the
_file1_
or
_file2_
operands refers to standard input. See the INPUT FILES section.

<a name="input-files"></a>

# Input Files

The input files shall be text files.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_comm_:

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
  Determine the locale for the collating sequence
  _comm_
  expects to have been used when the input files were sorted.
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

The
_comm_
utility shall produce output depending on the options selected. If the
**\(mi1**,
**\(mi2**,
and
**\(mi3**
options are all selected,
_comm_
shall write nothing to standard output.

If the
**\(mi1**
option is not selected, lines contained only in
_file1_
shall be written using the format:

    
    "%sen", <line in file1>


If the
**\(mi2**
option is not selected, lines contained only in
_file2_
are written using the format:

    
    "%s%sen", <lead>, <line in file2>


where the string &lt;_lead_&gt; is as follows:

* &lt;tab&gt;  
  The
  **\(mi1**
  option is not selected.
* null&nbsp;string  
  The
  **\(mi1**
  option is selected.

If the
**\(mi3**
option is not selected, lines contained in both files shall be written
using the format:

    
    "%s%sen", <lead>, <line in both>


where the string &lt;_lead_&gt; is as follows:

* &lt;tab&gt;&lt;tab&gt;  
  Neither the
  **\(mi1**
  nor the
  **\(mi2**
  option is selected.
* &lt;tab&gt;  
  Exactly one of the
  **\(mi1**
  and
  **\(mi2**
  options is selected.
* null&nbsp;string  
  Both the
  **\(mi1**
  and
  **\(mi2**
  options are selected.

If the input files were ordered according to the collating sequence of
the current locale, the lines written shall be in the collating
sequence of the original lines.

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
  All input files were successfully output as specified.
* &gt;0  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

If the input files are not properly presorted, the output of
_comm_
might not be useful.

<a name="examples"></a>

# Examples

If a file named
**xcu**
contains a sorted list of the utilities in this volume of POSIX.1-2008, a file named
**xpg3**
contains a sorted list of the utilities specified in the X/Open
Portability Guide, Issue 3, and a file named
**svid89**
contains a sorted list of the utilities in the System V Interface
Definition Third Edition:

    
    comm (mi23 xcu xpg3 | comm (mi23 (mi svid89


would print a list of utilities in this volume of POSIX.1-2008 not specified by either of the
other documents:

    
    comm (mi12 xcu xpg3 | comm (mi12 (mi svid89


would print a list of utilities specified by all three documents, and:

    
    comm (mi12 xpg3 svid89 | comm (mi23 (mi xcu


would print a list of utilities specified by both XPG3 and the SVID,
but not specified in this volume of POSIX.1-2008.

<a name="rationale"></a>

# Rationale

None.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__cmp_\^_,
__diff_\^_,
__sort_\^_,
__uniq_\^_

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
