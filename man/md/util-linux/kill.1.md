# kill(1) - terminate a process

util-linux, July 2014

```
kill [-signal|-s signal|-p] [-q value] [-a] [--] pid|name...
kill -l [number] | -L
```

<a name="description"></a>

# Description

The command
**kill**
sends the specified _signal_ to the specified processes or process groups.

If no signal is specified, the TERM signal is sent.
The default action for this signal is to terminate the process.
This signal should be used in preference to the
KILL signal (number 9), since a process may install a handler for the
TERM signal in order to perform clean-up steps before terminating in
an orderly fashion.
If a process does not terminate after a TERM signal has been sent,
then the KILL signal may be used; be aware that the latter signal
cannot be caught, and so does not give the target process the opportunity
to perform any clean-up before terminating.

Most modern shells have a builtin kill command, with a usage rather similar to
that of the command described here.  The
**--all**,
**--pid**, and
**--queue**
options, and the possibility to specify processes by command name, are local extensions.

If _signal_ is 0, then no actual signal is sent, but error checking is still performed.


<a name="arguments"></a>

# Arguments

The list of processes to be signaled can be a mixture of names and PIDs.

* _pid_  
  Each
  _pid_
  can be one of four things:
    * _n_  
      where
      _n_
      is larger than 0.  The process with PID
      _n_
      is signaled.
    * **0**  
      All processes in the current process group are signaled.
    * **-1**  
      All processes with a PID larger than 1 are signaled.
    * **-**_n_  
      where
      _n_
      is larger than 1.  All processes in process group
      _n_
      are signaled.  When an argument of the form '-n' is given, and it is meant to
      denote a process group, either a signal must be specified first, or the
      argument must be preceded by a '--' option, otherwise it will be taken as the
      signal to send.
* _name_  
  All processes invoked using this _name_ will be signaled.
  

<a name="options"></a>

# Options


* **-s**, **--signal** _signal_  
  The signal to send.  It may be given as a name or a number.
* **-l**, **--list** [_number_]  
  Print a list of signal names, or convert the given signal number to a name.
  The signals can be found in
  _/usr/​include/​linux/​signal.h_
* **-L**, **--table**  
  Similar to **-l**, but it will print signal names and their corresponding
  numbers.
* **-a**, **--all**  
  Do not restrict the command-name-to-PID conversion to processes with the same
  UID as the present process.
* **-p**, **--pid**  
  Only print the process ID (PID) of the named processes, do not send any
  signals.
* **--verbose**  
  Print PID(s) that will be signaled with kill along with the signal.
* **-q**, **--queue** _value_  
  Use
  **sigqueue**(3)
  rather than
  **kill**(2).
  The
  _value_
  argument is an integer that is sent along with the signal.  If the
  receiving process has installed a handler for this signal using the
  **SA_SIGINFO**
  flag to
  **sigaction**(2),
  then it can obtain this data via the
  _si_sigval_
  field of the
  _siginfo_t_
  structure.
  

<a name="notes"></a>

# Notes

Although it is possible to specify the TID (thread ID, see
**gettid**(2))
of one of the threads in a multithreaded process as the argument of
**kill**,
the signal is nevertheless directed to the process
(i.e., the entire thread group).
In other words, it is not possible to send a signal to an
explicitly selected thread in a multithreaded process.
The signal will be delivered to an arbitrarily selected thread
in the target process that is not blocking the signal.
For more details, see
**signal**(7)
and the description of
**CLONE_THREAD**
in
**clone**(2).


<a name="return-codes"></a>

# Return Codes

**kill**
has the following return codes:

* **0**  
  success
* **1**  
  failure
* **64**  
  partial success (when more than one process specified)
  

<a name="see-also"></a>

# See Also

**bash**(1),
**tcsh**(1),
**sigaction**(2),
**kill**(2),
**sigqueue**(3),
**signal**(7)


<a name="authors"></a>

# Authors

.MT [svalente@mit.edu](mailto:svalente@mit.edu)
Salvatore Valente
.ME  
.MT [kzak@redhat.com](mailto:kzak@redhat.com)
Karel Zak
.ME  

The original version was taken from BSD 4.4.


<a name="availability"></a>

# Availability

The kill command is part of the util-linux package and is available from
[Linux Kernel Archive](https://​www.kernel.org​/pub​/linux​/utils​/util-linux/).
