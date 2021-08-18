# command(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

command
— execute a simple command

<a name="synopsis"></a>

# Synopsis

```


```
    command [(mip] command_name [argument...]
    
    command [(mip][(miv|(miV] command_name

<a name="description"></a>

# Description

The
_command_
utility shall cause the shell to treat the arguments as a simple
command, suppressing the shell function lookup that is described in
_Section 2.9.1.1_, _Command Search and Execution_,
item 1b.

If the
_command_name_
is the same as the name of one of the special built-in utilities, the
special properties in the enumerated list at the beginning of
_Section 2.14_, _Special Built-In Utilities_
shall not occur. In every other respect, if
_command_name_
is not the name of a function, the effect of
_command_
(with no options) shall be the same as omitting
_command_.

When the
**\(miv**
or
**\(miV**
option is used, the
_command_
utility shall provide information concerning how a command name
is interpreted by the shell.

<a name="options"></a>

# Options

The
_command_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(mip**  
  Perform the command search using a default value for
  _PATH_
  that is guaranteed to find all of the standard utilities.
* **\(miv**  
  Write a string to standard output that indicates the pathname or command
  that will be used by the shell, in the current shell execution environment
  (see
  _Section 2.12_, _Shell Execution Environment_),
  to invoke
  _command_name_,
  but do not invoke
  _command_name_.
    *  *  
      Utilities, regular built-in utilities,
      _command_name_s
      including a
      &lt;slash&gt;
      character, and any implementation-defined functions that are found
      using the
      _PATH_
      variable (as described in
      _Section 2.9.1.1_, _Command Search and Execution_),
      shall be written as absolute pathnames.
    *  *  
      Shell functions, special built-in utilities, regular built-in utilities
      not associated with a
      _PATH_
      search, and shell reserved words shall be written as just their names.
    *  *  
      An alias shall be written as a command line that represents its alias
      definition.
    *  *  
      Otherwise, no output shall be written and the exit status shall reflect
      that the name was not found.
* **\(miV**  
  Write a string to standard output that indicates how the name given in the
  _command_name_
  operand will be interpreted by the shell, in the current shell
  execution environment (see
  _Section 2.12_, _Shell Execution Environment_),
  but do not invoke
  _command_name_.
  Although the format of this string is unspecified, it shall indicate in
  which of the following categories
  _command_name_
  falls and shall include the information stated:
    *  *  
      Utilities, regular built-in utilities, and any implementation-defined
      functions that are found using the
      _PATH_
      variable (as described in
      _Section 2.9.1.1_, _Command Search and Execution_),
      shall be identified as such and include the absolute pathname in the
      string.
    *  *  
      Other shell functions shall be identified as functions.
    *  *  
      Aliases shall be identified as aliases and their definitions
      included in the string.
    *  *  
      Special built-in utilities shall be identified as special built-in
      utilities.
    *  *  
      Regular built-in utilities not associated with a
      _PATH_
      search shall be identified as regular built-in utilities. (The term
      \`\`regular'' need not be used.)
    *  *  
      Shell reserved words shall be identified as reserved words.

<a name="operands"></a>

# Operands

The following operands shall be supported:

* _argument_  
  One of the strings treated as an argument to
  _command_name_.
* _command\_name_    
  The name of a utility or a special built-in utility.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_command_:

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
  contents of diagnostic messages written to standard error and
  informative messages written to standard output.
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.
* _PATH_  
  Determine the search path used during the command search described in
  _Section 2.9.1.1_, _Command Search and Execution_,
  except as described under the
  **\(mip**
  option.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

When the
**\(miv**
option is specified, standard output shall be formatted as:

    
    "%sen", <pathname or command>


When the
**\(miV**
option is specified, standard output shall be formatted as:

    
    "%sen", <unspecified>


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

When the
**\(miv**
or
**\(miV**
options are specified, the following exit values shall be returned:

* \00  
  Successful completion.
* &gt;0  
  The
  _command_name_
  could not be found or an error occurred.

Otherwise, the following exit values shall be returned:

* 126  
  The utility specified by
  _command_name_
  was found but could not be invoked.
* 127  
  An error occurred in the
  _command_
  utility or the utility specified by
  _command_name_
  could not be found.

Otherwise, the exit status of
_command_
shall be that of the simple command specified by the arguments to
_command_.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

The order for command search allows functions to override regular
built-ins and path searches. This utility is necessary to allow
functions that have the same name as a utility to call the utility
(instead of a recursive call to the function).

The system default path is available using
_getconf_;
however, since
_getconf_
may need to have the
_PATH_
set up before it can be called itself, the following can be used:

    
    command (mip getconf PATH


There are some advantages to suppressing the special characteristics of
special built-ins on occasion. For example:

    
    command exec > unwritable-file


does not cause a non-interactive script to abort, so that the output
status can be checked by the script.

The
_command_,
_env_,
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

Since the
**\(miv**
and
**\(miV**
options of
_command_
produce output in relation to the current shell execution environment,
_command_
is generally provided as a shell regular built-in. If it is called in a
subshell or separate utility execution environment, such as one of the
following:

    
    (PATH=foo command (miv)
     nohup command (miv


it does not necessarily produce correct results. For example, when
called with
_nohup_
or an
_exec_
function, in a separate utility execution environment, most
implementations are not able to identify aliases, functions, or special
built-ins.

Two types of regular built-ins could be encountered on a system and
these are described separately by
_command_.
The description of command search in
_Section 2.9.1.1_, _Command Search and Execution_
allows for a standard utility to be implemented as a regular built-in
as long as it is found in the appropriate place in a
_PATH_
search. So, for example,
_command_
**\(miv**
_true_
might yield
**/bin/true**
or some similar pathname. Other implementation-defined utilities that
are not defined by this volume of POSIX.1-2008 might exist only as built-ins and have no
pathname associated with them. These produce output identified as
(regular) built-ins. Applications encountering these are not able to
count on
_exec_ing
them, using them with
_nohup_,
overriding them with a different
_PATH_,
and so on.

<a name="examples"></a>

# Examples


*  1.  
  Make a version of
  _cd_
  that always prints out the new working directory exactly once:

    
    cd() {
        command cd "$@" >/dev/null
        pwd
    }


*  2.  
  Start off a \`\`secure shell script'' in which the script avoids
  being spoofed by its parent:

    
    IFS='
    '
    #    The preceding value should be <space><tab><newline>.
    #    Set IFS to its default value.
    
    eunalias (mia
    #    Unset all possible aliases.
    #    Note that unalias is escaped to prevent an alias
    #    being used for unalias.
    
    unset (mif command
    #    Ensure command is not a user function.
    
    PATH="$(command (mip getconf PATH):$PATH"
    #    Put on a reliable PATH prefix.
    
    #    ...


At this point, given correct permissions on the directories called by
_PATH_,
the script has the ability to ensure that any utility it calls is the
intended one. It is being very cautious because it assumes that
implementation extensions may be present that would allow user
functions to exist when it is invoked; this capability is not specified
by this volume of POSIX.1-2008, but it is not prohibited as an extension. For example, the
_ENV_
variable precedes the invocation of the script with a user start-up
script. Such a script could define functions to spoof the application.

<a name="rationale"></a>

# Rationale

Since
_command_
is a regular built-in utility it is always found prior to the
_PATH_
search.

There is nothing in the description of
_command_
that implies the command line is parsed any differently from that of
any other simple command. For example:

    
    command a | b ; c


is not parsed in any special way that causes
**'|'**
or
**';'**
to be treated other than a pipe operator or
&lt;semicolon&gt;
or that prevents function lookup on
**b**
or
**c**.

The
_command_
utility is somewhat similar to the Eighth Edition shell
_builtin_
command, but since
_command_
also goes to the file system to search for utilities, the name
_builtin_
would not be intuitive.

The
_command_
utility is most likely to be provided as a regular built-in. It is not
listed as a special built-in
for the following reasons:

*  *  
  The removal of exportable functions made the special precedence of a
  special built-in unnecessary.
*  *  
  A special built-in has special properties (see
  _Section 2.14_, _Special Built-In Utilities_)
  that were inappropriate for invoking other utilities. For example, two
  commands such as:

    
    date > unwritable-file
    
    command date > unwritable-file


would have entirely different results; in a non-interactive script, the
former would continue to execute the next command, the latter would
abort. Introducing this semantic difference along with suppressing
functions was seen to be non-intuitive.

The
**\(mip**
option is present because it is useful to be able to ensure a safe path
search that finds all the standard utilities. This search might not be
identical to the one that occurs through one of the
_exec_
functions (as defined in the System Interfaces volume of POSIX.1-2008) when
_PATH_
is unset. At the very least, this feature is required to allow the
script to access the correct version of
_getconf_
so that the value of the default path can be accurately retrieved.

The
_command_
**\(miv**
and
**\(miV**
options were added to satisfy requirements from users that are
currently accomplished by three different historical utilities:
_type_
in the System V shell,
_whence_
in the KornShell, and
_which_
in the C shell. Since there is no historical agreement on how and what
to accomplish here, the POSIX
_command_
utility was enhanced and the historical utilities were left unmodified.
The C shell
_which_
merely conducts a path search. The KornShell
_whence_
is more elaborate—in addition to the categories required by POSIX,
it also reports on tracked aliases, exported aliases, and undefined
functions.

The output format of
**\(miV**
was left mostly unspecified because human users are its only audience.
Applications should not be written to care about this information; they
can use the output of
**\(miv**
to differentiate between various types of commands, but the additional
information that may be emitted by the more verbose
**\(miV**
is not needed and should not be arbitrarily constrained in its
verbosity or localization for application parsing reasons.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Section 2.9.1.1_, _Command Search and Execution_,
_Section 2.12_, _Shell Execution Environment_,
_Section 2.14_, _Special Built-In Utilities_,
__sh_\^_,
__type_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_

The System Interfaces volume of POSIX.1-2008,
__exec_\^_

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
