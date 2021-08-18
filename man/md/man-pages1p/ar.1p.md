# ar(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

ar
— create and maintain library archives

<a name="synopsis"></a>

# Synopsis

```


```
    ar (mid [(miv] archive file...
    
    ar (mim [(miv] archive file...
    ar (mim (mia [(miv] posname archive file...
    ar (mim (mib [(miv] posname archive file...
    ar (mim (mii [(miv] posname archive file...
    
    ar (mip [(miv] [(mis] archive [file...]
    
    ar (miq [(micv] archive file...
    
    ar (mir [(micuv] archive file...
    
    ar (mir (mia [(micuv] posname archive file...
    ar (mir (mib [(micuv] posname archive file...
    ar (mir (mii [(micuv] posname archive file...
    
    ar (mit [(miv] [(mis] archive [file...]
    
    ar (mix [(miv] [(misCT] archive [file...]

<a name="description"></a>

# Description


The
_ar_
utility is part of the Software Development Utilities option.

The
_ar_
utility can be used to create and maintain groups of files combined
into an archive. Once an archive has been created, new files can be
added, and existing files in an archive can be extracted, deleted, or
replaced. When an archive consists entirely of valid object files, the
implementation shall format the archive so that it is usable as a
library for link editing (see
_c99_
and
_fort77_).
When some of the archived files are not valid object files, the
suitability of the archive for library use is undefined.
If an archive consists entirely of printable files, the entire
archive shall be printable.

When
_ar_
creates an archive, it creates administrative information indicating
whether a symbol table is present in the archive. When there is at
least one object file that
_ar_
recognizes as such in the archive, an archive symbol table shall be
created in the archive and maintained by
_ar_;
it is used by the link editor to search the archive. Whenever the
_ar_
utility is used to create or update the contents of such an archive,
the symbol table shall be rebuilt. The
**\(mis**
option shall force the symbol table to be rebuilt.

All
_file_
operands can be pathnames. However, files within archives shall be
named by a filename, which is the last component of the pathname used
when the file was entered into the archive. The comparison of
_file_
operands to the names of files in archives shall be performed by
comparing the last component of the operand to the name of the file
in the archive.

It is unspecified whether multiple files in the archive may be
identically named. In the case of such files, however, each
_file_
and
_posname_
operand shall match only the first file in the archive having a name
that is the same as the last component of the operand.

<a name="options"></a>

# Options

The
_ar_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_,
except for Guideline 9.

The following options shall be supported:

* **\(mia**  
  Position new files in the archive after the file named by the
  _posname_
  operand.
* **\(mib**  
  Position new files in the archive before the file named by the
  _posname_
  operand.
* **\(mic**  
  Suppress the diagnostic message that is written to standard error by
  default when the archive
  _archive_
  is created.
* **\(miC**  
  Prevent extracted files from replacing like-named files in the
  file system. This option is useful when
  **\(miT**
  is also used, to prevent truncated filenames from replacing files with
  the same prefix.
* **\(mid**  
  Delete one or more
  _file_s
  from
  _archive_.
* **\(mii**  
  Position new files in the archive before the file in the archive
  named by the
  _posname_
  operand (equivalent to
  **\(mib**).
* **\(mim**  
  Move the named files in the archive. The
  **\(mia**,
  **\(mib**,
  or
  **\(mii**
  options with the
  _posname_
  operand indicate the position; otherwise, move the names files in the
  archive to the end of the archive.
* **\(mip**  
  Write the contents of the
  _file_s
  in the archive named by
  _file_
  operands from
  _archive_
  to the standard output. If no
  _file_
  operands are specified, the contents of all files in the archive shall
  be written in the order of the archive.
* **\(miq**  
  Append the named files to the end of the archive. In this case
  _ar_
  does not check whether the added files are already in the archive.
  This is useful to bypass the searching otherwise done when creating a
  large archive piece by piece.
* **\(mir**  
  Replace or add
  _file_s
  to
  _archive_.
  If the archive named by
  _archive_
  does not exist, a new archive shall be created and a diagnostic message
  shall be written to standard error (unless the
  **\(mic**
  option is specified). If no
  _file_s
  are specified and the
  _archive_
  exists, the results are undefined. Files that replace existing files in
  the archive shall not change the order of the archive. Files that do
  not replace existing files in the archive shall be appended to the
  archive
  unless a
  **\(mia**,
  **\(mib**,
  or
  **\(mii**
  option specifies another position.
* **\(mis**  
  Force the regeneration of the archive symbol table even if
  _ar_
  is not invoked with an option that modifies the archive contents. This
  option is useful to restore the archive symbol table after it has been
  stripped; see
  _strip_.
* **\(mit**  
  Write a table of contents of
  _archive_
  to the standard output. Only the files specified by the
  _file_
  operands shall be included in the written list. If no
  _file_
  operands are specified, all files in
  _archive_
  shall be included in the order of the archive.
* **\(miT**  
  Allow filename truncation of extracted files whose archive names are
  longer than the file system can support. By default, extracting a file
  with a name that is too long shall be an error; a diagnostic message
  shall be written and the file shall not be extracted.
* **\(miu**  
  Update older files in the archive. When used with the
  **\(mir**
  option, files in the archive shall be replaced only if the
  corresponding
  _file_
  has a modification time that is at least as new as the modification
  time of the file in the archive.
* **\(miv**  
  Give verbose output. When used with the option characters
  **\(mid**,
  **\(mir**,
  or
  **\(mix**,
  write a detailed file-by-file description of the archive creation and
  maintenance activity, as described in the STDOUT section.

When used with
**\(mip**,
write the name of the file in the archive to the standard output before
writing the file in the archive itself to the standard output, as
described in the STDOUT section.

When used with
**\(mit**,
include a long listing of information about the files in the archive,
as described in the STDOUT section.

* **\(mix**  
  Extract the files in the archive named by the
  _file_
  operands from
  _archive_.
  The contents of the archive shall not be changed. If no
  _file_
  operands are given, all files in the archive shall be extracted. The
  modification time of each file extracted shall be set to the time the
  file is extracted from the archive.

<a name="operands"></a>

# Operands

The following operands shall be supported:

* _archive_  
  A pathname of the archive.
* _file_  
  A pathname. Only the last component shall be used when comparing
  against the names of files in the archive. If two or more
  _file_
  operands have the same last pathname component (basename), the results
  are unspecified. The implementation's archive format shall not truncate
  valid filenames of files added to or replaced in the archive.
* _posname_  
  The name of a file in the archive, used for relative positioning; see
  options
  **\(mim**
  and
  **\(mir**.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

The archive named by
_archive_
shall be a file in the format created by
_ar_
**\(mir**.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_ar_:

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
* _LC\_TIME_  
  Determine the format and content for date and time strings written by
  _ar_
  **\(mitv**.
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.
* _TMPDIR_  
  Determine the pathname that overrides the default directory for
  temporary files, if any.
* _TZ_  
  Determine the timezone used to calculate date and time strings written
  by
  _ar_
  **\(mitv**.
  If
  _TZ_
  is unset or null, an unspecified default timezone shall be used.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

If the
**\(mid**
option is used with the
**\(miv**
option, the standard output format shall be:

    
    "d (mi %sen", <file>


where
_file_
is the operand specified on the command line.

If the
**\(mip**
option is used with the
**\(miv**
option,
_ar_
shall precede the contents of each file with:

    
    "en<%s>enen", <file>


where
_file_
is the operand specified on the command line, if
_file_
operands were specified, and the name of the file in the archive if
they were not.

If the
**\(mir**
option is used with the
**\(miv**
option:

*  *  
  If
  _file_
  is already in the archive, the standard output format shall be:

    
    "r (mi %sen", <file>


where &lt;_file_&gt; is the operand specified on the command line.

*  *  
  If
  _file_
  is not already in the archive, the standard output format shall be:

    
    "a (mi %sen", <file>


where &lt;_file_&gt; is the operand specified on the command line.

If the
**\(mit**
option is used,
_ar_
shall write the names of the files in the archive to the standard
output in the format:

    
    "%sen", <file>


where
_file_
is the operand specified on the command line, if
_file_
operands were specified, or the name of the file in the archive if they
were not.

If the
**\(mit**
option is used with the
**\(miv**
option, the standard output format shall be:

    
    "%s %u/%u %u %s %d %d:%d %d %sen", <member mode>, <user ID>,
        <group ID>, <number of bytes in member>,
        <abbreviated month>, <day-of-month>, <hour>,
        <minute>, <year>, <file>


where:

* &lt;_file_&gt;  
  Shall be the operand specified on the command line, if
  _file_
  operands were specified, or the name of the file in the archive if they
  were not.
* &lt;_member&nbsp;mode_&gt;    
  Shall be formatted the same as the &lt;_file&nbsp;mode_&gt; string defined in
  the STDOUT section of
  _ls_,
  except that the first character, the &lt;_entry&nbsp;type_&gt;, is not used;
  the string represents the file mode of the file in the archive at the
  time it was added to or replaced in the archive.  

The following represent the last-modification time of a file when it
was most recently added to or replaced in the archive:

* &lt;_abbreviated&nbsp;month_&gt;    
  Equivalent to the format of the
  **%b**
  conversion specification format in
  _date_.
* &lt;_day-of-month_&gt;    
  Equivalent to the format of the
  **%e**
  conversion specification format in
  _date_.
* &lt;_hour_&gt;  
  Equivalent to the format of the
  **%H**
  conversion specification format in
  _date_.
* &lt;_minute_&gt;  
  Equivalent to the format of the
  **%M**
  conversion specification format in
  _date_.
* &lt;_year_&gt;  
  Equivalent to the format of the
  **%Y**
  conversion specification format in
  _date_.

When
_LC_TIME_
does not specify the POSIX locale, a different format and order of
presentation of these fields relative to each other may be used in a
format appropriate in the specified locale.

If the
**\(mix**
option is used with the
**\(miv**
option, the standard output format shall be:

    
    "x (mi %sen", <file>


where
_file_
is the operand specified on the command line, if
_file_
operands were specified, or the name of the file in the archive if they
were not.

<a name="stderr"></a>

# Stderr

The standard error shall be used only for diagnostic messages.
The diagnostic message about creating a new archive when
**\(mic**
is not specified shall not modify the exit status.

<a name="output-files"></a>

# Output Files

Archives are files with unspecified formats.

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

None.

<a name="examples"></a>

# Examples

None.

<a name="rationale"></a>

# Rationale

The archive format is not described. It is recognized that there are
several known
_ar_
formats, which are not compatible. The
_ar_
utility is included, however, to allow creation of archives that
are intended for use only on one machine. The archive is
specified as a file, and it can be moved as a file. This does allow an
archive to be moved from one machine to another machine that uses the
same implementation of
_ar_.

Utilities such as
_pax_
(and its forebears
_tar_
and
_cpio_)
also provide portable \`\`archives''. This is a not a duplication; the
_ar_
utility is included to provide an interface primarily for
_make_
and the compilers, based on a historical model.

In historical implementations, the
**\(miq**
option (available on XSI-conforming systems) is known to execute
quickly because
_ar_
does not check on whether the added members are already in the
archive. This is useful to bypass the searching otherwise done when
creating a large archive piece-by-piece. These remarks may but need not
remain true for a brand new implementation of this utility; hence,
these remarks have been moved into the RATIONALE.

BSD implementations historically required applications to provide the
**\(mis**
option whenever the archive was supposed to contain a symbol table.
As in this volume of POSIX.1-2008, System V historically creates or updates an archive symbol
table whenever an object file is removed from, added to, or updated
in the archive.

The OPERANDS section requires what might seem to be true without
specifying it: the archive cannot truncate the filenames below
{NAME_MAX}.
Some historical implementations do so, however, causing unexpected
results for the application. Therefore, this volume of POSIX.1-2008 makes the requirement
explicit to avoid misunderstandings.

According to the System V documentation, the options
**\(midmpqrtx**
are not required to begin with a
&lt;hyphen&gt;
(\c
**'\(mi'**).
This volume of POSIX.1-2008 requires that a conforming application use the leading
&lt;hyphen&gt;.

The archive format used by the 4.4 BSD implementation is documented in
this RATIONALE as an example:

A file created by
_ar_
begins with the \`\`magic'' string
**"!&lt;arch&gt;\en"**.
The rest of the archive is made up of objects, each of which is
composed of a header for a file, a possible filename, and the file
contents. The header is portable between machine architectures, and, if
the file contents are printable, the archive is itself printable.

The header is made up of six ASCII fields, followed by a two-character
trailer. The fields are the object name (16 characters), the file last
modification time (12 characters), the user and group IDs (each 6
characters), the file mode (8 characters), and the file size (10
characters). All numeric fields are in decimal, except for the file
mode, which is in octal.

The modification time is the file
_st_mtime_
field. The user and group IDs are the file
_st_uid_
and
_st_gid_
fields. The file mode is the file
_st_mode_
field. The file size is the file
_st_size_
field. The two-byte trailer is the string
**"\`&lt;newline&gt;"**.

Only the name field has any provision for overflow. If any filename is
more than 16 characters in length or contains an embedded space, the
string
**"#1/"**
followed by the ASCII length of the name is written in the name field.
The file size (stored in the archive header) is incremented by the
length of the name. The name is then written immediately following the
archive header.

Any unused characters in any of these fields are written as
&lt;space&gt;
characters. If any fields are their particular maximum number of
characters in length, there is no separation between the fields.

Objects in the archive are always an even number of bytes long; files
that are an odd number of bytes long are padded with a
&lt;newline&gt;,
although the size in the header does not reflect this.

The
_ar_
utility description requires that (when all its members are valid
object files)
_ar_
produce an object code library, which the linkage editor can use to
extract object modules. If the linkage editor needs a symbol table to
permit random access to the archive,
_ar_
must provide it; however,
_ar_
does not require a symbol table.

The BSD
**\(mio**
option was omitted. It is a rare conforming application that uses
_ar_
to extract object code from a library with concern for its modification
time, since this can only be of importance to
_make_.
Hence, since this functionality is not deemed important for
applications portability, the modification time of the extracted files
is set to the current time.

There is at least one known implementation (for a small computer) that
can accommodate only object files for that system, disallowing mixed
object and other files. The ability to handle any type of file is not
only historical practice for most implementations, but is also a
reasonable expectation.

Consideration was given to changing the output format of
_ar_
**\(mitv**
to the same format as the output of
_ls_
**\(mil**.
This would have made parsing the output of
_ar_
the same as that of
_ls_.
This was rejected in part because the current
_ar_
format is commonly used and changes would break historical usage.
Second,
_ar_
gives the user ID and group ID in numeric format separated by a
&lt;slash&gt;.
Changing this to be the user name and group name would not be correct
if the archive were moved to a machine that contained a different user
database. Since
_ar_
cannot know whether the archive was generated on the same machine,
it cannot tell what to report.

The text on the
**\(miur**
option combination is historical practice—since one filename can
easily represent two different files (for example,
**/a/foo**
and
**/b/foo**),
it is reasonable to replace the file in the archive even when the
modification time in the archive is identical to that in the file
system.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__c99_\^_,
__date_\^_,
__fort77_\^_,
__pax_\^_,
__strip_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_,
_**&lt;unistd.h&gt;**_,
description of
{POSIX_NO_TRUNC}

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
