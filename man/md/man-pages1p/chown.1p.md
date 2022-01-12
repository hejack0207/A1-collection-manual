# chown(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

chown
— change the file ownership

<a name="synopsis"></a>

# Synopsis

```


```
    chown [(mih] owner[:group] file...
    
    chown (miR [(miH|(miL|(miP] owner[:group] file...

<a name="description"></a>

# Description

The
_chown_
utility shall set the user ID of the file named by each
_file_
operand to the user ID specified by the
_owner_
operand.

For each
_file_
operand, or, if the
**\(miR**
option is used, each file encountered while walking the directory
trees specified by the
_file_
operands, the
_chown_
utility shall perform actions equivalent to the
_chown_()
function defined in the System Interfaces volume of POSIX.1-2008, called with the following arguments:

*  1.  
  The
  _file_
  operand shall be used as the
  _path_
  argument.
*  2.  
  The user ID indicated by the
  _owner_
  portion of the first operand shall be used as the
  _owner_
  argument.
*  3.  
  If the
  _group_
  portion of the first operand is given, the group ID indicated by it
  shall be used as the
  _group_
  argument; otherwise, the group ownership shall not be changed.

Unless
_chown_
is invoked by a process with appropriate privileges, the set-user-ID
and set-group-ID bits of a regular file shall be cleared upon
successful completion; the set-user-ID and set-group-ID bits of other
file types may be cleared.

<a name="options"></a>

# Options

The
_chown_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported by the implementation:

* **\(mih**  
  For each file operand that names a file of type symbolic link,
  _chown_
  shall attempt to set the user ID of the symbolic link. If a group ID
  was specified, for each file operand that names a file of
  type symbolic link,
  _chown_
  shall attempt to set the group ID of the symbolic link.
* **\(miH**  
  If the
  **\(miR**
  option is specified and a symbolic link referencing a file of type
  directory is specified on the command line,
  _chown_
  shall change the user ID (and group ID, if specified) of the directory
  referenced by the symbolic link and all files in the file hierarchy
  below it.
* **\(miL**  
  If the
  **\(miR**
  option is specified and a symbolic link referencing a file of type
  directory is specified on the command line or encountered during the
  traversal of a file hierarchy,
  _chown_
  shall change the user ID (and group ID, if specified) of the directory
  referenced by the symbolic link and all files in the file hierarchy
  below it.
* **\(miP**  
  If the
  **\(miR**
  option is specified and a symbolic link is specified on the command
  line or encountered during the traversal of a file hierarchy,
  _chown_
  shall change the owner ID (and group ID, if specified) of the symbolic
  link. The
  _chown_
  utility shall not follow the symbolic link to any other part of the
  file hierarchy.
* **\(miR**  
  Recursively change file user and group IDs. For each
  _file_
  operand that names a directory,
  _chown_
  shall change the user ID (and group ID, if specified) of the directory
  and all files in the file hierarchy below it. Unless a
  **\(miH**,
  **\(miL**,
  or
  **\(miP**
  option is specified, it is unspecified which of these options will be
  used as the default.

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

* owner**[**:group**]**  
  A user ID and optional group ID to be assigned to
  _file_.
  The
  _owner_
  portion of this operand shall be a user name from the user database or
  a numeric user ID. Either specifies a user ID which shall be given to
  each file named by one of the
  _file_
  operands. If a numeric
  _owner_
  operand exists in the user database as a user name, the user ID number
  associated with that user name shall be used as the user ID. Similarly,
  if the
  _group_
  portion of this operand is present, it shall be a group name from the
  group database or a numeric group ID. Either specifies a group ID which
  shall be given to each file. If a numeric group operand exists in the
  group database as a group name, the group ID number associated with
  that group name shall be used as the group ID.
* _file_  
  A pathname of a file whose user ID is to be modified.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_chown_:

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
  contents of diagnostic messages written to standard error.
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
  The utility executed successfully and all requested changes were made.
* &gt;0  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

Only the owner of a file or the user with appropriate privileges may
change the owner or group of a file.

Some implementations restrict the use of
_chown_
to a user with appropriate privileges.

<a name="examples"></a>

# Examples

None.

<a name="rationale"></a>

# Rationale

The System V and BSD versions use different exit status codes. Some
implementations used the exit status as a count of the number of errors
that occurred; this practice is unworkable since it can overflow the
range of valid exit status values. These are masked by specifying only
0 and &gt;0 as exit values.

The functionality of
_chown_
is described substantially through references to functions in the
System Interfaces volume of POSIX.1-2008. In this way, there is no duplication of effort required for
describing the interactions of permissions, multiple groups, and so
on.

The 4.3 BSD method of specifying both owner and group was included in
this volume of POSIX.1-2008 because:

*  *  
  There are cases where the desired end condition could not be achieved
  using the
  _chgrp_
  and
  _chown_
  (that only changed the user ID) utilities. (If the current owner is not
  a member of the desired group and the desired owner is not a member of
  the current group, the
  _chown_()
  function could fail unless both owner and group are changed at the same
  time.)
*  *  
  Even if they could be changed independently, in cases where both are
  being changed, there is a 100% performance penalty caused by being
  forced to invoke both utilities.

The BSD syntax
_user_[.\c
_group_]
was changed to
_user_[:\c
_group_]
in this volume of POSIX.1-2008 because the
&lt;period&gt;
is a valid character in login names (as specified by the Base Definitions volume of POSIX.1-2008, login
names consist of characters in the portable filename character set). The
&lt;colon&gt;
character was chosen as the replacement for the
&lt;period&gt;
character because it would never be allowed as a character in a user
name or group name on historical implementations.

The
**\(miR**
option is considered by some observers as an undesirable departure from
the historical UNIX system tools approach; since a tool,
_find_,
already exists to recurse over directories, there seemed to be no good
reason to require other tools to have to duplicate that functionality.
However, the
**\(miR**
option was deemed an important user convenience, is far more efficient
than forking a separate process for each element of the directory
hierarchy, and is in widespread historical use.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__chgrp_\^_,
__chmod_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_

The System Interfaces volume of POSIX.1-2008,
__chown_\^(\|)_

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
