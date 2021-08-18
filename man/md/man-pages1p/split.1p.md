# split(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

split
— split files into pieces

<a name="synopsis"></a>

# Synopsis

```


```
    split [(mil line_count] [(mia suffix_length] [file[name]]
    
    split (mib n[k|m] [(mia suffix_length] [file[name]]

<a name="description"></a>

# Description

The
_split_
utility shall read an input file and write one or more output files.
The default size of each output file shall be 1\|000 lines. The size
of the output files can be modified by specification of the
**\(mib**
or
**\(mil**
options. Each output file shall be created with a unique suffix. The
suffix shall consist of exactly
_suffix_length_
lowercase letters from the POSIX locale. The letters of the suffix
shall be used as if they were a base-26 digit system, with the first
suffix to be created consisting of all
**'a'**
characters, the second with a
**'b'**
replacing the last
**'a'**,
and so on, until a name of all
**'z'**
characters is created. By default, the names of the output files shall
be
**'x'**,
followed by a two-character suffix from the character set as described
above, starting with
**"aa"**,
**"ab"**,
**"ac"**,
and so on, and continuing until the suffix
**"zz"**,
for a maximum of 676 files.

If the number of files required exceeds the maximum allowed by the
suffix length provided, such that the last allowable file would be
larger than the requested size, the
_split_
utility shall fail after creating the last file with a valid suffix;
_split_
shall not delete the files it created with valid suffixes. If the file
limit is not exceeded, the last file created shall contain the
remainder of the input file, and may be smaller than the requested
size.

<a name="options"></a>

# Options

The
_split_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(mia&nbsp;suffix\_length**    
  Use
  _suffix_length_
  letters to form the suffix portion of the filenames of the split
  file. If
  **\(mia**
  is not specified, the default suffix length shall be two. If the sum
  of the
  _name_
  operand and the
  _suffix_length_
  option-argument would create a filename exceeding
  {NAME_MAX}
  bytes, an error shall result;
  _split_
  shall exit with a diagnostic message and no files shall be created.
* **\(mib&nbsp;n**  
  Split a file into pieces
  _n_
  bytes in size.
* **\(mib&nbsp;nk**  
  Split a file into pieces
  _n_*1\|024
  bytes in size.
* **\(mib&nbsp;nm**  
  Split a file into pieces
  _n_*1\|048\|576
  bytes in size.
* **\(mil&nbsp;line\_count**  
  Specify the number of lines in each resulting file piece. The
  _line_count_
  argument is an unsigned decimal integer. The default is 1\|000. If
  the input does not end with a
  &lt;newline&gt;,
  the partial line shall be included in the last output file.

<a name="operands"></a>

# Operands

The following operands shall be supported:

* _file_  
  The pathname of the ordinary file to be split. If no input file is
  given or
  _file_
  is
  **'\(mi'**,
  the standard input shall be used.
* _name_  
  The prefix to be used for each of the files resulting from the split
  operation. If no
  _name_
  argument is given,
  **'x'**
  shall be used as the prefix of the output files. The combined length
  of the basename of
  _prefix_
  and
  _suffix_length_
  cannot exceed
  {NAME_MAX}
  bytes. See the OPTIONS section.

<a name="stdin"></a>

# Stdin

See the INPUT FILES section.

<a name="input-files"></a>

# Input Files

Any file can be used as input.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_split_:

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

Not used.

<a name="stderr"></a>

# Stderr

The standard error shall be used only for diagnostic messages.

<a name="output-files"></a>

# Output Files

The output files contain portions of the original input file; otherwise,
unchanged.

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

In the following examples
**foo**
is a text file that contains 5\|000 lines.

*  1.  
  Create five files,
  **xaa**,
  **xab**,
  **xac**,
  **xad**,
  and
  **xae**:

    
    split foo


*  2.  
  Create five files, but the suffixed portion of the created
  files consists of three letters,
  **xaaa**,
  **xaab**,
  **xaac**,
  **xaad**,
  and
  **xaae**:

    
    split (mia 3 foo


*  3.  
  Create three files with four-letter suffixes and a supplied prefix,
  **bar_aaaa**,
  **bar_aaab**,
  and
  **bar_aaac**:

    
    split (mia 4 (mil 2000 foo bar_


*  4.  
  Create as many files as are necessary to contain at most 20*1\|024
  bytes, each with the default prefix of
  **x**
  and a five-letter suffix:

    
    split (mia 5 (mib 20k foo


<a name="rationale"></a>

# Rationale

The
**\(mib**
option was added to provide a mechanism for splitting files other than
by lines. While most uses of the
**\(mib**
option are for transmitting files over networks, some believed it would
have additional uses.

The
**\(mia**
option was added to overcome the limitation of being able to create
only 676 files.

Consideration was given to deleting this utility, using the rationale
that the functionality provided by this utility is available via the
_csplit_
utility (see
__csplit_\^_).
Upon reconsideration of the purpose of the User Portability Utilities
option, it was decided to retain both this utility and the
_csplit_
utility because users use both utilities and have historical
expectations of their behavior. Furthermore, the splitting on byte
boundaries in
_split_
cannot be duplicated with the historical
_csplit_.

The text \`\`\c
_split_
shall not delete the files it created with valid suffixes'' would
normally be assumed, but since the related utility,
_csplit_,
does delete files under some circumstances, the historical behavior of
_split_
is made explicit to avoid misinterpretation.

Earlier versions of this standard allowed a
**\(mi**\c
_line_count_
option. This form is no longer specified by POSIX.1-2008 but may be
present in some implementations.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__csplit_\^_

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
