# trap(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

trap
— trap signals

<a name="synopsis"></a>

# Synopsis

```


```
    trap n [condition...]
    trap [action condition...]

<a name="description"></a>

# Description

If the first operand is an unsigned decimal integer, the shell shall
treat all operands as conditions, and shall reset each condition to
the default value. Otherwise, if there are operands, the first is
treated as an action and the remaining as conditions.

If
_action_
is
**'\(mi'**,
the shell shall reset each
_condition_
to the default value. If
_action_
is null (\c
**"\^"**),
the shell shall ignore each specified
_condition_
if it arises. Otherwise, the argument
_action_
shall be read and executed by the shell when one of the corresponding
conditions arises. The action of
_trap_
shall override a previous action (either default action or one
explicitly set). The value of
**"$?"**
after the
_trap_
action completes shall be the value it had before
_trap_
was invoked.

The condition can be EXIT, 0 (equivalent to EXIT), or a signal
specified using a symbolic name, without the SIG prefix, as listed in
the tables of signal names in the
_&lt;signal.h&gt;_
header defined in the Base Definitions volume of POSIX.1-2008,
_Chapter 13_, _Headers_;
for example, HUP, INT, QUIT, TERM. Implementations may permit names with
the SIG prefix or ignore case in signal names as an extension. Setting
a trap for SIGKILL or SIGSTOP produces undefined results.

The environment in which the shell executes a
_trap_
on EXIT shall be identical to the environment immediately after the
last command executed before the
_trap_
on EXIT was taken.

Each time
_trap_
is invoked, the
_action_
argument shall be processed in a manner equivalent to:

    
    eval action


Signals that were ignored on entry to a non-interactive shell cannot be
trapped or reset, although no error need be reported when attempting to
do so. An interactive shell may reset or catch signals ignored on
entry. Traps shall remain in place for a given shell until explicitly
changed with another
_trap_
command.

When a subshell is entered, traps that are not being ignored shall be
set to the default actions, except in the case of a command substitution
containing only a single
_trap_
command, when the traps need not be altered. Implementations may check
for this case using only lexical analysis; for example, if
_\`trap\`_
and
_$( trap -- )_
do not alter the traps in the subshell, cases such as assigning
_var=trap_
and then using
_$($var)_
may still alter them. This does not imply that the
_trap_
command cannot be used within the subshell to set new traps.

The
_trap_
command with no operands shall write to standard output a list of commands
associated with each condition. If the command is executed in a subshell,
the implementation does not perform the optional check described above
for a command substitution containing only a single
_trap_
command, and no
_trap_
commands with operands have been executed since entry to the subshell,
the list shall contain the commands that were associated with each
condition immediately before the subshell environment was entered.
Otherwise, the list shall contain the commands currently associated with
each condition. The format shall be:

    
    "trap (mi|(mi %s %s ...en", <action>, <condition> ...


The shell shall format the output, including the proper use of quoting,
so that it is suitable for reinput to the shell as commands that
achieve the same trapping results. For example:

    
    save_traps=$(trap)
    ...
    eval "$save_traps"


XSI-conformant systems also allow numeric signal numbers for the
conditions corresponding to the following signal names:

* 1  
  SIGHUP
* 2  
  SIGINT
* 3  
  SIGQUIT
* 6  
  SIGABRT
* 9  
  SIGKILL
* 14  
  SIGALRM
* 15  
  SIGTERM

The
_trap_
special built-in shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

<a name="options"></a>

# Options

None.

<a name="operands"></a>

# Operands

See the DESCRIPTION.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

None.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

See the DESCRIPTION.

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

If the trap name
or number
is invalid, a non-zero exit status shall be returned; otherwise, zero
shall be returned. For both interactive and non-interactive shells,
invalid signal names
or numbers
shall not be considered a syntax error and do not cause the shell to
abort.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

None.

<a name="examples"></a>

# Examples

Write out a list of all traps and actions:

    
    trap


Set a trap so the
_logout_
utility in the directory referred to by the
_HOME_
environment variable executes when the shell terminates:

    
    trap '"$HOME"/logout' EXIT


or:

    
    trap '"$HOME"/logout' 0


Unset traps on INT, QUIT, TERM, and EXIT:

    
    trap (mi INT QUIT TERM EXIT


<a name="rationale"></a>

# Rationale

Implementations may permit lowercase signal names as an extension.
Implementations may also accept the names with the SIG prefix; no known
historical shell does so. The
_trap_
and
_kill_
utilities in this volume of POSIX.1-2008 are now consistent in their omission of the SIG
prefix for signal names. Some
_kill_
implementations do not allow the prefix, and
_kill_
**\(mil**
lists the signals without prefixes.

Trapping SIGKILL or SIGSTOP is syntactically accepted by some
historical implementations, but it has no effect. Portable POSIX
applications cannot attempt to trap these signals.

The output format is not historical practice. Since the output of
historical
_trap_
commands is not portable (because numeric signal values are not
portable) and had to change to become so, an opportunity was taken to
format the output in a way that a shell script could use to save and
then later reuse a trap if it wanted.

The KornShell uses an
**ERR**
trap that is triggered whenever
_set_
**\(mie**
would cause an exit. This is allowable as an extension, but was not
mandated, as other shells have not used it.

The text about the environment for the EXIT trap invalidates the
behavior of some historical versions of interactive shells which, for
example, close the standard input before executing a trap on 0. For
example, in some historical interactive shell sessions the following
trap on 0 would always print
**"\(mi\|\(mi"**:

    
    trap 'read foo; echo "(mi$foo(mi"' 0


The command:

    
    trap 'eval " $cmd"' 0


causes the contents of the shell variable
_cmd_
to be executed as a command when the shell exits. Using:

    
    trap '$cmd' 0


does not work correctly if
_cmd_
contains any special characters such as quoting or redirections. Using:

    
    trap " $cmd" 0


also works (the leading
&lt;space&gt;
character protects against unlikely cases where
_cmd_
is a decimal integer or begins with
**'\(mi'**),
but it expands the
_cmd_
variable when the
_trap_
command is executed, not when the exit action is executed.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Section 2.14_, _Special Built-In Utilities_

The Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_,
_**&lt;signal.h&gt;**_

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
