# ln(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

ln
— link files

<a name="synopsis"></a>

# Synopsis

```


```
    ln [(mifs] [(miL|(miP] source_file target_file
    
    ln [(mifs] [(miL|(miP] source_file... target_dir

<a name="description"></a>

# Description

In the first synopsis form, the
_ln_
utility shall create a new directory entry (link) at the
destination path specified by the
_target_file_
operand. If the
**\(mis**
option is specified, a symbolic link shall be created for the file
specified by the
_source_file_
operand. This first synopsis form shall be assumed when the final
operand does not name an existing directory; if more than two operands
are specified and the final is not an existing directory, an error
shall result.

In the second synopsis form, the
_ln_
utility shall create a new directory entry (link), or if the
**\(mis**
option is specified a symbolic link, for each file specified by a
_source_file_
operand, at a destination path in the existing directory named by
_target_dir_.

If the last operand specifies an existing file of a type not
specified by the System Interfaces volume of POSIX.1-2008, the behavior is implementation-defined.

The corresponding destination path for each
_source_file_
shall be the concatenation of the target directory pathname, a
&lt;slash&gt;
character if the target directory pathname did not end in a
&lt;slash&gt;,
and the last pathname component of the
_source_file_.
The second synopsis form shall be assumed when the final operand names
an existing directory.

For each
_source_file_:

*  1.  
  If the destination path exists and was created by a previous step,
  it is unspecified whether
  _ln_
  shall write a diagnostic message to standard error, do nothing more with
  the current
  _source_file_,
  and go on to any remaining
  _source_file_s;
  or will continue processing the current
  _source_file_.
  If the destination path exists:
    *  a.  
      If the
      **\(mif**
      option is not specified,
      _ln_
      shall write a diagnostic message to standard error, do nothing more
      with the current
      _source_file_,
      and go on to any remaining
      _source_file_s.
    *  b.  
      If
      _destination_
      names the same directory entry as the current
      _source_file_
      _ln_
      shall write a diagnostic message to standard error, do nothing more with
      the current
      _source_file_,
      and go on to any remaining
      _source_file_s_._
    *  c.  
      Actions shall be performed equivalent to the
      _unlink_()
      function defined in the System Interfaces volume of POSIX.1-2008, called using
      _destination_
      as the
      _path_
      argument. If this fails for any reason,
      _ln_
      shall write a diagnostic message to standard error, do nothing more
      with the current
      _source_file_,
      and go on to any remaining
      _source_file_s.
*  2.  
  If the
  **\(mis**
  option is specified, actions shall be performed equivalent to the
  _symlink_()
  function with
  _source_file_
  as the
  _path1_
  argument and the destination path as the
  _path2_
  argument. The
  _ln_
  utility shall do nothing more with
  _source_file_
  and shall go on to any remaining files.
*  3.  
  If
  _source_file_
  is a symbolic link:
    *  a.  
      If the
      **\(miP**
      option is in effect, actions shall be performed equivalent to the
      _linkat_()
      function with
      _source_file_
      as the
      _path1_
      argument, the destination path as the
      _path2_
      argument, AT_FDCWD as the
      _fd1_
      and
      _fd2_
      arguments, and zero as the
      _flag_
      argument.
    *  b.  
      If the
      **\(miL**
      option is in effect, actions shall be performed equivalent to the
      _linkat_()
      function with
      _source_file_
      as the
      _path1_
      argument, the destination path as the
      _path2_
      argument, AT_FDCWD as the
      _fd1_
      and
      _fd2_
      arguments, and AT_SYMLINK_FOLLOW as the
      _flag_
      argument.

The
_ln_
utility shall do nothing more with
_source_file_
and shall go on to any remaining files.

*  4.  
  Actions shall be performed equivalent to the
  _link_()
  function defined in the System Interfaces volume of POSIX.1-2008 using
  _source_file_
  as the
  _path1_
  argument, and the destination path as the
  _path2_
  argument.

<a name="options"></a>

# Options

The
_ln_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(mif**  
  Force existing destination pathnames to be removed to allow the link.
* **\(miL**  
  For each
  _source_file_
  operand that names a file of type symbolic link, create a (hard)
  link to the file referenced by the symbolic link.
* **\(miP**  
  For each
  _source_file_
  operand that names a file of type symbolic link, create a (hard)
  link to the symbolic link itself.
* **\(mis**  
  Create symbolic links instead of hard links. If the
  **\(mis**
  option is specified, the
  **\(miL**
  and
  **\(miP**
  options shall be silently ignored.

Specifying more than one of the mutually-exclusive options
**\(miL**
and
**\(miP**
shall not be considered an error. The last option specified shall
determine the behavior of the utility (unless the
**\(mis**
option causes it to be ignored).

If the
**\(mis**
option is not specified and neither a
**\(miL**
nor a
**\(miP**
option is specified, it is implementation-defined which of the
**\(miL**
and
**\(miP**
options will be used as the default.

<a name="operands"></a>

# Operands

The following operands shall be supported:

* _source\_file_  
  A pathname of a file to be linked. If the
  **\(mis**
  option is specified, no restrictions on the type of file or on its
  existence shall be made. If the
  **\(mis**
  option is not specified, whether a directory can be linked is
  implementation-defined.
* _target\_file_  
  The pathname of the new directory entry to be created.
* _target\_dir_  
  A pathname of an existing directory in which the new directory entries
  are created.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_ln_:

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
  All the specified files were linked successfully.
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

The CONSEQUENCES OF ERRORS section does not require
_ln_
**\(mif**
_a b_
to remove
_b_
if a subsequent link operation would fail.

Some historic versions of
_ln_
(including the one specified by the SVID) unlink the destination file,
if it exists, by default. If the mode does not permit writing, these
versions prompt for confirmation before attempting the unlink. In these
versions the
**\(mif**
option causes
_ln_
not to attempt to prompt for confirmation.

This allows
_ln_
to succeed in creating links when the target file already exists, even
if the file itself is not writable (although the directory must be).
Early proposals specified this functionality.

This volume of POSIX.1-2008 does not allow the
_ln_
utility to unlink existing destination paths by default for the
following reasons:

*  *  
  The
  _ln_
  utility has historically been used to provide locking for shell
  applications, a usage that is incompatible with
  _ln_
  unlinking the destination path by default. There was no corresponding
  technical advantage to adding this functionality.
*  *  
  This functionality gave
  _ln_
  the ability to destroy the link structure of files, which changes the
  historical behavior of
  _ln_.
*  *  
  This functionality is easily replicated with a combination of
  _rm_
  and
  _ln_.
*  *  
  It is not historical practice in many systems; BSD and BSD-derived
  systems do not support this behavior. Unfortunately, whichever behavior
  is selected can cause scripts written expecting the other behavior to
  fail.
*  *  
  It is preferable that
  _ln_
  perform in the same manner as the
  _link_()
  function, which does not permit the target to exist already.

This volume of POSIX.1-2008 retains the
**\(mif**
option to provide support for shell scripts depending on the SVID
semantics. It seems likely that shell scripts would not be written to
handle prompting by
_ln_
and would therefore have specified the
**\(mif**
option.

The
**\(mif**
option is an undocumented feature of many historical versions of the
_ln_
utility, allowing linking to directories. These versions require
modification.

Early proposals of this volume of POSIX.1-2008 also required a
**\(mii**
option, which behaved like the
**\(mii**
options in
_cp_
and
_mv_,
prompting for confirmation before unlinking existing files. This was
not historical practice for the
_ln_
utility and has been omitted.

The
**\(miL**
and
**\(miP**
options allow for implementing both common behaviors of the
_ln_
utility. Earlier versions of this standard did not specify these options
and required the behavior now described for the
**\(miL**
option. Many systems by default or as an alternative provided a
non-conforming
_ln_
utility with the behavior now described for the
**\(miP**
option. Since applications could not rely on
_ln_
following links in practice, the
**\(miL**
and
**\(miP**
options were added to specify the desired behavior for the application.

The
**\(miL**
and
**\(miP**
options are ignored when
**\(mis**
is specified in order to allow an alias to be created to alter the
default behavior when creating hard links (for example,
_alias_
_ln_='\c
_ln_
**\(miL**').
They serve no purpose when
**\(mis**
is specified, since
_source_file_
is then just a string to be used as the contents of the created symbolic
link and need not exist as a file.

The specification ensures that
_ln_
**a**
**a**
with or without the
**\(mif**
option will not unlink the file
**a**.
Earlier versions of this standard were unclear in this case.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__chmod_\^_,
__find_\^_,
__pax_\^_,
__rm_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_

The System Interfaces volume of POSIX.1-2008,
__link_\^(\|)_,
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
