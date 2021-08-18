# iconv(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

iconv
— codeset conversion

<a name="synopsis"></a>

# Synopsis

```


```
    iconv [(mics] (mif frommap (mit tomap [file...]
    
    iconv (mif fromcode [(mics] [(mit tocode] [file...]
    
    iconv (mit tocode [(mics] [(mif fromcode] [file...]
    
    iconv (mil

<a name="description"></a>

# Description

The
_iconv_
utility shall convert the encoding of characters in
_file_
from one codeset to another and write the results to standard output.

When the options indicate that charmap files are used to specify the
codesets (see OPTIONS), the codeset conversion shall be accomplished by
performing a logical join on the symbolic character names in the two
charmaps. The implementation need not support the use of charmap files
for codeset conversion unless the POSIX2_LOCALEDEF symbol is defined on
the system.

<a name="options"></a>

# Options

The
_iconv_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(mic**  
  Omit any characters that are invalid in the codeset of the input file
  from the output. When
  **\(mic**
  is not used, the results of encountering invalid characters in the
  input stream (either those that are not characters in the codeset of
  the input file or that have no corresponding character in the codeset
  of the output file) shall be specified in the system documentation. The
  presence or absence of
  **\(mic**
  shall not affect the exit status of
  _iconv_.
* **\(mif&nbsp;fromcodeset**    
  Identify the codeset of the input file. The implementation shall
  recognize the following two forms of the
  _fromcodeset_
  option-argument:
    * _fromcode_  
      The
      _fromcode_
      option-argument must not contain a
      &lt;slash&gt;
      character. It shall be interpreted as the name of one of the codeset
      descriptions provided by the implementation in an unspecified
      format. Valid values of
      _fromcode_
      are implementation-defined.
    * _frommap_  
      The
      _frommap_
      option-argument must contain a
      &lt;slash&gt;
      character. It shall be interpreted as the pathname of a charmap file as
      defined in the Base Definitions volume of POSIX.1-2008,
      _Section 6.4_, _Character Set Description File_.
      If the pathname does not represent a valid, readable charmap file,
      the results are undefined.

If this option is omitted, the codeset of the current locale shall
be used.

* **\(mil**  
  Write all supported
  _fromcode_
  and
  _tocode_
  values to standard output in an unspecified format.
* **\(mis**  
  Suppress any messages written to standard error concerning invalid
  characters. When
  **\(mis**
  is not used, the results of encountering invalid characters in the
  input stream (either those that are not valid characters in the codeset
  of the input file or that have no corresponding character in the
  codeset of the output file) shall be specified in the system
  documentation. The presence or absence of
  **\(mis**
  shall not affect the exit status of
  _iconv_.
* **\(mit&nbsp;tocodeset**  
  Identify the codeset to be used for the output file. The implementation
  shall recognize the following two forms of the
  _tocodeset_
  option-argument:
    * _tocode_  
      The semantics shall be equivalent to the
      **\(mif**
      _fromcode_
      option.
    * _tomap_  
      The semantics shall be equivalent to the
      **\(mif**
      _frommap_
      option.

If this option is omitted, the codeset of the current locale shall be
used.

If either
**\(mif**
or
**\(mit**
represents a charmap file, but the other does not (or is omitted), or
both
**\(mif**
and
**\(mit**
are omitted, the results are undefined.

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

<a name="input-files"></a>

# Input Files

The input file shall be a text file.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_iconv_:

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
  multi-byte characters in arguments). During translation of the file,
  this variable is superseded by the use of the
  _fromcode_
  option-argument.
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

When the
**\(mil**
option is used, the standard output shall contain all supported
_fromcode_
and
_tocode_
values, written in an unspecified format.

When the
**\(mil**
option is not used, the standard output shall contain the sequence of
characters read from the input files, translated to the specified
codeset. Nothing else shall be written to the standard output.

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

The user must ensure that both charmap files use the same symbolic
names for characters the two codesets have in common.

<a name="examples"></a>

# Examples

The following example converts the contents of file
**mail.x400**
from the ISO/IEC&nbsp;6937:\|2001 standard codeset to the ISO/IEC&nbsp;8859-1:\|1998 standard codeset, and stores the results in
file
**mail.local**:

    
    iconv (mif IS6937 (mit IS8859 mail.x400 > mail.local


<a name="rationale"></a>

# Rationale

The
_iconv_
utility can be used portably only when the user provides two charmap
files as option-arguments. This is because a single charmap provided by
the user cannot reliably be joined with the names in a system-provided
character set description. The valid values for
_fromcode_
and
_tocode_
are implementation-defined and do not have to have any relation to
the charmap mechanisms. As an aid to interactive users, the
**\(mil**
option was adopted from the Plan 9 operating system. It writes
information concerning these implementation-defined values. The
format is unspecified because there are many possible useful formats
that could be chosen, such as a matrix of valid combinations of
_fromcode_
and
_tocode_.
The
**\(mil**
option is not intended for shell script usage; conforming applications
will have to use charmaps.

The
_iconv_
utility may support the conversion between ASCII and EBCDIC-based
encodings, but is not required to do so. In an XSI-compliant
implementation, the
_dd_
utility is the only method guaranteed to support conversion between
these two character sets.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__dd_\^_,
__gencat_\^_

The Base Definitions volume of POSIX.1-2008,
_Section 6.4_, _Character Set Description File_,
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
