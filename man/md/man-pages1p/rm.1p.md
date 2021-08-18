# rm(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

rm
— remove directory entries

<a name="synopsis"></a>

# Synopsis

```


```
    rm [(mifiRr] file...

<a name="description"></a>

# Description

The
_rm_
utility shall remove the directory entry specified by each
_file_
argument.

If either of the files dot or dot-dot are specified as the basename
portion of an operand (that is, the final pathname component) or if an
operand resolves to the root directory,
_rm_
shall write a diagnostic message to standard error and do nothing more
with such operands.

For each
_file_
the following steps shall be taken:

*  1.  
  If the
  _file_
  does not exist:
    *  a.  
      If the
      **\(mif**
      option is not specified,
      _rm_
      shall write a diagnostic message to standard error.
    *  b.  
      Go on to any remaining
      _files_.
*  2.  
  If
  _file_
  is of type directory, the following steps shall be taken:
    *  a.  
      If neither the
      **\(miR**
      option nor the
      **\(mir**
      option is specified,
      _rm_
      shall write a diagnostic message to standard error, do nothing more
      with
      _file_,
      and go on to any remaining files.
    *  b.  
      If the
      **\(mif**
      option is not specified, and either the permissions of
      _file_
      do not permit writing and the standard input is a terminal or the
      **\(mii**
      option is specified,
      _rm_
      shall write a prompt to standard error and read a line from the
      standard input. If the response is not affirmative,
      _rm_
      shall do nothing more with the current file and go on to any remaining
      files.
    *  c.  
      For each entry contained in
      _file_,
      other than dot or dot-dot, the four steps listed here (1 to 4) shall be
      taken with the entry as if it were a
      _file_
      operand. The
      _rm_
      utility shall not traverse directories by following symbolic links into
      other parts of the hierarchy, but shall remove the links themselves.
    *  d.  
      If the
      **\(mii**
      option is specified,
      _rm_
      shall write a prompt to standard error and read a line from the
      standard input. If the response is not affirmative,
      _rm_
      shall do nothing more with the current file, and go on to any remaining
      files.
*  3.  
  If
  _file_
  is not of type directory, the
  **\(mif**
  option is not specified, and either the permissions of
  _file_
  do not permit writing and the standard input is a terminal or the
  **\(mii**
  option is specified,
  _rm_
  shall write a prompt to the standard error and read a line from the
  standard input. If the response is not affirmative,
  _rm_
  shall do nothing more with the current file and go on to any remaining
  files.
*  4.  
  If the current file is a directory,
  _rm_
  shall perform actions equivalent to the
  _rmdir_()
  function defined in the System Interfaces volume of POSIX.1-2008 called with a pathname of the current
  file used as the
  _path_
  argument. If the current file is not a directory,
  _rm_
  shall perform actions equivalent to the
  _unlink_()
  function defined in the System Interfaces volume of POSIX.1-2008 called with a pathname of the current
  file used as the
  _path_
  argument.

If this fails for any reason,
_rm_
shall write a diagnostic message to standard error, do nothing more
with the current file, and go on to any remaining files.

The
_rm_
utility shall be able to descend to arbitrary depths in a file
hierarchy, and shall not fail due to path length limitations (unless an
operand specified by the user exceeds system limitations).

<a name="options"></a>

# Options

The
_rm_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(mif**  
  Do not prompt for confirmation. Do not write diagnostic messages or
  modify the exit status in the case of nonexistent operands. Any
  previous occurrences of the
  **\(mii**
  option shall be ignored.
* **\(mii**  
  Prompt for confirmation as described previously. Any previous
  occurrences of the
  **\(mif**
  option shall be ignored.
* **\(miR**  
  Remove file hierarchies. See the DESCRIPTION.
* **\(mir**  
  Equivalent to
  **\(miR**.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _file_  
  A pathname of a directory entry to be removed.

<a name="stdin"></a>

# Stdin

The standard input shall be used to read an input line in response to
each prompt specified in the STDOUT section. Otherwise, the standard
input shall not be used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_rm_:

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
  multi-byte characters in arguments) and the behavior of character
  classes within regular expressions used in the extended regular
  expression defined for the
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

Prompts shall be written to standard error under the conditions
specified in the DESCRIPTION and OPTIONS sections. The prompts shall
contain the
_file_
pathname, but their format is otherwise unspecified. The standard
error also shall be used for diagnostic messages.

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
  Each directory entry was successfully removed, unless its removal was
  canceled by a non-affirmative response to a prompt for confirmation.
* &gt;0  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

The
_rm_
utility is forbidden to remove the names dot and dot-dot in order to
avoid the consequences of inadvertently doing something like:

    
    rm (mir .*


Some implementations do not permit the removal of the last link to an
executable binary file that is being executed; see the
**[EBUSY]**
error in the
_unlink_()
function defined in the System Interfaces volume of POSIX.1-2008. Thus, the
_rm_
utility can fail to remove such files.

The
**\(mii**
option causes
_rm_
to prompt and read the standard input even if the standard input is not
a terminal, but in the absence of
**\(mii**
the mode prompting is not done when the standard input is not a
terminal.

<a name="examples"></a>

# Examples


*  1.  
  The following command:

    
    rm a.out core


removes the directory entries:
**a.out**
and
**core**.

*  2.  
  The following command:

    
    rm (miRf junk


removes the directory
**junk**
and all its contents, without prompting.

<a name="rationale"></a>

# Rationale

For absolute clarity, paragraphs (2b) and (3) in the DESCRIPTION of
_rm_
describing the behavior when prompting for confirmation, should be
interpreted in the following manner:

    
    if ((NOT f_option) AND
        ((not_writable AND input_is_terminal) OR i_option))


The exact format of the interactive prompts is unspecified. Only the
general nature of the contents of prompts are specified because
implementations may desire more descriptive prompts than those used on
historical implementations. Therefore, an application not using the
**\(mif**
option, or using the
**\(mii**
option, relies on the system to provide the most suitable dialog
directly with the user, based on the behavior specified.

The
**\(mir**
option is historical practice on all known systems. The synonym
**\(miR**
option is provided for consistency with the other utilities in this volume of POSIX.1-2008
that provide options requesting recursive descent through the file
hierarchy.

The behavior of the
**\(mif**
option in historical versions of
_rm_
is inconsistent. In general, along with \`\`forcing'' the unlink without
prompting for permission, it always causes diagnostic messages to be
suppressed and the exit status to be unmodified for nonexistent
operands and files that cannot be unlinked. In some versions, however,
the
**\(mif**
option suppresses usage messages and system errors as well.
Suppressing such messages is not a service to either shell scripts or
users.

It is less clear that error messages regarding files that cannot be
unlinked (removed) should be suppressed. Although this is historical
practice, this volume of POSIX.1-2008 does not permit the
**\(mif**
option to suppress such messages.

When given the
**\(mir**
and
**\(mii**
options, historical versions of
_rm_
prompt the user twice for each directory, once before removing its
contents and once before actually attempting to delete the directory
entry that names it. This allows the user to \`\`prune'' the file
hierarchy walk. Historical versions of
_rm_
were inconsistent in that some did not do the former prompt for
directories named on the command line and others had obscure prompting
behavior when the
**\(mii**
option was specified and the permissions of the file did not permit
writing. The POSIX Shell and Utilities
_rm_
differs little from historic practice, but does require that prompts be
consistent. Historical versions of
_rm_
were also inconsistent in that prompts were done to both standard
output and standard error. This volume of POSIX.1-2008 requires that prompts be done to
standard error, for consistency with
_cp_
and
_mv_,
and to allow historical extensions to
_rm_
that provide an option to list deleted files on standard output.

The
_rm_
utility is required to descend to arbitrary depths so that any file
hierarchy may be deleted. This means, for example, that the
_rm_
utility cannot run out of file descriptors during its descent (that is,
if the number of file descriptors is limited,
_rm_
cannot be implemented in the historical fashion where one file
descriptor is used per directory level). Also,
_rm_
is not permitted to fail because of path length restrictions, unless an
operand specified by the user is longer than
{PATH_MAX}.

The
_rm_
utility removes symbolic links themselves, not the files they refer to,
as a consequence of the dependence on the
_unlink_()
functionality, per the DESCRIPTION. When removing hierarchies with
**\(mir**
or
**\(miR**,
the prohibition on following symbolic links has to be made explicit.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__rmdir_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_

The System Interfaces volume of POSIX.1-2008,
__remove_\^(\|)_,
__rmdir_\^(\|)_,
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
