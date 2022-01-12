# chmod(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

chmod
— change the file modes

<a name="synopsis"></a>

# Synopsis

```


```
    chmod [(miR] mode file...

<a name="description"></a>

# Description

The
_chmod_
utility shall change any or all of the file mode bits of the file named
by each
_file_
operand in the way specified by the
_mode_
operand.

It is implementation-defined whether and how the
_chmod_
utility affects any alternate or additional file access control
mechanism (see the Base Definitions volume of POSIX.1-2008,
_Section 4.4_, _File Access Permissions_)
being used for the specified file.

Only a process whose effective user ID matches the user ID of the file,
or a process with appropriate privileges, shall be permitted to
change the file mode bits of a file.

Upon successfully changing the file mode bits of a file, the
_chmod_
utility shall mark for update the last file status change timestamp
of the file.

<a name="options"></a>

# Options

The
_chmod_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following option shall be supported:

* **\(miR**  
  Recursively change file mode bits. For each
  _file_
  operand that names a directory,
  _chmod_
  shall change the file mode bits of the directory and all files in the
  file hierarchy below it.

<a name="operands"></a>

# Operands

The following operands shall be supported:

* _mode_  
  Represents the change to be made to the file mode bits of each
  file named by one of the
  _file_
  operands; see the EXTENDED DESCRIPTION section.
* _file_  
  A pathname of a file whose file mode bits shall be modified.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_chmod_:

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

The
_mode_
operand shall be either a
_symbolic_mode_
expression or a non-negative octal integer. The
_symbolic_mode_
form is described by the grammar later in this section.

Each
**clause**
shall specify an operation to be performed on the current file mode
bits of each
_file_.
The operations shall be performed on each
_file_
in the order in which the
**clause**s
are specified.

The
**who**
symbols
**u**,
**g**,
and
**o**
shall specify the
_user_,
_group_,
and
_other_
parts of the file mode bits, respectively. A
**who**
consisting of the symbol
**a**
shall be equivalent to
**ugo**.

The
**perm**
symbols
**r**,
**w**,
and
**x**
represent the
_read_,
_write_,
and
_execute_/\c
_search_
portions of file mode bits, respectively. The
**perm**
symbol
**s**
shall represent the
_set-user-ID-on-execution_
(when
**who**
contains or implies
**u**)
and
_set-group-ID-on-execution_
(when
**who**
contains or implies
**g**)
bits.

The
**perm**
symbol
**X**
shall represent the execute/search portion of the file mode bits if the
file is a directory or if the current (unmodified) file mode bits have
at least one of the execute bits (S_IXUSR, S_IXGRP, or S_IXOTH) set. It
shall be ignored if the file is not a directory and none of the execute
bits are set in the current file mode bits.

The
**permcopy**
symbols
**u**,
**g**,
and
**o**
shall represent the current permissions associated with the user,
group, and other parts of the file mode bits, respectively. For the
remainder of this section,
**perm**
refers to the non-terminals
**perm**
and
**permcopy**
in the grammar.

If multiple
**actionlist**s
are grouped with a single
**wholist**
in the grammar, each
**actionlist**
shall be applied in the order specified with that
**wholist**.
The
_op_
symbols shall represent the operation performed, as follows:

* +  
  If
  **perm**
  is not specified, the
  **'\(pl'**
  operation shall not change the file mode bits.

If
**who**
is not specified, the file mode bits represented by
**perm**
for the owner, group, and other permissions, except for those with
corresponding bits in the file mode creation mask of the invoking
process, shall be set.

Otherwise, the file mode bits represented by the specified
**who**
and
**perm**
values shall be set.

* \(mi  
  If
  **perm**
  is not specified, the
  **'\(mi'**
  operation shall not change the file mode bits.

If
**who**
is not specified, the file mode bits represented by
**perm**
for the owner, group, and other permissions, except for those with
corresponding bits in the file mode creation mask of the invoking
process, shall be cleared.

Otherwise, the file mode bits represented by the specified
**who**
and
**perm**
values shall be cleared.

* =  
  Clear the file mode bits specified by the
  **who**
  value, or, if no
  **who**
  value is specified, all of the file mode bits specified in this volume of POSIX.1-2008.

If
**perm**
is not specified, the
**'='**
operation shall make no further modifications to the file mode bits.

If
**who**
is not specified, the file mode bits represented by
**perm**
for the owner, group, and other permissions, except for those with
corresponding bits in the file mode creation mask of the invoking
process, shall be set.

Otherwise, the file mode bits represented by the specified
**who**
and
**perm**
values shall be set.

When using the symbolic mode form on a regular file, it is
implementation-defined whether or not:

*  *  
  Requests to set the set-user-ID-on-execution or
  set-group-ID-on-execution bit when all execute bits are currently clear
  and none are being set are ignored.
*  *  
  Requests to clear all execute bits also clear the
  set-user-ID-on-execution and set-group-ID-on-execution bits.
*  *  
  Requests to clear the set-user-ID-on-execution or
  set-group-ID-on-execution bits when all execute bits are currently
  clear are ignored. However, if the command
  _ls_
  **\(mil**
  _file_
  writes an
  _s_
  in the position indicating that the set-user-ID-on-execution or
  set-group-ID-on-execution is set, the commands
  _chmod_
  **u\(mis**
  _file_
  or
  _chmod_
  **g\(mis**
  _file_,
  respectively, shall not be ignored.

When using the symbolic mode form on other file types, it is
implementation-defined whether or not requests to set or clear the
set-user-ID-on-execution or set-group-ID-on-execution bits are
honored.

If the
**who**
symbol
**o**
is used in conjunction with the
**perm**
symbol
**s**
with no other
**who**
symbols being specified, the set-user-ID-on-execution and
set-group-ID-on-execution bits shall not be modified. It shall not be
an error to specify the
**who**
symbol
**o**
in conjunction with the
**perm**
symbol
**s**.

The
**perm**
symbol
**t**
shall specify the S_ISVTX bit. When used with a file of type
directory, it can be used with the
**who**
symbol
**a**,
or with no
**who**
symbol. It shall not be an error to specify a
**who**
symbol of
**u**,
**g**,
or
**o**
in conjunction with the
**perm**
symbol
**t**,
but the meaning of these combinations is unspecified. The effect when
using the
**perm**
symbol
**t**
with any file type other than directory is unspecified.

For an octal integer
_mode_
operand, the file mode bits shall be set absolutely.

For each bit set in the octal number, the corresponding file permission
bit shown in the following table shall be set; all other file
permission bits shall be cleared. For regular files, for each bit set
in the octal number corresponding to the set-user-ID-on-execution or
the set-group-ID-on-execution, bits shown in the following table shall
be set; if these bits are not set in the octal number, they are
cleared. For other file types, it is implementation-defined whether
or not requests to set or clear the set-user-ID-on-execution or
set-group-ID-on-execution bits are honored.
.TS
center tab(@) box;
cB cB | cB cB | cB cB | cB cB
nB l | nB l | nB l | nB l.
Octal@Mode Bit@Octal@Mode Bit@Octal@Mode Bit@Octal@Mode Bit
_
4000@S_ISUID@0400@S_IRUSR@0040@S_IRGRP@0004@S_IROTH
_
2000@S_ISGID@0200@S_IWUSR@0020@S_IWGRP@0002@S_IWOTH
_
1000@S_ISVTX@0100@S_IXUSR@0010@S_IXGRP@0001@S_IXOTH
.TE

When bits are set in the octal number other than those listed in the
table above, the behavior is unspecified.

<a name="grammar-for-chmod"></a>

### Grammar for chmod


The grammar and lexical conventions in this section describe the syntax
for the
_symbolic_mode_
operand. The general conventions for this style of grammar are
described in
_Section 1.3_, _Grammar Conventions_.
A valid
_symbolic_mode_
can be represented as the non-terminal symbol
_symbolic_mode_
in the grammar. This formal syntax shall take precedence over the
preceding text syntax description.

The lexical processing is based entirely on single characters.
Implementations need not allow
&lt;blank&gt;
characters within the single argument being processed.

    
    %start    symbolic_mode
    %%
    
    symbolic_mode    : clause
                     | symbolic_mode ',' clause
                     ;
    
    clause           : actionlist
                     | wholist actionlist
                     ;
    
    wholist          : who
                     | wholist who
                     ;
    
    who              : 'u' | 'g' | 'o' | 'a'
                     ;
    
    actionlist       : action
                     | actionlist action
                     ;
    
    action           : op
                     | op permlist
                     | op permcopy
                     ;
    
    permcopy         : 'u' | 'g' | 'o'
                     ;
    
    op               : '+' | '(mi' | '='
                     ;
    
    permlist         : perm
                     | perm permlist
                     ;
    
    perm             : 'r' | 'w' | 'x' | 'X' | 's' | 't'  
                     ;


<a name="exit-status"></a>

# Exit Status

The following exit values shall be returned:

* \00  
  The utility executed successfully and all requested changes were made.
* &gt;0  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

Some implementations of the
_chmod_
utility change the mode of a directory before the files in the
directory when performing a recursive (\c
**\(miR**
option) change; others change the directory mode after the files in the
directory. If an application tries to remove read or search permission
for a file hierarchy, the removal attempt fails if the directory is
changed first; on the other hand, trying to re-enable permissions to a
restricted hierarchy fails if directories are changed last. Users
should not try to make a hierarchy inaccessible to themselves.

Some implementations of
_chmod_
never used the
_umask_
of the process when changing modes; systems conformant with this volume of POSIX.1-2008
do so when
**who**
is not specified. Note the difference between:

    
    chmod a(miw file


which removes all write permissions, and:

    
    chmod (mi|(mi (miw file


which removes write permissions that would be allowed if
**file**
was created with the same
_umask_.

Conforming applications should never assume that they know how the
set-user-ID and set-group-ID bits on directories are interpreted.

<a name="examples"></a>

# Examples

.TS
center tab(@) box;
cB | cB
l | lw(3i).
Mode@Results
_
_a_+=@T{
Equivalent to
_a_+,\c
_a_=;
clears all file mode bits.
T}
_go_+\(miw@T{
Equivalent to
_go_+,\c
_go_\(mi\c
_w_;
clears group and other write bits.
T}
_g_=_o_\(mi_w_@T{
Equivalent to
_g_=\c
_o_,\c
_g_\(mi\c
_w_;
sets group bit to match other bits and then clears group write bit.
T}
_g_\(mi_r_+_w_@T{
Equivalent to
_g_\(mi\c
_r_,\c
_g_+\c
_w_;
clears group read bit and sets group write bit.
T}
_uo_=_g_@T{
Sets owner bits to match group bits and sets other bits to
match group bits.
T}
.TE

<a name="rationale"></a>

# Rationale

The functionality of
_chmod_
is described substantially through references to concepts defined in
the System Interfaces volume of POSIX.1-2008. In this way, there is less duplication of effort required
for describing the interactions of permissions. However, the behavior
of this utility is not described in terms of the
_chmod_()
function from the System Interfaces volume of POSIX.1-2008 because that specification requires certain
side-effects upon alternate file access control mechanisms that might
not be appropriate, depending on the implementation.

Implementations that support mandatory file and record locking as
specified
by the 1984 /usr/group standard historically used the combination of set-group-ID bit set
and group execute bit clear to indicate mandatory locking. This
condition is usually set or cleared with the symbolic mode
**perm**
symbol
**l**
instead of the
**perm**
symbols
**s**
and
**x**
so that the mandatory locking mode is not changed without explicit
indication that that was what the user intended. Therefore, the details
on how the implementation treats these conditions must be defined in
the documentation. This volume of POSIX.1-2008 does not require mandatory locking (nor does
the System Interfaces volume of POSIX.1-2008), but does allow it as an extension. However, this volume of POSIX.1-2008 does
require that the
_ls_
and
_chmod_
utilities work consistently in this area. If
_ls_
**\(mil**
_file_
indicates that the set-group-ID bit is set,
_chmod_
**g\(mis**
_file_
must clear it (assuming appropriate privileges exist to change modes).

The System V and BSD versions use different exit status codes. Some
implementations used the exit status as a count of the number of errors
that occurred; this practice is unworkable since it can overflow the
range of valid exit status values. This problem is avoided here by
specifying only 0 and &gt;0 as exit values.

The System Interfaces volume of POSIX.1-2008 indicates that implementation-defined restrictions may cause
the S_ISUID and S_ISGID bits to be ignored. This volume of POSIX.1-2008 allows the
_chmod_
utility to choose to modify these bits before calling
_chmod_()
(or some function providing equivalent capabilities) for non-regular
files. Among other things, this allows implementations that use the
set-user-ID and set-group-ID bits on directories to enable extended
features to
handle these extensions in an intelligent manner.

The
**X**
**perm**
symbol was adopted from BSD-based systems because it provides commonly
desired functionality when doing recursive (\c
**\(miR**
option) modifications. Similar functionality is not provided by the
_find_
utility. Historical BSD versions of
_chmod_,
however, only supported
**X**
with
_op_+;
it has been extended in this volume of POSIX.1-2008 because it is also useful with
_op_=.
(It has also been added for
_op_\(mi
even though it duplicates
**x**,
in this case, because it is intuitive and easier to explain.)

The grammar was extended with the
_permcopy_
non-terminal to allow historical-practice forms of symbolic modes like
**o**=\c
**u**
**\(mig**
(that is, set the \`\`other'' permissions to the permissions of \`\`owner''
minus the permissions of \`\`group'').

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__ls_\^_,
__umask_\^_

The Base Definitions volume of POSIX.1-2008,
_Section 4.4_, _File Access Permissions_,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_

The System Interfaces volume of POSIX.1-2008,
__chmod_\^(\|)_

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
