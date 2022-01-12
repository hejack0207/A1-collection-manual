# mv(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

mv
— move files

<a name="synopsis"></a>

# Synopsis

```


```
    mv [(miif] source_file target_file
    
    mv [(miif] source_file... target_dir

<a name="description"></a>

# Description

In the first synopsis form, the
_mv_
utility shall move the file named by the
_source_file_
operand to the destination specified by the
_target_file_.
This first synopsis form is assumed when the final operand does not
name an existing directory and is not a symbolic link referring to
an existing directory. In this case, if
_source_file_
names a non-directory file and
_target_file_
ends with a trailing
&lt;slash&gt;
character,
_mv_
shall treat this as an error and no
_source_file_
operands will be processed.

In the second synopsis form,
_mv_
shall move each file named by a
_source_file_
operand to a destination file in the existing directory named by the
_target_dir_
operand, or referenced if
_target_dir_
is a symbolic link referring to an existing directory. The
destination path for each
_source_file_
shall be the concatenation of the target directory, a single
&lt;slash&gt;
character if the target did not end in a
&lt;slash&gt;,
and the last pathname component of the
_source_file_.
This second form is assumed when the final operand names an existing
directory.

If any operand specifies an existing file of a type not
specified by the System Interfaces volume of POSIX.1-2008, the behavior is implementation-defined.

For each
_source_file_
the following steps shall be taken:

*  1.  
  If the destination path exists, the
  **\(mif**
  option is not specified, and either of the following conditions is
  true:
    *  a.  
      The permissions of the destination path do not permit writing and the
      standard input is a terminal.
    *  b.  
      The
      **\(mii**
      option is specified.

the
_mv_
utility shall write a prompt to standard error and read a line from
standard input. If the response is not affirmative,
_mv_
shall do nothing more with the current
_source_file_
and go on to any remaining
_source_file_s.

*  2.  
  If the
  _source_file_
  operand and destination path name the same existing file, then the
  destination path shall not be removed, and one of the following shall
  occur:
    *  a.  
      No change is made to
      _source_file_,
      no error occurs, and no diagnostic is issued.
    *  b.  
      No change is made to
      _source_file_,
      a diagnostic is issued to standard error identifying the two names,
      and the exit status is affected.
    *  c.  
      If the
      _source_file_
      operand and destination path name distinct directory entries, then the
      _source_file_
      operand is removed, no error occurs, and no diagnostic is issued.

The
_mv_
utility shall do nothing more with the current
_source_file_,
and go on to any remaining
_source_file_s.

*  3.  
  The
  _mv_
  utility shall perform actions equivalent to the
  _rename_()
  function defined in the System Interfaces volume of POSIX.1-2008, called with the following arguments:
    *  a.  
      The
      _source_file_
      operand is used as the
      _old_
      argument.
    *  b.  
      The destination path is used as the
      _new_
      argument.

If this succeeds,
_mv_
shall do nothing more with the current
_source_file_
and go on to any remaining
_source_file_s.
If this fails for any reasons other than those described for the
_errno_
**[EXDEV]**
in the System Interfaces volume of POSIX.1-2008,
_mv_
shall write a diagnostic message to standard error, do nothing more
with the current
_source_file_,
and go on to any remaining
_source_file_s.

*  4.  
  If the destination path exists, and it is a file of type directory and
  _source_file_
  is not a file of type directory, or it is a file not of type directory
  and
  _source_file_
  is a file of type directory,
  _mv_
  shall write a diagnostic message to standard error, do nothing more
  with the current
  _source_file_,
  and go on to any remaining
  _source_file_s.
  If the destination path exists and was created by a previous step, it
  is unspecified whether this will treated as an error or the destination
  path will be overwritten.
*  5.  
  If the destination path exists,
  _mv_
  shall attempt to remove it. If this fails for any reason,
  _mv_
  shall write a diagnostic message to standard error, do nothing more
  with the current
  _source_file_,
  and go on to any remaining
  _source_file_s.
*  6.  
  The file hierarchy rooted in
  _source_file_
  shall be duplicated as a file hierarchy rooted in the destination path. If
  _source_file_
  or any of the files below it in the hierarchy are symbolic links, the
  links themselves shall be duplicated, including their contents, rather
  than any files to which they refer. The following characteristics of
  each file in the file hierarchy shall be duplicated:
    *  *  
      The time of last data modification and time of last access
    *  *  
      The user ID and group ID
    *  *  
      The file mode

If the user ID, group ID, or file mode of a regular file cannot be
duplicated, the file mode bits S_ISUID and S_ISGID shall not be
duplicated.

When files are duplicated to another file system, the implementation
may require that the process invoking
_mv_
has read access to each file being duplicated.

If files being duplicated to another file system have hard links to
other files, it is unspecified whether the files copied to the new
file system have the hard links preserved or separate copies are created
for the linked files.

If the duplication of the file hierarchy fails for any reason,
_mv_
shall write a diagnostic message to standard error, do nothing more
with the current
_source_file_,
and go on to any remaining
_source_file_s.

If the duplication of the file characteristics fails for any reason,
_mv_
shall write a diagnostic message to standard error, but this failure
shall not cause
_mv_
to modify its exit status.

*  7.  
  The file hierarchy rooted in
  _source_file_
  shall be removed. If this fails for any reason,
  _mv_
  shall write a diagnostic message to the standard error, do nothing more
  with the current
  _source_file_,
  and go on to any remaining
  _source_file_s.

<a name="options"></a>

# Options

The
_mv_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(mif**  
  Do not prompt for confirmation if the destination path exists. Any
  previous occurrence of the
  **\(mii**
  option is ignored.
* **\(mii**  
  Prompt for confirmation if the destination path exists. Any previous
  occurrence of the
  **\(mif**
  option is ignored.

Specifying more than one of the
**\(mif**
or
**\(mii**
options shall not be considered an error. The last option specified
shall determine the behavior of
_mv_.

<a name="operands"></a>

# Operands

The following operands shall be supported:

* _source\_file_  
  A pathname of a file or directory to be moved.
* _target\_file_  
  A new pathname for the file or directory being moved.
* _target\_dir_  
  A pathname of an existing directory into which to move the input
  files.

<a name="stdin"></a>

# Stdin

The standard input shall be used to read an input line in response to
each prompt specified in the STDERR section. Otherwise, the standard
input shall not be used.

<a name="input-files"></a>

# Input Files

The input files specified by each
_source_file_
operand can be of any file type.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_mv_:

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
  multi-byte characters in arguments and input files), the behavior of
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

Prompts shall be written to the standard error under the conditions
specified in the DESCRIPTION section. The prompts shall contain the
destination pathname, but their format is otherwise unspecified.
Otherwise, the standard error shall be used only for diagnostic messages.

<a name="output-files"></a>

# Output Files

The output files may be of any file type.

<a name="extended-description"></a>

# Extended Description

None.

<a name="exit-status"></a>

# Exit Status

The following exit values shall be returned:

* \00  
  All input files were moved successfully.
* &gt;0  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

If the copying or removal of
_source_file_
is prematurely terminated by a signal or error,
_mv_
may leave a partial copy of
_source_file_
at the source or destination. The
_mv_
utility shall not modify both
_source_file_
and the destination path simultaneously; termination at any point shall
leave either
_source_file_
or the destination path complete.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

Some implementations mark for update the last file status change timestamp
of renamed files and some do not. Applications which make use of the
last file status change timestamp may behave differently with respect
to renamed files unless they are designed to allow for either behavior.

The specification ensures that
_mv_
**a**
**a**
will not alter the contents of file
**a**,
and allows the implementation to issue an error that a file cannot be
moved onto itself. Likewise, when
**a**
and
**b**
are hard links to the same file,
_mv_
**a**
**b**
will not alter
**b**,
but if a diagnostic is not issued, then it is unspecified whether
**a**
is left untouched (as it would be by the
_rename_()
function) or unlinked (reducing the link count of
**b**).

<a name="examples"></a>

# Examples

If the current directory contains only files
**a**
(of any type defined by the System Interfaces volume of POSIX.1-2008),
**b**
(also of any type), and a directory
**c**:

    
    mv a b c
    mv c d


results with the original files
**a**
and
**b**
residing in the directory
**d**
in the current directory.

<a name="rationale"></a>

# Rationale

Early proposals diverged from the SVID and BSD historical practice in
that they required that when the destination path exists, the
**\(mif**
option is not specified, and input is not a terminal,
_mv_
fails. This was done for compatibility with
_cp_.
The current text returns to historical practice. It should be noted
that this is consistent with the
_rename_()
function defined in the System Interfaces volume of POSIX.1-2008, which does not require write permission
on the target.

For absolute clarity, paragraph (1), describing the behavior of
_mv_
when prompting for confirmation, should be interpreted in the following
manner:

    
    if (exists AND (NOT f_option) AND
        ((not_writable AND input_is_terminal) OR i_option))


The
**\(mii**
option exists on BSD systems, giving applications and users a way to
avoid accidentally unlinking files when moving others. When the
standard input is not a terminal, the 4.3 BSD
_mv_
deletes all existing destination paths without prompting, even when
**\(mii**
is specified; this is inconsistent with the behavior of the 4.3 BSD
_cp_
utility, which always generates an error when the file is unwritable
and the standard input is not a terminal. The standard developers
decided that use of
**\(mii**
is a request for interaction, so when the destination
path exists, the utility takes instructions from whatever responds to
standard input.

The
_rename_()
function is able to move directories within the same file system. Some
historical versions of
_mv_
have been able to move directories, but not to a different file system.
The standard developers considered that this was an annoying
inconsistency, so this volume of POSIX.1-2008 requires directories to be able to be moved
even across file systems. There is no
**\(miR**
option to confirm that moving a directory is actually intended, since
such an option was not required for moving directories in historical
practice. Requiring the application to specify it sometimes, depending
on the destination, seemed just as inconsistent. The semantics of the
_rename_()
function were preserved as much as possible. For example,
_mv_
is not permitted to \`\`rename'' files to or from directories, even
though they might be empty and removable.

Historic implementations of
_mv_
did not exit with a non-zero exit status if they were unable to
duplicate any file characteristics when moving a file across file
systems, nor did they write a diagnostic message for the user. The
former behavior has been preserved to prevent scripts from breaking; a
diagnostic message is now required, however, so that users are alerted
that the file characteristics have changed.

The exact format of the interactive prompts is unspecified. Only the
general nature of the contents of prompts are specified because
implementations may desire more descriptive prompts than those used on
historical implementations. Therefore, an application not using the
**\(mif**
option or using the
**\(mii**
option relies on the system to provide the most suitable dialog
directly with the user, based on the behavior specified.

When
_mv_
is dealing with a single file system and
_source_file_
is a symbolic link, the link itself is moved as a consequence of the
dependence on the
_rename_()
functionality, per the DESCRIPTION. Across file systems, this has to be
made explicit.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__cp_\^_,
__ln_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_

The System Interfaces volume of POSIX.1-2008,
__rename_\^(\|)_

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
