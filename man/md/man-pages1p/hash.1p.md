# hash(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

hash
— remember or report utility locations

<a name="synopsis"></a>

# Synopsis

```


```
    hash [utility...]
    
    hash (mir

<a name="description"></a>

# Description

The
_hash_
utility shall affect the way the current shell environment remembers
the locations of utilities found as described in
_Section 2.9.1.1_, _Command Search and Execution_.
Depending on the arguments specified, it shall add utility locations to
its list of remembered locations or it shall purge the contents of the
list. When no arguments are specified, it shall report on the contents
of the list.

Utilities provided as built-ins to the shell shall not be reported by
_hash_.

<a name="options"></a>

# Options

The
_hash_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following option shall be supported:

* **\(mir**  
  Forget all previously remembered utility locations.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _utility_  
  The name of a utility to be searched for and added to the list of
  remembered locations. If
  _utility_
  contains one or more
  &lt;slash&gt;
  characters, the results are unspecified.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_hash_:

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
* _PATH_  
  Determine the location of
  _utility_,
  as described in the Base Definitions volume of POSIX.1-2008,
  _Chapter 8_, _Environment Variables_.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

The standard output of
_hash_
shall be used when no arguments are specified. Its format is
unspecified, but includes the pathname of each utility in the list of
remembered locations for the current shell environment. This list
shall consist of those utilities named in previous
_hash_
invocations that have been invoked, and may contain those invoked and
found through the normal command search process.

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

Since
_hash_
affects the current shell execution environment, it is always provided
as a shell regular built-in. If it is called in a separate utility
execution environment, such as one of the following:

    
    nohup hash (mir
    find . (mitype f | xargs hash


it does not affect the command search process of the caller's
environment.

The
_hash_
utility may be implemented as an alias—for example,
_alias_
**\(mit&nbsp;\(mi**,
in which case utilities found through normal command search are not
listed by the
_hash_
command.

The effects of
_hash_
**\(mir**
can also be achieved portably by resetting the value of
_PATH_;
in the simplest form, this can be:

    
    PATH="$PATH"


The use of
_hash_
with
_utility_
names is unnecessary for most applications, but may provide a
performance improvement on a few implementations; normally, the hashing
process is included by default.

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

_Section 2.9.1.1_, _Command Search and Execution_

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
