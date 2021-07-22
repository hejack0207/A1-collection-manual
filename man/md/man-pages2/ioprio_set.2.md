# ioprio_set(2) - get/set I/O scheduling class and priority

Linux, 2017-09-15

    int ioprio_get(int which, int who);
    int ioprio_set(int which, int who, int ioprio);
```

 Note: There are no glibc wrappers for these system calls; see NOTES.
```

<a name="description"></a>

# Description

The
**ioprio_get**()
and
**ioprio_set**()
system calls respectively get and set the I/O scheduling class and
priority of one or more threads.

The
_which_
and
_who_
arguments identify the thread(s) on which the system
calls operate.
The
_which_
argument determines how
_who_
is interpreted, and has one of the following values:

* **IOPRIO_WHO_PROCESS**  
  _who_
  is a process ID or thread ID identifying a single process or thread.
  If
  _who_
  is 0, then operate on the calling thread.
* **IOPRIO_WHO_PGRP**  
  _who_
  is a process group ID identifying all the members of a process group.
  If
  _who_
  is 0, then operate on the process group of which the caller is a member.
* **IOPRIO_WHO_USER**  
  _who_
  is a user ID identifying all of the processes that
  have a matching real UID.
  
  

If
_which_
is specified as
**IOPRIO_WHO_PGRP**
or
**IOPRIO_WHO_USER**
when calling
**ioprio_get**(),
and more than one process matches
_who_,
then the returned priority will be the highest one found among
all of the matching processes.
One priority is said to be
higher than another one if it belongs to a higher priority
class
(**IOPRIO_CLASS_RT**
is the highest priority class;
**IOPRIO_CLASS_IDLE**
is the lowest)
or if it belongs to the same priority class as the other process but
has a higher priority level (a lower priority number means a
higher priority level).

The
_ioprio_
argument given to
**ioprio_set**()
is a bit mask that specifies both the scheduling class and the
priority to be assigned to the target process(es).
The following macros are used for assembling and dissecting
_ioprio_
values:

* **IOPRIO_PRIO_VALUE(**_class_**, **_data_**)**  
  Given a scheduling
  _class_
  and priority
  (_data_),
  this macro combines the two values to produce an
  _ioprio_
  value, which is returned as the result of the macro.
* **IOPRIO_PRIO_CLASS(**_mask_**)**  
  Given
  _mask_
  (an
  _ioprio_
  value), this macro returns its I/O class component, that is,
  one of the values
  **IOPRIO_CLASS_RT**,
  **IOPRIO_CLASS_BE**,
  or
  **IOPRIO_CLASS_IDLE**.
* **IOPRIO_PRIO_DATA(**_mask_**)**  
  Given
  _mask_
  (an
  _ioprio_
  value), this macro returns its priority
  (_data_)
  component.

See the NOTES section for more
information on scheduling classes and priorities,
as well as the meaning of specifying
_ioprio_
as 0.

I/O priorities are supported for reads and for synchronous
(**O_DIRECT**,
**O_SYNC**)
writes.
I/O priorities are not supported for asynchronous
writes because they are issued outside the context of the program
dirtying the memory, and thus program-specific priorities do not apply.

<a name="return-value"></a>

# Return Value

On success,
**ioprio_get**()
returns the
_ioprio_
value of the process with highest I/O priority of any of the processes
that match the criteria specified in
_which_
and
_who_.
On error, -1 is returned, and
_errno_
is set to indicate the error.

On success,
**ioprio_set**()
returns 0.
On error, -1 is returned, and
_errno_
is set to indicate the error.

<a name="errors"></a>

# Errors


* **EINVAL**  
  Invalid value for
  _which_
  or
  _ioprio_.
  Refer to the NOTES section for available scheduler
  classes and priority levels for
  _ioprio_.
* **EPERM**  
  The calling process does not have the privilege needed to assign this
  _ioprio_
  to the specified process(es).
  See the NOTES section for more information on required
  privileges for
  **ioprio_set**().
* **ESRCH**  
  No process(es) could be found that matched the specification in
  _which_
  and
  _who_.

<a name="versions"></a>

# Versions

These system calls have been available on Linux since
kernel 2.6.13.

<a name="conforming-to"></a>

# Conforming to

These system calls are Linux-specific.

<a name="notes"></a>

# Notes

Glibc does not provide a wrapper for these system calls; call them using
**syscall**(2).

Two or more processes or threads can share an I/O context.
This will be the case when
**clone**(2)
was called with the
**CLONE_IO**
flag.
However, by default, the distinct threads of a process will
**not**
share the same I/O context.
This means that if you want to change the I/O
priority of all threads in a process, you may need to call
**ioprio_set**()
on each of the threads.
The thread ID that you would need for this operation
is the one that is returned by
**gettid**(2)
or
**clone**(2).

These system calls have an effect only when used
in conjunction with an I/O scheduler that supports I/O priorities.
As at kernel 2.6.17 the only such scheduler is the Completely Fair Queuing
(CFQ) I/O scheduler.

If no I/O scheduler has been set for a thread,
then by default the I/O priority will follow the CPU nice value
(**setpriority**(2)).
In Linux kernels before version 2.6.24,
once an I/O priority had been set using
**ioprio_set**(),
there was no way to reset the I/O scheduling behavior to the default.
Since Linux 2.6.24,

specifying
_ioprio_
as 0 can be used to reset to the default I/O scheduling behavior.

<a name="selecting-an-io-scheduler"></a>

### Selecting an I/O scheduler

I/O schedulers are selected on a per-device basis via the special
file
_/sys/block/&lt;device&gt;/queue/scheduler_.

One can view the current I/O scheduler via the
_/sys_
filesystem.
For example, the following command
displays a list of all schedulers currently loaded in the kernel:

.in +4n
.EX
$** cat /sys/block/sda/queue/scheduler**
noop anticipatory deadline [cfq]
.EE
.in

The scheduler surrounded by brackets is the one actually
in use for the device
(_sda_
in the example).
Setting another scheduler is done by writing the name of the
new scheduler to this file.
For example, the following command will set the
scheduler for the
_sda_
device to
_cfq_:

.in +4n
.EX
$** su**
Password:
#** echo cfq &gt; /sys/block/sda/queue/scheduler**
.EE
.in


<a name="the-completely-fair-queuing-cfq-io-scheduler"></a>

### The Completely Fair Queuing (CFQ) I/O scheduler

Since version 3 (also known as CFQ Time Sliced), CFQ implements
I/O nice levels similar to those
of CPU scheduling.
These nice levels are grouped into three scheduling classes,
each one containing one or more priority levels:

* **IOPRIO_CLASS_RT** (1)  
  This is the real-time I/O class.
  This scheduling class is given
  higher priority than any other class:
  processes from this class are
  given first access to the disk every time.
  Thus, this I/O class needs to be used with some
  care: one I/O real-time process can starve the entire system.
  Within the real-time class,
  there are 8 levels of class data (priority) that determine exactly
  how much time this process needs the disk for on each service.
  The highest real-time priority level is 0; the lowest is 7.
  In the future, this might change to be more directly mappable to
  performance, by passing in a desired data rate instead.
* **IOPRIO_CLASS_BE** (2)  
  This is the best-effort scheduling class,
  which is the default for any process
  that hasn't set a specific I/O priority.
  The class data (priority) determines how much
  I/O bandwidth the process will get.
  Best-effort priority levels are analogous to CPU nice values
  (see
  **getpriority**(2)).
  The priority level determines a priority relative
  to other processes in the best-effort scheduling class.
  Priority levels range from 0 (highest) to 7 (lowest).
* **IOPRIO_CLASS_IDLE** (3)  
  This is the idle scheduling class.
  Processes running at this level get I/O
  time only when no one else needs the disk.
  The idle class has no class data.
  Attention is required when assigning this priority class to a process,
  since it may become starved if higher priority processes are
  constantly accessing the disk.

Refer to the kernel source file
_Documentation/block/ioprio.txt_
for more information on the CFQ I/O Scheduler and an example program.

<a name="required-permissions-to-set-io-priorities"></a>

### Required permissions to set I/O priorities

Permission to change a process's priority is granted or denied based
on two criteria:

* **Process ownership**  
  An unprivileged process may set the I/O priority only for a process
  whose real UID
  matches the real or effective UID of the calling process.
  A process which has the
  **CAP_SYS_NICE**
  capability can change the priority of any process.
* **What is the desired priority**  
  Attempts to set very high priorities
  (**IOPRIO_CLASS_RT**)
  require the
  **CAP_SYS_ADMIN**
  capability.
  Kernel versions up to 2.6.24 also required
  **CAP_SYS_ADMIN**
  to set a very low priority
  (**IOPRIO_CLASS_IDLE**),
  but since Linux 2.6.25, this is no longer required.

A call to
**ioprio_set**()
must follow both rules, or the call will fail with the error
**EPERM**.

<a name="bugs"></a>

# Bugs





Glibc does not yet provide a suitable header file defining
the function prototypes and macros described on this page.
Suitable definitions can be found in
_linux/ioprio.h_.

<a name="see-also"></a>

# See Also

**ionice**(1),
**getpriority**(2),
**open**(2),
**capabilities**(7),
**cgroups**(7)

_Documentation/block/ioprio.txt_
in the Linux kernel source tree

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
