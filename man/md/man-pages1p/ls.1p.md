# ls(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

ls
— list directory contents

<a name="synopsis"></a>

# Synopsis

```


```
    ls [(miikqrs] [(mig|lno|] [(miA|(mia] [(miC|(mim|(mix|(mi1] e
        [(miF|(mip] [(miH|(miL] [(miR|(mid] [(miS|(mif|(mit] [(mic|(miu] [file...]

<a name="description"></a>

# Description

For each operand that names a file of a type other than directory or
symbolic link to a directory,
_ls_
shall write the name of the file as well as any requested, associated
information. For each operand that names a file of type directory,
_ls_
shall write the names of files contained within the directory as well
as any requested, associated information. Filenames beginning
with a
&lt;period&gt;
(\c
**'.'**)
and any associated information shall not be written out unless
explicitly referenced, the
**\(miA**
or
**\(mia**
option is supplied, or an implementation-defined condition causes them
to be written. If one or more of the
**\(mid**,
**\(miF**,
or
**\(mil**
options are specified, and neither the
**\(miH**
nor the
**\(miL**
option is specified, for each operand that names a file of type
symbolic link to a directory,
_ls_
shall write the name of the file as well as any requested, associated
information. If none of the
**\(mid**,
**\(miF**,
or
**\(mil**
options are specified, or the
**\(miH**
or
**\(miL**
options are specified, for each operand that names a file of type
symbolic link to a directory,
_ls_
shall write the names of files contained within the directory as well
as any requested, associated information. In each case where the names
of files contained within a directory are written, if the directory
contains any symbolic links then
_ls_
shall evaluate the file information and file type to be those of
the symbolic link itself, unless the
**\(miL**
option is specified.

If no operands are specified,
_ls_
shall behave as if a single operand of dot (\c
**'.'**)
had been specified. If more than one operand is specified,
_ls_
shall write non-directory operands first; it shall sort directory and
non-directory operands separately according to the collating sequence
in the current locale.

The
_ls_
utility shall detect infinite loops; that is, entering a previously
visited directory that is an ancestor of the last file encountered.
When it detects an infinite loop,
_ls_
shall write a diagnostic message to standard error and shall either
recover its position in the hierarchy or terminate.

<a name="options"></a>

# Options

The
_ls_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(miA**  
  Write out all directory entries, including those whose names begin with a
  &lt;period&gt;
  (\c
  **'.'**)
  but excluding the entries dot and dot-dot (if they exist).
* **\(miC**  
  Write multi-text-column output with entries sorted down the columns,
  according to the collating sequence. The number of text columns and the
  column separator characters are unspecified, but should be adapted to
  the nature of the output device. This option disables long format output.
* **\(miF**  
  Do not follow symbolic links named as operands unless the
  **\(miH**
  or
  **\(miL**
  options are specified. Write a
  &lt;slash&gt;
  (\c
  **'/'**)
  immediately after each pathname that is a directory, an
  &lt;asterisk&gt;
  (\c
  **'*'**)
  after each that is executable, a
  &lt;vertical-line&gt;
  (\c
  **'|'**)
  after each that is a FIFO, and an at-sign (\c
  **'@'**)
  after each that is a symbolic link. For other file types, other
  symbols may be written.
* **\(miH**  
  Evaluate the file information and file type for symbolic links specified
  on the command line to be those of the file referenced by the link,
  and not the link itself; however,
  _ls_
  shall write the name of the link itself and not the file referenced by
  the link.
* **\(miL**  
  Evaluate the file information and file type for all symbolic links
  (whether named on the command line or encountered in a file hierarchy)
  to be those of the file referenced by the link, and not the link
  itself; however,
  _ls_
  shall write the name of the link itself and not the file referenced by
  the link. When
  **\(miL**
  is used with
  **\(mil**,
  write the contents of symbolic links in the long format (see the STDOUT
  section).
* **\(miR**  
  Recursively list subdirectories encountered. When a symbolic link to a
  directory is encountered, the directory shall not be recursively listed
  unless the
  **\(miL**
  option is specified.
  The use of
  **\(miR**
  with
  **\(mid**
  or
  **\(mif**
  produces unspecified results.
* **\(miS**  
  Sort with the primary key being file size (in decreasing order) and the
  secondary key being filename in the collating sequence (in increasing
  order).
* **\(mia**  
  Write out all directory entries, including those whose names begin with a
  &lt;period&gt;
  (\c
  **'.'**).
* **\(mic**  
  Use time of last modification of the file status information (see the Base Definitions volume of POSIX.1-2008,
  _**&lt;sys\_stat.h&gt;**_)
  instead of last modification of the file itself for sorting (\c
  **\(mit**)
  or writing (\c
  **\(mil**).
* **\(mid**  
  Do not follow symbolic links named as operands unless the
  **\(miH**
  or
  **\(miL**
  options are specified. Do not treat directories differently than other
  types of files. The use of
  **\(mid**
  with
  **\(miR**
  or
  **\(mif**
  produces unspecified results.
* **\(mif**  
  List the entries in directory operands in the order they appear in the
  directory. The behavior for non-directory operands is unspecified. This
  option shall turn on
  **\(mia**.
  When
  **\(mif**
  is specified, any occurrences of the
  **\(mir**,
  **\(miS**,
  and
  **\(mit**
  options shall be ignored and any occurrences of the
  **\(miA**,
  **\(mig**,
  **\(mil**,
  **\(min**,
  **\(mio**,
  and
  **\(mis**
  options may be ignored. The use of
  **\(mif**
  with
  **\(miR**
  or
  **\(mid**
  produces unspecified results.
* **\(mig**  
  Turn on the
  **\(mil**
  (ell) option, but disable writing the file's owner name or number.
  Disable the
  **\(miC**,
  **\(mim**,
  and
  **\(mix**
  options.
* **\(mii**  
  For each file, write the file's file serial number (see
  _stat_()
  in the System Interfaces volume of POSIX.1-2008).
* **\(mik**  
  Set the block size for the
  **\(mis**
  option and the per-directory block count written for the
  **\(mil**,
  **\(min**,
  **\(mis**,
  **\(mig**,
  and
  **\(mio**
  options (see the STDOUT section) to 1\|024 bytes.
* **\(mil**  
  (The letter ell.) Do not follow symbolic links named as operands unless
  the
  **\(miH**
  or
  **\(miL**
  options are specified. Write out in long format (see the STDOUT
  section). Disable the
  **\(miC**,
  **\(mim**,
  and
  **\(mix**
  options.
* **\(mim**  
  Stream output format; list pathnames across the page, separated by a
  &lt;comma&gt;
  character followed by a
  &lt;space&gt;
  character. Use a
  &lt;newline&gt;
  character as the list terminator and after the separator sequence when
  there is not room on a line for the next list entry. This option disables
  long format output.
* **\(min**  
  Turn on the
  **\(mil**
  (ell) option, but when writing the file's owner or group, write
  the file's numeric UID or GID rather than the user or group name,
  respectively. Disable the
  **\(miC**,
  **\(mim**,
  and
  **\(mix**
  options.
* **\(mio**  
  Turn on the
  **\(mil**
  (ell) option, but disable writing the file's group name or number.
  Disable the
  **\(miC**,
  **\(mim**,
  and
  **\(mix**
  options.
* **\(mip**  
  Write a
  &lt;slash&gt;
  (\c
  **'/'**)
  after each filename if that file is a directory.
* **\(miq**  
  Force each instance of non-printable filename characters and
  &lt;tab&gt;
  characters to be written as the
  &lt;question-mark&gt;
  (\c
  **'?'**)
  character. Implementations may provide this option by default if the
  output is to a terminal device.
* **\(mir**  
  Reverse the order of the sort to get reverse collating sequence oldest
  first, or smallest file size first depending on the other options
  given.
* **\(mis**  
  Indicate the total number of file system blocks consumed by each file
  displayed. If the
  **\(mik**
  option is also specified, the block size shall be 1\|024 bytes;
  otherwise, the block size is implementation-defined.
* **\(mit**  
  Sort with the primary key being time modified (most recently modified
  first) and the secondary key being filename in the collating sequence.
  For a symbolic link, the time used as the sort key is that of the
  symbolic link itself, unless
  _ls_
  is evaluating its file information to be that of the file referenced
  by the link (see the
  **\(miH**
  and
  **\(miL**
  options).
* **\(miu**  
  Use time of last access (see the Base Definitions volume of POSIX.1-2008,
  _**&lt;sys\_stat.h&gt;**_)
  instead of last modification of the file for sorting (\c
  **\(mit**)
  or writing (\c
  **\(mil**).
* **\(mix**  
  The same as
  **\(miC**,
  except that the multi-text-column output is produced with entries sorted
  across, rather than down, the columns. This option disables long format
  output.
* **\(mi1**  
  (The numeric digit one.) Force output to be one entry per line.
  This option does not disable long format output. (Long format output is
  enabled by
  **\(mig**,
  **\(mil**
  (ell),
  **\(min**,
  and
  **\(mio**;
  and disabled by
  **\(miC**,
  **\(mim**,
  and
  **\(mix**.)

If an option that enables long format output (\c
**\(mig**,
**\(mil**
(ell),
**\(min**,
and
**\\(mio\|**
is given with an option that disables long format output (\c
**\(miC**,
**\(mim**,
and
**\(mix**),
this shall not be considered an error. The last of these options
specified shall determine whether long format output is written.

If
**\(miR**,
**\(mid**,
or
**\(mif**
are specified, the results of specifying these mutually-exclusive options
are specified by the descriptions of these options above. If more
than one of any of the other options shown in the SYNOPSIS section in
mutually-exclusive sets are given, this shall not be considered an error;
the last option specified in each set shall determine the output.

Note that if
**\(mit**
is specified,
**\(mic**
and
**\(miu**
are not only mutually-exclusive with each other, they are also
mutually-exclusive with
**\(miS**
when determining sort order. But even if
**\(miS**
is specified after all occurrences of
**\(mic**,
**\(mit**,
and
**\(miu**,
the last use of
**\(mic**
or
**\(miu**
determines the timestamp printed when producing long format output.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _file_  
  A pathname of a file to be written. If the file specified is not
  found, a diagnostic message shall be output on standard error.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.  

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_ls_:

* _COLUMNS_  
  Determine the user's preferred column position width for writing
  multiple text-column output. If this variable contains a string
  representing a decimal integer, the
  _ls_
  utility shall calculate how many pathname text columns to write (see
  **\(miC**)
  based on the width provided. If
  _COLUMNS_
  is not set or invalid, an implementation-defined number of column
  positions shall be assumed, based on the implementation's knowledge of
  the output device. The column width chosen to write the names of files
  in any given directory shall be constant. Filenames shall not be
  truncated to fit into the multiple text-column output.
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
  Determine the locale for character collation information in determining
  the pathname collation sequence.
* _LC\_CTYPE_  
  Determine the locale for the interpretation of sequences of bytes of
  text data as characters (for example, single-byte as opposed to multi-byte
  characters in arguments) and which characters are defined as printable
  (character class
  **print**).
* _LC\_MESSAGES_    
  Determine the locale that should be used to affect the format and
  contents of diagnostic messages written to standard error.
* _LC\_TIME_  
  Determine the format and contents for date and time strings written by
  _ls_.
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.
* _TZ_  
  Determine the timezone for date and time strings written by
  _ls_.
  If
  _TZ_
  is unset or null, an unspecified default timezone shall be used.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

The default format shall be to list one entry per line to standard
output; the exceptions are to terminals or when one of the
**\(miC**,
**\(mim**,
or
**\(mix**
options is specified. If the output is to a terminal, the format is
implementation-defined.

When
**\(mim**
is specified, the format used for the last element of the list
shall be:

    
    "%sen", <filename>


The format used for each other element of the list shall be:

    
    "%s,%s", <filename>, <separator>


where, if there is not room for the next element of the list to fit
within the current line length, &lt;_separator_&gt; is a string containing
an optional
&lt;space&gt;
character and a mandatory
&lt;newline&gt;
character; otherwise it is a single
&lt;space&gt;
character.

If the
**\(mii**
option is specified, the file's file serial number (see the Base Definitions volume of POSIX.1-2008,
_**&lt;sys\_stat.h&gt;**_)
shall be written in the following format before any other output for
the corresponding entry:

    
    %u ", <file serial number>


If the
**\(mil**
option is specified, the following information shall be written for
files other than character special and block special files:

    
    "%s %u %s %s %u %s %sen", <file mode>, <number of links>,
        <owner name>, <group name>, <size>, <date and time>,
        <pathname>


If the
**\(mil**
option is specified, the following information shall be written
for character special and block special files:

    
    "%s %u %s %s %s %s %sen", <file mode>, <number of links>,
        <owner name>, <group name>, <device info>, <date and time>,
        <pathname>


In both cases if the file is a symbolic link and the
**\(miL**
option is also specified, this information shall be for the file
resolved from the symbolic link, except that the &lt;_pathname_&gt; field
shall contain the pathname of the symbolic link itself. If the file is
a symbolic link and the
**\(miL**
option is not specified, this information shall be about the link itself
and the &lt;_pathname_&gt; field shall be of the form:

    
    "%s (mi> %s", <pathname of link>, <contents of link>


The
**\(min**,
**\(mig**,
and
**\(mio**
options use the same format as
**\(mil**,
but with omitted items and their associated
&lt;blank&gt;
characters. See the OPTIONS section.

In both the preceding
**\(mil**
forms, if &lt;_owner name_&gt; or &lt;_group name_&gt; cannot be
determined, or if
**\(min**
is given, they shall be replaced with their associated numeric values
using the format
**%u**.

The &lt;_size_&gt; field shall contain the value that would be returned
for the file in the
_st_size_
field of
**struct stat**
(see the Base Definitions volume of POSIX.1-2008,
_**&lt;sys\_stat.h&gt;**_).
Note that for some file types this value is unspecified.

The &lt;_device&nbsp;info_&gt; field shall contain implementation-defined
information associated with the device in question.

The &lt;_date&nbsp;and&nbsp;time_&gt; field shall contain the appropriate date
and timestamp of when the file was last modified. In the POSIX locale,
the field shall be the equivalent of the output of the following
_date_
command:

    
    date "+%b %e %H:%M"


if the file has been modified in the last six months, or:

    
    date "+%b %e %Y"


(where two
&lt;space&gt;
characters are used between
**%e**
and
**%Y**)
if the file has not been modified in the last six months or if the
modification date is in the future, except that, in both cases, the final
&lt;newline&gt;
produced by
_date_
shall not be included and the output shall be as if the
_date_
command were executed at the time of the last modification date of the
file rather than the current time. When the
_LC_TIME_
locale category is not set to the POSIX locale, a different format and
order of presentation of this field may be used.

If the pathname was specified as a
_file_
operand, it shall be written as specified.

The file mode written under the
**\(mil**,
**\(min**,
**\(mig**,
and
**\(mio**
options shall consist of the following format:

    
    "%c%s%s%s%s", <entry type>, <owner permissions>,
        <group permissions>, <other permissions>,
        <optional alternate access method flag>


The &lt;_optional&nbsp;alternate&nbsp;access&nbsp;method&nbsp;flag_&gt; shall be the
empty string if there is no alternate or additional access control
method associated with the file; otherwise, it shall be a string
containing a single printable character that is not a
&lt;blank&gt;.

The &lt;_entry&nbsp;type_&gt; character shall describe the type of file, as
follows:

* d  
  Directory.
* b  
  Block special file.
* c  
  Character special file.
* l&nbsp;(ell)  
  Symbolic link.
* p  
  FIFO.
* \(mi  
  Regular file.

Implementations may add other characters to this list to represent
other implementation-defined file types.

The next three fields shall be three characters each:

* &lt;_owner permissions_&gt;    
  Permissions for the file owner class (see the Base Definitions volume of POSIX.1-2008,
  _Section 4.4_, _File Access Permissions_).
* &lt;_group permissions_&gt;    
  Permissions for the file group class.
* &lt;_other permissions_&gt;    
  Permissions for the file other class.

Each field shall have three character positions:

*  1.  
  If
  **'r'**,
  the file is readable; if
  **'\(mi'**,
  the file is not readable.
*  2.  
  If
  **'w'**,
  the file is writable; if
  **'\(mi'**,
  the file is not writable.
*  3.  
  The first of the following that applies:
    * S  
      If in &lt;_owner&nbsp;permissions_&gt;, the file is not executable and
      set-user-ID mode is set. If in &lt;_group&nbsp;permissions_&gt;, the file is
      not executable and set-group-ID mode is set.
    * s  
      If in &lt;_owner&nbsp;permissions_&gt;, the file is executable and
      set-user-ID mode is set. If in &lt;_group&nbsp;permissions_&gt;, the file is
      executable and set-group-ID mode is set.
    * T  
      If in &lt;_other&nbsp;permissions_&gt; and the file is a directory, search
      permission is not granted to others, and the restricted deletion flag
      is set.
    * t  
      If in &lt;_other&nbsp;permissions_&gt; and the file is a directory, search
      permission is granted to others, and the restricted deletion flag
      is set.
    * x  
      The file is executable or the directory is searchable.
    * \(mi  
      None of the attributes of
      **'S'**,
      **'s'**,
      **'T'**,
      **'t'**,
      or
      **'x'**
      applies.

Implementations may add other characters to this list for the third
character position. Such additions shall, however, be written in
lowercase if the file is executable or searchable, and in uppercase if
it is not.

If any of the
**\(mil**,
**\(min**,
**\(mis**,
**\(mig**,
or
**\(mio**
options is specified, each list of files within the directory shall be
preceded by a status line indicating the number of file system blocks
occupied by files in the directory in 512-byte units if the
**\(mik**
option is not specified, or 1\|024-byte units if the
**\(mik**
option is specified, rounded up to the next integral number of units,
if necessary. In the POSIX locale, the format shall be:

    
    "total %uen", <number of units in the directory>


If more than one directory, or a combination of non-directory files and
directories are written, either as a result of specifying multiple
operands, or the
**\(miR**
option, each list of files within a directory shall be preceded by:

    
    "en%s:en", <directory name>


If this string is the first thing to be written, the first
&lt;newline&gt;
shall not be written. This output shall precede the number of units in
the directory.

If the
**\(mis**
option is given, each file shall be written with the number of blocks
used by the file. Along with
**\(miC**,
**\(mi1**,
**\(mim**,
or
**\(mix**,
the number and a
&lt;space&gt;
shall precede the filename; with
**\(mil**,
**\(min**,
**\(mig**,
or
**\(mio**,
they shall precede each line describing a file.

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

Many implementations use the
&lt;equals-sign&gt;
(\c
**'='**)
to denote sockets bound to the file system for the
**\(miF**
option. Similarly, many historical implementations use the
**'s'**
character to denote sockets as the entry type characters for the
**\(mil**
option.

It is difficult for an application to use every part of the file modes
field of
_ls_
**\(mil**
in a portable manner. Certain file types and executable bits are not
guaranteed to be exactly as shown, as implementations may have
extensions. Applications can use this field to pass directly to a user
printout or prompt, but actions based on its contents should generally
be deferred, instead, to the
_test_
utility.

The output of
_ls_
(with the
**\(mil**
and related options) contains information that logically could be used
by utilities such as
_chmod_
and
_touch_
to restore files to a known state. However, this information is
presented in a format that cannot be used directly by those utilities
or be easily translated into a format that can be used. A character
has been added to the end of the permissions string so that
applications at least have an indication that they may be working in an
area they do not understand instead of assuming that they can translate
the permissions string into something that can be used. Future versions
or related documents may define one or more specific characters to be
used based on different standard additional or alternative access
control mechanisms.

As with many of the utilities that deal with filenames, the output of
_ls_
for multiple files or in one of the long listing formats must be used
carefully on systems where filenames can contain embedded white
space. Systems and system administrators should institute policies and
user training to limit the use of such filenames.

The number of disk blocks occupied by the file that it reports varies
depending on underlying file system type, block size units reported,
and the method of calculating the number of blocks. On some file
system types, the number is the actual number of blocks occupied by the
file (counting indirect blocks and ignoring holes in the file); on
others it is calculated based on the file size (usually making an
allowance for indirect blocks, but ignoring holes).

<a name="examples"></a>

# Examples

An example of a small directory tree being fully listed with
_ls_
**\(milaRF&nbsp;a**
in the POSIX locale:

    
    total 11
    drwxr-xr-x   3 fox      prog          64 Jul  4 12:07 ./
    drwxrwxrwx   4 fox      prog        3264 Jul  4 12:09 ../
    drwxr-xr-x   2 fox      prog          48 Jul  4 12:07 b/
    -rwxr--r--   1 fox      prog         572 Jul  4 12:07 foo*
    
    a/b:
    total 4
    drwxr-xr-x   2 fox      prog          48 Jul  4 12:07 ./
    drwxr-xr-x   3 fox      prog          64 Jul  4 12:07 ../
    -rw-r--r--   1 fox      prog         700 Jul  4 12:07 bar


<a name="rationale"></a>

# Rationale

Some historical implementations of the
_ls_
utility show all entries in a directory except dot and dot-dot when a
superuser invokes
_ls_
without specifying the
**\(mia**
option. When \`\`normal'' users invoke
_ls_
without specifying
**\(mia**,
they should not see information about any files with names beginning
with a
&lt;period&gt;
unless they were named as
_file_
operands.

Implementations are expected to traverse arbitrary depths when
processing the
**\(miR**
option. The only limitation on depth should be based on running out of
physical storage for keeping track of untraversed directories.

The
**\(mi1**
(one) option was historically found in BSD and BSD-derived
implementations only. It is required in this volume of POSIX.1-2008 so that conforming
applications might ensure that output is one entry per line, even if
the output is to a terminal.

The
**\(miS**
option was added in Issue 7, but had been provided by several
implementations for many years. The description given in the
standard documents historic practice, but does not match much of the
documentation that described its behavior. Historical documentation
typically described it as something like:

* **\(miS**  
  Sort by size (largest size first) instead of by name. Special character
  devices (listed last) are sorted by name.

even though the file type was never considered when sorting the output.
Character special files do typically sort close to the end of the list
because their file size on most implementations is zero. But they are
sorted alphabetically with any other files that happen to have the same
file size (zero), not sorted separately and added to the end.

This volume of POSIX.1-2008 is frequently silent about what happens when mutually-exclusive
options are specified. Except for
**\(miR**,
**\(mid**,
and
**\(mif**,
the
_ls_
utility is required to accept multiple options from each
mutually-exclusive option set without treating them as errors and to use
the behavior specified by the last option given in each mutually-exclusive
set. Since
_ls_
is one of the most aliased commands, it is important that the
implementation perform intuitively. For example, if the alias were:

    
    alias ls="ls (miC"


and the user typed
_ls_
**\(mi1**
(one), single-text-column output should result, not an error.

The
**\(mig**,
**\(mil**
(ell),
**\(min**,
and
**\(mio**
options are not mutually-exclusive options. They all enable long format
output. They work together to determine whether the file's owner is
written (no if
**\(mig**
is present), file's group is written (no if
**\(mio**
is present), and if the file's group or owner is written whether it is
written as the name (default) or a string representation of the UID or
GID number (if
**\(min**
is present). The
**\(miC**,
**\(mim**,
**\(mix**,
and
**\(mi1**
(one) are mutually-exclusive options and the first three of these disable
long format output. The
**\(mi1**
(one) option does not directly change whether or not long format output
is enabled, but by overriding
**\(miC**,
**\(mim**,
and
**\(mix**,
it can re-enable long format output that had been disabled by one of
these options.

Earlier versions of this standard did not describe the BSD
**\(miA**
option (like
**\(mia**,
but dot and dot-dot are not written out). It has been added due to
widespread implementation.

Implementations may make
**\(miq**
the default for terminals to prevent trojan horse attacks on terminals
with special escape sequences.
This is not required because:

*  *  
  Some control characters may be useful on some terminals; for example, a
  system might write them as
  **"\e001"**
  or
  **"^A"**.
*  *  
  Special behavior for terminals is not relevant to applications
  portability.

An early proposal specified that the
&lt;_optional&nbsp;alternate&nbsp;access&nbsp;method&nbsp;flag_&gt; had to be
**'\(pl'**
if there was an alternate access method used on the file or
&lt;space&gt;
if there was not. This was changed to be
&lt;space&gt;
if there is not and a single printable character if there is. This was
done for three reasons:

*  1.  
  There are historical implementations using characters other than
  **'\(pl'**.
*  2.  
  There are implementations that vary this character used in that
  position to distinguish between various alternate access methods in
  use.
*  3.  
  The standard developers did not want to preclude future specifications
  that might need a way to specify more than one alternate access
  method.

Nonetheless, implementations providing a single alternate access method
are encouraged to use
**'\(pl'**.

Earlier versions of this standard did not have the
**\(mik**
option, which meant that the
**\(mis**
option could not be used portably as its block size was
implementation-defined, and the units used to specify the
number of blocks occupied by files in a directory in an
_ls_
**\(mil**
listing were fixed as 512-byte units. The
**\(mik**
option has been added to provide a way for the
**\(mis**
option to be used portably, and for consistency it also changes the
aforementioned units from 512-byte to 1\|024-byte.

The &lt;_date&nbsp;and&nbsp;time_&gt; field in the
**\(mil**
format is specified only for the POSIX locale. As noted, the format can
be different in other locales. No mechanism for defining this is
present in this volume of POSIX.1-2008, as the appropriate vehicle is a messaging system;
that is, the format should be specified as a \`\`message''.

<a name="future-directions"></a>

# Future Directions

Allowing
**\(mif**
to ignore the
**\(miA**,
**\(mig**,
**\(mil**,
**\(min**,
**\(mio**,
and
**\(mis**
options may be removed in a future version.

<a name="see-also"></a>

# See Also

__chmod_\^_,
__find_\^_

The Base Definitions volume of POSIX.1-2008,
_Section 4.4_, _File Access Permissions_,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_,
_**&lt;sys\_stat.h&gt;**_

The System Interfaces volume of POSIX.1-2008,
__fstatat_\^(\|)_

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
