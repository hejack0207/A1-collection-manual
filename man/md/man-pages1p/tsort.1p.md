# tsort(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

tsort
— topological sort

<a name="synopsis"></a>

# Synopsis

```


```
    tsort [file]

<a name="description"></a>

# Description

The
_tsort_
utility shall write to standard output a totally ordered list of items
consistent with a partial ordering of items contained in the input.

The application shall ensure that the input consists of pairs of items
(non-empty strings) separated by
&lt;blank&gt;
characters. Pairs of different items indicate ordering. Pairs of
identical items indicate presence, but not ordering.

<a name="options"></a>

# Options

None.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _file_  
  A pathname of a text file to order. If no
  _file_
  operand is given, the standard input shall be used.

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

The input file shall be a text file.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_tsort_:

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

The standard output shall be a text file consisting of the order list
produced from the partially ordered input.

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
_LC_COLLATE_
variable need not affect the actions of
_tsort_.
The output ordering is not lexicographic, but depends on the pairs of
items given as input.

<a name="examples"></a>

# Examples

The command:

    
    tsort <<EOF
    a b c c d e
    g g
    f g e f
    h h
    EOF


produces the output:

    
    a
    b
    c
    d
    e
    f
    g
    h


<a name="rationale"></a>

# Rationale

None.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

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
