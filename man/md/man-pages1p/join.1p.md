# join(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

join
— relational database operator

<a name="synopsis"></a>

# Synopsis

```


```
    join [(mia file_number|(miv file_number] [(mie string] [(mio list] [(mit char]
        [(mi1 field] [(mi2 field] file1 file2

<a name="description"></a>

# Description

The
_join_
utility shall perform an equality join on the files
_file1_
and
_file2_.
The joined files shall be written to the standard output.

The join field is a field in each file on which the files are
compared. The
_join_
utility shall write one line in the output for each pair of lines in
_file1_
and
_file2_
that have identical join fields. The output line by default shall
consist of the join field, then the remaining fields from
_file1_,
then the remaining fields from
_file2_.
This format can be changed by using the
**\(mio**
option (see below). The
**\(mia**
option can be used to add unmatched lines to the output. The
**\(miv**
option can be used to output only unmatched lines.

The files
_file1_
and
_file2_
shall be ordered in the collating sequence of
_sort_
**\(mib**
on the fields on which they shall be joined, by default the first in
each line. All selected output shall be written in the same collating
sequence.

The default input field separators shall be
&lt;blank&gt;
characters. In this case, multiple separators shall count as one field
separator, and leading separators shall be ignored. The default output
field separator shall be a
&lt;space&gt;.

The field separator and collating sequence can be changed by using the
**\(mit**
option (see below).

If the same key appears more than once in either file, all combinations
of the set of remaining fields in
_file1_
and the set of remaining fields in
_file2_
are output in the order of the lines encountered.

If the input files are not in the appropriate collating sequence, the
results are unspecified.

<a name="options"></a>

# Options

The
_join_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(mia&nbsp;file\_number**    
  Produce a line for each unpairable line in file
  _file_number_,
  where
  _file_number_
  is 1 or 2, in addition to the default output. If both
  **\(mia**1
  and
  **\(mia**2
  are specified, all unpairable lines shall be output.
* **\(mie&nbsp;string**  
  Replace empty output fields in the list selected by
  **\(mio**
  with the string
  _string_.
* **\(mio&nbsp;list**  
  Construct the output line to comprise the fields specified in
  _list_,
  each element of which shall have one of the following two forms:
    *  1.  
      _file\_number.field_, where
      _file_number_
      is a file number and
      _field_
      is a decimal integer field number
    *  2.  
      0 (zero), representing the join field

The elements of
_list_
shall be either
&lt;comma&gt;-separated
or
&lt;blank&gt;-separated,
as specified in Guideline 8 of the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.
The fields specified by
_list_
shall be written for all selected output lines. Fields selected by
_list_
that do not appear in the input shall be treated as empty output
fields. (See the
**\(mie**
option.) Only specifically requested fields shall be written. The
application shall ensure that
_list_
is a single command line argument.

* **\(mit&nbsp;char**  
  Use character
  _char_
  as a separator, for both input and output. Every appearance of
  _char_
  in a line shall be significant. When this option is specified, the
  collating sequence shall be the same as
  _sort_
  without the
  **\(mib**
  option.
* **\(miv&nbsp;file\_number**    
  Instead of the default output, produce a line only for each unpairable
  line in
  _file_number_,
  where
  _file_number_
  is 1 or 2. If both
  **\(miv**1
  and
  **\(miv**2
  are specified, all unpairable lines shall be output.
* **\(mi1&nbsp;field**  
  Join on the
  _field_th
  field of file 1. Fields are decimal integers starting with 1.
* **\(mi2&nbsp;field**  
  Join on the
  _field_th
  field of file 2. Fields are decimal integers starting with 1.

<a name="operands"></a>

# Operands

The following operands shall be supported:

* _file1_,&nbsp;_file2_  
  A pathname of a file to be joined. If either of the
  _file1_
  or
  _file2_
  operands is
  **'\(mi'**,
  the standard input shall be used in its place.

<a name="stdin"></a>

# Stdin

The standard input shall be used only if the
_file1_
or
_file2_
operand is
**'\(mi'**.
See the INPUT FILES section.

<a name="input-files"></a>

# Input Files

The input files shall be text files.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_join_:

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
  Determine the locale of the collating sequence
  _join_
  expects to have been used when the input files were sorted.
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

The
_join_
utility output shall be a concatenation of selected character fields.
When the
**\(mio**
option is not specified, the output shall be:

    
    "%s%s%sen", <join field>, <other file1 fields>,
        <other file2 fields>


If the join field is not the first field in a file, the
&lt;_other&nbsp;file&nbsp;fields_&gt; for that file shall be:

    
    <fields preceding join field>, <fields following join field>


When the
**\(mio**
option is specified, the output format shall be:

    
    "%sen", <concatenation of fields>


where the concatenation of fields is described by the
**\(mio**
option, above.

For either format, each field (except the last) shall be written with
its trailing separator character. If the separator is the default (\c
&lt;blank&gt;
characters), a single
&lt;space&gt;
shall be written after each field (except the last).

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
  All input files were output successfully.
* &gt;0  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

Pathnames consisting of numeric digits or of the form
_string.string_
should not be specified directly following the
**\(mio**
list.

<a name="examples"></a>

# Examples

The
**\(mio**
0 field essentially selects the union of the join fields. For example,
given file
**phone**:

    
    !Name           Phone Number
    Don             +1 123-456-7890
    Hal             +1 234-567-8901
    Yasushi         +2 345-678-9012


and file
**fax**:

    
    !Name           Fax Number
    Don             +1 123-456-7899
    Keith           +1 456-789-0122
    Yasushi         +2 345-678-9011


(where the large expanses of white space are meant to each represent a
single
&lt;tab&gt;),
the command:

    
    join (mit "<tab>" (mia 1 (mia 2 (mie '(unknown)' (mio 0,1.2,2.2 phone fax


would produce:

    
    !Name           Phone Number            Fax Number
    Don             +1 123-456-7890         +1 123-456-7899
    Hal             +1 234-567-8901         (unknown)
    Keith           (unknown)               +1 456-789-0122
    Yasushi         +2 345-678-9012         +2 345-678-9011


Multiple instances of the same key will produce combinatorial results.
The following:

    
    fa:
        a x
        a y
        a z
    fb:
        a p


will produce:

    
    a x p
    a y p
    a z p


And the following:

    
    fa:
        a b c
        a d e
    fb:
        a w x
        a y z
        a o p


will produce:

    
    a b c w x
    a b c y z
    a b c o p
    a d e w x
    a d e y z
    a d e o p


<a name="rationale"></a>

# Rationale

The
**\(mie**
option is only effective when used with
**\(mio**
because, unless specific fields are identified using
**\(mio**,
_join_
is not aware of what fields might be empty. The exception to this is
the join field, but identifying an empty join field with the
**\(mie**
string is not historical practice and some scripts might break if this
were changed.

The 0 field in the
**\(mio**
list was adopted from the Tenth Edition version of
_join_
to satisfy international objections that the
_join_
in the base documents does not support the \`\`full join'' or \`\`outer
join'' described in relational database literature. Although it has
been possible to include a join field in the output (by default, or by
field number using
**\(mio**),
the join field could not be included for an unpaired line selected by
**\(mia**.
The
**\(mio**
0 field essentially selects the union of the join fields.

This sort of outer join was not possible with the
_join_
commands in the base documents. The
**\(mio**
0 field was chosen because it is an upwards-compatible change for
applications. An alternative was considered: have the join field
represent the union of the fields in the files (where they are
identical for matched lines, and one or both are null for unmatched
lines). This was not adopted because it would break some historical
applications.

The ability to specify
_file2_
as
**\(mi**
is not historical practice; it was added for completeness.

The
**\(miv**
option is not historical practice, but was considered necessary because
it permitted the writing of
_only_
those lines that do not match on the join field, as opposed to the
**\(mia**
option, which prints both lines that do and do not match. This
additional facility is parallel with the
**\(miv**
option of
_grep_.

Some historical implementations have been encountered where a blank
line in one of the input files was considered to be the end of the
file; the description in this volume of POSIX.1-2008 does not cite this as an allowable case.

Earlier versions of this standard allowed
**\(mij**,
**\(mij1**,
**\(mij2**
options, and a form of the
**\(mio**
option that allowed the
_list_
option-argument to be multiple arguments. These forms are no longer
specified by POSIX.1-2008 but may be present in some implementations.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__awk_\^_,
__comm_\^_,
__sort_\^_,
__uniq_\^_

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
