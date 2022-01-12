# cmp(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

cmp
— compare two files

<a name="synopsis"></a>

# Synopsis

```


```
    cmp [(mil|(mis] file1 file2

<a name="description"></a>

# Description

The
_cmp_
utility shall compare two files. The
_cmp_
utility shall write no output if the files are the same. Under default
options, if they differ, it shall write to standard output the byte and
line number at which the first difference occurred. Bytes and lines
shall be numbered beginning with 1.

<a name="options"></a>

# Options

The
_cmp_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(mil**  
  (Lowercase ell.) Write the byte number (decimal) and the differing
  bytes (octal) for each difference.
* **\(mis**  
  Write nothing for differing files; return exit status only.

<a name="operands"></a>

# Operands

The following operands shall be supported:

* _file1_  
  A pathname of the first file to be compared. If
  _file1_
  is
  **'\(mi'**,
  the standard input shall be used.
* _file2_  
  A pathname of the second file to be compared. If
  _file2_
  is
  **'\(mi'**,
  the standard input shall be used.

If both
_file1_
and
_file2_
refer to standard input or refer to the same FIFO special, block
special, or character special file, the results are undefined.

<a name="stdin"></a>

# Stdin

The standard input shall be used only if the
_file1_
or
_file2_
operand refers to standard input. See the INPUT FILES section.

<a name="input-files"></a>

# Input Files

The input files can be any file type.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_cmp_:

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
  contents of diagnostic messages written to standard error and
  informative messages written to standard output.
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

In the POSIX locale, results of the comparison shall be written to
standard output. When no options are used, the format shall be:

    
    "%s %s differ: char %d, line %den", file1, file2,
        <byte number>, <line number>


When the
**\(mil**
option is used, the format shall be:

    
    "%d %o %oen", <byte number>, <differing byte>,
        <differing byte>


for each byte that differs. The first &lt;_differing&nbsp;byte_&gt; number is
from
_file1_
while the second is from
_file2_.
In both cases, &lt;_byte&nbsp;number_&gt; shall be relative to the beginning
of the file, beginning with 1.

No output shall be written to standard output when the
**\(mis**
option is used.

<a name="stderr"></a>

# Stderr

The standard error shall be used only for diagnostic messages. If the
**\(mil**
option is used and
_file1_
and
_file2_
differ in length, or if the
**\(mis**
option is not used and
_file1_
and
_file2_
are identical for the entire length of the shorter file, in the POSIX
locale the following diagnostic message shall be written:

    
    "cmp: EOF on %s%sen", <name of shorter file>, <additional info>


The &lt;_additional&nbsp;info_&gt; field shall either be null or a string
that starts with a
&lt;blank&gt;
and contains no
&lt;newline&gt;
characters. Some implementations report on the number of lines in
this case.

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
  The files are identical.
* \01  
  The files are different; this includes the case where one file is
  identical to the first part of the other.
* &gt;1  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

Although input files to
_cmp_
can be any type, the results might not be what would be expected on
character special device files or on file types not described by the
System Interfaces volume of POSIX.1-2008. Since this volume of POSIX.1-2008 does not specify the block size used when doing
input, comparisons of character special files need not compare all of
the data in those files.

For files which are not text files, line numbers simply reflect the
presence of a
&lt;newline&gt;,
without any implication that the file is organized into lines.

<a name="examples"></a>

# Examples

None.

<a name="rationale"></a>

# Rationale

The global language in
_Section 1.4_, _Utility Description Defaults_
indicates that using two mutually-exclusive options together produces
unspecified results. Some System V implementations consider the option
usage:

    
    cmp (mil (mis ...


to be an error. They also treat:

    
    cmp (mis (mil ...


as if no options were specified. Both of these behaviors are
considered bugs, but are allowed.

The word
**char**
in the standard output format comes from historical usage, even though
it is actually a byte number. When
_cmp_
is supported in other locales, implementations are encouraged to use
the word
_byte_
or its equivalent in another language. Users should not interpret this
difference to indicate that the functionality of the utility changed
between locales.

Some implementations report on the number of lines in the
identical-but-shorter file case. This is allowed by the inclusion of
the &lt;_additional&nbsp;info_&gt; fields in the output format. The
restriction on having a leading
&lt;blank&gt;
and no
&lt;newline&gt;
characters is to make parsing for the filename easier. It is recognized
that some filenames containing white-space characters make parsing
difficult anyway, but the restriction does aid programs used on systems
where the names are predominantly well behaved.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__comm_\^_,
__diff_\^_

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
