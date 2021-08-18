# sort(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

sort
— sort, merge, or sequence check text files

<a name="synopsis"></a>

# Synopsis

```


```
    sort [(mim] [(mio output] [(mibdfinru] [(mit char] [(mik keydef]... [file...]
    
    sort [(mic|(miC] [(mibdfinru] [(mit char] [(mik keydef] [file]

<a name="description"></a>

# Description

The
_sort_
utility shall perform one of the following functions:

*  1.  
  Sort lines of all the named files together and write the result to
  the specified output.
*  2.  
  Merge lines of all the named (presorted) files together and write the
  result to the specified output.
*  3.  
  Check that a single input file is correctly presorted.

Comparisons shall be based on one or more sort keys extracted from each
line of input (or, if no sort keys are specified, the entire line up
to, but not including, the terminating
&lt;newline&gt;),
and shall be performed using the collating sequence of the current
locale.

<a name="options"></a>

# Options

The
_sort_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_,
except for Guideline 9, and the
**\(mik**
_keydef_
option should follow the
**\(mib**,
**\(mid**,
**\(mif**,
**\(mii**,
**\(min**,
and
**\(mir**
options. In addition,
**'\(pl'**
may be recognized as an option delimiter as well as
**'\(mi'**.

The following options shall be supported:

* **\(mic**  
  Check that the single input file is ordered as specified by the
  arguments and the collating sequence of the current locale. Output
  shall not be sent to standard output. The exit code shall indicate
  whether or not disorder was detected or an error occurred. If
  disorder (or, with
  **\(miu**,
  a duplicate key) is detected, a warning message shall be sent to
  standard error indicating where the disorder or duplicate key
  was found.
* **\(miC**  
  Same as
  **\(mic**,
  except that a warning message shall not be sent to standard error
  if disorder or, with
  **\(miu**,
  a duplicate key is detected.
* **\(mim**  
  Merge only; the input file shall be assumed to be already sorted.
* **\(mio&nbsp;output**  
  Specify the name of an output file to be used instead of the standard
  output. This file can be the same as one of the input
  _file_s.
* **\(miu**  
  Unique: suppress all but one in each set of lines having equal keys.
  If used with the
  **\(mic**
  option, check that there are no lines with duplicate keys, in addition
  to checking that the input file is sorted.

The following options shall override the default ordering rules. When
ordering options appear independent of any key field specifications,
the requested field ordering rules shall be applied globally to all
sort keys. When attached to a specific key (see
**\(mik**),
the specified ordering options shall override all global ordering
options for that key.

* **\(mid**  
  Specify that only
  &lt;blank&gt;
  characters and alphanumeric characters, according to the current
  setting of
  _LC_CTYPE_,
  shall be significant in comparisons. The behavior is undefined for a
  sort key to which
  **\(mii**
  or
  **\(min**
  also applies.
* **\(mif**  
  Consider all lowercase characters that have uppercase equivalents,
  according to the current setting of
  _LC_CTYPE_,
  to be the uppercase equivalent for the purposes of comparison.
* **\(mii**  
  Ignore all characters that are non-printable, according to the current
  setting of
  _LC_CTYPE_.
  The behavior is undefined for a sort key for which
  **\(min**
  also applies.
* **\(min**  
  Restrict the sort key to an initial numeric string, consisting of
  optional
  &lt;blank&gt;
  characters, optional minus-sign, and zero or more digits with an
  optional radix character and thousands separators (as defined in the
  current locale), which shall be sorted by arithmetic value. An empty
  digit string shall be treated as zero. Leading zeros and signs on zeros
  shall not affect ordering.
* **\(mir**  
  Reverse the sense of comparisons.

The treatment of field separators can be altered using the options:

* **\(mib**  
  Ignore leading
  &lt;blank&gt;
  characters when determining the starting and ending positions of a
  restricted sort key. If the
  **\(mib**
  option is specified before the first
  **\(mik**
  option, it shall be applied to all
  **\(mik**
  options. Otherwise, the
  **\(mib**
  option can be attached independently to each
  **\(mik**
  _field_start_
  or
  _field_end_
  option-argument (see below).
* **\(mit&nbsp;char**  
  Use
  _char_
  as the field separator character;
  _char_
  shall not be considered to be part of a field (although it can be
  included in a sort key). Each occurrence of
  _char_
  shall be significant (for example, &lt;_char_&gt;&lt;_char_&gt; delimits an
  empty field). If
  **\(mit**
  is not specified,
  &lt;blank&gt;
  characters shall be used as default field separators; each maximal
  non-empty sequence of
  &lt;blank&gt;
  characters that follows a non-\c
  &lt;blank&gt;
  shall be a field separator.

Sort keys can be specified using the options:

* **\(mik&nbsp;keydef**  
  The
  _keydef_
  argument is a restricted sort key field definition. The format of this
  definition is:

    
    field_start[type][,field_end[type]]


where
_field_start_
and
_field_end_
define a key field restricted to a portion of the line (see the
EXTENDED DESCRIPTION section), and
_type_
is a modifier from the list of characters
**'b'**,
**'d'**,
**'f'**,
**'i'**,
**'n'**,
**'r'**.
The
**'b'**
modifier shall behave like the
**\(mib**
option, but shall apply only to the
_field_start_
or
_field_end_
to which it is attached. The other modifiers shall behave like the
corresponding options, but shall apply only to the key field to which
they are attached; they shall have this effect if specified with
_field_start_,
_field_end_,
or both. If any modifier is attached to a
_field_start_
or to a
_field_end_,
no option shall apply to either. Implementations shall support at
least nine occurrences of the
**\(mik**
option, which shall be significant in command line order. If no
**\(mik**
option is specified, a default sort key of the entire line shall be
used.

When there are multiple key fields, later keys shall be compared only
after all earlier keys compare equal. Except when the
**\(miu**
option is specified, lines that otherwise compare equal shall be
ordered as if none of the options
**\(mid**,
**\(mif**,
**\(mii**,
**\(min**,
or
**\(mik**
were present (but with
**\(mir**
still in effect, if it was specified) and with all bytes in the lines
significant to the comparison. The order in which lines that still
compare equal are written is unspecified.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _file_  
  A pathname of a file to be sorted, merged, or checked. If no
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
See the INPUT FILES section.

<a name="input-files"></a>

# Input Files

The input files shall be text files, except that the
_sort_
utility shall add a
&lt;newline&gt;
to the end of a file ending with an incomplete last line.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_sort_:

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
  Determine the locale for ordering rules.
* _LC\_CTYPE_  
  Determine the locale for the interpretation of sequences of bytes of
  text data as characters (for example, single-byte as opposed to
  multi-byte characters in arguments and input files) and the behavior of
  character classification for the
  **\(mib**,
  **\(mid**,
  **\(mif**,
  **\(mii**,
  and
  **\(min**
  options.
* _LC\_MESSAGES_    
  Determine the locale that should be used to affect the format and
  contents of diagnostic messages written to standard error.
* _LC\_NUMERIC_    
  Determine the locale for the definition of the radix character and
  thousands separator for the
  **\(min**
  option.
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

Unless the
**\(mio**
or
**\(mic**
options are in effect, the standard output shall contain the sorted
input.

<a name="stderr"></a>

# Stderr

The standard error shall be used for diagnostic messages. When
**\(mic**
is specified, if disorder is detected (or if
**\(miu**
is also specified and a duplicate key is detected), a message shall
be written to the standard error which identifies the input line at
which disorder (or a duplicate key) was detected. A warning
message about correcting an incomplete last line of an input file
may be generated, but need not affect the final exit status.

<a name="output-files"></a>

# Output Files

If the
**\(mio**
option is in effect, the sorted input shall be written to the file
_output_.

<a name="extended-description"></a>

# Extended Description

The notation:

    
    (mik field_start[type][,field_end[type]]


shall define a key field that begins at
_field_start_
and ends at
_field_end_
inclusive, unless
_field_start_
falls beyond the end of the line or after
_field_end_,
in which case the key field is empty. A missing
_field_end_
shall mean the last character of the line.

A field comprises a maximal sequence of non-separating characters and,
in the absence of option
**\(mit**,
any preceding field separator.

The
_field_start_
portion of the
_keydef_
option-argument shall have the form:

    
    field_number[.first_character]


Fields and characters within fields shall be numbered starting with 1.
The
_field_number_
and
_first_character_
pieces, interpreted as positive decimal integers, shall specify the
first character to be used as part of a sort key. If
_.first_character_
is omitted, it shall refer to the first character of the field.

The
_field_end_
portion of the
_keydef_
option-argument shall have the form:

    
    field_number[.last_character]


The
_field_number_
shall be as described above for
_field_start._
The
_last_character_
piece, interpreted as a non-negative decimal integer, shall specify the
last character to be used as part of the sort key. If
_last_character_
evaluates to zero or
_.last_character_
is omitted, it shall refer to the last character of the field specified
by
_field_number_.

If the
**\(mib**
option or
**b**
type modifier is in effect, characters within a field shall be counted
from the first non-\c
&lt;blank&gt;
in the field. (This shall apply separately to
_first_character_
and
_last_character_.)

<a name="exit-status"></a>

# Exit Status

The following exit values shall be returned:

* \00  
  All input files were output successfully, or
  **\(mic**
  was specified and the input file was correctly sorted.
* \01  
  Under the
  **\(mic**
  option, the file was not ordered as specified, or if the
  **\(mic**
  and
  **\(miu**
  options were both specified, two input lines were found with equal
  keys.
* &gt;1  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

The default value for
**\(mit**,
&lt;blank&gt;,
has different properties from, for example,
**\(mit**\c
"&lt;space&gt;". If a line contains:

    
    <space><space>foo


the following treatment would occur with default separation as opposed
to specifically selecting a
&lt;space&gt;:
.TS
center box tab(@);
cB | cB | cB
n | l | l.
Field@Default@\(mit "&lt;space&gt;"
_
1@&lt;space&gt;&lt;space&gt;foo@_empty_
2@_empty_@_empty_
3@_empty_@foo
.TE

The leading field separator itself is included in a field when
**\(mit**
is not used. For example, this command returns an exit status of zero,
meaning the input was already sorted:

    
    sort (mic (mik 2 <<eof
    y<tab>b
    x<space>a
    eof


(assuming that a
&lt;tab&gt;
precedes the
&lt;space&gt;
in the current collating sequence). The field separator is not included
in a field when it is explicitly set via
**\(mit**.
This is historical practice and allows usage such as:

    
    sort (mit "|" (mik 2n <<eof
    Atlanta|425022|Georgia
    Birmingham|284413|Alabama
    Columbia|100385|South Carolina
    eof


where the second field can be correctly sorted numerically without
regard to the non-numeric field separator.

The wording in the OPTIONS section clarifies that the
**\(mib**,
**\(mid**,
**\(mif**,
**\(mii**,
**\(min**,
and
**\(mir**
options have to come before the first sort key specified if they are
intended to apply to all specified keys. The way it is described in
this volume of POSIX.1-2008 matches historical practice, not historical documentation.
The results are unspecified if these options are specified after a
**\(mik**
option.

The
**\(mif**
option might not work as expected in locales where there is not a
one-to-one mapping between an uppercase and a lowercase letter.

<a name="examples"></a>

# Examples


*  1.  
  The following command sorts the contents of
  **infile**
  with the second field as the sort key:

    
    sort (mik 2,2 infile


*  2.  
  The following command sorts, in reverse order, the contents of
  **infile1**
  and
  **infile2**,
  placing the output in
  **outfile**
  and using the second character of the second field as the sort key
  (assuming that the first character of the second field is the field
  separator):

    
    sort (mir (mio outfile (mik 2.2,2.2 infile1 infile2


*  3.  
  The following command sorts the contents of
  **infile1**
  and
  **infile2**
  using the second non-\c
  &lt;blank&gt;
  of the second field as the sort key:

    
    sort (mik 2.2b,2.2b infile1 infile2


*  4.  
  The following command prints the System&nbsp;V password file (user
  database) sorted by the numeric user ID (the third
  &lt;colon&gt;-separated
  field):

    
    sort (mit : (mik 3,3n /etc/passwd


*  5.  
  The following command prints the lines of the already sorted file
  **infile**,
  suppressing all but one occurrence of lines having the same third
  field:

    
    sort (mium (mik 3.1,3.0 infile


<a name="rationale"></a>

# Rationale

Examples in some historical documentation state that options
**\(mium**
with one input file keep the first in each set of lines with equal
keys. This behavior was deemed to be an implementation artifact and
was not standardized.

The
**\(miz**
option was omitted; it is not standard practice on most systems and is
inconsistent with using
_sort_
to sort several files individually and then merge them together. The
text concerning
**\(miz**
in historical documentation appeared to require implementations to
determine the proper buffer length during the sort phase of operation,
but not during the merge.

The
**\(miy**
option was omitted because of non-portability. The
**\(miM**
option, present in System V, was omitted because of non-portability in
international usage.

An undocumented
**\(miT**
option exists in some implementations. It is used to specify a
directory for intermediate files. Implementations are encouraged to
support the use of the
_TMPDIR_
environment variable instead of adding an option to support this
functionality.

The
**\(mik**
option was added to satisfy two objections. First, the zero-based
counting used by
_sort_
is not consistent with other utility conventions. Second, it did not
meet syntax guideline requirements.

Historical documentation indicates that \`\`setting
**\(min**
implies
**\(mib**''.
The description of
**\(min**
already states that optional leading &lt;blank&gt;s are tolerated in doing
the comparison. If
**\(mib**
is enabled, rather than implied, by
**\(min**,
this has unusual side-effects. When a character offset is used in a
column of numbers (for example, to sort modulo 100), that offset is
measured relative to the most significant digit, not to the column.
Based upon a recommendation from the author of the original
_sort_
utility, the
**\(mib**
implication has been omitted from this volume of POSIX.1-2008, and an application wishing to
achieve the previously mentioned side-effects has to code the
**\(mib**
flag explicitly.

Earlier versions of this standard allowed the
**\(mio**
option to appear after operands. Historical practice allowed all
options to be interspersed with operands. This version of the
standard allows implementations to accept options after operands
but conforming applications should not use this form.

Earlier versions of this standard also allowed the
**\(mi**\c
_number_
and
**\(pl**\c
_number_
options. These options are no longer specified by POSIX.1-2008 but may
be present in some implementations.

Historical implementations produced a message on standard error when
**\(mic**
was specified and disorder was detected, and when
**\(mic**
and
**\(miu**
were specified and a duplicate key was detected. An earlier version of
this standard contained wording that did not make it clear that this
message was allowed and some implementations removed this message to
be sure that they conformed to the standard's requirements. Confronted
with this difference in behavior, interactive users that wanted to be
sure that they got visual feedback instead of just exit code 1 could
have used a command like:

    
    sort (mic file || echo disorder


whether or not the
_sort_
utility provided a message in this case. But, it was not easy for a user
to find where the disorder or duplicate key occurred on implementations
that do not produce a message, especially when some parts of the input
line were not part of the key and when one or more of the
**\(mib**,
**\(mid**,
**\(mif**,
**\(mii**,
**\(min**,
or
**\(mi**r
options or
_keydef_
type modifiers were in use. POSIX.1-2008 requires a message to be
produced in this case. POSIX.1-2008 also contains the
**\(miC**
option giving users the ability to choose either behavior.

When a disorder or duplicate is found when the
**\(mic**
option is specified, some implementations print a message containing
the first line that is out of order or contains a duplicate key; others
print a message specifying the line number of the offending line. This
standard allows either type of message.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__comm_\^_,
__join_\^_,
__uniq_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_

The System Interfaces volume of POSIX.1-2008,
__toupper_\^(\|)_

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
