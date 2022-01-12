# expand(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

expand
— convert tabs to spaces

<a name="synopsis"></a>

# Synopsis

```


```
    expand [(mit tablist] [file...]

<a name="description"></a>

# Description

The
_expand_
utility shall write files or the standard input to the standard output
with
&lt;tab&gt;
characters replaced with one or more
&lt;space&gt;
characters needed to pad to the next tab stop. Any
&lt;backspace&gt;
characters shall be copied to the output and cause the column position
count for tab stop calculations to be decremented; the column position
count shall not be decremented below zero.

<a name="options"></a>

# Options

The
_expand_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following option shall be supported:

* **\(mit&nbsp;tablist**  
  Specify the tab stops. The application shall ensure that the argument
  _tablist_
  consists of either a single positive decimal integer or a list of
  tabstops. If a single number is given, tabs shall be set that number of
  column positions apart instead of the default 8.

If a list of tabstops is given, the application shall ensure that it
consists of a list of two or more positive decimal integers, separated
by
&lt;blank&gt;
or
&lt;comma&gt;
characters, in ascending order. The
&lt;tab&gt;
characters shall be set at those specific column positions. Each tab stop
_N_
shall be an integer value greater than zero, and the list is in
strictly ascending order. This is taken to mean that, from the start of
a line of output, tabbing to position
_N_
shall cause the next character output to be in the (\c
_N_+1)th
column position on that line.

In the event of
_expand_
having to process a
&lt;tab&gt;
at a position beyond the last of those specified in a multiple tab-stop
list, the
&lt;tab&gt;
shall be replaced by a single
&lt;space&gt;
in the output.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _file_  
  The pathname of a text file to be used as input.

<a name="stdin"></a>

# Stdin

See the INPUT FILES section.

<a name="input-files"></a>

# Input Files

Input files shall be text files.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_expand_:

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
  multi-byte characters in arguments and input files), the processing of
  &lt;tab&gt;
  and
  &lt;space&gt;
  characters, and for the determination of the width in column positions
  each character would occupy on an output device.
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

The standard output shall be equivalent to the input files with
&lt;tab&gt;
characters converted into the appropriate number of
&lt;space&gt;
characters.

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
  Successful completion
* &gt;0  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

The
_expand_
utility shall terminate with an error message and non-zero exit status
upon encountering difficulties accessing one of the
_file_
operands.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

None.

<a name="examples"></a>

# Examples

None.

<a name="rationale"></a>

# Rationale

The
_expand_
utility is useful for preprocessing text files (before sorting, looking
at specific columns, and so on) that contain
&lt;tab&gt;
characters.

See the Base Definitions volume of POSIX.1-2008,
_Section 3.103_, _Column Position_.

The
_tablist_
option-argument consists of integers in ascending order. Utility Syntax
Guideline 8 mandates that
_expand_
shall accept the integers (within the single argument) separated using
either
&lt;comma&gt;
or
&lt;blank&gt;
characters.

Earlier versions of this standard allowed the following form in
the SYNOPSIS:

    
    expand [(mitabstop][(mitab1,tab2,...,tabn][file ...]


This form is no longer specified by POSIX.1-2008 but may be present
in some implementations.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__tabs_\^_,
__unexpand_\^_

The Base Definitions volume of POSIX.1-2008,
_Section 3.103_, _Column Position_,
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
