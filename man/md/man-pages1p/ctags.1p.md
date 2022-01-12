# ctags(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

ctags
— create a tags file (**DEVELOPMENT**, **FORTRAN**)

<a name="synopsis"></a>

# Synopsis

```


```
    ctags [(mia] [(mif tagsfile] pathname...
    
    ctags (mix pathname...

<a name="description"></a>

# Description

The
_ctags_
utility shall be provided on systems that support the the Software
Development Utilities option, and either or both of the C-Language
Development Utilities option and FORTRAN Development Utilities option. On
other systems, it is optional.

The
_ctags_
utility shall write a
_tagsfile_
or an index of objects from C-language or FORTRAN source files
specified by the
_pathname_
operands. The
_tagsfile_
shall list the locators of language-specific objects within the source
files. A locator consists of a name, pathname, and either a search
pattern
or a line number that can be used in searching for the object
definition. The objects that shall be recognized are specified in the
EXTENDED DESCRIPTION section.

<a name="options"></a>

# Options

The
_ctags_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(mia**  
  Append to
  _tagsfile_.
* **\(mif&nbsp;tagsfile**  
  Write the object locator lists into
  _tagsfile_
  instead of the default file named
  **tags**
  in the current directory.
* **\(mix**  
  Produce a list of object names, the line number, and filename in which
  each is defined, as well as the text of that line, and write this to
  the standard output. A
  _tagsfile_
  shall not be created when
  **\(mix**
  is specified.

<a name="operands"></a>

# Operands

The following
_pathname_
operands are supported:

* file**.c**  
  Files with basenames ending with the
  **.c**
  suffix shall be treated as C-language source code. Such files that are
  not valid input to
  _c99_
  produce unspecified results.
* file**.h**  
  Files with basenames ending with the
  **.h**
  suffix shall be treated as C-language source code. Such files that are
  not valid input to
  _c99_
  produce unspecified results.
* file**.f**  
  Files with basenames ending with the
  **.f**
  suffix shall be treated as FORTRAN-language source code. Such files
  that are not valid input to
  _fort77_
  produce unspecified results.

The handling of other files is implementation-defined.

<a name="stdin"></a>

# Stdin

See the INPUT FILES section.

<a name="input-files"></a>

# Input Files

The input files shall be text files containing source code in the
language indicated by the operand filename suffixes.  

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_ctags_:

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
  Determine the order in which output is sorted for the
  **\(mix**
  option. The POSIX locale determines the order in which the
  _tagsfile_
  is written.
* _LC\_CTYPE_  
  Determine the locale for the interpretation of sequences of bytes of
  text data as characters (for example, single-byte as opposed to
  multi-byte characters in arguments and input files). When processing
  C-language source code, if the locale is not compatible with the C
  locale described by the ISO&nbsp;C standard, the results are unspecified.
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

The list of object name information produced by the
**\(mix**
option shall be written to standard output in the following format:

    
    "%s %d %s %s", <object-name>, <line-number>, <filename>, <text>


where &lt;_text_&gt; is the text of line &lt;_line-number_&gt; of file
&lt;_filename_&gt;.

<a name="stderr"></a>

# Stderr

The standard error shall be used only for diagnostic messages.

<a name="output-files"></a>

# Output Files

When the
**\(mix**
option is not specified, the format of the output file shall be:

    
    "%set%set/%s/en", <identifier>, <filename>, <pattern>


where &lt;_pattern_&gt; is a search pattern that could be used by an
editor to find the defining instance of &lt;_identifier_&gt; in
&lt;_filename_&gt; (where
_defining instance_
is indicated by the declarations listed in the EXTENDED DESCRIPTION).

An optional
&lt;circumflex&gt;
(\c
**'^'**)
can be added as a prefix to &lt;_pattern_&gt;, and an optional
&lt;dollar-sign&gt;
can be appended to &lt;_pattern_&gt; to indicate that the pattern is
anchored to the beginning (end) of a line of text. Any
&lt;slash&gt;
or
&lt;backslash&gt;
characters in &lt;_pattern_&gt; shall be preceded by a
&lt;backslash&gt;
character. The anchoring
&lt;circumflex&gt;,
&lt;dollar-sign&gt;,
and escaping
&lt;backslash&gt;
characters shall not be considered part of the search pattern. All other
characters in the search pattern shall be considered literal characters.  

An alternative format is:

    
    "%set%set?%s?en", <identifier>, <filename>, <pattern>


which is identical to the first format except that
&lt;slash&gt;
characters in &lt;_pattern_&gt; shall not be preceded by escaping
&lt;backslash&gt;
characters, and
&lt;question-mark&gt;
characters in &lt;_pattern_&gt; shall be preceded by
&lt;backslash&gt;
characters.

A second alternative format is:

    
    "%set%set%den", <identifier>, <filename>, <lineno>


where &lt;_lineno_&gt; is a decimal line number that could be used by an
editor to find &lt;_identifier_&gt; in &lt;_filename_&gt;.

Neither alternative format shall be produced by
_ctags_
when it is used as described by POSIX.1-2008, but the standard utilities that
process tags files shall be able to process those formats as well as
the first format.

In any of these formats, the file shall be sorted by identifier, based
on the collation sequence in the POSIX locale.

<a name="extended-description"></a>

# Extended Description

If the operand identifies C-language source, the
_ctags_
utility shall attempt to produce an output line for each of the
following objects:

*  *  
  Function definitions
*  *  
  Type definitions
*  *  
  Macros with arguments

It may also produce output for any of the following objects:

*  *  
  Function prototypes
*  *  
  Structures
*  *  
  Unions
*  *  
  Global variable definitions
*  *  
  Enumeration types
*  *  
  Macros without arguments
*  *  
  **#define**
  statements
*  *  
  **#line**
  statements

Any
**#if**
and
**#ifdef**
statements shall produce no output. The tag
**main**
is treated specially in C programs. The tag formed shall be created by
prefixing
**M**
to the name of the file, with the trailing
**.c**,
and leading pathname components (if any) removed.

On systems that do not support the C-Language Development Utilities
option,
_ctags_
produces unspecified results for C-language source code files. It should
write to standard error a message identifying this condition and cause
a non-zero exit status to be produced.

If the operand identifies FORTRAN source, the
_ctags_
utility shall produce an output line for each function definition. It
may also produce output for any of the following objects:

*  *  
  Subroutine definitions
*  *  
  COMMON statements
*  *  
  PARAMETER statements
*  *  
  DATA and BLOCK DATA statements
*  *  
  Statement numbers

On systems that do not support the FORTRAN Development Utilities
option,
_ctags_
produces unspecified results for FORTRAN source code files. It should
write to standard error a message identifying this condition and cause
a non-zero exit status to be produced.

It is implementation-defined what other objects (including duplicate
identifiers) produce output.

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

The output with
**\(mix**
is meant to be a simple index that can be written out as an off-line
readable function index. If the input files to
_ctags_
(such as
**.c**
files) were not created using the same locale as that in effect when
_ctags_
**\(mix**
is run, results might not be as expected.

The description of C-language processing says \`\`attempts to'' because
the C language can be greatly confused, especially through the use of
**#define**s,
and this utility would be of no use if the real C preprocessor were run
to identify them. The output from
_ctags_
may be fooled and incorrect for various constructs.

<a name="examples"></a>

# Examples

None.

<a name="rationale"></a>

# Rationale

The option list was significantly reduced from that provided by
historical implementations. The
**\(miF**
option was omitted as redundant, since it is the default. The
**\(miB**
option was omitted as being of very limited usefulness. The
**\(mit**
option was omitted since the recognition of
**typedef**s
is now required for C source files. The
**\(miu**
option was omitted because the update function was judged to be not
only inefficient, but also rarely needed.

An early proposal included a
**\(miw**
option to suppress warning diagnostics. Since the types of such
diagnostics could not be described, the option was omitted as being not
useful.

The text for
_LC_CTYPE_
about compatibility with the C locale acknowledges that the ISO&nbsp;C standard
imposes requirements on the locale used to process C source. This could
easily be a superset of that known as \`\`the C locale'' by way of
implementation extensions, or one of a few alternative locales for
systems supporting different codesets. No statement is made for FORTRAN
because the ANSI&nbsp;X3.9-1978 standard (FORTRAN 77) does not (yet) define a similar locale
concept. However, a general rule in this volume of POSIX.1-2008 is that any time that locales
do not match (preparing a file for one locale and processing it in
another), the results are suspect.

The collation sequence of the tags file is not affected by
_LC_COLLATE_
because it is typically not used by human readers, but only by programs
such as
_vi_
to locate the tag within the source files. Using the POSIX locale
eliminates some of the problems of coordinating locales between the
_ctags_
file creator and the
_vi_
file reader.

Historically, the tags file has been used only by
_ex_
and
_vi_.
However, the format of the tags file has been published to encourage
other programs to use the tags in new ways. The format allows either
patterns or line numbers to find the identifiers because the historical
_vi_
recognizes either. The
_ctags_
utility does not produce the format using line numbers because it is
not useful following any source file changes that add or delete lines.
The documented search patterns match historical practice. It should be
noted that literal leading
&lt;circumflex&gt;
or trailing
&lt;dollar-sign&gt;
characters in the search pattern will only behave correctly if anchored
to the beginning of the line or end of the line by an additional
&lt;circumflex&gt;
or
&lt;dollar-sign&gt;
character.

Historical implementations also understand the objects used by the
languages Pascal and sometimes LISP, and they understand the C source
output by
_lex_
and
_yacc_.
The
_ctags_
utility is not required to accommodate these languages, although
implementors are encouraged to do so.

The following historical option was not specified, as
_vgrind_
is not included in this volume of POSIX.1-2008:

* **\(miv**  
  If the
  **\(miv**
  flag is given, an index of the form expected by
  _vgrind_
  is produced on the standard output. This listing contains the function
  name, filename, and page number (assuming 64-line pages). Since the
  output is sorted into lexicographic order, it may be desired to run the
  output through
  _sort_
  **\(mif**.
  Sample use:

    
    ctags (miv files | sort (mif > index vgrind (mix index


The special treatment of the tag
**main**
makes the use of
_ctags_
practical in directories with more than one program.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__c99_\^_,
__fort77_\^_,
__vi_\^_

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
