# cd(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

cd
— change the working directory

<a name="synopsis"></a>

# Synopsis

```


```
    cd [(miL|(miP] [directory]
    
    cd (mi

<a name="description"></a>

# Description

The
_cd_
utility shall change the working directory of the current shell
execution environment (see
_Section 2.12_, _Shell Execution Environment_)
by executing the following steps in sequence. (In the following steps,
the symbol
**curpath**
represents an intermediate value used to simplify the description of
the algorithm used by
_cd_.
There is no requirement that
**curpath**
be made visible to the application.)

*  1.  
  If no
  _directory_
  operand is given and the
  _HOME_
  environment variable is empty or undefined, the default behavior is
  implementation-defined and no further steps shall be taken.
*  2.  
  If no
  _directory_
  operand is given and the
  _HOME_
  environment variable is set to a non-empty value, the
  _cd_
  utility shall behave as if the directory named in the
  _HOME_
  environment variable was specified as the
  _directory_
  operand.
*  3.  
  If the
  _directory_
  operand begins with a
  &lt;slash&gt;
  character, set
  **curpath**
  to the operand and proceed to step 7.
*  4.  
  If the first component of the
  _directory_
  operand is dot or dot-dot, proceed to step 6.
*  5.  
  Starting with the first pathname in the
  &lt;colon&gt;-separated
  pathnames of
  _CDPATH_
  (see the ENVIRONMENT VARIABLES section) if the pathname is non-null,
  test if the concatenation of that pathname, a
  &lt;slash&gt;
  character if that pathname did not end with a
  &lt;slash&gt;
  character, and the
  _directory_
  operand names a directory. If the pathname is null, test if the
  concatenation of dot, a
  &lt;slash&gt;
  character, and the operand names a directory. In either case, if the
  resulting string names an existing directory, set
  **curpath**
  to that string and proceed to step 7. Otherwise, repeat this step with
  the next pathname in
  _CDPATH_
  until all pathnames have been tested.
*  6.  
  Set
  **curpath**
  to the
  _directory_
  operand.
*  7.  
  If the
  **\(miP**
  option is in effect, proceed to step 10. If
  **curpath**
  does not begin with a
  &lt;slash&gt;
  character, set
  **curpath**
  to the string formed by the concatenation of the value of
  _PWD_,
  a
  &lt;slash&gt;
  character if the value of
  _PWD_
  did not end with a
  &lt;slash&gt;
  character, and
  **curpath**.
*  8.  
  The
  **curpath**
  value shall then be converted to canonical form as follows, considering
  each component from beginning to end, in sequence:
    *  a.  
      Dot components and any
      &lt;slash&gt;
      characters that separate them from the next component shall be deleted.
    *  b.  
      For each dot-dot component, if there is a preceding component and it is
      neither root nor dot-dot, then:
        *  i.  
          If the preceding component does not refer (in the context of pathname
          resolution with symbolic links followed) to a directory, then the
          _cd_
          utility shall display an appropriate error message and no further steps
          shall be taken.
        * ii.  
          The preceding component, all
          &lt;slash&gt;
          characters separating the preceding component from dot-dot, dot-dot,
          and all
          &lt;slash&gt;
          characters separating dot-dot from the following component (if any)
          shall be deleted.
    *  c.  
      An implementation may further simplify
      **curpath**
      by removing any trailing
      &lt;slash&gt;
      characters that are not also leading
      &lt;slash&gt;
      characters, replacing multiple non-leading consecutive
      &lt;slash&gt;
      characters with a single
      &lt;slash&gt;,
      and replacing three or more leading
      &lt;slash&gt;
      characters with a single
      &lt;slash&gt;.
      If, as a result of this canonicalization, the
      **curpath**
      variable is null, no further steps shall be taken.
*  9.  
  If
  **curpath**
  is longer than
  {PATH_MAX}
  bytes (including the terminating null) and the
  _directory_
  operand was not longer than
  {PATH_MAX}
  bytes (including the terminating null), then
  **curpath**
  shall be converted from an absolute pathname to an equivalent relative
  pathname if possible. This conversion shall always be considered
  possible if the value of
  _PWD_,
  with a trailing
  &lt;slash&gt;
  added if it does not already have one, is an initial substring of
  **curpath**.
  Whether or not it is considered possible under other circumstances is
  unspecified. Implementations may also apply this conversion if
  **curpath**
  is not longer than
  {PATH_MAX}
  bytes or the
  _directory_
  operand was longer than
  {PATH_MAX}
  bytes.
* 10.  
  The
  _cd_
  utility shall then perform actions equivalent to the
  _chdir_()
  function called with
  **curpath**
  as the
  _path_
  argument. If these actions fail for any reason, the
  _cd_
  utility shall display an appropriate error message and the remainder of
  this step shall not be executed. If the
  **\(miP**
  option is not in effect, the
  _PWD_
  environment variable shall be set to the value that
  **curpath**
  had on entry to step 9 (i.e., before conversion to a relative
  pathname). If the
  **\(miP**
  option is in effect, the
  _PWD_
  environment variable shall be set to the string that would be output by
  _pwd_
  **\(miP**.
  If there is insufficient permission on the new directory, or on any
  parent of that directory, to determine the current working directory,
  the value of the
  _PWD_
  environment variable is unspecified.

If, during the execution of the above steps, the
_PWD_
environment variable
is set, the
_OLDPWD_
environment variable shall also be set to
the value of the old working directory (that is the current working
directory immediately prior to the call to
_cd_).

<a name="options"></a>

# Options

The
_cd_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported by the implementation:

* **\(miL**  
  Handle the operand dot-dot logically; symbolic link components shall
  not be resolved before dot-dot components are processed (see steps 8.
  and 9. in the DESCRIPTION).
* **\(miP**  
  Handle the operand dot-dot physically; symbolic link components shall
  be resolved before dot-dot components are processed (see step 7. in the
  DESCRIPTION).

If both
**\(miL**
and
**\(miP**
options are specified, the last of these options shall be used and all
others ignored. If neither
**\(miL**
nor
**\(miP**
is specified, the operand shall be handled dot-dot logically; see the
DESCRIPTION.

<a name="operands"></a>

# Operands

The following operands shall be supported:

* _directory_  
  An absolute or relative pathname of the directory that shall become
  the new working directory. The interpretation of a relative pathname
  by
  _cd_
  depends on the
  **\(miL**
  option and the
  _CDPATH_
  and
  _PWD_
  environment variables. If
  _directory_
  is an empty string, the results are unspecified.
* \(mi  
  When a
  &lt;hyphen&gt;
  is used as the operand, this shall be equivalent to the command:

    
    cd "$OLDPWD" && pwd


which changes to the previous working directory and then writes its
name.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_cd_:

* _CDPATH_  
  A
  &lt;colon&gt;-separated
  list of pathnames that refer to directories. The
  _cd_
  utility shall use this list in its attempt to change the directory, as
  described in the DESCRIPTION. An empty string in place of a directory
  pathname represents the current directory. If
  _CDPATH_
  is not set, it shall be treated as if it were an empty string.
* _HOME_  
  The name of the directory, used when no
  _directory_
  operand is specified.
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
* _OLDPWD_  
  A pathname of the previous working directory, used by
  _cd_
  **\(mi**.
* _PWD_  
  This variable shall be set as specified in the DESCRIPTION. If an
  application sets or unsets the value of
  _PWD_,
  the behavior of
  _cd_
  is unspecified.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

If a non-empty directory name from
_CDPATH_
is used, or if
_cd_
**\(mi**
is used, an absolute pathname of the new working directory shall be
written to the standard output as follows:

    
    "%sen", <new directory>


Otherwise, there shall be no output.

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
  The directory was successfully changed.
* &gt;0  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

The working directory shall remain unchanged.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

Since
_cd_
affects the current shell execution environment, it is always provided
as a shell regular built-in. If it is called in a subshell or separate
utility execution environment, such as one of the following:

    
    (cd /tmp)
    nohup cd
    find . (miexec cd {} e;


it does not affect the working directory of the caller's environment.

The user must have execute (search) permission in
_directory_
in order to change to it.

<a name="examples"></a>

# Examples

The following template can be used to perform processing in the directory
specified by
_location_
and end up in the current working directory in use before the first
_cd_
command was issued:

    
    cd location
    if [ $? -ne 0 ]
    then
        print error message
        exit 1
    fi
    ... do whatever is desired as long as the OLDPWD environment variable
        is not modified
    cd -


<a name="rationale"></a>

# Rationale

The use of the
_CDPATH_
was introduced in the System V shell. Its use is analogous to the use
of the
_PATH_
variable in the shell. The BSD C shell used a shell parameter
_cdpath_
for this purpose.

A common extension when
_HOME_
is undefined is to get the login directory from the user database for
the invoking user. This does not occur on System V implementations.

Some historical shells, such as the KornShell, took special actions
when the directory name contained a dot-dot component, selecting the
logical parent of the directory, rather than the actual parent
directory; that is, it moved up one level toward the
**'/'**
in the pathname, remembering what the user typed, rather than
performing the equivalent of:

    
    chdir("..");


In such a shell, the following commands would not necessarily produce
equivalent output for all directories:

    
    cd .. && ls      ls ..


This behavior is now the default. It is not consistent with the
definition of dot-dot in most historical practice; that is, while this
behavior has been optionally available in the KornShell, other shells
have historically not supported this functionality. The logical
pathname is stored in the
_PWD_
environment variable when the
_cd_
utility completes and this value is used to construct the next
directory name if
_cd_
is invoked with the
**\(miL**
option.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Section 2.12_, _Shell Execution Environment_,
__pwd_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_

The System Interfaces volume of POSIX.1-2008,
__chdir_\^(\|)_

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
