# basename(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

basename
— return non-directory portion of a pathname

<a name="synopsis"></a>

# Synopsis

```


```
    basename string [suffix]

<a name="description"></a>

# Description

The
_string_
operand shall be treated as a pathname, as defined in the Base Definitions volume of POSIX.1-2008,
_Section 3.267_, _Pathname_.
The string
_string_
shall be converted to the filename corresponding to the last pathname
component in
_string_
and then the suffix string
_suffix_,
if present, shall be removed. This shall be done by performing actions
equivalent to the following steps in order:

*  1.  
  If
  _string_
  is a null string, it is unspecified whether the resulting string is
  **'.'**
  or a null string. In either case, skip steps 2 through 6.
*  2.  
  If
  _string_
  is
  **"//"**,
  it is implementation-defined whether steps 3 to 6 are skipped or
  processed.
*  3.  
  If
  _string_
  consists entirely of
  &lt;slash&gt;
  characters,
  _string_
  shall be set to a single
  &lt;slash&gt;
  character. In this case, skip steps 4 to 6.
*  4.  
  If there are any trailing
  &lt;slash&gt;
  characters in
  _string_,
  they shall be removed.
*  5.  
  If there are any
  &lt;slash&gt;
  characters remaining in
  _string_,
  the prefix of
  _string_
  up to and including the last
  &lt;slash&gt;
  character in
  _string_
  shall be removed.
*  6.  
  If the
  _suffix_
  operand is present, is not identical to the characters remaining in
  _string_,
  and is identical to a suffix of the characters remaining in
  _string_,
  the suffix
  _suffix_
  shall be removed from
  _string_.
  Otherwise,
  _string_
  is not modified by this step. It shall not be considered an error if
  _suffix_
  is not found in
  _string_.

The resulting string shall be written to standard output.

<a name="options"></a>

# Options

None.

<a name="operands"></a>

# Operands

The following operands shall be supported:

* _string_  
  A string.
* _suffix_  
  A string.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_basename_:

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
  multi-byte characters in arguments).
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
_basename_
utility shall write a line to the standard output in the following
format:

    
    "%sen", <resulting string>


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

The definition of
_pathname_
specifies implementation-defined behavior for pathnames starting with
two
&lt;slash&gt;
characters. Therefore, applications shall not arbitrarily add
&lt;slash&gt;
characters to the beginning of a pathname unless they can ensure
that there are more or less than two or are prepared to deal with the
implementation-defined consequences.

<a name="examples"></a>

# Examples

If the string
_string_
is a valid pathname:

    
    $(basename -- "string")


produces a filename that could be used to open the file named by
_string_
in the directory returned by:

    
    $(dirname -- "string")


If the string
_string_
is not a valid pathname, the same algorithm is used, but the result
need not be a valid filename. The
_basename_
utility is not expected to make any judgements about the validity of
_string_
as a pathname; it just follows the specified algorithm to produce a
result string.

The following shell script compiles
**/usr/src/cmd/cat.c**
and moves the output to a file named
**cat**
in the current directory when invoked with the argument
**/usr/src/cmd/cat**
or with the argument
**/usr/src/cmd/cat.c**:

    
    c99 -- "$(dirname -- "$1")/$(basename -- "$1" .c).c" &&
    mv a.out "$(basename -- "$1" .c)"


<a name="rationale"></a>

# Rationale

The behaviors of
_basename_
and
_dirname_
have been coordinated so that when
_string_
is a valid pathname:

    
    $(basename -- "string")


would be a valid filename for the file in the directory:

    
    $(dirname -- "string")


This would not work for the early proposal versions of these utilities due
to the way it specified handling of trailing
&lt;slash&gt;
characters.

Since the definition of
_pathname_
specifies implementation-defined behavior for pathnames starting with
two
&lt;slash&gt;
characters, this volume of POSIX.1-2008 specifies similar implementation-defined behavior
for the
_basename_
and
_dirname_
utilities.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Section 2.5_, _Parameters and Variables_,
__dirname_\^_

The Base Definitions volume of POSIX.1-2008,
_Section 3.267_, _Pathname_,
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
