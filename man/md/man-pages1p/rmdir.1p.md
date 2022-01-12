# rmdir(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

rmdir
— remove directories

<a name="synopsis"></a>

# Synopsis

```


```
    rmdir [(mip] dir...

<a name="description"></a>

# Description

The
_rmdir_
utility shall remove the directory entry specified by each
_dir_
operand.

For each
_dir_
operand, the
_rmdir_
utility shall perform actions equivalent to the
_rmdir_()
function called with the
_dir_
operand as its only argument.

Directories shall be processed in the order specified. If a directory
and a subdirectory of that directory are specified in a single
invocation of the
_rmdir_
utility, the application shall specify the subdirectory before the
parent directory so that the parent directory will be empty when the
_rmdir_
utility tries to remove it.

<a name="options"></a>

# Options

The
_rmdir_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following option shall be supported:

* **\(mip**  
  Remove all directories in a pathname. For each
  _dir_
  operand:
    *  1.  
      The directory entry it names shall be removed.
    *  2.  
      If the
      _dir_
      operand includes more than one pathname component, effects equivalent
      to the following command shall occur:

    
    rmdir (mip $(dirname dir)


<a name="operands"></a>

# Operands

The following operand shall be supported:

* _dir_  
  A pathname of an empty directory to be removed.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_rmdir_:

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
  Each directory entry specified by a
  _dir_
  operand was removed successfully.
* &gt;0  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

The definition of an empty directory is one that contains, at most,
directory entries for dot and dot-dot.

<a name="examples"></a>

# Examples

If a directory
**a**
in the current directory is empty except it contains a directory
**b**
and
**a/b**
is empty except it contains a directory
**c**:

    
    rmdir (mip a/b/c


removes all three directories.

<a name="rationale"></a>

# Rationale

On historical System V systems, the
**\(mip**
option also caused a message to be written to the standard output. The
message indicated whether the whole path was removed or whether part of
the path remained for some reason. The STDERR section requires this
diagnostic when the entire path specified by a
_dir_
operand is not removed, but does not allow the status message reporting
success to be written as a diagnostic.

The
_rmdir_
utility on System V also included a
**\(mis**
option that suppressed the informational message output by the
**\(mip**
option. This option has been omitted because the informational message
is not specified by this volume of POSIX.1-2008.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__rm_\^_

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
