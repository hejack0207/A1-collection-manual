# cp(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

cp
— copy files

<a name="synopsis"></a>

# Synopsis

```


```
    cp [(miPfip] source_file target_file
    
    cp [(miPfip] source_file... target
    
    cp (miR [(miH|(miL|(miP] [(mifip] source_file... target

<a name="description"></a>

# Description

The first synopsis form is denoted by two operands, neither of which
are existing files of type directory. The
_cp_
utility shall copy the contents of
_source_file_
(or, if
_source_file_
is a file of type symbolic link, the contents of the file referenced by
_source_file_)
to the destination path named by
_target_file._

The second synopsis form is denoted by two or more operands where the
**\(miR**
option is not specified and the first synopsis form is not
applicable. It shall be an error if any
_source_file_
is a file of type directory, if
_target_
does not exist, or if
_target_
does not name a directory. The
_cp_
utility shall copy the contents of each
_source_file_
(or, if
_source_file_
is a file of type symbolic link, the contents of the file referenced by
_source_file_)
to the destination path named by the concatenation of
_target_,
a single
&lt;slash&gt;
character if
_target_
did not end in a
&lt;slash&gt;,
and the last component of
_source_file_.

The third synopsis form is denoted by two or more operands where the
**\(miR**
option is specified. The
_cp_
utility shall copy each file in the file hierarchy rooted in each
_source_file_
to a destination path named as follows:

*  *  
  If
  _target_
  exists and names an existing directory, the name of the corresponding
  destination path for each file in the file hierarchy shall be the
  concatenation of
  _target_,
  a single
  &lt;slash&gt;
  character if
  _target_
  did not end in a
  &lt;slash&gt;,
  and the pathname of the file relative to the directory containing
  _source_file_.
*  *  
  If
  _target_
  does not exist and two operands are specified, the name of the
  corresponding destination path for
  _source_file_
  shall be
  _target_;
  the name of the corresponding destination path for all other files in
  the file hierarchy shall be the concatenation of
  _target_,
  a
  &lt;slash&gt;
  character, and the pathname of the file relative to
  _source_file_.

It shall be an error if
_target_
does not exist and more than two operands are specified, or if
_target_
exists and does not name a directory.

In the following description, the term
_dest_file_
refers to the file named by the destination path. The term
_source_file_
refers to the file that is being copied, whether specified as an
operand or a file in a file hierarchy rooted in a
_source_file_
operand. If
_source_file_
is a file of type symbolic link:

*  *  
  If the
  **\(miR**
  option was not specified,
  _cp_
  shall take actions based on the type and contents of the file referenced
  by the symbolic link, and not by the symbolic link itself, unless the
  **\(miP**
  option was specified.
*  *  
  If the
  **\(miR**
  option was specified:
    * --  
      If none of the options
      **\(miH**,
      **\(miL**,
      nor
      **\(miP**
      were specified, it is unspecified which of
      **\(miH**,
      **\(miL**,
      or
      **\(miP**
      will be used as a default.
    * --  
      If the
      **\(miH**
      option was specified,
      _cp_
      shall take actions based on the type and contents of the
      file referenced by any symbolic link specified as a
      _source_file_
      operand.
    * --  
      If the
      **\(miL**
      option was specified,
      _cp_
      shall take actions based on the type and contents of the
      file referenced by any symbolic link specified as a
      _source_file_
      operand or any symbolic links encountered during traversal of a
      file hierarchy.
    * --  
      If the
      **\(miP**
      option was specified,
      _cp_
      shall copy any symbolic link specified as a
      _source_file_
      operand and any symbolic links encountered during traversal of a
      file hierarchy, and shall not follow any symbolic links.

For each
_source_file_,
the following steps shall be taken:

*  1.  
  If
  _source_file_
  references the same file as
  _dest_file_,
  _cp_
  may write a diagnostic message to standard error; it shall do nothing
  more with
  _source_file_
  and shall go on to any remaining files.
*  2.  
  If
  _source_file_
  is of type directory, the following steps shall be taken:
    *  a.  
      If the
      **\(miR**
      option was not specified,
      _cp_
      shall write a diagnostic message to standard error, do nothing more
      with
      _source_file_,
      and go on to any remaining files.
    *  b.  
      If
      _source_file_
      was not specified as an operand and
      _source_file_
      is dot or dot-dot,
      _cp_
      shall do nothing more with
      _source_file_
      and go on to any remaining files.
    *  c.  
      If
      _dest_file_
      exists and it is a file type not specified by the System Interfaces volume of POSIX.1-2008, the behavior
      is implementation-defined.
    *  d.  
      If
      _dest_file_
      exists and it is not of type directory,
      _cp_
      shall write a diagnostic message to standard error, do nothing more
      with
      _source_file_
      or any files below
      _source_file_
      in the file hierarchy, and go on to any remaining files.
    *  e.  
      If the directory
      _dest_file_
      does not exist, it shall be created with file permission bits set to
      the same value as those of
      _source_file_,
      modified by the file creation mask of the user if the
      **\(mip**
      option was not specified, and then bitwise-inclusively OR'ed with
      S_IRWXU. If
      _dest_file_
      cannot be created,
      _cp_
      shall write a diagnostic message to standard error, do nothing more
      with
      _source_file_,
      and go on to any remaining files. It is unspecified if
      _cp_
      attempts to copy files in the file hierarchy rooted in
      _source_file_.
    *  f.  
      The files in the directory
      _source_file_
      shall be copied to the directory
      _dest_file_,
      taking the four steps (1 to 4) listed here with the files as
      _source_file_s.
    *  g.  
      If
      _dest_file_
      was created, its file permission bits shall be changed (if necessary)
      to be the same as those of
      _source_file_,
      modified by the file creation mask of the user if the
      **\(mip**
      option was not specified.
    *  h.  
      The
      _cp_
      utility shall do nothing more with
      _source_file_
      and go on to any remaining files.
*  3.  
  If
  _source_file_
  is of type regular file, the following steps shall be taken:
    *  a.  
      The behavior is unspecified if
      _dest_file_
      exists and was written by a previous step. Otherwise, if
      _dest_file_
      exists, the following steps shall be taken:
        *  i.  
          If the
          **\(mii**
          option is in effect, the
          _cp_
          utility shall write a prompt to the standard error and read a line from
          the standard input. If the response is not affirmative,
          _cp_
          shall do nothing more with
          _source_file_
          and go on to any remaining files.
        * ii.  
          A file descriptor for
          _dest_file_
          shall be obtained by performing actions equivalent to the
          _open_()
          function defined in the System Interfaces volume of POSIX.1-2008 called using
          _dest_file_
          as the
          _path_
          argument, and the bitwise-inclusive OR of O_WRONLY and O_TRUNC as the
          _oflag_
          argument.
        * iii.  
          If the attempt to obtain a file descriptor fails and the
          **\(mif**
          option is in effect,
          _cp_
          shall attempt to remove the file by performing actions equivalent to
          the
          _unlink_()
          function defined in the System Interfaces volume of POSIX.1-2008 called using
          _dest_file_
          as the
          _path_
          argument. If this attempt succeeds,
          _cp_
          shall continue with step 3b.
    *  b.  
      If
      _dest_file_
      does not exist, a file descriptor shall be obtained by performing
      actions equivalent to the
      _open_()
      function defined in the System Interfaces volume of POSIX.1-2008 called using
      _dest_file_
      as the
      _path_
      argument, and the bitwise-inclusive OR of O_WRONLY and O_CREAT as the
      _oflag_
      argument. The file permission bits of
      _source_file_
      shall be the
      _mode_
      argument.
    *  c.  
      If the attempt to obtain a file descriptor fails,
      _cp_
      shall write a diagnostic message to standard error, do nothing more with
      _source_file_,
      and go on to any remaining files.
    *  d.  
      The contents of
      _source_file_
      shall be written to the file descriptor. Any write errors shall cause
      _cp_
      to write a diagnostic message to standard error and continue to step
      3e.
    *  e.  
      The file descriptor shall be closed.
    *  f.  
      The
      _cp_
      utility shall do nothing more with
      _source_file_.
      If a write error occurred in step 3d, it is unspecified if
      _cp_
      continues with any remaining files. If no write error occurred in step
      3d,
      _cp_
      shall go on to any remaining files.
*  4.  
  Otherwise, the
  **\(miR**
  option was specified, and the following steps shall be taken:
    *  a.  
      The
      _dest_file_
      shall be created with the same file type as
      _source_file_.
    *  b.  
      If
      _source_file_
      is a file of type FIFO, the file permission bits shall be the same as
      those of
      _source_file,_
      modified by the file creation mask of the user if the
      **\(mip**
      option was not specified. Otherwise, the permissions, owner ID, and
      group ID of
      _dest_file_
      are implementation-defined.

If this creation fails for any reason,
_cp_
shall write a diagnostic message to standard error, do nothing more
with
_source_file_,
and go on to any remaining files.

*  c.  
  If
  _source_file_
  is a file of type symbolic link, and the options require the symbolic
  link itself to be acted upon, the pathname contained in
  _dest_file_
  shall be the same as the pathname contained in
  _source_file_.

If this fails for any reason,
_cp_
shall write a diagnostic message to standard error, do nothing more
with
_source_file_,
and go on to any remaining files.

If the implementation provides additional or alternate access control
mechanisms (see the Base Definitions volume of POSIX.1-2008,
_Section 4.4_, _File Access Permissions_),
their effect on copies of files is implementation-defined.

<a name="options"></a>

# Options

The
_cp_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(mif**  
  If a file descriptor for a destination file cannot be obtained, as
  described in step 3.a.ii., attempt to unlink the destination file and
  proceed.
* **\(miH**  
  Take actions based on the type and contents of the file referenced by
  any symbolic link specified as a
  _source_file_
  operand.
* **\(mii**  
  Write a prompt to standard error before copying to any existing
  non-directory destination file. If the response from the standard input
  is affirmative, the copy shall be attempted; otherwise, it shall not.
* **\(miL**  
  Take actions based on the type and contents of the file referenced by
  any symbolic link specified as a
  _source_file_
  operand or any symbolic links encountered during traversal of a
  file hierarchy.
* **\(miP**  
  Take actions on any symbolic link specified as a
  _source_file_
  operand or any symbolic link encountered during traversal of a
  file hierarchy.
* **\(mip**  
  Duplicate the following characteristics of each source file in the
  corresponding destination file:
    *  1.  
      The time of last data modification and time of last access. If this
      duplication fails for any reason,
      _cp_
      shall write a diagnostic message to standard error.
    *  2.  
      The user ID and group ID. If this duplication fails for any reason, it
      is unspecified whether
      _cp_
      writes a diagnostic message to standard error.
    *  3.  
      The file permission bits and the S_ISUID and S_ISGID bits. Other,
      implementation-defined, bits may be duplicated as well. If this
      duplication fails for any reason,
      _cp_
      shall write a diagnostic message to standard error.

If the user ID or the group ID cannot be duplicated, the file
permission bits S_ISUID and S_ISGID shall be cleared. If these bits are
present in the source file but are not duplicated in the destination
file, it is unspecified whether
_cp_
writes a diagnostic message to standard error.

The order in which the preceding characteristics are duplicated is
unspecified. The
_dest_file_
shall not be deleted if these characteristics cannot be preserved.

* **\(miR**  
  Copy file hierarchies.

Specifying more than one of the mutually-exclusive options
**\(miH**,
**\(miL**,
and
**\(miP**
shall not be considered an error. The last option specified shall
determine the behavior of the utility.

<a name="operands"></a>

# Operands

The following operands shall be supported:

* _source\_file_  
  A pathname of a file to be copied. If a
  _source_file_
  operand is
  **'\(mi'**,
  it shall refer to a file named
  **\(mi**;
  implementations shall not treat it as meaning standard input.
* _target\_file_  
  A pathname of an existing or nonexistent file, used for the output when
  a single file is copied. If a
  _target_file_
  operand is
  **'\(mi'**,
  it shall refer to a file named
  **\(mi**;
  implementations shall not treat it as meaning standard output.
* _target_  
  A pathname of a directory to contain the copied files.

<a name="stdin"></a>

# Stdin

The standard input shall be used to read an input line in response to
each prompt specified in the STDERR section. Otherwise, the standard
input shall not be used.

<a name="input-files"></a>

# Input Files

The input files specified as operands may be of any file type.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_cp_:

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
  and multi-character collating elements used in the extended regular
  expression defined for the
  **yesexpr**
  locale keyword in the
  _LC_MESSAGES_
  category.
* _LC\_CTYPE_  
  Determine the locale for the interpretation of sequences of bytes of
  text data as characters (for example, single-byte as opposed to
  multi-byte characters in arguments and input files) and the behavior of
  character classes used in the extended regular expression defined for
  the
  **yesexpr**
  locale keyword in the
  _LC_MESSAGES_
  category.
* _LC\_MESSAGES_    
  Determine the locale used to process affirmative responses, and the
  locale used to affect the format and contents of diagnostic messages
  and prompts written to standard error.
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

Not used.

<a name="stderr"></a>

# Stderr

A prompt shall be written to standard error under the conditions
specified in the DESCRIPTION section. The prompt shall contain the
destination pathname, but its format is otherwise unspecified.
Otherwise, the standard error shall be used only for diagnostic
messages.

<a name="output-files"></a>

# Output Files

The output files may be of any type.

<a name="extended-description"></a>

# Extended Description

None.

<a name="exit-status"></a>

# Exit Status

The following exit values shall be returned:

* \00  
  All files were copied successfully.
* &gt;0  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

If
_cp_
is prematurely terminated by a signal or error, files or file
hierarchies may be only partially copied and files and directories may
have incorrect permissions or access and modification times.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

The set-user-ID and set-group-ID bits are explicitly cleared when files
are created. This is to prevent users from creating programs that are
set-user-ID or set-group-ID to them when copying files or to make
set-user-ID or set-group-ID files accessible to new groups of users.
For example, if a file is set-user-ID and the copy has a different
group ID than the source, a new group of users has execute permission
to a set-user-ID program than did previously. In particular, this is a
problem for superusers copying users' trees.

<a name="examples"></a>

# Examples

None.

<a name="rationale"></a>

# Rationale

The
**\(mii**
option exists on BSD systems, giving applications and users a way to
avoid accidentally removing files when copying. Although the 4.3 BSD
version does not prompt if the standard input is not a terminal, the
standard developers decided that use of
**\(mii**
is a request for interaction, so when the destination path exists, the
utility takes instructions from whatever responds on standard input.

The exact format of the interactive prompts is unspecified. Only the
general nature of the contents of prompts are specified because
implementations may desire more descriptive prompts than those used on
historical implementations. Therefore, an application using the
**\(mii**
option relies on the system to provide the most suitable dialog
directly with the user, based on the behavior specified.

The
**\(mip**
option is historical practice on BSD systems, duplicating the time of
last data modification and time of last access. This volume of POSIX.1-2008 extends it to
preserve the user and group IDs, as well as the file permissions. This
requirement has obvious problems in that the directories are almost
certainly modified after being copied. This volume of POSIX.1-2008 requires that the
modification times be preserved. The statement that the order in which
the characteristics are duplicated is unspecified is to permit
implementations to provide the maximum amount of security for the user.
Implementations should take into account the obvious security issues
involved in setting the owner, group, and mode in the wrong order or
creating files with an owner, group, or mode different from the final
value.

It is unspecified whether
_cp_
writes diagnostic messages when the user and group IDs cannot be set
due to the widespread practice of users using
**\(mip**
to duplicate some portion of the file characteristics, indifferent to
the duplication of others. Historic implementations only write
diagnostic messages on errors other than
**[EPERM]**.

Earlier versions of this standard included support for the
**\(mir**
option to copy file hierarchies. The
**\(mir**
option is historical practice on BSD and BSD-derived systems. This
option is no longer specified by POSIX.1-2008 but may be present
in some implementations. The
**\(miR**
option was added as a close synonym to the
**\(mir**
option, selected for consistency with all other options in this volume of POSIX.1-2008 that
do recursive directory descent.

The difference between
**\(miR**
and the removed
**\(mir**
option is in the treatment by
_cp_
of file types other than regular and directory. It was
implementation-defined how the
**\(mi**
option treated special files to allow both historical implementations
and those that chose to support
**\(mir**
with the same abilities as
**\(miR**
defined by this volume of POSIX.1-2008. The original
**\(mir**
flag, for historic reasons, did not handle special files any differently
from regular files, but always read the file and copied its contents. This
had obvious problems in the presence of special file types; for example,
character devices, FIFOs, and sockets.

When a failure occurs during the copying of a file hierarchy,
_cp_
is required to attempt to copy files that are on the same level in the
hierarchy or above the file where the failure occurred. It is
unspecified if
_cp_
shall attempt to copy files below the file where the failure occurred
(which cannot succeed in any case).

Permissions, owners, and groups of created special file types have been
deliberately left as implementation-defined. This is to allow systems
to satisfy special requirements (for example, allowing users to create
character special devices, but requiring them to be owned by a certain
group). In general, it is strongly suggested that the permissions,
owner, and group be the same as if the user had run the historical
_mknod_,
_ln_,
or other utility to create the file. It is also probable that
additional privileges are required to create block, character, or
other implementation-defined special file types.

Additionally, the
**\(mip**
option explicitly requires that all set-user-ID
and set-group-ID permissions be
discarded if any of the owner or group IDs cannot be set. This is to
keep users from unintentionally giving away special privilege when
copying programs.

When creating regular files, historical versions of
_cp_
use the mode of the source file as modified by the file mode creation
mask. Other choices would have been to use the mode of the source file
unmodified by the creation mask or to use the same mode as would be
given to a new file created by the user (plus the execution bits of the
source file) and then modify it by the file mode creation mask. In the
absence of any strong reason to change historic practice, it was in
large part retained.

When creating directories, historical versions of
_cp_
use the mode of the source directory, plus read, write, and search bits
for the owner, as modified by the file mode creation mask. This is done
so that
_cp_
can copy trees where the user has read permission, but the owner does
not. A side-effect is that if the file creation mask denies the owner
permissions,
_cp_
fails. Also, once the copy is done, historical versions of
_cp_
set the permissions on the created directory to be the same as the
source directory, unmodified by the file creation mask.

This behavior has been modified so that
_cp_
is always able to create the contents of the directory, regardless of
the file creation mask. After the copy is done, the permissions are set
to be the same as the source directory, as modified by the file
creation mask. This latter change from historical behavior is to
prevent users from accidentally creating directories with permissions
beyond those they would normally set and for consistency with the
behavior of
_cp_
in creating files.

It is not a requirement that
_cp_
detect attempts to copy a file to itself; however, implementations are
strongly encouraged to do so. Historical implementations have detected
the attempt in most cases.

There are two methods of copying subtrees in this volume of POSIX.1-2008. The other method is
described as part of the
_pax_
utility (see
__pax_\^_).
Both methods are historical practice. The
_cp_
utility provides a simpler, more intuitive interface, while
_pax_
offers a finer granularity of control. Each provides additional
functionality to the other; in particular,
_pax_
maintains the hard-link structure of the hierarchy, while
_cp_
does not. It is the intention of the standard developers that the
results be similar (using appropriate option combinations in both
utilities). The results are not required to be identical; there seemed
insufficient gain to applications to balance the difficulty of
implementations having to guarantee that the results would be exactly
identical.

The wording allowing
_cp_
to copy a directory to implementation-defined file types not
specified by the System Interfaces volume of POSIX.1-2008 is provided so that implementations supporting
symbolic links are not required to prohibit copying directories to
symbolic links. Other extensions to the System Interfaces volume of POSIX.1-2008 file types may need to
use this loophole as well.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__mv_\^_,
__find_\^_,
__ln_\^_,
__pax_\^_

The Base Definitions volume of POSIX.1-2008,
_Section 4.4_, _File Access Permissions_,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_

The System Interfaces volume of POSIX.1-2008,
__open_\^(\|)_,
__unlink_\^(\|)_

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
