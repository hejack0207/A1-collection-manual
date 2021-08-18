# newgrp(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

newgrp
— change to a new group

<a name="synopsis"></a>

# Synopsis

```


```
    newgrp [(mil] [group]

<a name="description"></a>

# Description

The
_newgrp_
utility shall create a new shell execution environment with a new real
and effective group identification. Of the attributes listed in
_Section 2.12_, _Shell Execution Environment_,
the new shell execution environment shall retain the working directory,
file creation mask, and exported variables from the previous
environment (that is, open files, traps, unexported variables, alias
definitions, shell functions, and
_set_
options may be lost). All other aspects of the process environment
that are preserved by the
_exec_
family of functions defined in the System Interfaces volume of POSIX.1-2008 shall also be preserved by
_newgrp_;
whether other aspects are preserved is unspecified.

A failure to assign the new group identifications (for example, for
security or password-related reasons) shall not prevent the new shell
execution environment from being created.

The
_newgrp_
utility shall affect the supplemental groups for the process as
follows:

*  *  
  On systems where the effective group ID is normally in the
  supplementary group list (or whenever the old effective group ID
  actually is in the supplementary group list):
    * --  
      If the new effective group ID is also in the supplementary group list,
      _newgrp_
      shall change the effective group ID.
    * --  
      If the new effective group ID is not in the supplementary group list,
      _newgrp_
      shall add the new effective group ID to the list, if there is room to
      add it.
*  *  
  On systems where the effective group ID is not normally in the
  supplementary group list (or whenever the old effective group ID is not
  in the supplementary group list):
    * --  
      If the new effective group ID is in the supplementary group list,
      _newgrp_
      shall delete it.
    * --  
      If the old effective group ID is not in the supplementary list,
      _newgrp_
      shall add it if there is room.
* **Note:**  
  The System Interfaces volume of POSIX.1-2008 does not specify whether the effective group ID of a process
  is included in its supplementary group list.


With no operands,
_newgrp_
shall change the effective group back to the groups identified in the
user's user entry, and shall set the list of supplementary groups to
that set in the user's group database entries.

If the first argument is
**'\(mi'**,
the results are unspecified.

If a password is required for the specified group, and the user is not
listed as a member of that group in the group database, the user shall
be prompted to enter the correct password for that group. If the user
is listed as a member of that group, no password shall be requested.
If no password is required for the specified group, it is
implementation-defined whether users not listed as members of that
group can change to that group. Whether or not a password is required,
implementation-defined system accounting or security mechanisms may
impose additional authorization restrictions that may cause
_newgrp_
to write a diagnostic message and suppress the changing of the group
identification.

<a name="options"></a>

# Options

The
_newgrp_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_,
except for the unspecified usage of
**'\(mi'**.

The following option shall be supported:

* **\(mil**  
  (The letter ell.) Change the environment to what would be expected if
  the user actually logged in again.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _group_  
  A group name from the group database or a non-negative numeric group
  ID. Specifies the group ID to which the real and effective group IDs
  shall be set. If
  _group_
  is a non-negative numeric string and exists in the group database as a
  group name (see
  _getgrnam_()),
  the numeric group ID associated with that group name shall be used as
  the group ID.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

The file
**/dev/tty**
shall be used to read a single line of text for password checking, when
one is required.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_newgrp_:

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

The standard error shall be used for diagnostic messages and a prompt
string for a password, if one is required. Diagnostic messages may be
written in cases where the exit status is not available. See the EXIT
STATUS section.

<a name="output-files"></a>

# Output Files

None.

<a name="extended-description"></a>

# Extended Description

None.

<a name="exit-status"></a>

# Exit Status

If
_newgrp_
succeeds in creating a new shell execution environment, whether or not
the group identification was changed successfully, the exit status
shall be the exit status of the shell. Otherwise, the following exit
value shall be returned:

* &gt;0  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

The invoking shell may terminate.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

There is no convenient way to enter a password into the group
database. Use of group passwords is not encouraged, because by their
very nature they encourage poor security practices. Group passwords
may disappear in the future.

A common implementation of
_newgrp_
is that the current shell uses
_exec_
to overlay itself with
_newgrp_,
which in turn overlays itself with a new shell after changing group.
On some implementations, however, this may not occur and
_newgrp_
may be invoked as a subprocess.

The
_newgrp_
command is intended only for use from an interactive terminal. It does
not offer a useful interface for the support of applications.

The exit status of
_newgrp_
is generally inapplicable. If
_newgrp_
is used in a script, in most cases it successfully invokes a new shell
and the rest of the original shell script is bypassed when the new
shell exits. Used interactively,
_newgrp_
displays diagnostic messages to indicate problems. But usage such as:

    
    newgrp foo
    echo $?


is not useful because the new shell might not have access to any status
_newgrp_
may have generated (and most historical systems do not provide this
status). A zero status echoed here does not necessarily indicate that
the user has changed to the new group successfully. Following
_newgrp_
with the
_id_
command provides a portable means of determining whether the group
change was successful or not.

<a name="examples"></a>

# Examples

None.

<a name="rationale"></a>

# Rationale

Most historical implementations use one of the
_exec_
functions to implement the behavior of
_newgrp_.
Errors detected before the
_exec_
leave the environment unchanged, while errors detected after the
_exec_
leave the user in a changed environment. While it would be useful to
have
_newgrp_
issue a diagnostic message to tell the user that the environment
changed, it would be inappropriate to require this change to some
historical implementations.

The password mechanism is allowed in the group database, but how this
would be implemented is not specified.

The
_newgrp_
utility was retained in this volume of POSIX.1-2008, even given the existence of the multiple
group permissions feature in the System Interfaces volume of POSIX.1-2008, for several reasons. First, in
some implementations, the group ownership of a newly created file is
determined by the group of the directory in which the file is created,
as allowed by the System Interfaces volume of POSIX.1-2008; on other implementations, the group ownership
of a newly created file is determined by the effective group ID. On
implementations of the latter type,
_newgrp_
allows files to be created with a specific group ownership. Finally,
many implementations use the real group ID in accounting, and on such
systems,
_newgrp_
allows the accounting identity of the user to be changed.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Chapter 2_, _Shell Command Language_,
__sh_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_

The System Interfaces volume of POSIX.1-2008,
__exec_\^_,
__getgrnam_\^(\|)_

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
