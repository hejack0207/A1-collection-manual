# csplit(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

csplit
— split files based on context

<a name="synopsis"></a>

# Synopsis

```


```
    csplit [(miks] [(mif prefix] [(min number] file arg...

<a name="description"></a>

# Description

The
_csplit_
utility shall read the file named by the
_file_
operand, write all or part of that file into other files as directed
by the
_arg_
operands, and write the sizes of the files.

<a name="options"></a>

# Options

The
_csplit_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(mif&nbsp;prefix**  
  Name the created files
  _prefix_\c
  **00**,
  _prefix_\c
  **01**,
  .\|.\|.,
  _prefixn_.
  The default is
  **xx00**
  .\|.\|.
  **xx**\c
  _n_.
  If the
  _prefix_
  argument would create a filename exceeding
  {NAME_MAX}
  bytes, an error shall result,
  _csplit_
  shall exit with a diagnostic message, and no files shall be created.
* **\(mik**  
  Leave previously created files intact. By default,
  _csplit_
  shall remove created files if an error occurs.
* **\(min&nbsp;number**  
  Use
  _number_
  decimal digits to form filenames for the file pieces. The default
  shall be 2.
* **\(mis**  
  Suppress the output of file size messages.

<a name="operands"></a>

# Operands

The following operands shall be supported:

* _file_  
  The pathname of a text file to be split. If
  _file_
  is
  **'\(mi'**,
  the standard input shall be used.

Each
_arg_
operand can be one of the following:

* /_rexp_/**[offset]**    
  A file shall be created using the content of the lines from the current
  line up to, but not including, the line that results from the
  evaluation of the regular expression with
  _offset_,
  if any, applied. The regular expression
  _rexp_
  shall follow the rules for basic regular expressions described in the Base Definitions volume of POSIX.1-2008,
  _Section 9.3_, _Basic Regular Expressions_.
  The application shall use the sequence
  **"\e/"**
  to specify a
  &lt;slash&gt;
  character within the
  _rexp_.
  The optional offset shall be a positive or negative integer value
  representing a number of lines. A positive integer value can be
  preceded by
  **'\(pl'**.
  If the selection of lines from an
  _offset_
  expression of this type would create a file with zero lines, or one
  with greater than the number of lines left in the input file, the
  results are unspecified. After the section is created, the current line
  shall be set to the line that results from the evaluation of the
  regular expression with any offset applied. If the current line is the
  first line in the file and a regular expression operation has not yet
  been performed, the pattern match of
  _rexp_
  shall be applied from the current line to the end of the file.
  Otherwise, the pattern match of
  _rexp_
  shall be applied from the line following the current line to the end of
  the file.
* %_rexp_%**[offset]**    
  Equivalent to /_rexp_/**[offset]**, except that no
  file shall be created for the selected section of the input file. The
  application shall use the sequence
  **"\e%"**
  to specify a
  &lt;percent-sign&gt;
  character within the
  _rexp_.
* _line\_no_  
  Create a file from the current line up to (but not including) the line
  number
  _line_no_.
  Lines in the file shall be numbered starting at one. The current line
  becomes
  _line_no_.
* {_num_}  
  Repeat operand. This operand can follow any of the operands described
  previously. If it follows a
  _rexp_
  type operand, that operand shall be applied
  _num_
  more times. If it follows a
  _line_no_
  operand, the file shall be split every
  _line_no_
  lines,
  _num_
  times, from that point.

An error shall be reported if an operand does not reference a line
between the current position and the end of the file.

<a name="stdin"></a>

# Stdin

See the INPUT FILES section.

<a name="input-files"></a>

# Input Files

The input file shall be a text file.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_csplit_:

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
  Determine the locale for the behavior of ranges, equivalence classes,
  and multi-character collating elements within regular expressions.
* _LC\_CTYPE_  
  Determine the locale for the interpretation of sequences of bytes of
  text data as characters (for example, single-byte as opposed to
  multi-byte characters in arguments and input files) and the behavior of
  character classes within regular expressions.
* _LC\_MESSAGES_    
  Determine the locale that should be used to affect the format and
  contents of diagnostic messages written to standard error.
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.

<a name="asynchronous-events"></a>

# Asynchronous Events

If the
**\(mik**
option is specified, created files shall be retained. Otherwise, the
default action occurs.

<a name="stdout"></a>

# Stdout

Unless the
**\(mis**
option is used, the standard output shall consist of one line per
file created, with a format as follows:

    
    "%den", <file size in bytes>


<a name="stderr"></a>

# Stderr

The standard error shall be used only for diagnostic messages.

<a name="output-files"></a>

# Output Files

The output files shall contain portions of the original input file;
otherwise, unchanged.

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

By default, created files shall be removed if an error occurs. When the
**\(mik**
option is specified, created files shall not be removed if an error
occurs.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

None.

<a name="examples"></a>

# Examples


*  1.  
  This example creates four files,
  **cobol00**
  .\|.\|.
  **cobol03**:

    
    csplit (mif cobol file '/procedure division/' /par5./ /par16./


After editing the split files, they can be recombined as follows:

    
    cat cobol0[0(mi3] > file


Note that this example overwrites the original file.

*  2.  
  This example would split the file after the first 99 lines, and every
  100 lines thereafter, up to 9\|999 lines; this is because lines in the
  file are numbered from 1 rather than zero, for historical reasons:

    
    csplit (mik file  100  {99}


*  3.  
  Assuming that
  **prog.c**
  follows the C-language coding convention of ending routines with a
  **'}'**
  at the beginning of the line, this example creates a file containing
  each separate C routine (up to 21) in
  **prog.c**:

    
    csplit (mik prog.c '%main(%'  '/^}/+1' {20}


<a name="rationale"></a>

# Rationale

The
**\(min**
option was added to extend the range of filenames that could be
handled.

Consideration was given to adding a
**\(mia**
flag to use the alphabetic filename generation used by the historical
_split_
utility, but the functionality added by the
**\(min**
option was deemed to make alphabetic naming unnecessary.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__sed_\^_,
__split_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Section 9.3_, _Basic Regular Expressions_,
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
