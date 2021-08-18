# fuser(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

fuser
— list process IDs of all processes that have one or more files open

<a name="synopsis"></a>

# Synopsis

```


```
    fuser [(micfu] file...

<a name="description"></a>

# Description

The
_fuser_
utility shall write to standard output the process IDs of processes
running on the local system that have one or more named files open.
For block special devices, all processes using any file on that device
are listed.

The
_fuser_
utility shall write to standard error additional information about the
named files indicating how the file is being used.

Any output for processes running on remote systems that have a named
file open is unspecified.

A user may need appropriate privileges to invoke the
_fuser_
utility.

<a name="options"></a>

# Options

The
_fuser_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(mic**  
  The file is treated as a mount point and the utility shall report
  on any files open in the file system.
* **\(mif**  
  The report shall be only for the named files.
* **\(miu**  
  The user name, in parentheses, associated with each process ID written
  to standard output shall be written to standard error.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _file_  
  A pathname on which the file or file system is to be reported.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

The user database.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_fuser_:

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

The
_fuser_
utility shall write the process ID for each process using each file
given as an operand to standard output in the following format:

    
    "%d", <process_id>


<a name="stderr"></a>

# Stderr

The
_fuser_
utility shall write diagnostic messages to standard error.

The
_fuser_
utility also shall write the following to standard error:

*  *  
  The pathname of each named file is written followed immediately by a
  &lt;colon&gt;.
*  *  
  For each process ID written to standard output, the character
  **'c'**
  shall be written to standard error if the process is using the file as
  its current directory and the character
  **'r'**
  shall be written to standard error if the process is using the file as
  its root directory. Implementations may write other alphabetic
  characters to indicate other uses of files.
*  *  
  When the
  **\(miu**
  option is specified, characters indicating the use of the file shall be
  followed immediately by the user name, in parentheses, corresponding to
  the real user ID of the process. If the user name cannot be resolved from
  the real user ID of the process, the real user ID of the process shall
  be written instead of the user name.

When standard output and standard error are directed to the same file,
the output shall be interleaved so that the filename appears at the
start of each line, followed by the process ID and characters
indicating the use of the file. Then, if the
**\(miu**
option is specified, the user name or user ID for each process using
that file shall be written.

A
&lt;newline&gt;
shall be written to standard error after the last output
described above for each
_file_
operand.

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

None.

<a name="examples"></a>

# Examples

The command:

    
    fuser (mifu .


writes to standard output the process IDs of processes that are using
the current directory and writes to standard error an indication of how
those processes are using the directory and the user names associated
with the processes that are using the current directory.

    
    fuser (mic <mount point>


writes to standard output the process IDs of processes that are using
any file in the file system which is mounted on &lt;_mount point_&gt;
and writes to standard error an indication of how those processes are
using the files.

    
    fuser <mount point>


writes to standard output the process IDs of processes that are using
the file which is named by &lt;_mount point_&gt; and writes to standard
error an indication of how those processes are using the file.

    
    fuser <block device>


writes to standard output the process IDs of processes that are using
any file which is on the device named by &lt;_block device_&gt; and
writes to standard error an indication of how those processes are using
the file.

    
    fuser (mif <block device>


writes to standard output the process IDs of processes that are using
the file &lt;_block device_&gt; itself and writes to standard error an
indication of how those processes are using the file.

<a name="rationale"></a>

# Rationale

The definition of the
_fuser_
utility follows existing practice.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_

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
