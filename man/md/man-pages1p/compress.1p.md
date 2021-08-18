# compress(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

compress
— compress data

<a name="synopsis"></a>

# Synopsis

```


```
    compress [(mifv] [(mib bits] [file...]
    
    compress [(micfv] [(mib bits] [file]

<a name="description"></a>

# Description

The
_compress_
utility shall attempt to reduce the size of the named files by using
adaptive Lempel-Ziv coding algorithm.

* **Note:**  
  Lempel-Ziv is US Patent 4464650, issued to William Eastman, Abraham
  Lempel, Jacob Ziv, Martin Cohn on August 7th, 1984, and assigned to
  Sperry Corporation.

Lempel-Ziv-Welch compression is covered by US Patent 4558302, issued to
Terry A. Welch on December 10th, 1985, and assigned to Sperry
Corporation.

On systems not supporting adaptive Lempel-Ziv coding algorithm, the
input files shall not be changed and an error value greater than two
shall be returned. Except when the output is to the standard output,
each file shall be replaced by one with the extension
**.Z**.
If the invoking process has appropriate privileges, the ownership,
modes, access time, and modification time of the original file are
preserved. If appending the
**.Z**
to the filename would make the name exceed
{NAME_MAX}
bytes, the command shall fail. If no files are specified, the standard
input shall be compressed to the standard output.

<a name="options"></a>

# Options

The
_compress_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(mib&nbsp;bits**  
  Specify the maximum number of bits to use in a code. For a conforming
  application, the
  _bits_
  argument shall be:

    
    9 <= bits <= 14


The implementation may allow
_bits_
values of greater than 14. The default is 14, 15, or 16.

* **\(mic**  
  Cause
  _compress_
  to write to the standard output; the input file is not changed, and no
  **.Z**
  files are created.
* **\(mif**  
  Force compression of
  _file_,
  even if it does not actually reduce the size of the file, or if the
  corresponding
  _file_\c
  **.Z**
  file already exists. If the
  **\(mif**
  option is not given, and the process is not running in the background,
  the user is prompted as to whether an existing
  _file_\c
  **.Z**
  file should be overwritten. If the response is affirmative, the existing
  file will be overwritten.
* **\(miv**  
  Write the percentage reduction of each file to standard error.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _file_  
  A pathname of a file to be compressed.

<a name="stdin"></a>

# Stdin

The standard input shall be used only if no
_file_
operands are specified, or if a
_file_
operand is
**'\(mi'**.

<a name="input-files"></a>

# Input Files

If
_file_
operands are specified, the input files contain the data to be
compressed.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_compress_:

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
  and multi-character collating elements used in the extended regular
  expression defined for the
  **yesexpr**
  locale keyword in the
  _LC_MESSAGES_
  category.
* _LC\_CTYPE_  
  Determine the locale for the interpretation of sequences of bytes of text
  data as characters (for example, single-byte as opposed to multi-byte
  characters in arguments), the behavior of character classes used in the
  extended regular expression defined for the
  **yesexpr**
  locale keyword in the
  _LC_MESSAGES_
  category.
* _LC\_MESSAGES_    
  Determine the locale used to process affirmative responses, and the
  locale used to affect the format and contents of diagnostic messages,
  prompts, and the output from the
  **\(miv**
  option written to standard error.
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

If no
_file_
operands are specified, or if a
_file_
operand is
**'\(mi'**,
or if the
**\(mic**
option is specified, the standard output contains the compressed
output.

<a name="stderr"></a>

# Stderr

The standard error shall be used only for diagnostic and prompt
messages and the output from
**\(miv**.

<a name="output-files"></a>

# Output Files

The output files shall contain the compressed output. The format of
compressed files is unspecified and interchange of such files between
implementations (including access via unspecified file sharing
mechanisms) is not required by POSIX.1-2008.

<a name="extended-description"></a>

# Extended Description

None.

<a name="exit-status"></a>

# Exit Status

The following exit values shall be returned:

* \00  
  Successful completion.
* \01  
  An error occurred.
* \02  
  One or more files were not compressed because they would have increased
  in size (and the
  **\(mif**
  option was not specified).
* &gt;2  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

The input file shall remain unmodified.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

The amount of compression obtained depends on the size of the input,
the number of
_bits_
per code, and the distribution of common substrings. Typically, text
such as source code or English is reduced by 50-60%. Compression is
generally much better than that achieved by Huffman coding
or adaptive Huffman coding (\c
_compact_),
and takes less time to compute.

Although
_compress_
strictly follows the default actions upon receipt of a signal or when
an error occurs, some unexpected results may occur. In some
implementations it is likely that a partially compressed file is left
in place, alongside its uncompressed input file. Since the general
operation of
_compress_
is to delete the uncompressed file only after the
**.Z**
file has been successfully filled, an application should always
carefully check the exit status of
_compress_
before arbitrarily deleting files that have like-named neighbors with
**.Z**
suffixes.

The limit of 14 on the
_bits_
option-argument is to achieve portability to all systems (within the
restrictions imposed by the lack of an explicit published file
format). Some implementations based on 16-bit architectures cannot
support 15 or 16-bit uncompression.

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

__uncompress_\^_,
__zcat_\^_

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
