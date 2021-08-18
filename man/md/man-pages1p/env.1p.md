# env(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

env
— set the environment for command invocation

<a name="synopsis"></a>

# Synopsis

```


```
    env [(mii] [name=value]... [utility [argument...]]

<a name="description"></a>

# Description

The
_env_
utility shall obtain the current environment, modify it according to
its arguments, then invoke the utility named by the
_utility_
operand with the modified environment.

Optional arguments shall be passed to
_utility_.

If no
_utility_
operand is specified, the resulting environment shall be written to the
standard output, with one
_name_=\c
_value_
pair per line.

If the first argument is
**'\(mi'**,
the results are unspecified.

<a name="options"></a>

# Options

The
_env_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_,
except for the unspecified usage of
**'\(mi'**.

The following options shall be supported:

* **\(mii**  
  Invoke
  _utility_
  with exactly the environment specified by the arguments; the inherited
  environment shall be ignored completely.

<a name="operands"></a>

# Operands

The following operands shall be supported:

* _name_=_value_  
  Arguments of the form
  _name_=\c
  _value_
  shall modify the execution environment, and shall be placed into the
  inherited environment before the
  _utility_
  is invoked.
* _utility_  
  The name of the utility to be invoked. If the
  _utility_
  operand names any of the special built-in utilities in
  _Section 2.14_, _Special Built-In Utilities_,
  the results are undefined.
* _argument_  
  A string to pass as an argument for the invoked utility.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_env_:

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
  Determine the location of the
  _utility_,
  as described in the Base Definitions volume of POSIX.1-2008,
  _Chapter 8_, _Environment Variables_.
  If
  _PATH_
  is specified as a
  _name_=\c
  _value_
  operand to
  _env_,
  the
  _value_
  given shall be used in the search for
  _utility_.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

If no
_utility_
operand is specified, each
_name_=\c
_value_
pair in the resulting environment shall be written in the form:

    
    "%s=%sen", <name>, <value>


If the
_utility_
operand is specified, the
_env_
utility shall not write to standard output.

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
_env_
shall be the exit status of
_utility_;
otherwise, the
_env_
utility shall exit with one of the following values:

* \0\0\0\00  
  The
  _env_
  utility completed successfully.
* 1\(mi125  
  An error occurred in the
  _env_
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

Historical implementations of the
_env_
utility use the
_execvp_()
or
_execlp_()
functions defined in the System Interfaces volume of POSIX.1-2008 to invoke the specified utility; this
provides better performance and keeps users from having to escape
characters with special meaning to the shell. Therefore, shell
functions, special built-ins, and built-ins that are only provided by
the shell are not found.

<a name="examples"></a>

# Examples

The following command:

    
    env (mii PATH=/mybin:"$PATH" $(getconf V7_ENV) mygrep xyz myfile


invokes the command
_mygrep_
with a new
_PATH_
value as the only entry in its environment other than any variables
required by the implementation for conformance. In this case,
_PATH_
is used to locate
_mygrep_,
which is expected to reside in
**/mybin**.

<a name="rationale"></a>

# Rationale

As with all other utilities that invoke other utilities, this volume of POSIX.1-2008 only
specifies what
_env_
does with standard input, standard output, standard error, input files,
and output files. If a utility is executed, it is not constrained by
the specification of input and output by
_env_.

The
**\(mii**
option was added to allow the functionality of the removed
**\(mi**
option in a manner compatible with the Utility Syntax Guidelines. It
is possible to create a non-conforming environment using the
**\(mii**
option, as it may remove environment variables required by the
implementation for conformance. The following will preserve these
environment variables as well as preserve the
_PATH_
for conforming utilities:

    
    IFS='
    '
    # The preceding value should be <space><tab><newline>.
    # Set IFS to its default value.
    
    set (mif
    # disable pathname expansion
    
    eunalias (mia
    # Unset all possible aliases.
    # Note that unalias is escaped to prevent an alias
    # being used for unalias.
    # This step is not strictly necessary, since aliases are not inherited,
    # and the ENV environment variable is only used by interactive shells,
    # the only way any aliases can exist in a script is if it defines them
    # itself.
    
    unset (mif env getconf
    # Ensure env and getconf are not user functions.
    
    env (mii $(getconf V7_ENV) PATH="$(getconf PATH)" command


Some have suggested that
_env_
is redundant since the same effect is achieved by:

    
    name=value ... utility [ argument ... ]


The example is equivalent to
_env_
when an environment variable is being added to the environment of the
command, but not when the environment is being set to the given value.
The
_env_
utility also writes out the current environment if invoked without
arguments. There is sufficient functionality beyond what the example
provides to justify inclusion of
_env_.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Section 2.14_, _Special Built-In Utilities_,
_Section 2.5_, _Parameters and Variables_

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
