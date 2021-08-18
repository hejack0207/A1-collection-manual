# du(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

du
— estimate file space usage

<a name="synopsis"></a>

# Synopsis

```


```
    du [(mia|(mis] [(mikx] [(miH|(miL] [file...]

<a name="description"></a>

# Description

By default, the
_du_
utility shall write to standard output the size of the file space
allocated to, and the size of the file space allocated to each
subdirectory of, the file hierarchy rooted in each of the specified
files. By default, when a symbolic link is encountered on the command
line or in the file hierarchy,
_du_
shall count the size of the symbolic link (rather than the file
referenced by the link), and shall not follow the link to another
portion of the file hierarchy. The size of the file space allocated to
a file of type directory shall be defined as the sum total of space
allocated to all files in the file hierarchy rooted in the directory
plus the space allocated to the directory itself.

When
_du_
cannot
_stat_()
files or
_stat_()
or read directories, it shall report an error condition and the final
exit status is affected. Files with multiple links shall be counted and
written for only one entry. The directory entry that is selected in the
report is unspecified. By default, file sizes shall be written in
512-byte units, rounded up to the next 512-byte unit.

<a name="options"></a>

# Options

The
_du_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(mia**  
  In addition to the default output, report the size of each file not of
  type directory in the file hierarchy rooted in the specified file.
  Regardless of the presence of the
  **\(mia**
  option, non-directories given as
  _file_
  operands shall always be listed.
* **\(miH**  
  If a symbolic link is specified on the command line,
  _du_
  shall count the size of the file or file hierarchy referenced by the
  link.
* **\(mik**  
  Write the files sizes in units of 1\|024 bytes, rather than the default
  512-byte units.
* **\(miL**  
  If a symbolic link is specified on the command line or encountered
  during the traversal of a file hierarchy,
  _du_
  shall count the size of the file or file hierarchy referenced by the
  link.
* **\(mis**  
  Instead of the default output, report only the total sum for each of
  the specified files.
* **\(mix**  
  When evaluating file sizes, evaluate only those files that have the
  same device as the file specified by the
  _file_
  operand.

Specifying more than one of the mutually-exclusive options
**\(miH**
and
**\(miL**
shall not be considered an error. The last option specified shall
determine the behavior of the utility.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _file_  
  The pathname of a file whose size is to be written. If no
  _file_
  is specified, the current directory shall be used.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_du_:

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

The output from
_du_
shall consist of the amount of space allocated to a file and the
name of the file, in the following format:

    
    "%d %sen", <size>, <pathname>


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

None.

<a name="examples"></a>

# Examples

None.

<a name="rationale"></a>

# Rationale

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
prefer the 1\|024-byte quantity can easily alias
_du_
to
_du_
**\(mik**
without breaking the many historical scripts relying on the 512-byte
units.

The
**\(mib**
option was added to an early proposal to provide a resolution to the
situation where System V and BSD systems give figures for file sizes in
_blocks_,
which is an implementation-defined concept. (In common usage, the
block size is 512 bytes for System V and 1\|024 bytes for BSD systems.)
However,
**\(mib**
was later deleted, since the default was eventually decided as 512-byte
units.

Historical file systems provided no way to obtain exact figures for the
space allocation given to files. There are two known areas of
inaccuracies in historical file systems: cases of
_indirect blocks_
being used by the file system or
_sparse_
files yielding incorrectly high values. An indirect block is space used
by the file system in the storage of the file, but that need not be
counted in the space allocated to the file. A
_sparse_
file is one in which an
_lseek_()
call has been made to a position beyond the end of the file and data
has subsequently been written at that point. A file system need not
allocate all the intervening zero-filled blocks to such a file. It is
up to the implementation to define exactly how accurate its methods
are.

The
**\(mia**
and
**\(mis**
options were mutually-exclusive in the original version of
_du_.
The POSIX Shell and Utilities description is implied by the language in
the SVID where
**\(mis**
is described as causing \`\`only the grand total'' to be reported. Some
systems may produce output for
**\(misa**,
but a Strictly Conforming POSIX Shell and Utilities Application cannot
use that combination.

The
**\(mia**
and
**\(mis**
options were adopted from the SVID except that the System V behavior of
not listing non-directories explicitly given as operands, unless the
**\(mia**
option is specified, was considered a bug; the BSD-based behavior
(report for all operands) is mandated. The default behavior of
_du_
in the SVID with regard to reporting the failure to read files (it
produces no messages) was considered counter-intuitive, and thus it was
specified that the POSIX Shell and Utilities default behavior shall be
to produce such messages. These messages can be turned off with shell
redirection to achieve the System V behavior.

The
**\(mix**
option is historical practice on recent BSD systems. It has been
adopted by this volume of POSIX.1-2008 because there was no other historical method of
limiting the
_du_
search to a single file hierarchy. This limitation of the search is
necessary to make it possible to obtain file space usage information
about a file system on which other file systems are mounted, without
having to resort to a lengthy
_find_
and
_awk_
script.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__ls_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_

The System Interfaces volume of POSIX.1-2008,
__fstatat_\^(\|)_

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
