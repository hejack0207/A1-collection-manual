# unalias(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

unalias
— remove alias definitions

<a name="synopsis"></a>

# Synopsis

```


```
    unalias alias-name...
    
    unalias (mia

<a name="description"></a>

# Description

The
_unalias_
utility shall remove the definition for each alias name specified. See
_Section 2.3.1_, _Alias Substitution_.
The aliases shall be removed from the current shell execution
environment; see
_Section 2.12_, _Shell Execution Environment_.

<a name="options"></a>

# Options

The
_unalias_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following option shall be supported:

* **\(mia**  
  Remove all alias definitions from the current shell execution
  environment.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _alias-name_  
  The name of an alias to be removed.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_unalias_:

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
  Successful completion.
* &gt;0  
  One of the
  _alias-name_
  operands specified did not represent a valid alias definition, or an
  error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

Since
_unalias_
affects the current shell execution environment, it is generally
provided as a shell regular built-in.

<a name="examples"></a>

# Examples

None.

<a name="rationale"></a>

# Rationale

The
_unalias_
description is based on that from historical KornShell implementations.
Known differences exist between that and the C shell. The KornShell
version was adopted to be consistent with all the other KornShell
features in this volume of POSIX.1-2008, such as command line editing.

The
**\(mia**
option is the equivalent of the
_unalias_
* form of the C shell and is provided to address security concerns
about unknown aliases entering the environment of a user (or
application) through the allowable implementation-defined predefined
alias route or as a result of an
_ENV_
file. (Although
_unalias_
could be used to simplify the \`\`secure'' shell script shown in the
_command_
rationale, it does not obviate the need to quote all command names. An
initial call to
_unalias_
**\(mia**
would have to be quoted in case there was an alias for
_unalias_.)

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Chapter 2_, _Shell Command Language_,
__alias_\^_

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
