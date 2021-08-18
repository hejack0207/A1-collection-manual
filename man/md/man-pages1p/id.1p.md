# id(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

id
— return user identity

<a name="synopsis"></a>

# Synopsis

```


```
    id [user]
    
    id (miG [(min] [user]
    
    id (mig [(minr] [user]
    
    id (miu [(minr] [user]

<a name="description"></a>

# Description

If no
_user_
operand is provided, the
_id_
utility shall write the user and group IDs and the corresponding user
and group names of the invoking process to standard output. If the
effective and real IDs do not match, both shall be written. If
multiple groups are supported by the underlying system (see the
description of
{NGROUPS_MAX}
in the System Interfaces volume of POSIX.1-2008), the supplementary group affiliations of the invoking
process shall also be written.

If a
_user_
operand is provided and the process has appropriate privileges, the
user and group IDs of the selected user shall be written. In this
case, effective IDs shall be assumed to be identical to real IDs. If
the selected user has more than one allowable group membership listed
in the group database, these shall be written in the same manner as the
supplementary groups described in the preceding paragraph.

<a name="options"></a>

# Options

The
_id_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(miG**  
  Output all different group IDs (effective, real, and supplementary)
  only, using the format
  **"%u\en"**.
  If there is more than one distinct group affiliation, output each such
  affiliation, using the format
  **"&nbsp;%u"**,
  before the
  &lt;newline&gt;
  is output.
* **\(mig**  
  Output only the effective group ID, using the format
  **"%u\en"**.
* **\(min**  
  Output the name in the format
  **"%s"**
  instead of the numeric ID using the format
  **"%u"**.
* **\(mir**  
  Output the real ID instead of the effective ID.
* **\(miu**  
  Output only the effective user ID, using the format
  **"%u\en"**.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _user_  
  The login name for which information is to be written.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_id_:

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

The following formats shall be used when the
_LC_MESSAGES_
locale category specifies the POSIX locale. In other locales, the
strings
_uid_,
_gid_,
_euid_,
_egid_,
and
_groups_
may be replaced with more appropriate strings corresponding to the
locale.

    
    "uid=%u(%s) gid=%u(%s)en", <real user ID>, <user-name>,
        <real group ID>, <group-name>


If the effective and real user IDs do not match, the following shall be
inserted immediately before the
**'\en'**
character in the previous format:

    
    " euid=%u(%s)"


with the following arguments added at the end of the argument list:

    
    <effective user ID>, <effective user-name>


If the effective and real group IDs do not match, the following shall
be inserted directly before the
**'\en'**
character in the format string (and after any addition resulting from
the effective and real user IDs not matching):

    
    " egid=%u(%s)"


with the following arguments added at the end of the argument list:

    
    <effective group-ID>, <effective group name>


If the process has supplementary group affiliations or the selected
user is allowed to belong to multiple groups, the first shall be added
directly before the
&lt;newline&gt;
in the format string:

    
    " groups=%u(%s)"


with the following arguments added at the end of the argument list:

    
    <supplementary group ID>, <supplementary group name>


and the necessary number of the following added after that for any
remaining supplementary group IDs:

    
    ",%u(%s)"


and the necessary number of the following arguments added at the end of
the argument list:

    
    <supplementary group ID>, <supplementary group name>


If any of the user ID, group ID, effective user ID, effective group ID,
or supplementary/multiple group IDs cannot be mapped by the system into
printable user or group names, the corresponding
**"(%s)"**
and
_name_
argument shall be omitted from the corresponding format string.

When any of the options are specified, the output format shall be as
described in the OPTIONS section.

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

Output produced by the
**\(miG**
option and by the default case could potentially produce very long
lines on systems that support large numbers of supplementary groups.
(On systems with user and group IDs that are 32-bit integers and with
group names with a maximum of 8 bytes per name, 93 supplementary groups
plus distinct effective and real group and user IDs could theoretically
overflow the 2\|048-byte
{LINE_MAX}
text file line limit on the default output case. It would take about
186 supplementary groups to overflow the 2\|048-byte barrier using
_id_
**\(miG**).
This is not expected to be a problem in practice, but in cases where it
is a concern, applications should consider using
_fold_
**\(mis**
before post-processing the output of
_id_.

<a name="examples"></a>

# Examples

None.

<a name="rationale"></a>

# Rationale

The functionality provided by the 4 BSD
_groups_
utility can be simulated using:

    
    id (miGn [ user ]


The 4 BSD command
_groups_
was considered, but it was not included because it did not provide the
functionality of the
_id_
utility of the SVID. Also, it was thought that it would be easier to
modify
_id_
to provide the additional functionality necessary to systems with
multiple groups than to invent another command.

The options
**\(miu**,
**\(mig**,
**\(min**,
and
**\(mir**
were added to ease the use of
_id_
with shell commands substitution. Without these options it is
necessary to use some preprocessor such as
_sed_
to select the desired piece of information. Since output such as that
produced by:

    
    id (miu (min


is frequently wanted, it seemed desirable to add the options.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__fold_\^_,
__logname_\^_,
__who_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_

The System Interfaces volume of POSIX.1-2008,
__getgid_\^(\|)_,
__getgroups_\^(\|)_,
__getuid_\^(\|)_

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
