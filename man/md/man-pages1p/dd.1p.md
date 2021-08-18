# dd(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

dd
— convert and copy a file

<a name="synopsis"></a>

# Synopsis

```


```
    dd [operand...]

<a name="description"></a>

# Description

The
_dd_
utility shall copy the specified input file to the specified output
file with possible conversions using specific input and output block
sizes. It shall read the input one block at a time, using the
specified input block size; it shall then process the block of data
actually returned, which could be smaller than the requested block
size. It shall apply any conversions that have been specified and write
the resulting data to the output in blocks of the specified output
block size. If the
**bs**=\c
_expr_
operand is specified and no conversions other than
**sync**,
**noerror**,
or
**notrunc**
are requested, the data returned from each input block shall be written
as a separate output block; if the read returns less than a full block
and the
**sync**
conversion is not specified, the resulting output block shall be the
same size as the input block. If the
**bs**=\c
_expr_
operand is not specified, or a conversion other than
**sync**,
**noerror**,
or
**notrunc**
is requested, the input shall be processed and collected into
full-sized output blocks until the end of the input is reached.

The processing order shall be as follows:

*  1.  
  An input block is read.
*  2.  
  If the input block is shorter than the specified input block size and
  the
  **sync**
  conversion is specified, null bytes shall be appended to the input data
  up to the specified size. (If either
  **block**
  or
  **unblock**
  is also specified,
  &lt;space&gt;
  characters shall be appended instead of null bytes.) The remaining
  conversions and output shall include the pad characters as if they had
  been read from the input.
*  3.  
  If the
  **bs**=\c
  _expr_
  operand is specified and no conversion other than
  **sync**
  or
  **noerror**
  is requested, the resulting data shall be written to the output as a
  single block, and the remaining steps are omitted.
*  4.  
  If the
  **swab**
  conversion is specified, each pair of input data bytes shall be
  swapped. If there is an odd number of bytes in the input block, the
  last byte in the input record shall not be swapped.
*  5.  
  Any remaining conversions (\c
  **block**,
  **unblock**,
  **lcase**,
  and
  **ucase**)
  shall be performed. These conversions shall operate on the input data
  independently of the input blocking; an input or output fixed-length
  record may span block boundaries.
*  6.  
  The data resulting from input or conversion or both shall be aggregated
  into output blocks of the specified size. After the end of input is
  reached, any remaining output shall be written as a block without
  padding if
  **conv**=\c
  **sync**
  is not specified; thus, the final output block may be shorter than the
  output block size.

<a name="options"></a>

# Options

None.

<a name="operands"></a>

# Operands

All of the operands shall be processed before any input is read.
The following operands shall be supported:

* **if**=_file_  
  Specify the input pathname; the default is standard input.
* **of**=_file_  
  Specify the output pathname; the default is standard output. If the
  **seek**=\c
  _expr_
  conversion is not also specified, the output file shall be truncated
  before the copy begins if an explicit
  **of**=\c
  _file_
  operand is specified, unless
  **conv**=\c
  **notrunc**
  is specified. If
  **seek**=\c
  _expr_
  is specified, but
  **conv**=\c
  **notrunc**
  is not, the effect of the copy shall be to preserve the blocks in the
  output file over which
  _dd_
  seeks, but no other portion of the output file shall be preserved. (If
  the size of the seek plus the size of the input file is less than the
  previous size of the output file, the output file shall be shortened by
  the copy. If the input file is empty and either the size of the seek is
  greater than the previous size of the output file or the output file
  did not previously exist, the size of the output file shall be set to
  the file offset after the seek.)
* **ibs**=_expr_  
  Specify the input block size, in bytes, by
  _expr_
  (default is 512).
* **obs**=_expr_  
  Specify the output block size, in bytes, by
  _expr_
  (default is 512).
* **bs**=_expr_  
  Set both input and output block sizes to
  _expr_
  bytes, superseding
  **ibs**=
  and
  **obs**=.
  If no conversion other than
  **sync**,
  **noerror**,
  and
  **notrunc**
  is specified, each input block shall be copied to the output as a
  single block without aggregating short blocks.
* **cbs**=_expr_  
  Specify the conversion block size for
  **block**
  and
  **unblock**
  in bytes by
  _expr_
  (default is zero). If
  **cbs**=
  is omitted or given a value of zero, using
  **block**
  or
  **unblock**
  produces unspecified results.

The application shall ensure that this operand is also specified if the
**conv**=
operand is specified with a value of
**ascii**,
**ebcdic**,
or
**ibm**.
For a
**conv**=
operand with an
**ascii**
value, the input is handled as described for the
**unblock**
value, except that characters are converted to ASCII before any
trailing
&lt;space&gt;
characters are deleted. For
**conv**=
operands with
**ebcdic**
or
**ibm**
values, the input is handled as described for the
**block**
value except that the characters are converted to EBCDIC or IBM EBCDIC,
respectively, after any trailing
&lt;space&gt;
characters are added.

* **skip**=_n_  
  Skip
  _n_
  input blocks (using the specified input block size) before starting to
  copy. On seekable files, the implementation shall read the blocks or
  seek past them; on non-seekable files, the blocks shall be read and the
  data shall be discarded.
* **seek**=_n_  
  Skip
  _n_
  blocks (using the specified output block size) from the beginning of the
  output file before copying. On non-seekable files, existing blocks
  shall be read and space from the current end-of-file to the specified
  offset, if any, filled with null bytes; on seekable files, the
  implementation shall seek to the specified offset or read the blocks as
  described for non-seekable files.
* **count**=_n_  
  Copy only
  _n_
  input blocks.
* **conv**=_value**[**,value_&nbsp;.\|.\|.**]**    
  Where
  _value_s
  are
  &lt;comma&gt;-separated
  symbols from the following list:
    * **ascii**  
      Convert EBCDIC to ASCII; see
      _Table 4-7, ASCII to EBCDIC Conversion_.
    * **ebcdic**  
      Convert ASCII to EBCDIC; see
      _Table 4-7, ASCII to EBCDIC Conversion_.
    * **ibm**  
      Convert ASCII to a different EBCDIC set; see
      _Table 4-8, ASCII to IBM EBCDIC Conversion_.

The
**ascii**,
**ebcdic**,
and
**ibm**
values are mutually-exclusive.

* **block**  
  Treat the input as a sequence of
  &lt;newline&gt;-terminated
  or end-of-file-terminated variable-length records independent of the
  input block boundaries. Each record shall be converted to a record with
  a fixed length specified by the conversion block size. Any
  &lt;newline&gt;
  shall be removed from the input line;
  &lt;space&gt;
  characters shall be appended to lines that are shorter than their
  conversion block size to fill the block. Lines that are longer than
  the conversion block size shall be truncated to the largest number of
  characters that fit into that size; the number of truncated lines shall
  be reported (see the STDERR section).

The
**block**
and
**unblock**
values are mutually-exclusive.

* **unblock**  
  Convert fixed-length records to variable length. Read a number of bytes
  equal to the conversion block size (or the number of bytes remaining in
  the input, if less than the conversion block size), delete all trailing
  &lt;space&gt;
  characters, and append a
  &lt;newline&gt;.
* **lcase**  
  Map uppercase characters specified by the
  _LC_CTYPE_
  keyword
  **tolower**
  to the corresponding lowercase character. Characters for which no
  mapping is specified shall not be modified by this conversion.

The
**lcase**
and
**ucase**
symbols are mutually-exclusive.

* **ucase**  
  Map lowercase characters specified by the
  _LC_CTYPE_
  keyword
  **toupper**
  to the corresponding uppercase character. Characters for which no
  mapping is specified shall not be modified by this conversion.
* **swab**  
  Swap every pair of input bytes.
* **noerror**  
  Do not stop processing on an input error. When an input error occurs, a
  diagnostic message shall be written on standard error, followed by the
  current input and output block counts in the same format as used at
  completion (see the STDERR section). If the
  **sync**
  conversion is specified, the missing input shall be replaced with null
  bytes and processed normally; otherwise, the input block shall be
  omitted from the output.
* **notrunc**  
  Do not truncate the output file. Preserve blocks in the output
  file not explicitly written by this invocation of the
  _dd_
  utility. (See also the preceding
  **of**=\c
  _file_
  operand.)
* **sync**  
  Pad every input block to the size of the
  **ibs**=
  buffer, appending null bytes. (If either
  **block**
  or
  **unblock**
  is also specified, append
  &lt;space&gt;
  characters, rather than null bytes.)

The behavior is unspecified if operands other than
**conv**=
are specified more than once.

For the
**bs**=,
**cbs**=,
**ibs**=,
and
**obs**=
operands, the application shall supply an expression specifying a size
in bytes. The expression,
_expr_,
can be:

*  1.  
  A positive decimal number
*  2.  
  A positive decimal number followed by
  _k_,
  specifying multiplication by 1\|024
*  3.  
  A positive decimal number followed by
  _b_,
  specifying multiplication by 512
*  4.  
  Two or more positive decimal numbers (with or without
  _k_
  or
  _b_)
  separated by
  _x_,
  specifying the product of the indicated values

All of the operands are processed before any input is read.

The following two tables display the octal number character values used
for the
**ascii**
and
**ebcdic**
conversions (first table) and for the
**ibm**
conversion (second table). In both tables, the ASCII values are the row
and column headers and the EBCDIC values are found at their
intersections. For example, ASCII 0012 (LF) is the second row, third
column, yielding 0045 in EBCDIC. The inverted tables (for EBCDIC to
ASCII conversion) are not shown, but are in one-to-one correspondence
with these tables. The differences between the two tables are
highlighted by small boxes drawn around five entries.  

.ce 1
**Table 4-7: ASCII to EBCDIC Conversion**
.bp

.ce 1
**Table 4-8: ASCII to IBM EBCDIC Conversion**

<a name="stdin"></a>

# Stdin

If no
**if**=
operand is specified, the standard input shall be used. See the INPUT
FILES section.

<a name="input-files"></a>

# Input Files

The input file can be any file type.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_dd_:

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
  multi-byte characters in arguments and input files), the classification
  of characters as uppercase or lowercase, and the mapping of characters
  from one case to the other.
* _LC\_MESSAGES_    
  Determine the locale that should be used to affect the format and
  contents of diagnostic messages written to standard error and
  informative messages written to standard output.
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.

<a name="asynchronous-events"></a>

# Asynchronous Events

For SIGINT, the
_dd_
utility shall interrupt its current processing, write status
information to standard error, and exit as though terminated by
SIGINT. It shall take the standard action for all other signals; see
the ASYNCHRONOUS EVENTS section in
_Section 1.4_, _Utility Description Defaults_.

<a name="stdout"></a>

# Stdout

If no
**of**=
operand is specified, the standard output shall be used. The nature of
the output depends on the operands selected.

<a name="stderr"></a>

# Stderr

On completion,
_dd_
shall write the number of input and output blocks to standard error. In
the POSIX locale the following formats shall be used:

    
    "%u+%u records inen", <number of whole input blocks>,
        <number of partial input blocks>
    
    "%u+%u records outen", <number of whole output blocks>,
        <number of partial output blocks>


A partial input block is one for which
_read_()
returned less than the input block size. A partial output block is one
that was written with fewer bytes than specified by the output block
size.

In addition, when there is at least one truncated block, the number of
truncated blocks shall be written to standard error. In the POSIX
locale, the format shall be:

    
    "%u truncated %sen", <number of truncated blocks>, "record" (if
        <number of truncated blocks> is one) "records" (otherwise)


Diagnostic messages may also be written to standard error.

<a name="output-files"></a>

# Output Files

If the
**of**=
operand is used, the output shall be the same as described in the
STDOUT section.

<a name="extended-description"></a>

# Extended Description

None.

<a name="exit-status"></a>

# Exit Status

The following exit values shall be returned:

* \00  
  The input file was copied successfully.
* &gt;0  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

If an input error is detected and the
**noerror**
conversion has not been specified, any partial output block shall be
written to the output file, a diagnostic message shall be written, and
the copy operation shall be discontinued. If some other error is
detected, a diagnostic message shall be written and the copy operation
shall be discontinued.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

The input and output block size can be specified to take advantage of
raw physical I/O.

There are many different versions of the EBCDIC codesets. The ASCII and
EBCDIC conversions specified for the
_dd_
utility perform conversions for the version specified by the tables.

<a name="examples"></a>

# Examples

The following command:

    
    dd if=/dev/rmt0h  of=/dev/rmt1h


copies from tape drive 0 to tape drive 1, using a common historical
device naming convention.

The following command:

    
    dd ibs=10  skip=1


strips the first 10 bytes from standard input.

This example reads an EBCDIC tape blocked ten 80-byte EBCDIC card
images per block into the ASCII file
**x**:

    
    dd if=/dev/tape of=x ibs=800 cbs=80 conv=ascii,lcase


<a name="rationale"></a>

# Rationale

The OPTIONS section is listed as \`\`None'' because there are no options
recognized by historical
_dd_
utilities. Certainly, many of the operands could have been designed to
use the Utility Syntax Guidelines, which would have resulted in the
classic hyphenated option letters. In this version of this volume of POSIX.1-2008,
_dd_
retains its curious JCL-like syntax due to the large number of
applications that depend on the historical implementation.

A suggested implementation technique for
**conv**=\c
**noerror**,\c
**sync**
is to zero (or
&lt;space&gt;-fill,
if
**block**ing
or
**unblock**ing)
the input buffer before each read and to write the contents of the
input buffer to the output even after an error. In this manner, any
data transferred to the input buffer before the error was detected is
preserved. Another point is that a failed read on a regular file or a
disk generally does not increment the file offset, and
_dd_
must then seek past the block on which the error occurred; otherwise,
the input error occurs repetitively. When the input is a magnetic tape,
however, the tape normally has passed the block containing the error
when the error is reported, and thus no seek is necessary.

The default
**ibs**=
and
**obs**=
sizes are specified as 512 bytes because there are historical (largely
portable) scripts that assume these values. If they were left
unspecified, unusual results could occur if an implementation chose an
odd block size.

Historical implementations of
_dd_
used
_creat_()
when processing
**of**=\c
_file_.
This makes the
**seek**=
operand unusable except on special files. The
**conv**=\c
**notrunc**
feature was added because more recent BSD-based implementations use
_open_()
(without O_TRUNC) instead of
_creat_(),
but they fail to delete output file contents after the data copied.

The
_w_
multiplier (historically meaning
_word_),
is used in System V to mean 2 and in 4.2 BSD to mean 4. Since
_word_
is inherently non-portable, its use is not supported by this volume of POSIX.1-2008.

Standard EBCDIC does not have the characters
**'['**
and
**']'**.
The values used in the table are taken from a common print train that
does contain them. Other than those characters, the print train values
are not filled in, but appear to provide some of the motivation for the
historical choice of translations reflected here.

The Standard EBCDIC table provides a 1:1 translation for all 256
bytes.

The IBM EBCDIC table does not provide such a translation. The marked
cells in the tables differ in such a way that:

*  1.  
  EBCDIC 0112 (\c
  **'¢'**)
  and 0152 (broken pipe) do not appear in the table.
*  2.  
  EBCDIC 0137 (\c
  **'\(no'**)
  translates to/from ASCII 0236 (\c
  **'^'**).
  In the standard table, EBCDIC 0232 (no graphic) is used.
*  3.  
  EBCDIC 0241 (\c
  **'~'**)
  translates to/from ASCII 0176 (\c
  **'~'**).
  In the standard table, EBCDIC 0137 (\c
  **'\(no'**)
  is used.
*  4.  
  0255 (\c
  **'['**)
  and 0275 (\c
  **']'**)
  appear twice, once in the same place as for the standard table and once
  in place of 0112 (\c
  **'¢'**)
  and 0241 (\c
  **'~'**).

In net result:

EBCDIC 0275 (\c
**']'**)
displaced EBCDIC 0241 (\c
**'~'**)
in cell 0345.

\0\0\0\0That displaced EBCDIC 0137 (\c
**'\(no'**)
in cell 0176.

\0\0\0\0That displaced EBCDIC 0232 (no graphic) in cell 0136.

\0\0\0\0That replaced EBCDIC 0152 (broken pipe) in cell 0313.

EBCDIC 0255 (\c
**'['**)
replaced EBCDIC 0112 (\c
**'¢'**).

This translation, however, reflects historical practice that (ASCII)
**'~'**
and
**'\(no'**
were often mapped to each other, as were
**'['**
and
**'¢'**;
and
**']'**
and (EBCDIC)
**'~'**.

The
**cbs**
operand is required if any of the
**ascii**,
**ebcdic**,
or
**ibm**
operands are specified. For the
**ascii**
operand, the input is handled as described for the
**unblock**
operand except that characters are converted to ASCII before the
trailing
&lt;space&gt;
characters are deleted. For the
**ebcdic**
and
**ibm**
operands, the input is handled as described for the
**block**
operand except that the characters are converted to EBCDIC or IBM
EBCDIC after the trailing
&lt;space&gt;
characters are added.

The
**block**
and
**unblock**
keywords are from historical BSD practice.

The consistent use of the word
**record**
in standard error messages matches most historical practice. An
earlier version of System V used
**block**,
but this has been updated in more recent releases.

Early proposals only allowed two numbers separated by
**x**
to be used in a product when specifying
**bs**=,
**cbs**=,
**ibs**=,
and
**obs**=
sizes. This was changed to reflect the historical practice of allowing
multiple numbers in the product as provided by Version 7 and all
releases of System V and BSD.

A change to the
**swab**
conversion is required to match historical practice and is the result
of IEEE PASC Interpretations 1003.2 #03 and #04, submitted for the
ISO&nbsp;POSIX-2:\|1993 standard.

A change to the handling of SIGINT is required to match historical
practice and is the result of IEEE PASC Interpretation 1003.2 #06
submitted for the ISO&nbsp;POSIX-2:\|1993 standard.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Section 1.4_, _Utility Description Defaults_,
__sed_\^_,
__tr_\^_

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
