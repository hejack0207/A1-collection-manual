# s390_runtime_instr(2) - enable/disable s390 CPU run-time instrumentation

Linux Programmer's Manual, 2017-09-15

    #include <asm/runtime_instr.h>
    
    int s390_runtime_instr(int command, int signum);

<a name="description"></a>

# Description

The
**s390_runtime_instr**()
system call starts or stops CPU run-time instrumentation for the
calling thread.

The
_command_
argument controls whether run-time instrumentation is started
(**S390_RUNTIME_INSTR_START**,
1) or stopped
(**S390_RUNTIME_INSTR_STOP**,
2) for the calling thread.

The
_signum_
argument specifies the number of a real-time signal.
The real-time signal is sent to the thread if the run-time instrumentation
buffer is full or if the run-time-instrumentation-halted interrupt
occurred.

<a name="return-value"></a>

# Return Value

On success,
**s390_runtime_instr**()
returns 0 and enables the thread for
run-time instrumentation by assigning the thread a default run-time
instrumentation control block.
The caller can then read and modify the control block and start the run-time
instrumentation.
On error, -1 is returned and
_errno_
is set to one of the error codes listed below.

<a name="errors"></a>

# Errors


* **EINVAL**  
  The value specified in
  _command_
  is not a valid command or the value specified in
  _signum_
  is not a real-time signal number.
* **ENOMEM**  
  Allocating memory for the run-time instrumentation control block failed.
* **EOPNOTSUPP**  
  The run-time instrumentation facility is not available.

<a name="versions"></a>

# Versions

This system call is available since Linux 3.7.

<a name="conforming-to"></a>

# Conforming to

This Linux-specific system call is available only on the s390 architecture.
The run-time instrumentation facility is available beginning with System z EC12.

<a name="notes"></a>

# Notes

Glibc does not provide a wrapper for this system call, use
**syscall**(2)
to call it.

<a name="see-also"></a>

# See Also

**syscall**(2),
**signal**(7)

<a name="colophon"></a>

# Colophon

This page is part of release 4.16 of the Linux
_man-pages_
project.
A description of the project,
information about reporting bugs,
and the latest version of this page,
can be found at
https://www.kernel.org/doc/man-pages/.
