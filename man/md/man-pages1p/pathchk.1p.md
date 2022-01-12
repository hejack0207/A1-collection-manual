# pathchk(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

pathchk
— check pathnames

<a name="synopsis"></a>

# Synopsis

```


```
    pathchk [(mip] [(miP] pathname...

<a name="description"></a>

# Description

The
_pathchk_
utility shall check that one or more pathnames are valid (that is, they
could be used to access or create a file without causing syntax errors)
and portable (that is, no filename truncation results). More
extensive portability checks are provided by the
**\(mip**
and
**\(miP**
options.

By default, the
_pathchk_
utility shall check each component of each
_pathname_
operand based on the underlying file system. A diagnostic shall be
written for each
_pathname_
operand that:

*  *  
  Is longer than
  {PATH_MAX}
  bytes (see
  **Pathname Variable Values**
  in the Base Definitions volume of POSIX.1-2008,
  _**&lt;limits.h&gt;**_)
*  *  
  Contains any component longer than
  {NAME_MAX}
  bytes in its containing directory
*  *  
  Contains any component in a directory that is not searchable
*  *  
  Contains any byte sequence that is not valid in its
  containing directory

The format of the diagnostic message is not specified, but shall
indicate the error detected and the corresponding
_pathname_
operand.

It shall not be considered an error if one or more components of a
_pathname_
operand do not exist as long as a file matching the pathname specified
by the missing components could be created that does not violate any of
the checks specified above.

<a name="options"></a>

# Options

The
_pathchk_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following option shall be supported:

* **\(mip**  
  Instead of performing checks based on the underlying file system, write
  a diagnostic for each
  _pathname_
  operand that:
    *  *  
      Is longer than
      {_POSIX_PATH_MAX}
      bytes (see
      **Minimum Values**
      in the Base Definitions volume of POSIX.1-2008,
      _**&lt;limits.h&gt;**_)
    *  *  
      Contains any component longer than
      {_POSIX_NAME_MAX}
      bytes
    *  *  
      Contains any character in any component that is not in the portable
      filename character set
* **\(miP**  
  Write a diagnostic for each
  _pathname_
  operand that:
    *  *  
      Contains a component whose first character is the
      &lt;hyphen&gt;
      character
    *  *  
      Is empty

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _pathname_  
  A pathname to be checked.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_pathchk_:

* _LANG_  
  Provide a default value for the internationalization variables that are
  unset or null. (See the Base Definitions volume of POSIX.1-2008,
  _Section 8.2_, _Internationalization Variables_
  the precedence of internationalization variables used to determine the
  values of locale categories.)
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
  All
  _pathname_
  operands passed all of the checks.
* &gt;0  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

The
_test_
utility can be used to determine whether a given pathname names an
existing file; it does not, however, give any indication of whether or
not any component of the pathname was truncated in a directory where
the _POSIX_NO_TRUNC feature is not in effect. The
_pathchk_
utility does not check for file existence; it performs checks to
determine whether a pathname does exist or could be created with no
pathname component truncation.

The
_noclobber_
option in the shell (see the
__set_\^_
special built-in) can be used to atomically create a file. As with all
file creation semantics in the System Interfaces volume of POSIX.1-2008, it guarantees atomic creation,
but still depends on applications to agree on conventions and cooperate
on the use of files after they have been created.

To verify that a pathname meets the requirements of filename
portability, applications should use both the
**\(mip**
and
**\(miP**
options together.

<a name="examples"></a>

# Examples

To verify that all pathnames in an imported data interchange archive
are legitimate and unambiguous on the current system:

    
    # This example assumes that no pathnames in the archive
    # contain <newline> characters.
    pax (mif archive | sed (mie 's/[^[:alnum:]]/ee&/g' | xargs pathchk (mi|(mi
    if [ $? (mieq 0 ]
    then
        pax (mir (mif archive
    else
        echo Investigate problems before importing files.
        exit 1
    fi


To verify that all files in the current directory hierarchy could be
moved to any system conforming to the System Interfaces volume of POSIX.1-2008 that also supports the
_pax_
utility:

    
    find . (miexec pathchk (mip (miP {} +
    if [ $? (mieq 0 ]
    then
        pax (miw (mif ../archive .
    else
        echo Portable archive cannot be created.
        exit 1
    fi


To verify that a user-supplied pathname names a readable file and that
the application can create a file extending the given path without
truncation and without overwriting any existing file:

    
    case $(mi in
        *C*)    reset="";;
        *)      reset="set +C"
                set (miC;;
    esac
    test (mir "$path" && pathchk "$path.out" &&
        rm "$path.out" > "$path.out"
    if [ $? (mine 0 ]; then
        printf "%s: %s not found or %s.out fails e
    creation checks.en" $0 "$path$path"
        $reset    # Reset the noclobber option in case a trap
                  # on EXIT depends on it.
        exit 1
    fi
    $reset
    PROCESSING < "$path" > "$path.out"


The following assumptions are made in this example:

*  1.  
  **PROCESSING**
  represents the code that is used by the application to use
  **$path**
  once it is verified that
  **$path.out**
  works as intended.
*  2.  
  The state of the
  _noclobber_
  option is unknown when this code is invoked and should be set on exit
  to the state it was in when this code was invoked. (The
  **reset**
  variable is used in this example to restore the initial state.)
*  3.  
  Note the usage of:

    
    rm "$path.out" > "$path.out"


*  a.  
  The
  _pathchk_
  command has already verified, at this point, that
  **$path.out**
  is not truncated.
*  b.  
  With the
  _noclobber_
  option set, the shell verifies that
  **$path.out**
  does not already exist before invoking
  _rm_.
*  c.  
  If the shell succeeded in creating
  **$path.out**,
  _rm_
  removes it so that the application can create the file again in the
  **PROCESSING**
  step.
*  d.  
  If the
  **PROCESSING**
  step wants the file to exist already when it is invoked, the:

    
    rm "$path.out" > "$path.out"


should be replaced with:

    
    > "$path.out"


which verifies that the file did not already exist, but leaves
**$path.out**
in place for use by
**PROCESSING**.

<a name="rationale"></a>

# Rationale

The
_pathchk_
utility was new for the ISO&nbsp;POSIX-2:\|1993 standard. It, along with the
_set_
**\(miC**(\c
_noclobber_)
option added to the shell, replaces the
_mktemp_,
_validfnam_,
and
_create_
utilities that appeared in early proposals. All of these utilities were
attempts to solve several common problems:

*  *  
  Verify the validity (for several different definitions of \`\`valid'') of
  a pathname supplied by a user, generated by an application, or imported
  from an external source.
*  *  
  Atomically create a file.
*  *  
  Perform various string handling functions to generate a temporary
  filename.

The
_create_
utility, included in an early proposal, provided checking and atomic
creation in a single invocation of the utility; these are orthogonal
issues and need not be grouped into a single utility. Note that the
_noclobber_
option also provides a way of creating a lock for process
synchronization; since it provides an atomic
_create_,
there is no race between a test for existence and the following
creation if it did not exist.

Having a function like
_tmpnam_()
in the ISO&nbsp;C standard is important in many high-level languages. The shell
programming language, however, has built-in string manipulation
facilities, making it very easy to construct temporary filenames. The
names needed obviously depend on the application, but are frequently of
a form similar to:

    
    $TMPDIR/application_abbreviation$$.suffix


In cases where there is likely to be contention for a given suffix, a
simple shell
**for**
or
**while**
loop can be used with the shell
_noclobber_
option to create a file without risk of collisions, as long as
applications trying to use the same filename name space are cooperating
on the use of files after they have been created.

For historical purposes,
**\(mip**
does not check for the use of the
&lt;hyphen&gt;
character as the first character in a component of the pathname, or for
an empty
_pathname_
operand.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Section 2.7_, _Redirection_,
__set_\^_,
__test_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_,
_**&lt;limits.h&gt;**_

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
