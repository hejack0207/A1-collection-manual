# localedef(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

localedef — define locale environment

<a name="synopsis"></a>

# Synopsis

```


```
    localedef [(mic] [(mif charmap] [(mii sourcefile] [(miu code_set_name] name

<a name="description"></a>

# Description

The
_localedef_
utility shall convert source definitions for locale categories into a
format usable by the functions and utilities whose operational behavior
is determined by the setting of the locale environment variables
defined in the Base Definitions volume of POSIX.1-2008,
_Chapter 7_, _Locale_.
It is implementation-defined whether users have the capability to create
new locales, in addition to those supplied by the implementation. If
the symbolic constant POSIX2_LOCALEDEF is defined, the system supports
the creation of new locales.
On XSI-conformant systems, the symbolic constant POSIX2_LOCALEDEF
shall be defined.

The utility shall read source definitions for one or more locale
categories belonging to the same locale from the file named in the
**\(mii**
option (if specified) or from standard input.

The
_name_
operand identifies the target locale. The utility shall support the
creation of
_public_,
or generally accessible locales, as well as
_private_,
or restricted-access locales. Implementations may restrict the
capability to create or modify public locales to users with
appropriate privileges.

Each category source definition shall be identified by the
corresponding environment variable name and terminated by an
**END**
_category-name_
statement. The following categories shall be supported. In addition,
the input may contain source for implementation-defined categories.

* _LC\_CTYPE_  
  Defines character classification and case conversion.
* _LC\_COLLATE_    
  Defines collation rules.
* _LC\_MONETARY_    
  Defines the format and symbols used in formatting of monetary
  information.
* _LC\_NUMERIC_    
  Defines the decimal delimiter, grouping, and grouping symbol for
  non-monetary numeric editing.
* _LC\_TIME_  
  Defines the format and content of date and time information.
* _LC\_MESSAGES_    
  Defines the format and values of affirmative and negative responses.

<a name="options"></a>

# Options

The
_localedef_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(mic**  
  Create permanent output even if warning messages have been issued.
* **\(mif&nbsp;charmap**  
  Specify the pathname of a file containing a mapping of character
  symbols and collating element symbols to actual character encodings.
  The format of the
  _charmap_
  is described in the Base Definitions volume of POSIX.1-2008,
  _Section 6.4_, _Character Set Description File_.
  The application shall ensure that this option is specified if symbolic
  names (other than collating symbols defined in a
  **collating-symbol**
  keyword) are used. If the
  **\(mif**
  option is not present, an implementation-defined character mapping
  shall be used.
* **\(mii&nbsp;inputfile**  
  The pathname of a file containing the source definitions. If this
  option is not present, source definitions shall be read from standard
  input. The format of the
  _inputfile_
  is described in the Base Definitions volume of POSIX.1-2008,
  _Section 7.3_, _Locale Definition_.
* **\(miu&nbsp;code\_set\_name**    
  Specify the name of a codeset used as the target mapping of character
  symbols and collating element symbols whose encoding values are defined
  in terms of the ISO/IEC&nbsp;10646-1:\|2000 standard position constant values.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _name_  
  Identifies the locale; see the Base Definitions volume of POSIX.1-2008,
  _Chapter 7_, _Locale_
  for a description of the use of this name. If the name contains one
  or more
  &lt;slash&gt;
  characters,
  _name_
  shall be interpreted as a pathname where the created locale definitions
  shall be stored. If
  _name_
  does not contain any
  &lt;slash&gt;
  characters, the interpretation of the name is implementation-defined
  and the locale shall be public. The ability to create public locales in
  this way may be restricted to users with appropriate privileges. (As a
  consequence of specifying one
  _name_,
  although several categories can be processed in one execution, only
  categories belonging to the same locale can be processed.)

<a name="stdin"></a>

# Stdin

Unless the
**\(mii**
option is specified, the standard input shall be a text file containing
one or more locale category source definitions, as described in the Base Definitions volume of POSIX.1-2008,
_Section 7.3_, _Locale Definition_.
When lines are continued using the escape character mechanism,
there is no limit to the length of the accumulated continued line.

<a name="input-files"></a>

# Input Files

The character set mapping file specified as the
_charmap_
option-argument is described in the Base Definitions volume of POSIX.1-2008,
_Section 6.4_, _Character Set Description File_.
If a locale category source definition contains a
**copy**
statement, as defined in the Base Definitions volume of POSIX.1-2008,
_Chapter 7_, _Locale_,
and the
**copy**
statement names a valid, existing locale, then
_localedef_
shall behave as if the source definition had contained a valid category
source definition for the named locale.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_localedef_:

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
  (This variable has no affect on
  _localedef_;
  the POSIX locale is used for this category.)
* _LC\_CTYPE_  
  Determine the locale for the interpretation of sequences of bytes of
  text data as characters (for example, single-byte as opposed to
  multi-byte characters in arguments and input files). This variable has
  no affect on the processing of
  _localedef_
  input data; the POSIX locale is used for this purpose, regardless of
  the value of this variable.
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

The utility shall report all categories successfully processed, in an
unspecified format.

<a name="stderr"></a>

# Stderr

The standard error shall be used only for diagnostic messages.

<a name="output-files"></a>

# Output Files

The format of the created output is unspecified. If the
_name_
operand does not contain a
&lt;slash&gt;,
the existence of an output file for the locale is unspecified.

<a name="extended-description"></a>

# Extended Description

When the
**\(miu**
option is used, the
_code_set_name_
option-argument shall be interpreted as an implementation-defined
name of a codeset to which the ISO/IEC&nbsp;10646-1:\|2000 standard position constant values shall be
converted via an implementation-defined method. Both the ISO/IEC&nbsp;10646-1:\|2000 standard
position constant values and other formats (decimal, hexadecimal, or
octal) shall be valid as encoding values within the
_charmap_
file. The codeset represented by the implementation-defined name can
be any codeset that is supported by the implementation.

When conflicts occur between the
_charmap_
specification of &lt;_code\_set\_name_&gt;, &lt;_mb\_cur\_max_&gt;, or
&lt;_mb\_cur\_min_&gt; and the implementation-defined interpretation of
these respective items for the codeset represented by the
**\(miu**
option-argument
_code_set_name_,
the result is unspecified.

When conflicts occur between the
_charmap_
encoding values specified for symbolic names of characters of the
portable character set and the implementation-defined assignment of
character encoding values, the result is unspecified.

If a non-printable character in the
_charmap_
has a width specified that is not
**\(mi1**,
the result will be undefined.

<a name="exit-status"></a>

# Exit Status

The following exit values shall be returned:

* \00  
  No errors occurred and the locales were successfully created.
* \01  
  Warnings occurred and the locales were successfully created.
* \02  
  The locale specification exceeded implementation limits or the coded
  character set or sets used were not supported by the implementation,
  and no locale was created.
* \03  
  The capability to create new locales is not supported by the
  implementation.
* &gt;3  
  Warnings or errors occurred and no output was created.

<a name="consequences-of-errors"></a>

# Consequences of Errors

If an error is detected, no permanent output shall be created.

If warnings occur, permanent output shall be created if the
**\(mic**
option was specified. The following conditions shall cause warning
messages to be issued:

*  *  
  If a symbolic name not found in the
  _charmap_
  file is used for the descriptions of the
  _LC_CTYPE_
  or
  _LC_COLLATE_
  categories (for other categories, this shall be an error condition).
*  *  
  If the number of operands to the
  **order**
  keyword exceeds the
  {COLL_WEIGHTS_MAX}
  limit.
*  *  
  If optional keywords not supported by the implementation are present in
  the source.

Other implementation-defined conditions may also cause warnings.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

The
_charmap_
definition is optional, and is contained outside the locale
definition. This allows both completely self-defined source files, and
generic sources (applicable to more than one codeset). To aid
portability, all
_charmap_
definitions must use the same symbolic names for the portable character
set. As explained in the Base Definitions volume of POSIX.1-2008,
_Section 6.4_, _Character Set Description File_,
it is implementation-defined whether or not users or applications can
provide additional character set description files. Therefore, the
**\(mif**
option might be operable only when an implementation-defined
_charmap_
is named.

<a name="examples"></a>

# Examples

None.

<a name="rationale"></a>

# Rationale

The output produced by the
_localedef_
utility is implementation-defined. The
_name_
operand is used to identify the specific locale. (As a consequence,
although several categories can be processed in one execution, only
categories belonging to the same locale can be processed.)

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__locale_\^_

The Base Definitions volume of POSIX.1-2008,
_Section 6.4_, _Character Set Description File_,
_Chapter 7_, _Locale_,
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
