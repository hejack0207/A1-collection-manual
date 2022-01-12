# cut(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

cut
— cut out selected fields of each line of a file

<a name="synopsis"></a>

# Synopsis

```


```
    cut (mib list [(min] [file...]
    
    cut (mic list [file...]
    
    cut (mif list [(mid delim] [(mis] [file...]

<a name="description"></a>

# Description

The
_cut_
utility shall cut out bytes (\c
**\(mib**
option), characters (\c
**\(mic**
option), or character-delimited fields (\c
**\(mif**
option) from each line in one or more files, concatenate them, and
write them to standard output.

<a name="options"></a>

# Options

The
_cut_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The application shall ensure that the option-argument
_list_
(see options
**\(mib**,
**\(mic**,
and
**\(mif**
below) is a
&lt;comma&gt;-separated
list or
&lt;blank&gt;-separated
list of positive numbers and ranges. Ranges can be in three forms. The
first is two positive numbers separated by a
&lt;hyphen&gt;
(\c
_low_\(mi\c
_high_),
which represents all fields from the first number to the second
number. The second is a positive number preceded by a
&lt;hyphen&gt;
(\(mi\c
_high_),
which represents all fields from field number 1 to that number. The
third is a positive number followed by a
&lt;hyphen&gt;
(\c
_low_\(mi),
which represents that number to the last field, inclusive. The elements
in
_list_
can be repeated, can overlap, and can be specified in any order, but
the bytes, characters, or fields selected shall be written in the order
of the input data. If an element appears in the selection list more
than once, it shall be written exactly once.

The following options shall be supported:

* **\(mib&nbsp;list**  
  Cut based on a
  _list_
  of bytes. Each selected byte shall be output unless the
  **\(min**
  option is also specified. It shall not be an error to select bytes not
  present in the input line.
* **\(mic&nbsp;list**  
  Cut based on a
  _list_
  of characters. Each selected character shall be output. It shall not
  be an error to select characters not present in the input line.
* **\(mid&nbsp;delim**  
  Set the field delimiter to the character
  _delim_.
  The default is the
  &lt;tab&gt;.
* **\(mif&nbsp;list**  
  Cut based on a
  _list_
  of fields, assumed to be separated in the file by a delimiter character
  (see
  **\(mid**).
  Each selected field shall be output. Output fields shall be separated
  by a single occurrence of the field delimiter character. Lines with no
  field delimiters shall be passed through intact, unless
  **\(mis**
  is specified. It shall not be an error to select fields not present in
  the input line.
* **\(min**  
  Do not split characters. When specified with the
  **\(mib**
  option, each element in
  _list_
  of the form
  _low_\(mi\c
  _high_
  (\c
  &lt;hyphen&gt;-separated
  numbers) shall be modified as follows:
    *  *  
      If the byte selected by
      _low_
      is not the first byte of a character,
      _low_
      shall be decremented to select the first byte of the character
      originally selected by
      _low_.
      If the byte selected by
      _high_
      is not the last byte of a character,
      _high_
      shall be decremented to select the last byte of the character prior to
      the character originally selected by
      _high_,
      or zero if there is no prior character. If the resulting range element
      has
      _high_
      equal to zero or
      _low_
      greater than
      _high_,
      the list element shall be dropped from
      _list_
      for that input line without causing an error.

Each element in
_list_
of the form
_low_\(mi
shall be treated as above with
_high_
set to the number of bytes in the current line, not including the
terminating
&lt;newline&gt;.
Each element in
_list_
of the form \(mi\c
_high_
shall be treated as above with
_low_
set to 1. Each element in
_list_
of the form
_num_
(a single number) shall be treated as above with
_low_
set to
_num_
and
_high_
set to
_num_.

* **\(mis**  
  Suppress lines with no delimiter characters, when used with the
  **\(mif**
  option. Unless specified, lines with no delimiters shall be passed
  through untouched.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _file_  
  A pathname of an input file. If no
  _file_
  operands are specified, or if a
  _file_
  operand is
  **'\(mi'**,
  the standard input shall be used.

<a name="stdin"></a>

# Stdin

The standard input shall be used only if no
_file_
operands are specified, or if a
_file_
operand is
**'\(mi'**.
See the INPUT FILES section.

<a name="input-files"></a>

# Input Files

The input files shall be text files, except that line lengths shall be
unlimited.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_cut_:

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

The
_cut_
utility output shall be a concatenation of the selected bytes,
characters, or fields (one of the following):

    
    "%sen", <concatenation of bytes>
    
    "%sen", <concatenation of characters>
    
    "%sen", <concatenation of fields and field delimiters>


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
  All input files were output successfully.
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
utilities can be used to create text files out of files with
arbitrary line lengths. The
_cut_
utility should be used when the number of lines (or records) needs
to remain constant. The
_fold_
utility should be used when the contents of long lines need to be
kept contiguous.

Earlier versions of the
_cut_
utility worked in an environment where bytes and characters were
considered equivalent (modulo
&lt;backspace&gt;
and
&lt;tab&gt;
processing in some implementations). In the extended world of
multi-byte characters, the new
**\(mib**
option has been added. The
**\(min**
option (used with
**\(mib**)
allows it to be used to act on bytes rounded to character boundaries.
The algorithm specified for
**\(min**
guarantees that:

    
    cut (mib 1(mi500 (min file > file1
    cut (mib 501(mi (min file > file2


ends up with all the characters in
**file**
appearing exactly once in
**file1**
or
**file2**.
(There is, however, a
&lt;newline&gt;
in both
**file1**
and
**file2**
for each
&lt;newline&gt;
in
**file**.)

<a name="examples"></a>

# Examples

Examples of the option qualifier list:

* 1,4,7  
  Select the first, fourth, and seventh bytes, characters, or fields and
  field delimiters.
* 1\(mi3,8  
  Equivalent to 1,2,3,8.
* \(mi5,10  
  Equivalent to 1,2,3,4,5,10.
* 3\(mi  
  Equivalent to third to last, inclusive.

The
_low_\(mi\c
_high_
forms are not always equivalent when used with
**\(mib**
and
**\(min**
and multi-byte characters; see the description of
**\(min**.

The following command:

    
    cut (mid : (mif 1,6 /etc/passwd


reads the System V password file (user database) and produces lines of
the form:

    
    <user ID>:<home directory>


Most utilities in this volume of POSIX.1-2008 work on text files. The
_cut_
utility can be used to turn files with arbitrary line lengths into a
set of text files containing the same data. The
_paste_
utility can be used to create (or recreate) files with arbitrary line
lengths. For example, if
**file**
contains long lines:

    
    cut (mib 1(mi500 (min file > file1
    cut (mib 501(mi (min file > file2


creates
**file1**
(a text file) with lines no longer than 500 bytes (plus the
&lt;newline&gt;)
and
**file2**
that contains the remainder of the data from
**file**.
(Note that
**file2**
is not a text file if there are lines in
**file**
that are longer than 500 +
{LINE_MAX}
bytes.) The original file can be recreated from
**file1**
and
**file2**
using the command:

    
    paste (mid "e0" file1 file2 > file


<a name="rationale"></a>

# Rationale

Some historical implementations do not count
&lt;backspace&gt;
characters in determining character counts with the
**\(mic**
option. This may be useful for using
_cut_
for processing
_nroff_
output. It was deliberately decided not to have the
**\(mic**
option treat either
&lt;backspace&gt;
or
&lt;tab&gt;
characters in any special fashion. The
_fold_
utility does treat these characters specially.

Unlike other utilities, some historical implementations of
_cut_
exit after not finding an input file, rather than continuing to process
the remaining
_file_
operands. This behavior is prohibited by this volume of POSIX.1-2008, where only the exit
status is affected by this problem.

The behavior of
_cut_
when provided with either mutually-exclusive options or options that do
not work logically together has been deliberately left unspecified in
favor of global wording in
_Section 1.4_, _Utility Description Defaults_.

The OPTIONS section was changed in response to IEEE PASC Interpretation
1003.2 #149. The change represents historical practice on all known
systems. The original standard was ambiguous on the nature of the
output.

The
_list_
option-arguments are historically used to select the portions of the
line to be written, but do not affect the order of the data. For
example:

    
    echo abcdefghi | cut (mic6,2,4(mi7,1


yields
**"abdefg"**.

A proposal to enhance
_cut_
with the following option:

* **\(mio**  
  Preserve the selected field order. When this option is specified, each
  byte, character, or field (or ranges of such) shall be written in the
  order specified by the
  _list_
  option-argument, even if this requires multiple outputs of the same
  bytes, characters, or fields.

was rejected because this type of enhancement is outside the scope of
the IEEE&nbsp;P1003.2b draft standard.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Section 2.5_, _Parameters and Variables_,
__fold_\^_,
__grep_\^_,
__paste_\^_

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
