# unexpand(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

unexpand
— convert spaces to tabs

<a name="synopsis"></a>

# Synopsis

```


```
    unexpand [(mia|(mit tablist] [file...]

<a name="description"></a>

# Description

The
_unexpand_
utility shall copy files or standard input to standard output,
converting
&lt;blank&gt;
characters at the beginning of each line into the maximum number of
&lt;tab&gt;
characters followed by the minimum number of
&lt;space&gt;
characters needed to fill the same column positions originally filled
by the translated
&lt;blank&gt;
characters. By default, tabstops shall be set at every eighth column
position. Each
&lt;backspace&gt;
shall be copied to the output, and shall cause the column position
count for tab calculations to be decremented; the count shall never be
decremented to a value less than one.

<a name="options"></a>

# Options

The
_unexpand_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(mia**  
  In addition to translating
  &lt;blank&gt;
  characters at the beginning of each line, translate all sequences of
  two or more
  &lt;blank&gt;
  characters immediately preceding a tab stop to the maximum number of
  &lt;tab&gt;
  characters followed by the minimum number of
  &lt;space&gt;
  characters needed to fill the same column positions originally filled
  by the translated
  &lt;blank&gt;
  characters.
* **\(mit&nbsp;tablist**  
  Specify the tab stops. The application shall ensure that the
  _tablist_
  option-argument is a single argument consisting of a single positive
  decimal integer or multiple positive decimal integers, separated by
  &lt;blank&gt;
  or
  &lt;comma&gt;
  characters, in ascending order. If a single number is given, tabs shall
  be set
  _tablist_
  column positions apart instead of the default 8. If multiple numbers
  are given, the tabs shall be set at those specific column positions.

The application shall ensure that each tab-stop position
_N_
is an integer value greater than zero, and the list shall be in
strictly ascending order. This is taken to mean that, from the start of
a line of output, tabbing to position
_N_
shall cause the next character output to be in the (\c
_N_+1)th
column position on that line. When the
**\(mit**
option is not specified, the default shall be the equivalent of
specifying
**\(mit&nbsp;8**
(except for the interaction with
**\(mia**,
described below).

No
&lt;space&gt;-to-\c
&lt;tab&gt;
conversions shall occur for characters at positions beyond the last of
those specified in a multiple tab-stop list.

When
**\(mit**
is specified, the presence or absence of the
**\(mia**
option shall be ignored; conversion shall not be limited to the
processing of leading
&lt;blank&gt;
characters.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _file_  
  A pathname of a text file to be used as input.

<a name="stdin"></a>

# Stdin

See the INPUT FILES section.

<a name="input-files"></a>

# Input Files

The input files shall be text files.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_unexpand_:

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
the specified
&lt;space&gt;-to-\c
&lt;tab&gt;
conversions.

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

One non-intuitive aspect of
_unexpand_
is its restriction to leading
&lt;space&gt;
characters when neither
**\(mia**
nor
**\(mit**
is specified. Users who always want to convert all
&lt;space&gt;
characters in a file can easily alias
_unexpand_
to use the
**\(mia**
or
**\(mit&nbsp;8**
option.

<a name="examples"></a>

# Examples

None.

<a name="rationale"></a>

# Rationale

On several occasions, consideration was given to adding a
**\(mit**
option to the
_unexpand_
utility to complement the
**\(mit**
in
_expand_
(see
__expand_\^_).
The historical intent of
_unexpand_
was to translate multiple
&lt;blank&gt;
characters into tab stops, where tab stops were a multiple of eight
column positions on most UNIX systems. An early proposal omitted
**\(mit**
because it seemed outside the scope of the User Portability Utilities
option; it was not described in any of the base documents. However,
hard-coding tab stops every eight columns was not suitable for the
international community and broke historical precedents for some
vendors in the FORTRAN community, so
**\(mit**
was restored in conjunction with the list of valid extension categories
considered by the standard developers. Thus,
_unexpand_
is now the logical converse of
_expand_.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__expand_\^_,
__tabs_\^_

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
