# locale(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

locale
— get locale-specific information

<a name="synopsis"></a>

# Synopsis

```


```
    locale [(mia|(mim]
    
    locale [(mick] name...

<a name="description"></a>

# Description

The
_locale_
utility shall write information about the current locale environment,
or all public locales, to the standard output. For the purposes of
this section, a
_public locale_
is one provided by the implementation that is accessible to the
application.

When
_locale_
is invoked without any arguments, it shall summarize the current locale
environment for each locale category as determined by the settings of
the environment variables defined in the Base Definitions volume of POSIX.1-2008,
_Chapter 7_, _Locale_.

When invoked with operands, it shall write values that have been
assigned to the keywords in the locale categories, as follows:

*  *  
  Specifying a keyword name shall select the named keyword and the
  category containing that keyword.
*  *  
  Specifying a category name shall select the named category and all
  keywords in that category.

<a name="options"></a>

# Options

The
_locale_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(mia**  
  Write information about all available public locales. The available
  locales shall include
  **POSIX**,
  representing the POSIX locale. The manner in which the implementation
  determines what other locales are available is
  implementation-defined.
* **\(mic**  
  Write the names of selected locale categories; see the STDOUT section.
  The
  **\(mic**
  option increases readability when more than one category is selected
  (for example, via more than one keyword name or via a category name).
  It is valid both with and without the
  **\(mik**
  option.
* **\(mik**  
  Write the names and values of selected keywords. The implementation
  may omit values for some keywords; see the OPERANDS section.
* **\(mim**  
  Write names of available charmaps; see the Base Definitions volume of POSIX.1-2008,
  _Section 6.1_, _Portable Character Set_.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _name_  
  The name of a locale category as defined in the Base Definitions volume of POSIX.1-2008,
  _Chapter 7_, _Locale_,
  the name of a keyword in a locale category, or the reserved name
  **charmap**.
  The named category or keyword shall be selected for output. If a
  single
  _name_
  represents both a locale category name and a keyword name in the
  current locale, the results are unspecified. Otherwise, both category
  and keyword names can be specified as
  _name_
  operands, in any sequence. It is implementation-defined whether any
  keyword values are written for the categories
  _LC_CTYPE_
  and
  _LC_COLLATE_.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_locale_:

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

The application shall ensure that the
_LANG_,
_LC_*_,
and
_NLSPATH_
environment variables specify the current locale environment to be
written out; they shall be used if the
**\(mia**
option is not specified.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

The
_LANG_
variable shall be written first using the format:

    
    "LANG=%sen", <value>


If
_LANG_
is not set or is an empty string, the value is the empty string.

If
_locale_
is invoked without any options or operands, the names and values of the
_LC_*_
environment variables described in this volume of POSIX.1-2008 shall be written to the
standard output, one variable per line, and each line using the
following format. Only those variables set in the environment and not
overridden by
_LC_ALL_
shall be written using this format:

    
    "%s=%sen", <variable_name>, <value>


The names of those
_LC_*_
variables associated with locale categories defined in this volume of POSIX.1-2008 that are
not set in the environment or are overridden by
_LC_ALL_
shall be written in the following format:

    
    "%s=e"%se"en", <variable_name>, <implied value>


The &lt;_implied&nbsp;value_&gt; shall be the name of the locale that has
been selected for that category by the implementation, based on the
values in
_LANG_
and
_LC_ALL_,
as described in the Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_.

The &lt;_value_&gt; and &lt;_implied&nbsp;value_&gt; shown above shall be
properly quoted for possible later reentry to the shell. The
&lt;_value_&gt; shall not be quoted using double-quotes (so that it can
be distinguished by the user from the &lt;_implied&nbsp;value_&gt; case,
which always requires double-quotes).

The
_LC_ALL_
variable shall be written last, using the first format shown above. If
it is not set, it shall be written as:

    
    "LC_ALL=en"


If any arguments are specified:

*  1.  
  If the
  **\(mia**
  option is specified, the names of all the public locales shall be
  written, each in the following format:

    
    "%sen", <locale&nbsp;name>


*  2.  
  If the
  **\(mic**
  option is specified, the names of all selected categories shall be
  written, each in the following format:

    
    "%sen", <category&nbsp;name>


If keywords are also selected for writing (see following items), the
category name output shall precede the keyword output for that
category.

If the
**\(mic**
option is not specified, the names of the categories shall not be
written; only the keywords, as selected by the &lt;_name_&gt; operand,
shall be written.

*  3.  
  If the
  **\(mik**
  option is specified, the names and values of selected keywords shall be
  written. If a value is non-numeric and is not a compound keyword
  value, it shall be written in the following format:

    
    "%s=e"%se"en", <keyword name>, <keyword value>


If a value is a non-numeric compound keyword value, it shall either be
written in the format:

    
    "%s=e"%se"en", <keyword name>, <keyword value>


where the &lt;_keyword value_&gt; is a single string of values separated by
&lt;semicolon&gt;
characters, or it shall be written in the format:

    
    "%s=%sen", <keyword name>, <keyword value>


where the &lt;_keyword value_&gt; is encoded as a set of strings, each
enclosed in double-quotation-marks, separated by
&lt;semicolon&gt;
characters.

If the keyword was
**charmap**,
the name of the charmap (if any) that was specified via the
_localedef_
**\(mif**
option when the locale was created shall be written, with the word
**charmap**
as &lt;_keyword&nbsp;name_&gt;.

If a value is numeric, it shall be written in one of the following
formats:

    
    "%s=%den", <keyword name>, <keyword value>
    
    "%s=%c%oen", <keyword name>, <escape character>, <keyword value>
    
    "%s=%cx%xen", <keyword name>, <escape character>, <keyword value>


where the &lt;_escape&nbsp;character_&gt; is that identified by the
**escape_char**
keyword in the current locale; see the Base Definitions volume of POSIX.1-2008,
_Section 7.3_, _Locale Definition_.

Compound keyword values (list entries) shall be separated in the output by
&lt;semicolon&gt;
characters. When included in keyword values, the
&lt;semicolon&gt;,
&lt;backslash&gt;,
double-quote, and any control character shall be preceded (escaped)
with the escape character.

*  4.  
  If the
  **\(mik**
  option is not specified, selected keyword values shall be written, each
  in the following format:

    
    "%sen", <keyword value>


If the keyword was
**charmap**,
the name of the charmap (if any) that was specified via the
_localedef_
**\(mif**
option when the locale was created shall be written.

*  5.  
  If the
  **\(mim**
  option is specified, then a list of all available charmaps shall be
  written, each in the format:

    
    "%sen", <charmap>


where &lt;_charmap_&gt; is in a format suitable for use as the
option-argument to the
_localedef_
**\(mif**
option.

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
  All the requested information was found and output successfully.
* &gt;0  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

If the
_LANG_
environment variable is not set or set to an empty value, or one of the
_LC_*_
environment variables is set to an unrecognized value, the actual
locales assumed (if any) are implementation-defined as described in the Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_.

Implementations are not required to write out the actual values for
keywords in the categories
_LC_CTYPE_
and
_LC_COLLATE_;
however, they must write out the categories (allowing an application to
determine, for example, which character classes are available).

<a name="examples"></a>

# Examples

In the following examples, the assumption is that locale environment
variables are set as follows:

    
    LANG=locale_x
    LC_COLLATE=locale_y


The command
_locale_
would result in the following output:

    
    LANG=locale_x
    LC_CTYPE="locale_x"
    LC_COLLATE=locale_y
    LC_TIME="locale_x"
    LC_NUMERIC="locale_x"
    LC_MONETARY="locale_x"
    LC_MESSAGES="locale_x"
    LC_ALL=


The order of presentation of the categories is not specified by this volume of POSIX.1-2008.

The command:

    
    LC_ALL=POSIX locale (mick decimal_point


would produce:

    
    LC_NUMERIC
    decimal_point="."


The following command shows an application of
_locale_
to determine whether a user-supplied response is affirmative:

    
    if printf "%sen$response" | grep (miEq "$(locale yesexpr)"
    then
        affirmative processing goes here
    else
        non-affirmative processing goes here
    fi


<a name="rationale"></a>

# Rationale

The output for categories
_LC_CTYPE_
and
_LC_COLLATE_
has been made implementation-defined because there is a questionable
value in having a shell script receive an entire array of characters.
It is also difficult to return a logical collation description, short
of returning a complete
_localedef_
source.

The
**\(mim**
option was included to allow applications to query for the existence of
charmaps.
The output is a list of the charmaps (implementation-supplied and
user-supplied, if any) on the system.

The
**\(mic**
option was included for readability when more than one category is
selected (for example, via more than one keyword name or via a category
name). It is valid both with and without the
**\(mik**
option.

The
**charmap**
keyword, which returns the name of the charmap (if any) that was used
when the current locale was created, was included to allow applications
needing the information to retrieve it.

According to the Base Definitions volume of POSIX.1-2008,
_Section 6.1_, _Portable Character Set_,
the standard requires that all supported locales must have the same
encoding for
&lt;period&gt;
and
&lt;slash&gt;,
because these two characters are used within the locale-independent
pathname resolution sequence. Therefore, it would be an error if
_locale_
**\(mia**
listed both ASCII and EBCDIC-based locales, since those two encodings
do not share the same representation for either
&lt;period&gt;
or
&lt;slash&gt;.
Any system that supports both environments would be expected to provide two
POSIX locales, one in either codeset, where only the locales appropriate
to the current environment can be visible at a time. In an XSI-compliant
implementation, the
_dd_
utility is the only portable means for performing conversions between
the two character sets.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__localedef_\^_

The Base Definitions volume of POSIX.1-2008,
_Section 6.1_, _Portable Character Set_,
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
