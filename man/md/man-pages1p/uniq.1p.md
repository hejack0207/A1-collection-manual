# uniq(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

uniq
— report or filter out repeated lines in a file

<a name="synopsis"></a>

# Synopsis

```


```
    uniq [(mic|(mid|(miu] [(mif fields] [(mis char] [input_file [output_file]]

<a name="description"></a>

# Description

The
_uniq_
utility shall read an input file comparing adjacent lines, and write
one copy of each input line on the output. The second and succeeding
copies of repeated adjacent input lines shall not be written.
The trailing
&lt;newline&gt;
of each line in the input shall be ignored when doing comparisons.

Repeated lines in the input shall not be detected if they are not
adjacent.

<a name="options"></a>

# Options

The
_uniq_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_,
except that
**'\(pl'**
may be recognized as an option delimiter as well as
**'\(mi'**.

The following options shall be supported:

* **\(mic**  
  Precede each output line with a count of the number of times the line
  occurred in the input.
* **\(mid**  
  Suppress the writing of lines that are not repeated in the input.
* **\(mif&nbsp;fields**  
  Ignore the first
  _fields_
  fields on each input line when doing comparisons, where
  _fields_
  is a positive decimal integer. A field is the maximal string matched
  by the basic regular expression:

    
    [[:blank:]]*[^[:blank:]]*


If the
_fields_
option-argument specifies more fields than appear on an input line, a
null string shall be used for comparison.

* **\(mis&nbsp;chars**  
  Ignore the first
  _chars_
  characters when doing comparisons, where
  _chars_
  shall be a positive decimal integer. If specified in conjunction with
  the
  **\(mif**
  option, the first
  _chars_
  characters after the first
  _fields_
  fields shall be ignored. If the
  _chars_
  option-argument specifies more characters than remain on an input line,
  a null string shall be used for comparison.
* **\(miu**  
  Suppress the writing of lines that are repeated in the input.

<a name="operands"></a>

# Operands

The following operands shall be supported:

* _input\_file_  
  A pathname of the input file. If the
  _input_file_
  operand is not specified, or if the
  _input_file_
  is
  **'\(mi'**,
  the standard input shall be used.
* _output\_file_  
  A pathname of the output file. If the
  _output_file_
  operand is not specified, the standard output shall be used. The
  results are unspecified if the file named by
  _output_file_
  is the file named by
  _input_file_.

<a name="stdin"></a>

# Stdin

The standard input shall be used only if no
_input_file_
operand is specified or if
_input_file_
is
**'\(mi'**.
See the INPUT FILES section.

<a name="input-files"></a>

# Input Files

The input file shall be a text file.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_uniq_:

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
  multi-byte characters in arguments and input files) and which
  characters constitute a
  &lt;blank&gt;
  in the current locale.
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

The standard output shall be used if no
_output_file_
operand is specified, and shall be used if the
_output_file_
operand is
**'\(mi'**
and the implementation treats the
**'\(mi'**
as meaning standard output. Otherwise, the standard output shall
not be used.
See the OUTPUT FILES section.

<a name="stderr"></a>

# Stderr

The standard error shall be used only for diagnostic messages.

<a name="output-files"></a>

# Output Files

If the
**\(mic**
option is specified, the output file shall be empty or each line
shall be of the form:

    
    "%d %s", <number of duplicates>, <line>


otherwise, the output file shall be empty or each line shall be
of the form:

    
    "%s", <line>


<a name="extended-description"></a>

# Extended Description

None.

<a name="exit-status"></a>

# Exit Status

The following exit values shall be returned:

* \00  
  The utility executed successfully.
* &gt;0  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

The
_sort_
utility can be used to cause repeated lines to be adjacent in the input
file.

<a name="examples"></a>

# Examples

The following input file data (but flushed left) was used for a test
series on
_uniq_:

    
    #01 foo0 bar0 foo1 bar1
    #02 bar0 foo1 bar1 foo1
    #03 foo0 bar0 foo1 bar1
    #04
    #05 foo0 bar0 foo1 bar1
    #06 foo0 bar0 foo1 bar1
    #07 bar0 foo1 bar1 foo0


What follows is a series of test invocations of the
_uniq_
utility that use a mixture of
_uniq_
options against the input file data. These tests verify the meaning of
_adjacent_.
The
_uniq_
utility views the input data as a sequence of strings delimited by
**'\en'**.
Accordingly, for the
_fields_th
member of the sequence,
_uniq_
interprets unique or repeated adjacent lines strictly relative to the
_fields_+1th
member.

*  1.  
  This first example tests the line counting option, comparing each line
  of the input file data starting from the second field:

    
    uniq (mic (mif 1 uniq_0I.t
        1 #01 foo0 bar0 foo1 bar1
        1 #02 bar0 foo1 bar1 foo1
        1 #03 foo0 bar0 foo1 bar1
        1 #04
        2 #05 foo0 bar0 foo1 bar1
        1 #07 bar0 foo1 bar1 foo0


The number
**'2'**,
prefixing the fifth line of output, signifies that the
_uniq_
utility detected a pair of repeated lines. Given the input data, this
can only be true when
_uniq_
is run using the
**\(mif&nbsp;1**
option (which shall cause
_uniq_
to ignore the first field on each input line).

*  2.  
  The second example tests the option to suppress unique lines, comparing
  each line of the input file data starting from the second field:

    
    uniq (mid (mif 1 uniq_0I.t
    #05 foo0 bar0 foo1 bar1


*  3.  
  This test suppresses repeated lines, comparing each line of the input
  file data starting from the second field:

    
    uniq (miu (mif 1 uniq_0I.t
    #01 foo0 bar0 foo1 bar1
    #02 bar0 foo1 bar1 foo1
    #03 foo0 bar0 foo1 bar1
    #04
    #07 bar0 foo1 bar1 foo0


*  4.  
  This suppresses unique lines, comparing each line of the input file
  data starting from the third character:

    
    uniq (mid (mis 2 uniq_0I.t


In the last example, the
_uniq_
utility found no input matching the above criteria.

<a name="rationale"></a>

# Rationale

Some historical implementations have limited lines to be 1\|080 bytes
in length, which does not meet the implied
{LINE_MAX}
limit.

Earlier versions of this standard allowed the
**\(mi**\c
_number_
and
**\(pl**\c
_number_
options. These options are no longer specified by POSIX.1-2008 but
may be present in some implementations.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__comm_\^_,
__sort_\^_

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
