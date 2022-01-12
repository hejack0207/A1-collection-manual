# umask(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

umask
— get or set the file mode creation mask

<a name="synopsis"></a>

# Synopsis

```


```
    umask [(miS] [mask]

<a name="description"></a>

# Description

The
_umask_
utility shall set the file mode creation mask of the current shell
execution environment (see
_Section 2.12_, _Shell Execution Environment_)
to the value specified by the
_mask_
operand. This mask shall affect the initial value of the file
permission bits of subsequently created files. If
_umask_
is called in a subshell or separate utility execution environment, such
as one of the following:

    
    (umask 002)
    nohup umask ...
    find . (miexec umask ... e;


it shall not affect the file mode creation mask of the caller's
environment.

If the
_mask_
operand is not specified, the
_umask_
utility shall write to standard output the value of the
file mode creation mask of the invoking process.

<a name="options"></a>

# Options

The
_umask_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following option shall be supported:

* **\(miS**  
  Produce symbolic output.

The default output style is unspecified, but shall be recognized on a
subsequent invocation of
_umask_
on the same system as a
_mask_
operand to restore the previous file mode creation mask.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _mask_  
  A string specifying the new file mode creation mask. The string is
  treated in the same way as the
  _mode_
  operand described in the EXTENDED DESCRIPTION section for
  _chmod_.

For a
_symbolic_mode_
value, the new value of the file mode creation mask shall be the
logical complement of the file permission bits portion of the file mode
specified by the
_symbolic_mode_
string.

In a
_symbolic_mode_
value, the permissions
_op_
characters
**'\(pl'**
and
**'\(mi'**
shall be interpreted relative to the current file mode creation mask;
**'\(pl'**
shall cause the bits for the indicated permissions to be cleared in the
mask;
**'\(mi'**
shall cause the bits for the indicated permissions to be set in the
mask.

The interpretation of
_mode_
values that specify file mode bits other than the file permission bits
is unspecified.

In the octal integer form of
_mode_,
the specified bits are set in the file mode creation mask.

The file mode creation mask shall be set to the resulting numeric
value.

The default output of a prior invocation of
_umask_
on the same system with no operand also shall be recognized as a
_mask_
operand.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_umask_:

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

When the
_mask_
operand is not specified, the
_umask_
utility shall write a message to standard output that can later be used
as a
_umask_
_mask_
operand.

If
**\(miS**
is specified, the message shall be in the following format:

    
    "u=%s,g=%s,o=%sen", <owner permissions>, <group permissions>,
        <other permissions>


where the three values shall be combinations of letters from the set
{\c
_r_,
_w_,
_x_};
the presence of a letter shall indicate that the corresponding bit is
clear in the file mode creation mask.

If a
_mask_
operand is specified, there shall be no output written to standard
output.

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
  The file mode creation mask was successfully changed, or no
  _mask_
  operand was supplied.
* &gt;0  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

Since
_umask_
affects the current shell execution environment, it is generally
provided as a shell regular built-in.

In contrast to the negative permission logic provided by the file mode
creation mask and the octal number form of the
_mask_
argument, the symbolic form of the
_mask_
argument specifies those permissions that are left alone.

<a name="examples"></a>

# Examples

Either of the commands:

    
    umask a=rx,ug+w
    
    umask 002


sets the mode mask so that subsequently created files have their
S_IWOTH bit cleared.

After setting the mode mask with either of the above commands, the
_umask_
command can be used to write out the current value of the mode mask:

    
    $ umask
    0002


(The output format is unspecified, but historical implementations use
the octal integer mode format.)

    
    $ umask (miS
    u=rwx,g=rwx,o=rx


Either of these outputs can be used as the mask operand to a subsequent
invocation of the
_umask_
utility.

Assuming the mode mask is set as above, the command:

    
    umask g(miw


sets the mode mask so that subsequently created files have their
S_IWGRP and S_IWOTH bits cleared.

The command:

    
    umask (mi|(mi (miw


sets the mode mask so that subsequently created files have all their
write bits cleared. Note that
_mask_
operands
**\(mir**,
**\(miw**,
**\(mix**
or anything beginning with a
&lt;hyphen&gt;,
must be preceded by
**"\(mi\|\(mi"**
to keep it from being interpreted as an option.

<a name="rationale"></a>

# Rationale

Since
_umask_
affects the current shell execution environment,
it is generally provided as a shell regular built-in. If it is called
in a subshell or separate utility execution environment, such as one of
the following:

    
    (umask 002)
    nohup umask ...
    find . (miexec umask ... e;


it does not affect the file mode creation mask of the environment of
the caller.

The description of the historical utility was modified to allow it to
use the symbolic modes of
_chmod_.
The
**\(mis**
option used in early proposals was changed to
**\(miS**
because
**\(mis**
could be confused with a
_symbolic_mode_
form of mask referring to the S_ISUID and S_ISGID bits.

The default output style is unspecified to permit implementors to
provide migration to the new symbolic style at the time most
appropriate to their users. A
**\(mio**
flag to force octal mode output was omitted because the octal mode may
not be sufficient to specify all of the information that may be present
in the file mode creation mask when more secure file access permission
checks are implemented.

It has been suggested that trusted systems developers might appreciate
ameliorating the requirement that the mode mask \`\`affects'' the file
access permissions, since it seems access control lists might replace
the mode mask to some degree. The wording has been changed to say that
it affects the file permission bits, and it leaves the details of the
behavior of how they affect the file access permissions to the
description in the System Interfaces volume of POSIX.1-2008.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Chapter 2_, _Shell Command Language_,
__chmod_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_

The System Interfaces volume of POSIX.1-2008,
__umask_\^(\|)_

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
