# alias(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

alias
— define or display aliases

<a name="synopsis"></a>

# Synopsis

```


```
    alias [alias-name[=string]...]

<a name="description"></a>

# Description

The
_alias_
utility shall create or redefine alias definitions or write the values
of existing alias definitions to standard output. An alias definition
provides a string value that shall replace a command name when it is
encountered; see
_Section 2.3.1_, _Alias Substitution_.

An alias definition shall affect the current shell execution
environment and the execution environments of the subshells of the
current shell. When used as specified by this volume of POSIX.1-2008, the alias definition
shall not affect the parent process of the current shell nor any
utility environment invoked by the shell; see
_Section 2.12_, _Shell Execution Environment_.

<a name="options"></a>

# Options

None.

<a name="operands"></a>

# Operands

The following operands shall be supported:

* _alias-name_  
  Write the alias definition to standard output.
* _alias-name_=_string_    
  Assign the value of
  _string_
  to the alias
  _alias-name_.

If no operands are given, all alias definitions shall be written to
standard output.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_alias_:

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

The format for displaying aliases (when no operands or only
_name_
operands are specified) shall be:

    
    "%s=%sen", name, value


The
_value_
string shall be written with appropriate quoting so that it is suitable
for reinput to the shell. See the description of shell quoting in
_Section 2.2_, _Quoting_.

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
  _name_
  operands specified did not have an alias definition, or an error
  occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

None.

<a name="examples"></a>

# Examples


*  1.  
  Create a short alias for a commonly used
  _ls_
  command:

    
    alias lf="ls (miCF"


*  2.  
  Create a simple \`\`redo'' command to repeat previous entries in the
  command history file:

    
    alias r='fc (mis'


*  3.  
  Use 1K units for
  _du_:

    
    alias du=due (mik


*  4.  
  Set up
  _nohup_
  so that it can deal with an argument that is itself an alias name:

    
    alias nohup="nohup "


<a name="rationale"></a>

# Rationale

The
_alias_
description is based on historical KornShell implementations. Known
differences exist between that and the C shell. The KornShell version
was adopted to be consistent with all the other KornShell features in
this volume of POSIX.1-2008, such as command line editing.

Since
_alias_
affects the current shell execution environment, it is generally
provided as a shell regular built-in.

Historical versions of the KornShell have allowed aliases to be
exported to scripts that are invoked by the same shell. This is
triggered by the
_alias_
**\(mix**
flag; it is allowed by this volume of POSIX.1-2008 only when an explicit extension such as
**\(mix**
is used. The standard developers considered that aliases were of use
primarily to interactive users and that they should normally not affect
shell scripts called by those users; functions are available to such
scripts.

Historical versions of the KornShell had not written aliases in a
quoted manner suitable for reentry to the shell, but this volume of POSIX.1-2008 has made
this a requirement for all similar output. Therefore, consistency was
chosen over this detail of historical practice.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Section 2.9.5_, _Function Definition Command_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_

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
