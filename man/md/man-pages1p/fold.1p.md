# fold(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

fold
— filter for folding lines

<a name="synopsis"></a>

# Synopsis

```


```
    fold [(mibs] [(miw width] [file...]

<a name="description"></a>

# Description

The
_fold_
utility is a filter that shall fold lines from its input files,
breaking the lines to have a maximum of
_width_
column positions (or bytes, if the
**\(mib**
option is specified). Lines shall be broken by the insertion of a
&lt;newline&gt;
such that each output line (referred to later in this section
as a _segment_) is the maximum width possible that does not exceed
the specified number of column positions (or bytes). A line shall not
be broken in the middle of a character. The behavior is undefined if
_width_
is less than the number of columns any single character in the input
would occupy.

If the
&lt;carriage-return&gt;,
&lt;backspace&gt;,
or
&lt;tab&gt;
characters are encountered in the input, and the
**\(mib**
option is not specified, they shall be treated specially:

* &lt;backspace&gt;  
  The current count of line width shall be decremented by one, although
  the count never shall become negative. The
  _fold_
  utility shall not insert a
  &lt;newline&gt;
  immediately before or after any
  &lt;backspace&gt;,
  unless the following character has a width greater than 1 and would
  cause the line width to exceed
  _width_.
* &lt;carriage-return&gt;    
  The current count of line width shall be set to zero. The
  _fold_
  utility shall not insert a
  &lt;newline&gt;
  immediately before or after any
  &lt;carriage-return&gt;.
* &lt;tab&gt;  
  Each
  &lt;tab&gt;
  encountered shall advance the column position pointer to the next tab
  stop. Tab stops shall be at each column position
  _n_
  such that
  _n_
  modulo 8 equals 1.

<a name="options"></a>

# Options

The
_fold_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(mib**  
  Count
  _width_
  in bytes rather than column positions.
* **\(mis**  
  If a segment of a line contains a
  &lt;blank&gt;
  within the first
  _width_
  column positions (or bytes), break the line after the last such
  &lt;blank&gt;
  meeting the width constraints. If there is no
  &lt;blank&gt;
  meeting the requirements, the
  **\(mis**
  option shall have no effect for that output segment of the input line.
* **\(miw&nbsp;width**  
  Specify the maximum line length, in column positions (or bytes if
  **\(mib**
  is specified). The results are unspecified if
  _width_
  is not a positive decimal number. The default value shall be 80.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _file_  
  A pathname of a text file to be folded. If no
  _file_
  operands are specified, the standard input shall be used.

<a name="stdin"></a>

# Stdin

The standard input shall be used if no
_file_
operands are specified, and shall be used if a
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
**\(mib**
option is specified, the input files shall be text files except that the
lines are not limited to
{LINE_MAX}
bytes in length. If the
**\(mib**
option is not specified, the input files shall be text files.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_fold_:

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
  multi-byte characters in arguments and input files), and for the
  determination of the width in column positions each character would
  occupy on a constant-width font output device.
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

The standard output shall be a file containing a sequence of characters
whose order shall be preserved from the input files, possibly with
inserted
&lt;newline&gt;
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
  All input files were processed successfully.
* &gt;0  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

The
_cut_
and
_fold_
utilities can be used to create text files out of files with arbitrary
line lengths. The
_cut_
utility should be used when the number of lines (or records) needs to
remain constant. The
_fold_
utility should be used when the contents of long lines need to be kept
contiguous.

The
_fold_
utility is frequently used to send text files to printers that
truncate, rather than fold, lines wider than the printer is able to
print (usually 80 or 132 column positions).

<a name="examples"></a>

# Examples

An example invocation that submits a file of possibly long lines to the
printer (under the assumption that the user knows the line width of the
printer to be assigned by
_lp_):

    
    fold (miw 132 bigfile | lp


<a name="rationale"></a>

# Rationale

Although terminal input in canonical processing mode requires the erase
character (frequently set to
&lt;backspace&gt;)
to erase the previous character (not byte or column position), terminal
output is not buffered and is extremely difficult, if not impossible,
to parse correctly; the interpretation depends entirely on the physical
device that actually displays/prints/stores the output. In all known
internationalized implementations, the utilities producing output for
mixed column-width output assume that a
&lt;backspace&gt;
character backs up one column position and outputs enough
&lt;backspace&gt;
characters to return to the start of the character when
&lt;backspace&gt;
is used to provide local line motions to support underlining and
emboldening operations. Since
_fold_
without the
**\(mib**
option is dealing with these same constraints,
&lt;backspace&gt;
is always treated as backing up one column position rather than backing
up one character.

Historical versions of the
_fold_
utility assumed 1 byte was one character and occupied one column
position when written out. This is no longer always true. Since the
most common usage of
_fold_
is believed to be folding long lines for output to limited-length
output devices, this capability was preserved as the default case. The
**\(mib**
option was added so that applications could
_fold_
files with arbitrary length lines into text files that could then be
processed by the standard utilities. Note that although the width for
the
**\(mib**
option is in bytes, a line is never split in the middle of a character.
(It is unspecified what happens if a width is specified that is too
small to hold a single character found in the input followed by a
&lt;newline&gt;.)

The tab stops are hardcoded to be every eighth column to meet
historical practice. No new method of specifying other tab stops was
invented.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__cut_\^_

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
