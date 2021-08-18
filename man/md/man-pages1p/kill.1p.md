# kill(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

kill
— terminate or signal processes

<a name="synopsis"></a>

# Synopsis

```


```
    kill (mis signal_name pid...
    
    kill (mil [exit_status]
    
    kill [(misignal_name] pid...
    
    kill [(misignal_number] pid...

<a name="description"></a>

# Description

The
_kill_
utility shall send a signal to the process or processes specified by
each
_pid_
operand.

For each
_pid_
operand, the
_kill_
utility shall perform actions equivalent to the
_kill_()
function defined in the System Interfaces volume of POSIX.1-2008 called with the following arguments:

*  *  
  The value of the
  _pid_
  operand shall be used as the
  _pid_
  argument.
*  *  
  The
  _sig_
  argument is the value specified by the
  **\(mis**
  option,
  **\(mi**\c
  _signal_number_
  option, or the
  **\(mi**\c
  _signal_name_
  option, or by SIGTERM, if none of these options is specified.

<a name="options"></a>

# Options

The
_kill_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_,
except that in the last two SYNOPSIS forms, the
**\(mi**\c
_signal_number_
and
**\(mi**\c
_signal_name_
options are usually more than a single character.

The following options shall be supported:

* **\(mil**  
  (The letter ell.) Write all values of
  _signal_name_
  supported by the implementation, if no operand is given. If an
  _exit_status_
  operand is given and it is a value of the
  **'?'**
  shell special parameter (see
  _Section 2.5.2_, _Special Parameters_
  and
  _wait_)
  corresponding to a process that was terminated by a signal, the
  _signal_name_
  corresponding to the signal that terminated the process shall be
  written. If an
  _exit_status_
  operand is given and it is the unsigned decimal integer value of a
  signal number, the
  _signal_name_
  (the symbolic constant name without the
  **SIG**
  prefix defined in the Base Definitions volume of POSIX.1-2008) corresponding to that signal shall be
  written. Otherwise, the results are unspecified.
* **\(mis&nbsp;signal\_name**    
  Specify the signal to send, using one of the symbolic names defined in
  the
  _&lt;signal.h&gt;_
  header. Values of
  _signal_name_
  shall be recognized in a case-independent fashion, without the
  **SIG**
  prefix. In addition, the symbolic name 0 shall be recognized,
  representing the signal value zero. The corresponding signal shall be
  sent instead of SIGTERM.
* **\(misignal\_name**    
  Equivalent to
  **\(mis**
  _signal_name_.
* **\(misignal\_number**    
  Specify a non-negative decimal integer,
  _signal_number_,
  representing the signal to be used instead of SIGTERM, as the
  _sig_
  argument in the effective call to
  _kill_().
  The correspondence between integer values and the
  _sig_
  value used is shown in the following list.

The effects of specifying any
_signal_number_
other than those listed below are undefined.

* 0  
  0
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

If the first argument is a negative integer, it shall be interpreted as a
**\(mi**\c
_signal_number_
option, not as a negative
_pid_
operand specifying a process group.

<a name="operands"></a>

# Operands

The following operands shall be supported:

* _pid_  
  One of the following:
    *  1.  
      A decimal integer specifying a process or process group to be signaled.
      The process or processes selected by positive, negative, and zero
      values of the
      _pid_
      operand shall be as described for the
      _kill_()
      function. If process number 0 is specified, all processes in the
      current process group shall be signaled. For the effects of negative
      _pid_
      numbers, see the
      _kill_()
      function defined in the System Interfaces volume of POSIX.1-2008. If the first
      _pid_
      operand is negative, it should be preceded by
      **"\(mi\|\(mi"**
      to keep it from being interpreted as an option.
    *  2.  
      A job control job ID (see the Base Definitions volume of POSIX.1-2008,
      _Section 3.204_, _Job Control Job ID_)
      that identifies a background process group to be signaled. The job
      control job ID notation is applicable only for invocations of
      _kill_
      in the current shell execution environment; see
      _Section 2.12_, _Shell Execution Environment_.
* _exit\_status_  
  A decimal integer specifying a signal number or the exit status of a
  process terminated by a signal.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_kill_:

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

When the
**\(mil**
option is not specified, the standard output shall not be used.

When the
**\(mil**
option is specified, the symbolic name of each signal shall be written
in the following format:

    
    "%s%c", <signal_name>, <separator>


where the &lt;_signal\_name_&gt; is in uppercase, without the
**SIG**
prefix, and the &lt;_separator_&gt; shall be either a
&lt;newline&gt;
or a
&lt;space&gt;.
For the last signal written, &lt;_separator_&gt; shall be a
&lt;newline&gt;.

When both the
**\(mil**
option and
_exit_status_
operand are specified, the symbolic name of the corresponding signal
shall be written in the following format:

    
    "%sen", <signal_name>


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
  At least one matching process was found for each
  _pid_
  operand, and the specified signal was successfully processed for at
  least one matching process.
* &gt;0  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

Process numbers can be found by using
_ps_.

The job control job ID notation is not required to work as expected
when
_kill_
is operating in its own utility execution environment. In either of
the following examples:

    
    nohup kill %1 &
    system("kill %1");


the
_kill_
operates in a different environment and does not share the shell's
understanding of job numbers.

<a name="examples"></a>

# Examples

Any of the commands:

    
    kill (mi9 100 (mi165
    kill (mis kill 100 (mi165
    kill (mis KILL 100 (mi165


sends the SIGKILL signal to the process whose process ID is 100 and to
all processes whose process group ID is 165, assuming the sending
process has permission to send that signal to the specified processes,
and that they exist.

The System Interfaces volume of POSIX.1-2008 and this volume of POSIX.1-2008 do not require specific signal numbers for any
_signal_names_.
Even the
**\(mi**\c
_signal_number_
option provides symbolic (although numeric) names for signals. If a
process is terminated by a signal, its exit status indicates the signal
that killed it, but the exact values are not specified. The
_kill_
**\(mil**
option, however, can be used to map decimal signal numbers and exit
status values into the name of a signal. The following example reports
the status of a terminated job:

    
    job
    stat=$?
    if [ $stat (mieq 0 ]
    then
        echo job completed successfully.
    elif [ $stat (migt 128 ]
    then
        echo job terminated by signal SIG$(kill (mil $stat).
    else
        echo job terminated with error code $stat.
    fi


To send the default signal to a process group (say 123), an application
should use a command similar to one of the following:

    
    kill (miTERM (mi123
    kill (mi|(mi (mi123


<a name="rationale"></a>

# Rationale

The
**\(mil**
option originated from the C shell, and is also implemented in the
KornShell. The C shell output can consist of multiple output lines
because the signal names do not always fit on a single line on some
terminal screens. The KornShell output also included the
implementation-defined signal numbers and was considered by the
standard developers to be too difficult for scripts to parse
conveniently. The specified output format is intended not only to
accommodate the historical C shell output, but also to permit an
entirely vertical or entirely horizontal listing on systems for which
this is appropriate.

An early proposal invented the name SIGNULL as a
_signal_name_
for signal 0 (used by the System Interfaces volume of POSIX.1-2008 to test for the existence of a process
without sending it a signal). Since the
_signal_name_
0 can be used in this case unambiguously, SIGNULL has been removed.

An early proposal also required symbolic
_signal_name_s
to be recognized with or without the
**SIG**
prefix. Historical versions of
_kill_
have not written the
**SIG**
prefix for the
**\(mil**
option and have not recognized the
**SIG**
prefix on
_signal_name_s.
Since neither applications portability nor ease-of-use would be improved
by requiring this extension, it is no longer required.

To avoid an ambiguity of an initial negative number argument specifying
either a signal number or a process group, POSIX.1-2008 mandates that it is
always considered the former by implementations that support the XSI
option. It also requires that conforming applications always use the
**"\(mi\|\(mi"**
options terminator argument when specifying a process group, unless an
option is also specified.

The
**\(mis**
option was added in response to international interest in providing
some form of
_kill_
that meets the Utility Syntax Guidelines.

The job control job ID notation is not required to work as expected
when
_kill_
is operating in its own utility execution environment. In either of
the following examples:

    
    nohup kill %1 &
    system("kill %1");


the
_kill_
operates in a different environment and does not understand how the
shell has managed its job numbers.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Chapter 2_, _Shell Command Language_,
__ps_\^_,
__wait_\^_

The Base Definitions volume of POSIX.1-2008,
_Section 3.204_, _Job Control Job ID_,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_,
_**&lt;signal.h&gt;**_

The System Interfaces volume of POSIX.1-2008,
__kill_\^(\|)_

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
