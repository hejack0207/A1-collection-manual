# uucp(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

uucp
— system-to-system copy

<a name="synopsis"></a>

# Synopsis

```


```
    uucp [(micCdfjmr] [(min user] source-file... destination-file

<a name="description"></a>

# Description

The
_uucp_
utility shall copy files named by the
_source-file_
argument to the
_destination-file_
argument. The files named can be on local or remote systems.

The
_uucp_
utility cannot guarantee support for all character encodings in all
circumstances. For example, transmission data may be restricted to 7
bits by the underlying network, 8-bit data and filenames need not be
portable to non-internationalized systems, and so on. Under these
circumstances, it is recommended that only characters defined in the
ISO/IEC&nbsp;646:\|1991 standard International Reference Version (equivalent to ASCII) 7-bit range
of characters be used, and that only characters defined in the portable
filename character set be used for naming files. The protocol for
transfer of files is unspecified by POSIX.1-2008.

Typical implementations of this utility require a communications line
configured to use the Base Definitions volume of POSIX.1-2008,
_Chapter 11_, _General Terminal Interface_,
but other communications means may be used. On systems where there are
no available communications means (either temporarily or permanently),
this utility shall write an error message describing the problem and
exit with a non-zero exit status.

<a name="options"></a>

# Options

The
_uucp_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(mic**  
  Do not copy local file to the spool directory for transfer to the
  remote machine (default).
* **\(miC**  
  Force the copy of local files to the spool directory for transfer.
* **\(mid**  
  Make all necessary directories for the file copy (default).
* **\(mif**  
  Do not make intermediate directories for the file copy.
* **\(mij**  
  Write the job identification string to standard output. This job
  identification can be used by
  _uustat_
  to obtain the status or terminate a job.
* **\(mim**  
  Send mail to the requester when the copy is completed.
* **\(min&nbsp;user**  
  Notify
  _user_
  on the remote system that a file was sent.
* **\(mir**  
  Do not start the file transfer; just queue the job.

<a name="operands"></a>

# Operands

The following operands shall be supported:

* _destination-file_,&nbsp;_source-file_    
  A pathname of a file to be copied to, or from, respectively. Either
  name can be a pathname on the local machine, or can have the form:

    
    system-name!pathname


where
_system-name_
is taken from a list of system names that
_uucp_
knows about.
The destination
_system-name_
can also be a list of names such as:

    
    system-name!system-name!...!system-name!pathname


in which case, an attempt is made to send the file via the specified
route to the destination. Care should be taken to ensure that
intermediate nodes in the route are willing to forward information.

The shell pattern matching notation characters
**'?'**,
**'*'**,
and
**"[...]"**
appearing in
_pathname_
shall be expanded on the appropriate system.

Pathnames can be one of:

*  1.  
  An absolute pathname.
*  2.  
  A pathname preceded by ~\c
  _user_
  where
  _user_
  is a login name on the specified system and is replaced by that user's
  login directory. Note that if an invalid login is specified, the
  default is to the public directory (called
  _PUBDIR_;
  the actual location of
  _PUBDIR_
  is implementation-defined).
*  3.  
  A pathname preceded by ~/\c
  _destination_
  where
  _destination_
  is appended to
  _PUBDIR_.
    * **Note:**  
      This destination is treated as a filename unless more than one file is
      being transferred by this request or the destination is already a
      directory. To ensure that it is a directory, follow the destination
      with a
      **'/'**.
      For example,
      **~/dan/**
      as the destination makes the directory
      **PUBDIR/dan**
      if it does not exist and puts the requested files in that directory.


*  4.  
  Anything else shall be prefixed by the current directory.

If the result is an erroneous pathname for the remote system, the copy
shall fail. If the
_destination-file_
is a directory, the last part of the
_source-file_
name shall be used.

The read, write, and execute permissions given by
_uucp_
are implementation-defined.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

The files to be copied are regular files.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_uucp_:

* _LANG_  
  Provide a default value for the internationalization variables that are
  unset or null. (See the Base Definitions volume of POSIX.1-2008,
  _Section 8.2_, _Internationalization Variables_
  for the precedence of internationalization variables used to determine
  the values of locale categories.)
* _LC\_ALL_  
  If set to a non-empty string value, override the values of all the
  other internationalization variables.
* _LC\_COLLATE_    
  Determine the locale for the behavior of ranges, equivalence classes,
  and multi-character collating elements within bracketed filename
  patterns.
* _LC\_CTYPE_  
  Determine the locale for the interpretation of sequences of bytes of
  text data as characters (for example, single-byte as opposed to
  multi-byte characters in arguments and input files) and the behavior of
  character classes within bracketed filename patterns (for example,
  **"'[[:lower:]]*'"**).
* _LC\_MESSAGES_    
  Determine the locale that should be used to affect the format and
  contents of diagnostic messages written to standard error, and
  informative messages written to standard output.
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

The output files (which may be on other systems) are copies of the
input files.

If
**\(mim**
is used, mail files are modified.

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

The domain of remotely accessible files can (and for obvious security
reasons usually should) be severely restricted.

Note that the
**'!'**
character in addresses has to be escaped when using
_csh_
as a command interpreter because of its history substitution syntax.
For
_ksh_
and
_sh_
the escape is not necessary, but may be used.

As noted above, shell metacharacters appearing in pathnames are
expanded on the appropriate system. On an internationalized system,
this is done under the control of local settings of
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

None.

<a name="rationale"></a>

# Rationale

None.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__mailx_\^_,
__uuencode_\^_,
__uustat_\^_,
__uux_\^_

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
