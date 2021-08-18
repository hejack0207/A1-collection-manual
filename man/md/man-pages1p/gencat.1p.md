# gencat(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

gencat
— generate a formatted message catalog

<a name="synopsis"></a>

# Synopsis

```


```
    gencat catfile msgfile...

<a name="description"></a>

# Description

The
_gencat_
utility shall merge the message text source file
_msgfile_
into a formatted message catalog
_catfile_.
The file
_catfile_
shall be created if it does not already exist. If
_catfile_
does exist, its messages shall be included in the new
_catfile_.
If set and message numbers collide, the new message text defined in
_msgfile_
shall replace the old message text currently contained in
_catfile_.

<a name="options"></a>

# Options

None.

<a name="operands"></a>

# Operands

The following operands shall be supported:

* _catfile_  
  A pathname of the formatted message catalog. If
  **'\(mi'**
  is specified, standard output shall be used. The format of the message
  catalog produced is unspecified.
* _msgfile_  
  A pathname of a message text source file. If
  **'\(mi'**
  is specified for an instance of
  _msgfile_,
  standard input shall be used. The format of message text source files
  is defined in the EXTENDED DESCRIPTION section.

<a name="stdin"></a>

# Stdin

The standard input shall not be used unless a
_msgfile_
operand is specified as
**'\(mi'**.

<a name="input-files"></a>

# Input Files

The input files shall be text files.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_gencat_:

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

The standard output shall not be used unless the
_catfile_
operand is specified as
**'\(mi'**.

<a name="stderr"></a>

# Stderr

The standard error shall be used only for diagnostic messages.

<a name="output-files"></a>

# Output Files

None.

<a name="extended-description"></a>

# Extended Description

The content of a message text file shall be in the format defined as
follows. Note that the fields of a message text source line are
separated by a single
&lt;blank&gt;
character. Any other
&lt;blank&gt;
characters are considered to be part of the subsequent field.

* **$set&nbsp;n&nbsp;comment**    
  This line specifies the set identifier of the following messages until
  the next
  **$set**
  or end-of-file appears. The
  _n_
  denotes the set identifier, which is defined as a number in the range
  [1,
  {NL_SETMAX}]
  (see the
  _&lt;limits.h&gt;_
  header defined in the Base Definitions volume of POSIX.1-2008). The application shall ensure that set
  identifiers are presented in ascending order within a single source
  file, but need not be contiguous. Any string following the set
  identifier shall be treated as a comment. If no
  **$set**
  directive is specified in a message text source file, all messages
  shall be located in an implementation-defined default message set
  NL_SETD (see the
  _&lt;nl_types.h&gt;_
  header defined in the Base Definitions volume of POSIX.1-2008).
* **$delset&nbsp;n&nbsp;comment**    
  This line deletes message set
  _n_
  from an existing message catalog. The
  _n_
  denotes the set number [1,
  {NL_SETMAX}].
  Any string following the set number shall be treated as a comment.
* **$&nbsp;comment**  
  A line beginning with
  **'$'**
  followed by a
  &lt;blank&gt;
  shall be treated as a comment.
* _m&nbsp;message-text_    
  The
  _m_
  denotes the message identifier, which is defined as a number in the
  range [1,
  {NL_MSGMAX}]
  (see the
  _&lt;limits.h&gt;_
  header). The
  _message-text_
  shall be stored in the message catalog with the set identifier
  specified by the last
  **$set**
  directive, and with message identifier
  _m_.
  If the
  _message-text_
  is empty, and a
  &lt;blank&gt;
  field separator is present, an empty string shall be stored
  in the message catalog. If a message source line has a message number,
  but neither a field separator nor
  _message-text_,
  the existing message with that number (if any) shall be deleted from
  the catalog. The application shall ensure that message identifiers are
  in ascending order within a single set, but need not be contiguous. The
  application shall ensure that the length of
  _message-text_
  is in the range [0,
  {NL_TEXTMAX}]
  (see the
  _&lt;limits.h&gt;_
  header).
* **$quote&nbsp;n**  
  This line specifies an optional quote character
  _c_,
  which can be used to surround
  _message-text_
  so that trailing
  &lt;space&gt;
  characters or null (empty) messages are visible in a message source
  line. By default, or if an empty
  **$quote**
  directive is supplied, no quoting of
  _message-text_
  shall be recognized.

Empty lines in a message text source file shall be ignored. The
effects of lines starting with any character other than those defined
above are implementation-defined.

Text strings can contain the special characters and escape sequences
defined in the following table:
.TS
center tab(@) box;
cB | cB | cB
l | l | lf5.
Description@Symbol@Sequence
_
&lt;newline&gt;@NL(LF)@\en
Horizontal-tab@HT@\et
&lt;vertical-tab&gt;@VT@\ev
&lt;backspace&gt;@BS@\eb
&lt;carriage-return&gt;@CR@\er
&lt;form-feed&gt;@FF@\ef
Backslash@\e@\e\e
Bit pattern@ddd@\eddd
.TE

The escape sequence
**"\eddd"**
consists of
&lt;backslash&gt;
followed by one, two, or three octal digits, which shall be taken to
specify the value of the desired character. If the character following a
&lt;backslash&gt;
is not one of those specified, the
&lt;backslash&gt;
shall be ignored.

A
&lt;backslash&gt;
followed by a
&lt;newline&gt;
is also used to continue a string on the following line. Thus, the
following two lines describe a single message string:

    
    1 This line continues e
    to the next line


which shall be equivalent to:

    
    1 This line continues to the next line


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

Message catalogs produced by
_gencat_
are binary encoded, meaning that their portability cannot be guaranteed
between different types of machine. Thus, just as C programs need to
be recompiled for each type of machine, so message catalogs must be
recreated via
_gencat_.

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

__iconv_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_**&lt;limits.h&gt;**_,
_**&lt;nl\_types.h&gt;**_

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
