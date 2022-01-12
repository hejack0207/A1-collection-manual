# mkdir(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

mkdir
— make directories

<a name="synopsis"></a>

# Synopsis

```


```
    mkdir [(mip] [(mim mode] dir...

<a name="description"></a>

# Description

The
_mkdir_
utility shall create the directories specified by the operands, in the
order specified.

For each
_dir_
operand, the
_mkdir_
utility shall perform actions equivalent to the
_mkdir_()
function defined in the System Interfaces volume of POSIX.1-2008, called with the following arguments:

*  1.  
  The
  _dir_
  operand is used as the
  _path_
  argument.
*  2.  
  The value of the bitwise-inclusive OR of S_IRWXU, S_IRWXG, and S_IRWXO
  is used as the
  _mode_
  argument. (If the
  **\(mim**
  option is specified, the value of the
  _mkdir_()
  _mode_
  argument is unspecified, but the directory shall at no time
  have permissions less restrictive than the
  **\(mim**
  _mode_
  option-argument.)

<a name="options"></a>

# Options

The
_mkdir_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(mim&nbsp;mode**  
  Set the file permission bits of the newly-created directory to the
  specified
  _mode_
  value. The
  _mode_
  option-argument shall be the same as the
  _mode_
  operand defined for the
  _chmod_
  utility. In the
  _symbolic_mode_
  strings, the
  _op_
  characters
  **'\(pl'**
  and
  **'\(mi'**
  shall be interpreted relative to an assumed initial mode of
  _a_=\c
  _rwx_;
  **'\(pl'**
  shall add permissions to the default mode,
  **'\(mi'**
  shall delete permissions from the default mode.
* **\(mip**  
  Create any missing intermediate pathname components.

For each
_dir_
operand that does not name an existing directory, before performing the
actions described in the DESCRIPTION above, the
_mkdir_
utility shall create any pathname components of the path prefix of
_dir_
that do not name an existing directory by performing actions equivalent
to first calling the
_mkdir_()
function with the following arguments:

*  1.  
  A pathname naming the missing pathname component, ending with a trailing
  &lt;slash&gt;
  character, as the
  _path_
  argument
*  2.  
  The value zero as the
  _mode_
  argument

and then calling the
_chmod_()
function with the following arguments:

*  1.  
  The same
  _path_
  argument as in the
  _mkdir_()
  call
*  2.  
  The value
  _(S\_IWUSR|S\_IXUSR|~_filemask_)&0777_
  as the
  _mode_
  argument, where
  _filemask_
  is the file mode creation mask of the process (see the System Interfaces volume of POSIX.1-2008,
  __umask_\^(\|)_)

Each
_dir_
operand that names an existing directory shall be ignored without
error.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _dir_  
  A pathname of a directory to be created.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_mkdir_:

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
  All the specified directories were created successfully or the
  **\(mip**
  option was specified and all the specified directories now exist.
* &gt;0  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

The default file mode for directories is
_a_=\c
_rwx_
(777 on most systems) with selected permissions removed in accordance
with the file mode creation mask. For intermediate pathname components
created by
_mkdir_,
the mode is the default modified by
_u_+\c
_wx_
so that the subdirectories can always be created regardless of the file
mode creation mask; if different ultimate permissions are desired for
the intermediate directories, they can be changed afterwards with
_chmod_.

Note that some of the requested directories may have been created even
if an error occurs.

<a name="examples"></a>

# Examples

None.

<a name="rationale"></a>

# Rationale

The System V
**\(mim**
option was included to control the file mode.

The System V
**\(mip**
option was included to create any needed intermediate directories and
to complement the functionality provided by
_rmdir_
for removing directories in the path prefix as they become empty.
Because no error is produced if any path component already exists, the
**\(mip**
option is also useful to ensure that a particular directory exists.

The functionality of
_mkdir_
is described substantially through a reference to the
_mkdir_()
function in the System Interfaces volume of POSIX.1-2008. For example, by default, the mode of the
directory is affected by the file mode creation mask in accordance with
the specified behavior of the
_mkdir_()
function. In this way, there is less duplication of effort required for
describing details of the directory creation.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__chmod_\^_,
__rm_\^_,
__rmdir_\^_,
__umask_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_

The System Interfaces volume of POSIX.1-2008,
__mkdir_\^(\|)_,
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
