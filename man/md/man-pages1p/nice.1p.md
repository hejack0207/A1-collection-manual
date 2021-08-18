# nice(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

nice
— invoke a utility with an altered nice value

<a name="synopsis"></a>

# Synopsis

```


```
    nice [(min increment] utility [argument...]

<a name="description"></a>

# Description

The
_nice_
utility shall invoke a utility, requesting that it be run with a
different nice value (see the Base Definitions volume of POSIX.1-2008,
_Section 3.240_, _Nice Value_).
With no options, the executed utility shall be run with a nice value
that is some implementation-defined quantity greater than or equal to
the nice value of the current process. If the user lacks appropriate
privileges to affect the nice value in the requested manner, the
_nice_
utility shall not affect the nice value; in this case, a warning
message may be written to standard error, but this shall not prevent
the invocation of
_utility_
or affect the exit status.

<a name="options"></a>

# Options

The
_nice_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following option is supported:

* **\(min&nbsp;increment**  
  A positive or negative decimal integer which shall have the same
  effect on the execution of the utility as if the utility had
  called the
  _nice_()
  function with the numeric value of the
  _increment_
  option-argument.

<a name="operands"></a>

# Operands

The following operands shall be supported:

* _utility_  
  The name of a utility that is to be invoked. If the
  _utility_
  operand names any of the special built-in utilities in
  _Section 2.14_, _Special Built-In Utilities_,
  the results are undefined.
* _argument_  
  Any string to be supplied as an argument when invoking the utility
  named by the
  _utility_
  operand.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_nice_:

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
  Determine the search path used to locate the utility to be invoked.
  See the Base Definitions volume of POSIX.1-2008,
  _Chapter 8_, _Environment Variables_.

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

If
_utility_
is invoked, the exit status of
_nice_
shall be the exit status of
_utility_;
otherwise, the
_nice_
utility shall exit with one of the following values:

* 1-125  
  An error occurred in the
  _nice_
  utility.
* \0\0126  
  The utility specified by
  _utility_
  was found but could not be invoked.
* \0\0127  
  The utility specified by
  _utility_
  could not be found.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

The only guaranteed portable uses of this utility are:

* _nice&nbsp;utility_    
  Run
  _utility_
  with the default higher or equal nice value.
* _nice&nbsp;**\(min&nbsp;**&lt;positive&nbsp;integer_&gt;_&nbsp;utility_    
  Run
  _utility_
  with a higher nice value.

On some implementations they have no discernible effect on the invoked
utility and on some others they are exactly equivalent.

Historical systems have frequently supported the &lt;positive
integer&gt; up to 20. Since there is no error penalty associated with
guessing a number that is too high, users without access to the system
conformance document (to see what limits are actually in place) could
use the historical 1 to 20 range or attempt to use very large numbers
if the job should be truly low priority.

The nice value of a process can be displayed using the command:

    
    ps (mio nice


The
_command_,
_env_,
_nice_,
_nohup_,
_time_,
and
_xargs_
utilities have been specified to use exit code 127 if an error occurs
so that applications can distinguish \`\`failure to find a utility'' from
\`\`invoked utility exited with an error indication''. The value 127 was
chosen because it is not commonly used for other meanings; most
utilities use small values for \`\`normal error conditions'' and the
values above 128 can be confused with termination due to receipt of a
signal. The value 126 was chosen in a similar manner to indicate that
the utility could be found, but not invoked. Some scripts produce
meaningful error messages differentiating the 126 and 127 cases. The
distinction between exit codes 126 and 127 is based on KornShell
practice that uses 127 when all attempts to
_exec_
the utility fail with
**[ENOENT]**,
and uses 126 when any attempt to
_exec_
the utility fails for any other reason.

<a name="examples"></a>

# Examples

None.

<a name="rationale"></a>

# Rationale

The 4.3 BSD version of
_nice_
does not check whether
_increment_
is a valid decimal integer. The command
_nice_
**\(mix**
_utility_,
for example, would be treated the same as the command
_nice_
**\(mi\|\(mi1**
_utility_.
If the user does not have appropriate privileges, this results in a
\`\`permission denied'' error.
This is considered a bug.

When a user without appropriate privileges gives a negative
_increment_,
System V treats it like the command
_nice_
**\(mi0**
_utility_,
while 4.3 BSD writes a \`\`permission denied'' message and does not run
the utility. The standard specifies the System V behavior together
with an optional BSD-style \`\`permission denied'' message.

The C shell has a built-in version of
_nice_
that has a different interface from the one described in this volume of POSIX.1-2008.

The term \`\`utility'' is used, rather than \`\`command'', to highlight the
fact that shell compound commands, pipelines, and so on, cannot be
used. Special built-ins also cannot be used.
However, \`\`utility'' includes user application programs and shell
scripts, not just utilities defined in this volume of POSIX.1-2008.

Historical implementations of
_nice_
provide a nice value range of 40 or 41 discrete steps, with the default
nice value being the midpoint of that range. By default, they raise the
nice value of the executed utility by 10.

Some historical documentation states that the
_increment_
value must be within a fixed range. This is misleading; the valid
_increment_
values on any invocation are determined by the current process
nice value, which is not always the default.

The definition of nice value is not intended to suggest that all
processes in a system have priorities that are comparable. Scheduling
policy extensions such as the realtime priorities in the System Interfaces volume of POSIX.1-2008 make the
notion of a single underlying priority for all scheduling policies
problematic. Some implementations may implement the
_nice_-related
features to affect all processes on the system, others to affect just
the general time-sharing activities implied by this volume of POSIX.1-2008, and others may
have no effect at all. Because of the use of
\`\`implementation-defined'' in
_nice_
and
_renice_,
a wide range of implementation strategies are possible.

Earlier versions of this standard allowed a
**\(mi**\c
_increment_
option. This form is no longer specified by POSIX.1-2008 but may
be present in some implementations.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Chapter 2_, _Shell Command Language_,
__renice_\^_

The Base Definitions volume of POSIX.1-2008,
_Section 3.240_, _Nice Value_,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_

The System Interfaces volume of POSIX.1-2008,
__nice_\^(\|)_

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
