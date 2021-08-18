# chgrp(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

chgrp
— change the file group ownership

<a name="synopsis"></a>

# Synopsis

```


```
    chgrp [(mih] group file...
    
    chgrp (miR [(miH|(miL|(miP] group file...

<a name="description"></a>

# Description

The
_chgrp_
utility shall set the group ID of the file named by each
_file_
operand to the group ID specified by the
_group_
operand.

For each
_file_
operand, or, if the
**\(miR**
option is used, each file encountered while walking the directory
trees specified by the
_file_
operands, the
_chgrp_
utility shall perform actions equivalent to the
_chown_()
function defined in the System Interfaces volume of POSIX.1-2008, called with the following arguments:

*  *  
  The
  _file_
  operand shall be used as the
  _path_
  argument.
*  *  
  The user ID of the file shall be used as the
  _owner_
  argument.
*  *  
  The specified group ID shall be used as the
  _group_
  argument.

Unless
_chgrp_
is invoked by a process with appropriate privileges, the set-user-ID
and set-group-ID bits of a regular file shall be cleared upon successful
completion; the set-user-ID and set-group-ID bits of other file types
may be cleared.

<a name="options"></a>

# Options

The
_chgrp_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported by the implementation:

* **\(mih**  
  For each
  _file_
  operand that names a file of type symbolic link,
  _chgrp_
  shall attempt to set the group ID of the symbolic link instead of the
  file referenced by the symbolic link.
* **\(miH**  
  If the
  **\(miR**
  option is specified and a symbolic link referencing a file of type
  directory is specified on the command line,
  _chgrp_
  shall change the group of the directory referenced by the symbolic link
  and all files in the file hierarchy below it.
* **\(miL**  
  If the
  **\(miR**
  option is specified and a symbolic link referencing a file of type
  directory is specified on the command line or encountered during the
  traversal of a file hierarchy,
  _chgrp_
  shall change the group of the directory referenced by the symbolic link
  and all files in the file hierarchy below it.
* **\(miP**  
  If the
  **\(miR**
  option is specified and a symbolic link is specified on the command
  line or encountered during the traversal of a file hierarchy,
  _chgrp_
  shall change the group ID of the symbolic link. The
  _chgrp_
  utility shall not follow the symbolic link to any other part of the
  file hierarchy.
* **\(miR**  
  Recursively change file group IDs. For each
  _file_
  operand that names a directory,
  _chgrp_
  shall change the group of the directory and all files in the
  file hierarchy below it. Unless a
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

* _group_  
  A group name from the group database or a numeric group ID. Either
  specifies a group ID to be given to each file named by one of the
  _file_
  operands. If a numeric
  _group_
  operand exists in the group database as a group name, the group ID
  number associated with that group name is used as the group ID.
* _file_  
  A pathname of a file whose group ID is to be modified.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_chgrp_:

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
_chgrp_
to a user with appropriate privileges when the
_group_
specified is not the effective group ID or one of the supplementary
group IDs of the calling process.

<a name="examples"></a>

# Examples

None.

<a name="rationale"></a>

# Rationale

The System V and BSD versions use different exit status codes. Some
implementations used the exit status as a count of the number of errors
that occurred; this practice is unworkable since it can overflow the
range of valid exit status values. The standard developers chose to
mask these by specifying only 0 and &gt;0 as exit values.

The functionality of
_chgrp_
is described substantially through references to
_chown_().
In this way, there is no duplication of effort required for describing
the interactions of permissions, multiple groups, and so on.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__chmod_\^_,
__chown_\^_

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
