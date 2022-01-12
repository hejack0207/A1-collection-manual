# time(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

time
— time a simple command

<a name="synopsis"></a>

# Synopsis

```


```
    time [(mip] utility [argument...]

<a name="description"></a>

# Description

The
_time_
utility shall invoke the utility named by the
_utility_
operand with arguments supplied as the
_argument_
operands and write a message to standard error that lists timing
statistics for the utility. The message shall include the following
information:

*  *  
  The elapsed (real) time between invocation of
  _utility_
  and its termination.
*  *  
  The User CPU time, equivalent to the sum of the
  _tms_utime_
  and
  _tms_cutime_
  fields returned by the
  _times_()
  function defined in the System Interfaces volume of POSIX.1-2008 for the process in which
  _utility_
  is executed.
*  *  
  The System CPU time, equivalent to the sum of the
  _tms_stime_
  and
  _tms_cstime_
  fields returned by the
  _times_()
  function for the process in which
  _utility_
  is executed.

The precision of the timing shall be no less than the granularity
defined for the size of the clock tick unit on the system, but the
results shall be reported in terms of standard time units (for example,
0.02 seconds, 00:00:00.02, 1m33.75s, 365.21 seconds), not numbers of
clock ticks.

When
_time_
is used as part of a pipeline, the times reported are unspecified,
except when it is the sole command within a grouping command (see
_Section 2.9.4.1_, _Grouping Commands_)
in that pipeline. For example, the commands on the left are
unspecified; those on the right report on utilities
**a**
and
**c**,
respectively:

    
    time a | b | c    { time a; } | b | c
    a | b | time c    a | b | (time c)


<a name="options"></a>

# Options

The
_time_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following option shall be supported:

* **\(mip**  
  Write the timing output to standard error in the format shown in the
  STDERR section.

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
_time_:

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
  contents of diagnostic and informative messages written to standard
  error.
* _LC\_NUMERIC_    
  Determine the locale for numeric formatting.
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.
* _PATH_  
  Determine the search path that shall be used to locate the utility to
  be invoked; see the Base Definitions volume of POSIX.1-2008,
  _Chapter 8_, _Environment Variables_.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

Not used.

<a name="stderr"></a>

# Stderr

The standard error shall be used to write the timing statistics. If
**\(mip**
is specified, the following format shall be used in the POSIX locale:

    
    "real %fenuser %fensys %fen", <real seconds>, <user seconds>,
        <system seconds>


where each floating-point number shall be expressed in seconds. The
precision used may be less than the default six digits of
**%f**,
but shall be sufficiently precise to accommodate the size of the clock
tick on the system (for example, if there were 60 clock ticks per
second, at least two digits shall follow the radix character). The
number of digits following the radix character shall be no less than
one, even if this always results in a trailing zero. The implementation
may append white space and additional information following the format
shown here. The implementation may also prepend a single empty line
before the format shown here.

<a name="output-files"></a>

# Output Files

None.

<a name="extended-description"></a>

# Extended Description

None.

<a name="exit-status"></a>

# Exit Status

If the
_utility_
utility is invoked, the exit status of
_time_
shall be the exit status of
_utility_;
otherwise, the
_time_
utility shall exit with one of the following values:

* 1-125  
  An error occurred in the
  _time_
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

It is frequently desirable to apply
_time_
to pipelines or lists of commands. This can be done by placing
pipelines and command lists in a single file; this file can then be
invoked as a utility, and the
_time_
applies to everything in the file.

Alternatively, the following command can be used to apply
_time_
to a complex command:

    
    time sh (mic 'complex-command-line'


<a name="rationale"></a>

# Rationale

When the
_time_
utility was originally proposed to be included in the ISO&nbsp;POSIX-2:\|1993 standard,
questions were raised about its suitability for inclusion on
the grounds that it was not useful for conforming applications,
specifically:

*  *  
  The underlying CPU definitions from the System Interfaces volume of POSIX.1-2008 are
  vague, so the numeric output could not be compared accurately between
  systems or even between invocations.
*  *  
  The creation of portable benchmark programs was outside the scope this volume of POSIX.1-2008.

However,
_time_
does fit in the scope of user portability. Human judgement can be
applied to the analysis of the output, and it could be very useful in
hands-on debugging of applications or in providing subjective measures
of system performance. Hence it has been included in this volume of POSIX.1-2008.

The default output format has been left unspecified because historical
implementations differ greatly in their style of depicting this numeric
output. The
**\(mip**
option was invented to provide scripts with a common means of obtaining
this information.

In the KornShell,
_time_
is a shell reserved word that can be used to time an entire pipeline,
rather than just a simple command. The POSIX definition has been
worded to allow this implementation. Consideration was given to
invalidating this approach because of the historical model from the C
shell and System V shell. However, since the System V
_time_
utility historically has not produced accurate results in pipeline
timing (because the constituent processes are not all owned by the same
parent process, as allowed by POSIX), it did not seem worthwhile to
break historical KornShell usage.

The term
_utility_
is used, rather than
_command_,
to highlight the fact that shell compound commands, pipelines, special
built-ins, and so on, cannot be used directly.
However,
_utility_
includes user application programs and shell scripts, not just the
standard utilities.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Chapter 2_, _Shell Command Language_,
__sh_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_

The System Interfaces volume of POSIX.1-2008,
__times_\^(\|)_

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
