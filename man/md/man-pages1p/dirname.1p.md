# dirname(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

dirname
— return the directory portion of a pathname

<a name="synopsis"></a>

# Synopsis

```


```
    dirname string

<a name="description"></a>

# Description

The
_string_
operand shall be treated as a pathname, as defined in the Base Definitions volume of POSIX.1-2008,
_Section 3.267_, _Pathname_.
The string
_string_
shall be converted to the name of the directory containing the
filename corresponding to the last pathname component in
_string_,
performing actions equivalent to the following steps in order:

*  1.  
  If
  _string_
  is
  **//**,
  skip steps 2 to 5.
*  2.  
  If
  _string_
  consists entirely of
  &lt;slash&gt;
  characters,
  _string_
  shall be set to a single
  &lt;slash&gt;
  character. In this case, skip steps 3 to 8.
*  3.  
  If there are any trailing
  &lt;slash&gt;
  characters in
  _string_,
  they shall be removed.
*  4.  
  If there are no
  &lt;slash&gt;
  characters remaining in
  _string_,
  _string_
  shall be set to a single
  &lt;period&gt;
  character. In this case, skip steps 5 to 8.
*  5.  
  If there are any trailing non-\c
  &lt;slash&gt;
  characters in
  _string_,
  they shall be removed.
*  6.  
  If the remaining
  _string_
  is
  **//**,
  it is implementation-defined whether steps 7 and 8 are skipped or
  processed.
*  7.  
  If there are any trailing
  &lt;slash&gt;
  characters in
  _string_,
  they shall be removed.
*  8.  
  If the remaining
  _string_
  is empty,
  _string_
  shall be set to a single
  &lt;slash&gt;
  character.

The resulting string shall be written to standard output.

<a name="options"></a>

# Options

None.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _string_  
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
_dirname_:

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
_dirname_
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

.TS
center tab(@) box;
cB | cB
l | l.
Command@Results
_
_dirname_ /@/
_dirname_ //@/ or //
_dirname_ /_a_/_b_/@/_a_
_dirname_ //_a_//_b_//@//_a_
_dirname_@Unspecified
_dirname a_@. ($? = 0)
_dirname_ ""@. ($? = 0)
_dirname_ /_a_@/
_dirname_ /_a_/_b_@/_a_
_dirname_ _a_/_b_@_a_
.TE

See also the examples for the
_basename_
utility.

<a name="rationale"></a>

# Rationale

The
_dirname_
utility originated in System III. It has evolved through the System V
releases to a version that matches the requirements specified in this
description in System V Release 3. 4.3 BSD and earlier versions did
not include
_dirname_.

The behaviors of
_basename_
and
_dirname_
in this volume of POSIX.1-2008 have been coordinated so that when
_string_
is a valid pathname:

    
    $(basename -- "string")


would be a valid filename for the file in the directory:

    
    $(dirname -- "string")


This would not work for the versions of these utilities in early proposals
due to the way processing of trailing
&lt;slash&gt;
characters was specified. Consideration was given to leaving processing
unspecified if there were trailing
&lt;slash&gt;
characters, but this cannot be done; the Base Definitions volume of POSIX.1-2008,
_Section 3.267_, _Pathname_
allows trailing
&lt;slash&gt;
characters. The
_basename_
and
_dirname_
utilities have to specify consistent handling for all valid pathnames.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Section 2.5_, _Parameters and Variables_,
__basename_\^_

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
