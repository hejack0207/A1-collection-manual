# grep(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

grep
— search a file for a pattern

<a name="synopsis"></a>

# Synopsis

```


```
    grep [(miE|(miF] [(mic|(mil|(miq] [(miinsvx] (mie pattern_list
        [(mie pattern_list]... [(mif pattern_file]... [file...]
    
    grep [(miE|(miF] [(mic|(mil|(miq] [(miinsvx] [(mie pattern_list]...
        (mif pattern_file [(mif pattern_file]... [file...]
    
    grep [(miE|(miF] [(mic|(mil|(miq] [(miinsvx] pattern_list [file...]

<a name="description"></a>

# Description

The
_grep_
utility shall search the input files, selecting lines matching one or
more patterns; the types of patterns are controlled by the options
specified. The patterns are specified by the
**\(mie**
option,
**\(mif**
option, or the
_pattern_list_
operand. The
_pattern_list_'s
value shall consist of one or more patterns separated by
&lt;newline&gt;
characters; the
_pattern_file_'s
contents shall consist of one or more patterns terminated by a
&lt;newline&gt;
character. By default, an input line shall be selected if any
pattern, treated as an entire basic regular expression (BRE) as
described in the Base Definitions volume of POSIX.1-2008,
_Section 9.3_, _Basic Regular Expressions_,
matches any part of the line excluding the terminating
&lt;newline&gt;;
a null BRE shall match every line. By default, each selected input
line shall be written to the standard output.

Regular expression matching shall be based on text lines. Since a
&lt;newline&gt;
separates or terminates patterns (see the
**\(mie**
and
**\(mif**
options below), regular expressions cannot contain a
&lt;newline&gt;.
Similarly, since patterns are matched against individual lines
(excluding the terminating
&lt;newline&gt;
characters) of the input, there is no way for a pattern to match a
&lt;newline&gt;
found in the input.

<a name="options"></a>

# Options

The
_grep_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(miE**  
  Match using extended regular expressions.
  Treat each pattern specified as an ERE, as described in the Base Definitions volume of POSIX.1-2008,
  _Section 9.4_, _Extended Regular Expressions_.
  If any entire ERE pattern matches some part of an input line excluding
  the terminating
  &lt;newline&gt;,
  the line shall be matched. A null ERE shall match every line.
* **\(miF**  
  Match using fixed strings. Treat each pattern specified as a string
  instead of a regular expression. If an input line contains any of the
  patterns as a contiguous sequence of bytes, the line shall be matched.
  A null string shall match every line.
* **\(mic**  
  Write only a count of selected lines to standard output.
* **\(mie&nbsp;pattern\_list**    
  Specify one or more patterns to be used during the search for input.
  The application shall ensure that patterns in
  _pattern_list_
  are separated by a
  &lt;newline&gt;.
  A null pattern can be specified by two adjacent
  &lt;newline&gt;
  characters in
  _pattern_list_.
  Unless the
  **\(miE**
  or
  **\(miF**
  option is also specified, each pattern shall be treated as a BRE, as
  described in the Base Definitions volume of POSIX.1-2008,
  _Section 9.3_, _Basic Regular Expressions_.
  Multiple
  **\(mie**
  and
  **\(mif**
  options shall be accepted by the
  _grep_
  utility. All of the specified patterns shall be used when matching
  lines, but the order of evaluation is unspecified.
* **\(mif&nbsp;pattern\_file**    
  Read one or more patterns from the file named by the pathname
  _pattern_file_.
  Patterns in
  _pattern_file_
  shall be terminated by a
  &lt;newline&gt;.
  A null pattern can be specified by an empty line in
  _pattern_file_.
  Unless the
  **\(miE**
  or
  **\(miF**
  option is also specified, each pattern shall be treated as a BRE, as
  described in the Base Definitions volume of POSIX.1-2008,
  _Section 9.3_, _Basic Regular Expressions_.
* **\(mii**  
  Perform pattern matching in searches without regard to case; see the Base Definitions volume of POSIX.1-2008,
  _Section 9.2_, _Regular Expression General Requirements_.
* **\(mil**  
  (The letter ell.) Write only the names of files containing selected
  lines to standard output. Pathnames shall be written once per file
  searched. If the standard input is searched, a pathname of
  **"(standard**input)"
  shall be written, in the POSIX locale. In other locales,
  **"standard**input"
  may be replaced by something more appropriate in those locales.
* **\(min**  
  Precede each output line by its relative line number in the file, each
  file starting at line 1. The line number counter shall be reset for
  each file processed.
* **\(miq**  
  Quiet. Nothing shall be written to the standard output, regardless of
  matching lines. Exit with zero status if an input line is selected.
* **\(mis**  
  Suppress the error messages ordinarily written for nonexistent or
  unreadable files. Other error messages shall not be suppressed.
* **\(miv**  
  Select lines not matching any of the specified patterns. If the
  **\(miv**
  option is not specified, selected lines shall be those that match any
  of the specified patterns.
* **\(mix**  
  Consider only input lines that use all characters in the line excluding
  the terminating
  &lt;newline&gt;
  to match an entire fixed string or regular expression to be matching
  lines.

<a name="operands"></a>

# Operands

The following operands shall be supported:

* _pattern\_list_  
  Specify one or more patterns to be used during the search for input.
  This operand shall be treated as if it were specified as
  **\(mie**
  _pattern_list_.
* _file_  
  A pathname of a file to be searched for the patterns. If no
  _file_
  operands are specified, the standard input shall be used.

<a name="stdin"></a>

# Stdin

The standard input shall be used if no
_file_
operands are specified, and shall be used if a
_file_
operand is
**'\(mi'**
and the implementation treats the
**'\(mi'**
as meaning standard input.
Otherwise, the standard input shall not be used.
See the INPUT FILES section.

<a name="input-files"></a>

# Input Files

The input files shall be text files.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_grep_:

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
  and multi-character collating elements within regular expressions.
* _LC\_CTYPE_  
  Determine the locale for the interpretation of sequences of bytes of
  text data as characters (for example, single-byte as opposed to
  multi-byte characters in arguments and input files) and the behavior of
  character classes within regular expressions.
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

If the
**\(mil**
option is in effect, the following shall be written for each file
containing at least one selected input line:

    
    "%sen", <file>


Otherwise, if more than one
_file_
argument appears, and
**\(miq**
is not specified, the
_grep_
utility shall prefix each output line by:

    
    "%s:", <file>


The remainder of each output line shall depend on the other options
specified:

*  *  
  If the
  **\(mic**
  option is in effect, the remainder of each output line shall contain:

    
    "%den", <count>


*  *  
  Otherwise, if
  **\(mic**
  is not in effect and the
  **\(min**
  option is in effect, the following shall be written to standard
  output:

    
    "%d:", <line number>


*  *  
  Finally, the following shall be written to standard output:

    
    "%s", <selected-line contents>


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
  One or more lines were selected.
* \01  
  No lines were selected.
* &gt;1  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

If the
**\(miq**
option is specified, the exit status shall be zero if an input line is
selected, even if an error was detected. Otherwise, default actions
shall be performed.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

Care should be taken when using characters in
_pattern_list_
that may also be meaningful to the command interpreter. It is safest
to enclose the entire
_pattern_list_
argument in single-quotes:

    
    '...'


The
**\(mie**
_pattern_list_
option has the same effect as the
_pattern_list_
operand, but is useful when
_pattern_list_
begins with the
&lt;hyphen&gt;
delimiter. It is also useful when it is more convenient to provide
multiple patterns as separate arguments.

Multiple
**\(mie**
and
**\(mif**
options are accepted and
_grep_
uses all of the patterns it is given while matching input text lines.
(Note that the order of evaluation is not specified. If an
implementation finds a null string as a pattern, it is allowed to use
that pattern first, matching every line, and effectively ignore any
other patterns.)

The
**\(miq**
option provides a means of easily determining whether or not a pattern
(or string) exists in a group of files. When searching several files,
it provides a performance improvement (because it can quit as soon as
it finds the first match) and requires less care by the user in
choosing the set of files to supply as arguments (because it exits zero
if it finds a match even if
_grep_
detected an access or read error on earlier
_file_
operands).

<a name="examples"></a>

# Examples


*  1.  
  To find all uses of the word
  **"Posix"**
  (in any case) in file
  **text.mm**
  and write with line numbers:

    
    grep (mii (min posix text.mm


*  2.  
  To find all empty lines in the standard input:

    
    grep ^$


or:

    
    grep (miv .


*  3.  
  Both of the following commands print all lines containing strings
  **"abc"**
  or
  **"def"**
  or both:

    
    grep (miE 'abc|def'
    
    grep (miF 'abc
    def'


*  4.  
  Both of the following commands print all lines matching exactly
  **"abc"**
  or
  **"def"**:

    
    grep (miE '^abc$|^def$'
    
    grep (miF (mix 'abc
    def'


<a name="rationale"></a>

# Rationale

This
_grep_
has been enhanced in an upwards-compatible way to provide the exact
functionality of the historical
_egrep_
and
_fgrep_
commands as well. It was the clear intention of the standard
developers to consolidate the three
_grep_s
into a single command.

The old
_egrep_
and
_fgrep_
commands are likely to be supported for many years to come as
implementation extensions, allowing historical applications to operate
unmodified.

Historical implementations usually silently ignored all but one of
multiply-specified
**\(mie**
and
**\(mif**
options, but were not consistent as to which specification was actually
used.

The
**\(mib**
option was omitted from the OPTIONS section because block numbers are
implementation-defined.

The System V restriction on using
**\(mi**
to mean standard input was omitted.

A definition of action taken when given a null BRE or ERE is specified.
This is an error condition in some historical implementations.

The
**\(mil**
option previously indicated that its use was undefined when no files
were explicitly named. This behavior was historical and placed an
unnecessary restriction on future implementations. It has been
removed.

The historical BSD
_grep_
**\(mis**
option practice is easily duplicated by redirecting standard output to
**/dev/null**.
The
**\(mis**
option required here is from System V.

The
**\(mix**
option, historically available only with
_fgrep_,
is available here for all of the non-obsolescent versions.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__sed_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Chapter 9_, _Regular Expressions_,
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
