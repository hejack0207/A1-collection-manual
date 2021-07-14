# taskset(1) - set or retrieve a process's CPU affinity

util-linux, August 2014

```
taskset [options] mask&nbsp;command&nbsp;[argument...]
taskset [options] -p [mask]&nbsp;pid
```

<a name="description"></a>

# Description


**taskset**
is used to set or retrieve the CPU affinity of a running process given its
_pid_, or to launch a new _command_ with a given CPU affinity.
CPU affinity is a
scheduler property that "bonds" a process to a given set of CPUs on the system.
The Linux scheduler will honor the given CPU affinity and the process will not
run on any other CPUs.  Note that the Linux scheduler also supports natural
CPU affinity: the scheduler attempts to keep processes on the same CPU as long
as practical for performance reasons.  Therefore, forcing a specific CPU
affinity is useful only in certain applications.

The CPU affinity is represented as a bitmask, with the lowest order bit
corresponding to the first logical CPU and the highest order bit corresponding
to the last logical CPU.  Not all CPUs may exist on a given system but a mask
may specify more CPUs than are present.  A retrieved mask will reflect only the
bits that correspond to CPUs physically on the system.  If an invalid mask is
given (i.e., one that corresponds to no valid CPUs on the current system) an
error is returned.  The masks may be specified in hexadecimal (with or without
a leading "0x"), or as a CPU list with the
**--cpu-list**
option.  For example,

* **0x00000001**  
  is processor #0,
* **0x00000003**  
  is processors #0 and #1,
* **0xFFFFFFFF**  
  is processors #0 through #31,
* **32**  
  is processors #1, #4, and #5,
* **--cpu-list&nbsp;0-2,6**  
  is processors #0, #1, #2, and #6.

When
**taskset**
returns, it is guaranteed that the given program has been scheduled to a legal
CPU.

<a name="options"></a>

# Options


* **-a**,&nbsp;**--all-tasks**  
  Set or retrieve the CPU affinity of all the tasks (threads) for a given PID.
* **-c**,&nbsp;**--cpu-list**  
  Interpret _mask_ as numerical list of processors instead of a bitmask.
  Numbers are separated by commas and may include ranges.  For example:
  **0,5,8-11**.
* **-p**,&nbsp;**--pid**  
  Operate on an existing PID and do not launch a new task.
* **-V**,&nbsp;**--version**  
  Display version information and exit.
* **-h**,&nbsp;**--help**  
  Display help text and exit.

<a name="usage"></a>

# Usage


* The default behavior is to run a new command with a given affinity mask:  
  **taskset**
  _mask_
  _command&nbsp;_[_arguments_]
* You can also retrieve the CPU affinity of an existing task:  
  **taskset -p**
  _pid_
* Or set it:  
  **taskset -p**
  _mask pid_

<a name="permissions"></a>

# Permissions

A user can change the CPU affinity of a process belonging to the same user.
A user must possess
**CAP_SYS_NICE**
to change the CPU affinity of a process belonging to another user.
A user can retrieve the affinity mask of any process.

<a name="see-also"></a>

# See Also

**chrt**(1),
**nice**(1),
**renice**(1),
**sched_getaffinity**(2),
**sched_setaffinity**(2)

See
**sched**(7)
for a description of the Linux scheduling scheme.

<a name="author"></a>

# Author

Written by Robert M. Love.

<a name="copyright"></a>

# Copyright

Copyright © 2004 Robert M. Love.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

<a name="availability"></a>

# Availability

The taskset command is part of the util-linux package and is available from
https://www.kernel.org/pub/linux/utils/util-linux/.
