# diff(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

diff
— compare two files

<a name="synopsis"></a>

# Synopsis

```


```
    diff [(mic|(mie|(mif|(miu|(miC n|(miU n] [(mibr] file1 file2

<a name="description"></a>

# Description

The
_diff_
utility shall compare the contents of
_file1_
and
_file2_
and write to standard output a list of changes necessary to convert
_file1_
into
_file2_.
This list should be minimal. No output shall be produced if the files
are identical.

<a name="options"></a>

# Options

The
_diff_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(mib**  
  Cause any amount of white space at the end of a line to be treated as a
  single
  &lt;newline&gt;
  (that is, the white-space characters preceding the
  &lt;newline&gt;
  are ignored) and other strings of white-space characters, not including
  &lt;newline&gt;
  characters, to compare equal.
* **\(mic**  
  Produce output in a form that provides three lines of copied context.
* **\(miC&nbsp;n**  
  Produce output in a form that provides
  _n_
  lines of copied context (where
  _n_
  shall be interpreted as a positive decimal integer).
* **\(mie**  
  Produce output in a form suitable as input for the
  _ed_
  utility, which can then be used to convert
  _file1_
  into
  _file2_.
* **\(mif**  
  Produce output in an alternative form, similar in format to
  **\(mie**,
  but not intended to be suitable as input for the
  _ed_
  utility, and in the opposite order.
* **\(mir**  
  Apply
  _diff_
  recursively to files and directories of the same name when
  _file1_
  and
  _file2_
  are both directories.

The
_diff_
utility shall detect infinite loops; that is, entering a previously
visited directory that is an ancestor of the last file encountered.
When it detects an infinite loop,
_diff_
shall write a diagnostic message to standard error and shall either
recover its position in the hierarchy or terminate.

* **\(miu**  
  Produce output in a form that provides three lines of unified context.
* **\(miU&nbsp;n**  
  Produce output in a form that provides
  _n_
  lines of unified context (where
  _n_
  shall be interpreted as a non-negative decimal integer).

<a name="operands"></a>

# Operands

The following operands shall be supported:

* _file1_,&nbsp;_file2_  
  A pathname of a file to be compared. If either the
  _file1_
  or
  _file2_
  operand is
  **'\(mi'**,
  the standard input shall be used in its place.

If both
_file1_
and
_file2_
are directories,
_diff_
shall not compare block special files, character special files, or FIFO
special files to any files and shall not compare regular files to
directories.
Further details are as specified in
_Diff Directory Comparison Format_.
The behavior of
_diff_
on other file types is implementation-defined when found in directories.

If only one of
_file1_
and
_file2_
is a directory,
_diff_
shall be applied to the non-directory file and the file contained in
the directory file with a filename that is the same as the last
component of the non-directory file.

<a name="stdin"></a>

# Stdin

The standard input shall be used only if one of the
_file1_
or
_file2_
operands references standard input. See the INPUT FILES section.

<a name="input-files"></a>

# Input Files

The input files may be of any type.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_diff_:

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
  contents of diagnostic messages written to standard error and
  informative messages written to standard output.
* _LC\_TIME_  
  Determine the locale for affecting the format of file timestamps
  written with the
  **\(miC**
  and
  **\(mic**
  options.
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.
* _TZ_  
  Determine the timezone used for calculating file timestamps written
  with a context format. If
  _TZ_
  is unset or null, an unspecified default timezone shall be used.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout


<a name="diff-directory-comparison-format"></a>

### Diff Directory Comparison Format


If both
_file1_
and
_file2_
are directories, the following output formats shall be used.

In the POSIX locale, each file that is present in only one directory
shall be reported using the following format:

    
    "Only in %s: %sen", <directory pathname>, <filename>


In the POSIX locale, subdirectories that are common to the two
directories may be reported with the following format:

    
    "Common subdirectories: %s and %sen", <directory1 pathname>,
        <directory2 pathname>


For each file common to the two directories, if the two files are not to
be compared: if the two files have the same device ID and file
serial number, or are both block special files that refer to the
same device, or are both character special files that refer to the
same device, in the POSIX locale the output format is unspecified.
Otherwise, in the POSIX locale an unspecified format shall be used
that contains the pathnames of the two files.

For each file common to the two directories, if the files are
compared and are identical, no output shall be written. If the two
files differ, the following format is written:

    
    "diff %s %s %sen", <diff_options>, <filename1>, <filename2>


where &lt;_diff\_options_&gt; are the options as specified on the command
line.

All directory pathnames listed in this section shall be relative to the
original command line arguments. All other names of files listed in
this section shall be filenames (pathname components).

<a name="diff-binary-output-format"></a>

### Diff Binary Output Format


In the POSIX locale, if one or both of the files being compared are not
text files, it is implementation-defined whether
_diff_
uses the binary file output format or the other formats as specified
below. The binary file output format shall contain the pathnames of
two files being compared and the string
**"differ"**.

If both files being compared are text files, depending on the options
specified, one of the following formats shall be used to write the
differences.

<a name="diff-default-output-format"></a>

### Diff Default Output Format


The default (without
**\(mie**,
**\(mif**,
**\(mic**,
**\(miC**,
**\(miu**,
or
**\(miU**
options)
_diff_
utility output shall contain lines of these forms:

    
    "%da%den", <num1>, <num2>
    
    "%da%d,%den", <num1>, <num2>, <num3>
    
    "%dd%den", <num1>, <num2>
    
    "%d,%dd%den", <num1>, <num2>, <num3>
    
    "%dc%den", <num1>, <num2>
    
    "%d,%dc%den", <num1>, <num2>, <num3>
    
    "%dc%d,%den", <num1>, <num2>, <num3>
    
    "%d,%dc%d,%den", <num1>, <num2>, <num3>, <num4>


These lines resemble
_ed_
subcommands to convert
_file1_
into
_file2_.
The line numbers before the action letters shall pertain to
_file1_;
those after shall pertain to
_file2_.
Thus, by exchanging
_a_
for
_d_
and reading the line in reverse order, one can also determine how to
convert
_file2_
into
_file1_.
As in
_ed_,
identical pairs (where
_num1_=
_num2_)
are abbreviated as a single number.

Following each of these lines,
_diff_
shall write to standard output all lines affected in the first
file using the format:

    
    "< %s", <line>


and all lines affected in the second file using the format:

    
    "> %s", <line>


If there are lines affected in both
_file1_
and
_file2_
(as with the
**c**
subcommand), the changes are separated with a line consisting of three
&lt;hyphen&gt;
characters:

    
    "(mi|(mi|(mien"


<a name="diff-mie-output-format"></a>

### Diff \(mie Output Format


With the
**\(mie**
option, a script shall be produced that shall, when provided as input
to
_ed_,
along with an appended
**w**
(write) command, convert
_file1_
into
_file2_.
Only the
**a**
(append),
**c**
(change),
**d**
(delete),
**i**
(insert), and
**s**
(substitute) commands of
_ed_
shall be used in this script. Text lines, except those consisting of
the single character
&lt;period&gt;
(\c
**'.'**),
shall be output as they appear in the file.

<a name="diff-mif-output-format"></a>

### Diff \(mif Output Format


With the
**\(mif**
option, an alternative format of script shall be produced. It is
similar to that produced by
**\(mie**,
with the following differences:

*  1.  
  It is expressed in reverse sequence; the output of
  **\(mie**
  orders changes from the end of the file to the beginning; the
  **\(mif**
  from beginning to end.
*  2.  
  The command form &lt;_lines_&gt; &lt;_command-letter_&gt; used by
  **\(mie**
  is reversed. For example, 10_c_ with
  **\(mie**
  would be
  _c_10
  with
  **\(mif**.
*  3.  
  The form used for ranges of line numbers is
  &lt;space&gt;-separated,
  rather than
  &lt;comma&gt;-separated.

<a name="diff-mic-or-mic-output-format"></a>

### Diff \(mic or \(miC Output Format


With the
**\(mic**
or
**\(miC**
option, the output format shall consist of affected lines along with
surrounding lines of context. The affected lines shall show which ones
need to be deleted or changed in
_file1_,
and those added from
_file2_.
With the
**\(mic**
option, three lines of context, if available, shall be written before
and after the affected lines. With the
**\(miC**
option, the user can specify how many lines of context are written.
The exact format follows.

The name and last modification time of each file shall be output in the
following format:

    
    "*** %s %sen", file1, <file1 timestamp>
    "(mi|(mi|(mi %s %sen", file2, <file2 timestamp>


Each &lt;_file_&gt; field shall be the pathname of the corresponding
file being compared. The pathname written for standard input is
unspecified.

In the POSIX locale, each &lt;_timestamp_&gt; field shall be equivalent
to the output from the following command:

    
    date "+%a %b %e %T %Y"


without the trailing
&lt;newline&gt;,
executed at the time of last modification of the corresponding file (or
the current time, if the file is standard input).

Then, the following output formats shall be applied for every set of
changes.

First, a line shall be written in the following format:

    
    "***************en"


Next, the range of lines in
_file1_
shall be written in the following format if the range contains
two or more lines:

    
    "*** %d,%d ****en", <beginning line number>, <ending line number>


and the following format otherwise:

    
    "*** %d ****en", <ending line number>


The ending line number of an empty range shall be the number of the
preceding line, or 0 if the range is at the start of the file.

Next, the affected lines along with lines of context (unaffected lines)
shall be written. Unaffected lines shall be written in the following
format:

    
    "  %s", <unaffected_line>


Deleted lines shall be written as:

    
    "(mi %s", <deleted_line>


Changed lines shall be written as:

    
    "! %s", <changed_line>


Next, the range of lines in
_file2_
shall be written in the following format if the range contains two
or more lines:

    
    "(mi|(mi|(mi %d,%d (mi|(mi|(mi|(mien", <beginning line number>, <ending line number>


and the following format otherwise:

    
    "(mi|(mi|(mi %d (mi|(mi|(mi|(mien", <ending line number>


Then, lines of context and changed lines shall be written as described in
the previous formats. Lines added from
_file2_
shall be written in the following format:

    
    "+ %s", <added_line>


<a name="diff-miu-or-miu-output-format"></a>

### Diff \(miu or \(miU Output Format


The
**\(miu**
or
**\(miU**
options behave like the
**\(mic**
or
**\(miC**
options, except that the context lines are not repeated; instead,
the context, deleted, and added lines are shown together, interleaved.
The exact format follows.

The name and last modification time of each file shall be output
in the following format:

    
    "--- %st%s%s %sn", file1, <file1 timestamp>, <file1 frac>, <file1 zone>
    "+++ %st%s%s %sn", file2, <file2 timestamp>, <file2 frac>, <file2 zone>


Each &lt;_file_&gt; field shall be the pathname of the corresponding file
being compared, or the single character
**'\(mi'**
if standard input is being compared. However, if the pathname contains
a
&lt;tab&gt;
or a
&lt;newline&gt;,
or if it does not consist entirely of characters taken
from the portable character set, the behavior is implementation-defined.

Each &lt;_timestamp_&gt; field shall be equivalent to the output from the
following command:

    
    date '+%Y-%m-%d %H:%M:%S'


without the trailing
&lt;newline&gt;,
executed at the time of last modification of the corresponding file
(or the current time, if the file is standard input).

Each &lt;_frac_&gt; field shall be either empty, or a decimal point
followed by at least one decimal digit, indicating the
fractional-seconds part (if any) of the file timestamp. The
number of fractional digits shall be at least the number needed to
represent the file's timestamp without loss of information.

Each &lt;_zone_&gt; field shall be of the form
**"shhmm"**,
where
**"shh"**
is a signed two-digit decimal number in the range \(mi24 through +25, and
**"mm"**
is an unsigned two-digit decimal number in the range 00 through 59.
It represents the timezone of the timestamp as the number of hours
(hh) and minutes (mm) east (+) or west (\(mi) of UTC for the timestamp.
If the hours and minutes are both zero, the sign shall be
**'+'**.
However, if the timezone is not an integral number of minutes away
from UTC, the &lt;_zone_&gt; field is implementation-defined.

Then, the following output formats shall be applied for every set
of changes.

First, the range of lines in each file shall be written in the
following format:

    
    "@@ -%s +%s @@", <file1 range>, <file2 range>


Each &lt;_range_&gt; field shall be of the form:

    
    "%1d", <beginning line number>


if the range contains exactly one line, and:

    
    "%1d,%1d", <beginning line number>, <number of lines>


otherwise. If a range is empty, its beginning line number shall be
the number of the line just before the range, or 0 if the empty
range starts the file.

Next, the affected lines along with lines of context shall be written.
Each non-empty unaffected line shall be written in the following format:

    
    " %s", <unaffected_line>


where the contents of the unaffected line shall be taken from
_file1_.
It is implementation-defined whether an empty unaffected line is written
as an empty line or a line containing a single
&lt;space&gt;
character. This line also represents the same line of
_file2_,
even though
_file2_'s
line may contain different contents due to the
**\(mib**.
Deleted lines shall be written as:

    
    "-%s", <deleted_line>


Added lines shall be written as:

    
    "+%s", <added_line>


The order of lines written shall be the same as that of the
corresponding file. A deleted line shall never be written
immediately after an added line.

If
**\(miU**
_n_
is specified, the output shall contain no more than
_n_
consecutive unaffected lines; and if the output contains an
affected line and this line is adjacent to up to
_n_
consecutive unaffected lines in the corresponding file, the output shall
contain these unaffected lines.
**\(miu**
shall act like
**\(miU**3.

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
  No differences were found.
* \01  
  Differences were found.
* &gt;1  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

If lines at the end of a file are changed and other lines are added,
_diff_
output may show this as a delete and add, as a change, or as a change
and add;
_diff_
is not expected to know which happened and users should not care about
the difference in output as long as it clearly shows the differences
between the files.

<a name="examples"></a>

# Examples

If
**dir1**
is a directory containing a directory named
**x**,
**dir2**
is a directory containing a directory named
**x**,
**dir1/x**
and
**dir2/x**
both contain files named
**date.out**,
and
**dir2/x**
contains a file named
**y**,
the command:

    
    diff (mir dir1 dir2


could produce output similar to:

    
    Common subdirectories: dir1/x and dir2/x
    Only in dir2/x: y
    diff (mir dir1/x/date.out dir2/x/date.out
    1c1
    < Mon Jul  2 13:12:16 PDT 1990
    (mi|(mi|(mi
    > Tue Jun 19 21:41:39 PDT 1990


<a name="rationale"></a>

# Rationale

The
**\(mih**
option was omitted because it was insufficiently specified and does not
add to applications portability.

Historical implementations employ algorithms that do not always produce
a minimum list of differences; the current language about making every
effort is the best this volume of POSIX.1-2008 can do, as there is no metric that could be
employed to judge the quality of implementations against any and all
file contents. The statement \`\`This list should be minimal'' clearly
implies that implementations are not expected to provide the following
output when comparing two 100-line files that differ in only one
character on a single line:

    
    1,100c1,100
    all 100 lines from file1 preceded with "< "
    (mi|(mi|(mi
    all 100 lines from file2 preceded with "> "


The \`\`Only in'' messages required when the
**\(mir**
option is specified are not used by most historical implementations if
the
**\(mie**
option is also specified. It is required here because it provides
useful information that must be provided to update a target directory
hierarchy to match a source hierarchy. The \`\`Common subdirectories''
messages are written by System V and 4.3 BSD when the
**\(mir**
option is specified. They are allowed here but are not required because
they are reporting on something that is the same, not reporting a
difference, and are not needed to update a target hierarchy.

The
**\(mic**
option, which writes output in a format using lines of context, has
been included. The format is useful for a variety of reasons, among
them being much improved readability and the ability to understand
difference changes when the target file has line numbers that differ
from another similar, but slightly different, copy. The
_patch_
utility is most valuable when working with difference listings using
a context format. The BSD version of
**\(mic**
takes an optional argument specifying the amount of context. Rather
than overloading
**\(mic**
and breaking the Utility Syntax Guidelines for
_diff_,
the standard developers decided to add a separate option for specifying
a context diff with a specified amount of context (\c
**\(miC**).
Also, the format for context
_diff_s
was extended slightly in 4.3 BSD to allow multiple changes that are
within context lines from each other to be merged together. The output
format contains an additional four
&lt;asterisk&gt;
characters after the range of affected lines in the first filename. This
was to provide a flag for old programs (like old versions of
_patch_)
that only understand the old context format. The version of context
described here does not require that multiple changes within context
lines be merged, but it does not prohibit it either. The extension is
upwards-compatible, so any vendors that wish to retain the old version
of
_diff_
can do so by adding the extra four
&lt;asterisk&gt;
characters (that is, utilities that currently use
_diff_
and understand the new merged format will also understand the old
unmerged format, but not _vice versa_).

The
**\(miu**
and
**\(miU**
options of GNU
_diff_
have been included. Their output format, designed by Wayne Davison,
takes up less space than
**\(mic**
and
**\(miC**
format, and in many cases is easier to read. The format's timestamps
do not vary by locale, so
_LC_TIME_
does not affect it. The format's line numbers are rendered with the
**%1d**
format, not
**%d**,
because the file format notation rules would allow extra
&lt;blank&gt;
characters to appear around the numbers.

The substitute command was added as an additional format for the
**\(mie**
option. This was added to provide implementations with a way to fix the
classic \`\`dot alone on a line'' bug present in many versions of
_diff_.
Since many implementations have fixed this bug, the standard developers
decided not to standardize broken behavior, but rather to provide the
necessary tool for fixing the bug. One way to fix this bug is to output
two periods whenever a lone period is needed, then terminate the append
command with a period, and then use the substitute command to convert
the two periods into one period.

The BSD-derived
**\(mir**
option was added to provide a mechanism for using
_diff_
to compare two file system trees. This behavior is useful, is standard
practice on all BSD-derived systems, and is not easily reproducible
with the
_find_
utility.

The requirement that
_diff_
not compare files in some circumstances, even though they have the same
name, is based on the actual output of historical implementations.
The specified behavior precludes the problems arising from running
into FIFOs and other files that would cause
_diff_
to hang waiting for input with no indication to the user that
_diff_
was hung. An earlier version of this standard specified the output
format more precisely, but in practice this requirement was widely
ignored and the benefit of standardization seemed small, so it is now
unspecified. In most common usage,
_diff_
**\(mir**
should indicate differences in the file hierarchies, not the difference
of contents of devices pointed to by the hierarchies.

Many early implementations of
_diff_
require seekable files. Since the System Interfaces volume of POSIX.1-2008 supports named pipes, the
standard developers decided that such a restriction was unreasonable.
Note also that the allowed filename
**\(mi**
almost always refers to a pipe.

No directory search order is specified for
_diff_.
The historical ordering is, in fact, not optimal, in that it prints out
all of the differences at the current level, including the statements
about all common subdirectories before recursing into those
subdirectories.

The message:

    
    "diff %s %s %sen", <diff_options>, <filename1>, <filename2>


does not vary by locale because it is the representation of a command,
not an English sentence.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__cmp_\^_,
__comm_\^_,
__ed_\^_,
__find_\^_

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
