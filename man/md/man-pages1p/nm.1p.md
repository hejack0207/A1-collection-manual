# nm(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

nm
— write the name list of an object file (**DEVELOPMENT**)

<a name="synopsis"></a>

# Synopsis

```


```
    nm [(miAPv] [(mig|(miu] [(mit format] file...
    nm [(miAPv] [(miefox] [(mig|(miu] [(mit format] file...

<a name="description"></a>

# Description

The
_nm_
utility shall display symbolic information appearing in the object
file, executable file, or object-file library named by
_file_.
If no symbolic information is available for a valid input file, the
_nm_
utility shall report that fact, but not consider it an error
condition.

The default base used when numeric values are written is unspecified.
On XSI-conformant systems, it shall be decimal.

<a name="options"></a>

# Options

The
_nm_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(miA**  
  Write the full pathname or library name of an object on each line.
* **\(mie**  
  Write only external (global) and static symbol information.
* **\(mif**  
  Produce full output. Write redundant symbols (\c
  **.text**,
  **.data**,
  and
  **.bss**),
  normally suppressed.
* **\(mig**  
  Write only external (global) symbol information.
* **\(mio**  
  Write numeric values in octal (equivalent to
  **\(mit&nbsp;o**).
* **\(miP**  
  Write information in a portable output format, as specified in the
  STDOUT section.
* **\(mit&nbsp;format**  
  Write each numeric value in the specified format. The format shall be
  dependent on the single character used as the
  _format_
  option-argument:
    * d  
      The offset is written in decimal
      (default).
    * The offset is written in octal.
    * x  
      The offset is written in hexadecimal.
* **\(miu**  
  Write only undefined symbols.
* **\(miv**  
  Sort output by value instead of by symbol name.
* **\(mix**  
  Write numeric values in hexadecimal (equivalent to
  **\(mit&nbsp;x**).

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _file_  
  A pathname of an object file, executable file, or object-file library.

<a name="stdin"></a>

# Stdin

See the INPUT FILES section.

<a name="input-files"></a>

# Input Files

The input file shall be an object file, an object-file library whose
format is the same as those produced by the
_ar_
utility for link editing, or an executable file. The
_nm_
utility may accept additional implementation-defined object library
formats for the input file.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_nm_:

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
  Determine the locale for character collation information for the
  symbol-name and symbol-value collation sequences.
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

If symbolic information is present in the input files, then for each
file or for each member of an archive, the
_nm_
utility shall write the following information to standard output. By
default, the format is unspecified, but the output shall be sorted by
symbol name according to the collation sequence in the current locale.

*  *  
  Library or object name, if
  **\(miA**
  is specified
*  *  
  Symbol name
*  *  
  Symbol type, which shall either be one of the following single
  characters or an implementation-defined type represented by a single
  character:
    * A  
      Global absolute symbol.
    * a  
      Local absolute symbol.
    * B  
      Global \`\`bss'' (that is, uninitialized data space) symbol.
    * b  
      Local bss symbol.
    * D  
      Global data symbol.
    * d  
      Local data symbol.
    * T  
      Global text symbol.
    * t  
      Local text symbol.
    * U  
      Undefined symbol.
*  *  
  Value of the symbol
*  *  
  The size associated with the symbol, if applicable

This information may be supplemented by additional information specific
to the implementation.

If the
**\(miP**
option is specified, the previous information shall be displayed using
the following portable format. The three versions differ depending on
whether
**\(mit&nbsp;d**,
**\(mit&nbsp;o**,
or
**\(mit&nbsp;x**
was specified, respectively:

    
    "%s%s %s %d %den", <library/object name>, <name>, <type>,
        <value>, <size>
    
    "%s%s %s %o %oen", <library/object name>, <name>, <type>,
        <value>, <size>
    
    "%s%s %s %x %xen", <library/object name>, <name>, <type>,
        <value>, <size>

where &lt;_library/object&nbsp;name_&gt; shall be formatted as follows:

*  *  
  If
  **\(miA**
  is not specified, &lt;_library/object&nbsp;name_&gt; shall be an empty string.
*  *  
  If
  **\(miA**
  is specified and the corresponding
  _file_
  operand does not name a library:

    
    "%s: ", <file>


*  *  
  If
  **\(miA**
  is specified and the corresponding
  _file_
  operand names a library. In this case, &lt;_object&nbsp;file_&gt; shall name
  the object file in the library containing the symbol being described:

    
    "%s[%s]: ", <file>, <object file>


If
**\(miA**
is not specified, then if more than one
_file_
operand is specified or if only one
_file_
operand is specified and it names a library,
_nm_
shall write a line identifying the object containing the following
symbols before the lines containing those symbols, in the form:

*  *  
  If the corresponding
  _file_
  operand does not name a library:

    
    "%s:en", <file>


*  *  
  If the corresponding
  _file_
  operand names a library; in this case, &lt;_object&nbsp;file_&gt; shall be
  the name of the file in the library containing the following symbols:

    
    "%s[%s]:en", <file>, <object file>


If
**\(miP**
is specified, but
**\(mit**
is not, the format shall be as if
**\(mit&nbsp;x**
had been specified.

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

Mechanisms for dynamic linking make this utility less meaningful when
applied to an executable file because a dynamically linked executable
may omit numerous library routines that would be found in a statically
linked executable.

<a name="examples"></a>

# Examples

None.

<a name="rationale"></a>

# Rationale

Historical implementations of
_nm_
have used different bases for numeric output and supplied different
default types of symbols that were reported. The
**\(mit**
_format_
option, similar to that used in
_od_
and
_strings_,
can be used to specify the numeric base;
**\(mig**
and
**\(miu**
can be used to restrict the amount of output or the types of symbols
included in the output.

The compromise of using
**\(mit**
_format_
_versus_ using
**\(mid**,
**\(mio**,
and other similar options was necessary because of differences in the
meaning of
**\(mio**
between implementations. The
**\(mio**
option from BSD has been provided here as
**\(miA**
to avoid confusion with the
**\(mio**
from System V (which has been provided here as
**\(mit**
and as
**\(mio**
on XSI-conformant systems).

The option list was significantly reduced from that provided by
historical implementations.

The
_nm_
description is a subset of both the System V and BSD
_nm_
utilities with no specified default output.

It was recognized that mechanisms for dynamic linking make this utility
less meaningful when applied to an executable file (because a
dynamically linked executable file may omit numerous library routines
that would be found in a statically linked executable file), but the
value of
_nm_
during software development was judged to outweigh other limitations.

The default output format of
_nm_
is not specified because of differences in historical implementations.
The
**\(miP**
option was added to allow some type of portable output format. After a
comparison of the different formats used in SunOS, BSD, SVR3, and SVR4,
it was decided to create one that did not match the current format of
any of these four systems. The format devised is easy to parse by
humans, easy to parse in shell scripts, and does not need to vary
depending on locale (because no English descriptions are included).
All of the systems currently have the information available to use this
format.

The format given in
_nm_
STDOUT uses
&lt;space&gt;
characters between the fields, which may be any number of
&lt;blank&gt;
characters required to align the columns. The single-character types
were selected to match historical practice, and the requirement that
implementation additions also be single characters made parsing the
information easier for shell scripts.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__ar_\^_,
__c99_\^_

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
