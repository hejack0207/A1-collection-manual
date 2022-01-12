# uux(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

uux
— remote command execution

<a name="synopsis"></a>

# Synopsis

```


```
    uux [(mijnp] command(mistring

<a name="description"></a>

# Description

The
_uux_
utility shall gather zero or more files from various systems, execute a
shell pipeline (see
_Section 2.9_, _Shell Commands_)
on a specified system, and then send the standard output of the command
to a file on a specified system. Only the first command of a pipeline
can have a
_system-name_!
prefix. All other commands in the pipeline shall be executed on the
system of the first command.

The following restrictions are applicable to the shell pipeline
processed by
_uux_:

*  *  
  In gathering files from different systems, pathname expansion shall
  not be performed by
  _uux_.
  Thus, a request such as:

    
    uux "c99 remsys!~/*.c"


would attempt to copy the file named literally
***.c**
to the local system.

*  *  
  The redirection operators
  **"&gt;&gt;"**,
  **"&lt;&lt;"**,
  **"&gt;|"**,
  and
  **"&gt;&"**
  shall not be accepted. Any use of these redirection operators shall
  cause this utility to write an error message describing the problem
  and exit with a non-zero exit status.
*  *  
  The reserved word
  **!**
  cannot be used at the head of the pipeline to modify the exit status.
  (See the
  _command-string_
  operand description below.)
*  *  
  Alias substitution shall not be performed.

A filename can be specified as for
_uucp_;
it can be an absolute pathname, a pathname preceded by ~\c
_name_
(which is replaced by the corresponding login directory), a pathname
specified as ~/\^\c
_dest_
(\c
_dest_
is prefixed by the public directory called
_PUBDIR_;
the actual location of
_PUBDIR_
is implementation-defined), or a simple filename (which is prefixed
by
_uux_
with the current directory). See
__uucp_\^_
for the details.

The execution of commands on remote systems shall take place in an
execution directory known to the
_uucp_
system. All files required for the execution shall be put into this
directory unless they already reside on that machine. Therefore, the
application shall ensure that non-local filenames (without path or
machine reference) are unique within the
_uux_
request.

The
_uux_
utility shall attempt to get all files to the execution system. For
files that are output files, the application shall ensure that the
filename is escaped using parentheses.

The remote system shall notify the user by mail if the requested
command on the remote system was disallowed or the files were not
accessible. This notification can be turned off by the
**\(min**
option.

Typical implementations of this utility require a communications line
configured to use the Base Definitions volume of POSIX.1-2008,
_Chapter 11_, _General Terminal Interface_,
but other communications means may be used. On systems where there are
no available communications means (either temporarily or permanently),
this utility shall write an error message describing the problem and
exit with a non-zero exit status.

The
_uux_
utility cannot guarantee support for all character encodings in all
circumstances. For example, transmission data may be restricted to 7
bits by the underlying network, 8-bit data and filenames need not be
portable to non-internationalized systems, and so on. Under these
circumstances, it is recommended that only characters defined in the
ISO/IEC&nbsp;646:\|1991 standard International Reference Version (equivalent to ASCII) 7-bit range
of characters be used and that only characters defined in the portable
filename character set be used for naming files.

<a name="options"></a>

# Options

The
_uux_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(mij**  
  Write the job identification string to standard output. This job
  identification can be used by
  _uustat_
  to obtain the status or terminate a job.
* **\(min**  
  Do not notify the user if the command fails.
* **\(mip**  
  Make the standard input to
  _uux_
  the standard input to the
  _command-string_.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _command-string_    
  A string made up of one or more arguments that are similar to normal
  command arguments, except that the command and any filenames can be
  prefixed by
  _system-name_!.
  A null
  _system-name_
  shall be interpreted as the local system.

<a name="stdin"></a>

# Stdin

The standard input shall not be used unless the
**'\(mi'**
or
**\(mip**
option is specified; in those cases, the standard input shall be made
the standard input of the
_command-string_.

<a name="input-files"></a>

# Input Files

Input files shall be selected according to the contents of
_command-string_.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_uux_:

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

The standard output shall not be used unless the
**\(mij**
option is specified; in that case, the job identification string shall
be written to standard output in the following format:

    
    "%sen", <jobid>


<a name="stderr"></a>

# Stderr

The standard error shall be used only for diagnostic messages.

<a name="output-files"></a>

# Output Files

Output files shall be created or written, or both, according to the
contents of
_command-string_.

If
**\(min**
is not used, mail files shall be modified following any command or
file-access failures on the remote system.

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

This utility is part of the UUCP Utilities option and need not be
supported by all implementations.

Note that, for security reasons, many installations limit the list of
commands executable on behalf of an incoming request from
_uux_.
Many sites permit little more than the receipt of mail via
_uux_.

Any characters special to the command interpreter should be quoted
either by quoting the entire
_command-string_
or quoting the special characters as individual arguments.

As noted in
_uucp_,
shell pattern matching notation
characters appearing in pathnames are expanded on the appropriate local
system. This is done under the control of local settings of
_LC_COLLATE_
and
_LC_CTYPE_.
Thus, care should be taken when using bracketed filename patterns, as
collation and typing rules may vary from one system to another. Also
be aware that certain types of expression (that is, equivalence
classes, character classes, and collating symbols) need not be
supported on non-internationalized systems.

<a name="examples"></a>

# Examples


*  1.  
  The following command gets
  **file1**
  from system
  **a**
  and
  **file2**
  from system
  **b**,
  executes
  _diff_
  on the local system, and puts the results in
  **file.diff**
  in the local
  _PUBDIR_
  directory. (\c
  _PUBDIR_
  is the
  _uucp_
  public directory on the local system.)

    
    uux "!diff a!/usr/file1 b!/a4/file2 >!~/file.diff"


*  2.  
  The following command fails because
  _uux_
  places all files copied to a system in the same working directory.
  Although the files
  **xyz**
  are from two different systems, their filenames are the same and
  conflict.

    
    uux "!diff a!/usr1/xyz b!/usr2/xyz >!~/xyz.diff"


*  3.  
  The following command succeeds (assuming
  _diff_
  is permitted on system
  **a**)
  because the file local to system
  **a**
  is not copied to the working directory, and hence does not conflict with
  the file from system
  **c**.

    
    uux "a!diff a!/usr/xyz c!/usr/xyz >!~/xyz.diff"


<a name="rationale"></a>

# Rationale

None.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Chapter 2_, _Shell Command Language_,
__uucp_\^_,
__uuencode_\^_,
__uustat_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Chapter 11_, _General Terminal Interface_,
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
