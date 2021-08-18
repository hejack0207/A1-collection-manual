# df(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

df
— report free disk space

<a name="synopsis"></a>

# Synopsis

```


```
    df [(mik] [(miP|(mit] [file...]

<a name="description"></a>

# Description

The
_df_
utility shall write the amount of available space
and file slots
for file systems on which the invoking user has appropriate read
access. File systems shall be specified by the
_file_
operands; when none are specified, information shall be written for all
file systems. The format of the default output from
_df_
is unspecified, but all space figures are reported in 512-byte units,
unless the
**\(mik**
option is specified. This output shall contain at least the file system
names, amount of available space on each of these file systems,
and, if no options other than
**\(mit**
are specified, the number of free file slots, or
_inode_s,
available; when
**\(mit**
is specified, the output shall contain the total allocated space as well.

<a name="options"></a>

# Options

The
_df_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(mik**  
  Use 1\|024-byte units, instead of the default 512-byte units, when
  writing space figures.
* **\(miP**  
  Produce output in the format described in the STDOUT section.
* **\(mit**  
  Include total allocated-space figures in the output.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _file_  
  A pathname of a file within the hierarchy of the desired file system.
  If a file other than a FIFO, a regular file, a directory,
  or a special file representing the device containing the file system
  (for example,
  **/dev/dsk/0s1**)
  is specified, the results are unspecified. If the
  _file_
  operand names a file other than a special file containing a file
  system,
  _df_
  shall write the amount of free space in the file system containing the
  specified
  _file_
  operand.
  Otherwise,
  _df_
  shall write the amount of free space in that file system.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_df_:

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

When both the
**\(mik**
and
**\(miP**
options are specified, the following header line shall be written (in
the POSIX locale):

    
    "Filesystem 1024-blocks Used Available Capacity Mounted onen"


When the
**\(miP**
option is specified without the
**\(mik**
option, the following header line shall be written (in the POSIX
locale):

    
    "Filesystem 512-blocks Used Available Capacity Mounted onen"


The implementation may adjust the spacing of the header line and the
individual data lines so that the information is presented in orderly
columns.

The remaining output with
**\(miP**
shall consist of one line of information for each specified
file system. These lines shall be formatted as follows:

    
    "%s %d %d %d %d%% %sen", <file system name>, <total space>,
        <space used>, <space free>, <percentage used>,
        <file system root>


In the following list, all quantities expressed in 512-byte units
(1\|024-byte when
**\(mik**
is specified) shall be rounded up to the next higher unit. The fields
are:

* &lt;_file&nbsp;system&nbsp;name_&gt;    
  The name of the file system, in an implementation-defined format.
* &lt;_total&nbsp;space_&gt;  
  The total size of the file system in 512-byte units. The exact meaning
  of this figure is implementation-defined, but should include
  &lt;_space&nbsp;used_&gt;, &lt;_space&nbsp;free_&gt;, plus any space reserved by
  the system not normally available to a user.
* &lt;_space&nbsp;used_&gt;  
  The total amount of space allocated to existing files in the
  file system, in 512-byte units.
* &lt;_space&nbsp;free_&gt;  
  The total amount of space available within the file system for the
  creation of new files by unprivileged users, in 512-byte units. When
  this figure is less than or equal to zero, it shall not be possible to
  create any new files on the file system without first deleting others,
  unless the process has appropriate privileges. The figure written may
  be less than zero.
* &lt;_percentage&nbsp;used_&gt;    
  The percentage of the normally available space that is currently
  allocated to all files on the file system. This shall be calculated
  using the fraction:

    
    <space used>/( <space used>+ <space free>)


expressed as a percentage. This percentage may be greater than 100 if
&lt;_space&nbsp;free_&gt; is less than zero. The percentage value shall be
expressed as a positive integer, with any fractional result causing it
to be rounded to the next highest integer.

* &lt;_file&nbsp;system&nbsp;root_&gt;    
  The directory below which the file system hierarchy appears.

The output format is unspecified when
**\(mit**
is used.

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

On most systems, the \`\`name of the file system, in an
implementation-defined format'' is the special file on which the
file system is mounted.

On large file systems, the calculation specified for percentage used
can create huge rounding errors.

<a name="examples"></a>

# Examples


*  1.  
  The following example writes portable information about the
  **/usr**
  file system:

    
    df (miP /usr


*  2.  
  Assuming that
  **/usr/src**
  is part of the
  **/usr**
  file system, the following produces the same output as the previous
  example:

    
    df (miP /usr/src


<a name="rationale"></a>

# Rationale

The behavior of
_df_
with the
**\(miP**
option is the default action of the 4.2 BSD
_df_
utility. The uppercase
**\(miP**
was selected to avoid collision with a known industry extension using
**\(mip**.

Historical
_df_
implementations vary considerably in their default output. It was
therefore necessary to describe the default output in a loose manner to
accommodate all known historical implementations and to add a portable
option (\c
**\(miP**)
to provide information in a portable format.

The use of 512-byte units is historical practice and maintains
compatibility with
_ls_
and other utilities in this volume of POSIX.1-2008. This does not mandate that the
file system itself be based on 512-byte blocks. The
**\(mik**
option was added as a compromise measure. It was agreed by the standard
developers that 512 bytes was the best default unit because of its
complete historical consistency on System V (_versus_ the mixed
512/1\|024-byte usage on BSD systems), and that a
**\(mik**
option to switch to 1\|024-byte units was a good compromise. Users who
prefer the more logical 1\|024-byte quantity can easily alias
_df_
to
_df_
**\(mik**
without breaking many historical scripts relying on the 512-byte
units.

It was suggested that
_df_
and the various related utilities be modified to access a
_BLOCKSIZE_
environment variable to achieve consistency and user acceptance. Since
this is not historical practice on any system, it is left as a possible
area for system extensions and will be re-evaluated in a future version
if it is widely implemented.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__find_\^_

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
