# sched_setscheduler(2)

Linux, 2017-09-15

sched_setscheduler, sched_getscheduler -
set and get scheduling policy/parameters

<a name="synopsis"></a>

# Synopsis

    #include <sched.h>
    
    int sched_setscheduler(pid_t pid, int policy,
                           const struct sched_param *param);
    
    int sched_getscheduler(pid_t pid);

<a name="description"></a>

# Description

The
**sched_setscheduler**()
system call
sets both the scheduling policy and parameters for the
thread whose ID is specified in _pid_.
If _pid_ equals zero, the
scheduling policy and parameters of the calling thread will be set.

The scheduling parameters are specified in the
_param_
argument, which is a pointer to a structure of the following form:

.in +4n
.EX
struct sched_param {
    ...
    int sched_priority;
    ...
};
.EE
.in

In the current implementation, the structure contains only one field,
_sched_priority_.
The interpretation of
_param_
depends on the selected policy.

Currently, Linux supports the following "normal"
(i.e., non-real-time) scheduling policies as values that may be specified in
_policy_:

* **SCHED_OTHER**  
  the standard round-robin time-sharing policy;
  
  
* **SCHED_BATCH**  
  for "batch" style execution of processes; and
* **SCHED_IDLE**  
  for running
  _very_
  low priority background jobs.

For each of the above policies,
_param-&gt;sched_priority_
must be 0.

Various "real-time" policies are also supported,
for special time-critical applications that need precise control over
the way in which runnable threads are selected for execution.
For the rules governing when a process may use these policies, see
**sched**(7).
The real-time policies that may be specified in
_policy_
are:

* **SCHED_FIFO**  
  a first-in, first-out policy; and
* **SCHED_RR**  
  a round-robin policy.

For each of the above policies,
_param-&gt;sched_priority_
specifies a scheduling priority for the thread.
This is a number in the range returned by calling
**sched_get_priority_min**(2)
and
**sched_get_priority_max**(2)
with the specified
_policy_.
On Linux, these system calls return, respectively, 1 and 99.

Since Linux 2.6.32, the
**SCHED_RESET_ON_FORK**
flag can be ORed in
_policy_
when calling
**sched_setscheduler**().
As a result of including this flag, children created by
**fork**(2)
do not inherit privileged scheduling policies.
See
**sched**(7)
for details.

**sched_getscheduler**()
returns the current scheduling policy of the thread
identified by _pid_.
If _pid_ equals zero, the policy of the
calling thread will be retrieved.

<a name="return-value"></a>

# Return Value

On success,
**sched_setscheduler**()
returns zero.
On success,
**sched_getscheduler**()
returns the policy for the thread (a nonnegative integer).
On error, both calls return -1, and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors


* **EINVAL**  
  Invalid arguments:
  _pid_
  is negative or
  _param_
  is NULL.
* **EINVAL**  
  (**sched_setscheduler**())
  _policy_
  is not one of the recognized policies.
* **EINVAL**  
  (**sched_setscheduler**())
  _param_
  does not make sense for the specified
  _policy_.
* **EPERM**  
  The calling thread does not have appropriate privileges.
* **ESRCH**  
  The thread whose ID is _pid_ could not be found.

<a name="conforming-to"></a>

# Conforming to

POSIX.1-2001, POSIX.1-2008 (but see BUGS below).
The **SCHED\_BATCH** and **SCHED\_IDLE** policies are Linux-specific.

<a name="notes"></a>

# Notes

Further details of the semantics of all of the above "normal"
and "real-time" scheduling policies can be found in the
**sched**(7)
manual page.
That page also describes an additional policy,
**SCHED_DEADLINE**,
which is settable only via
**sched_setattr**(2).

POSIX systems on which
**sched_setscheduler**()
and
**sched_getscheduler**()
are available define
**_POSIX_PRIORITY_SCHEDULING**
in _&lt;unistd.h&gt;_.

POSIX.1 does not detail the permissions that an unprivileged
thread requires in order to call
**sched_setscheduler**(),
and details vary across systems.
For example, the Solaris 7 manual page says that
the real or effective user ID of the caller must
match the real user ID or the save set-user-ID of the target.

The scheduling policy and parameters are in fact per-thread
attributes on Linux.
The value returned from a call to
**gettid**(2)
can be passed in the argument
_pid_.
Specifying
_pid_
as 0 will operate on the attributes of the calling thread,
and passing the value returned from a call to
**getpid**(2)
will operate on the attributes of the main thread of the thread group.
(If you are using the POSIX threads API, then use
**pthread_setschedparam**(3),
**pthread_getschedparam**(3),
and
**pthread_setschedprio**(3),
instead of the
**sched_***(2)
system calls.)

<a name="bugs"></a>

# Bugs

POSIX.1 says that on success,
**sched_setscheduler**()
should return the previous scheduling policy.
Linux
**sched_setscheduler**()
does not conform to this requirement,
since it always returns 0 on success.

<a name="see-also"></a>

# See Also

.nh
**chrt**(1),
**nice**(2),
**sched_get_priority_max**(2),
**sched_get_priority_min**(2),
**sched_getaffinity**(2),
**sched_getattr**(2),
**sched_getparam**(2),
**sched_rr_get_interval**(2),
**sched_setaffinity**(2),
**sched_setattr**(2),
**sched_setparam**(2),
**sched_yield**(2),
**setpriority**(2),
**capabilities**(7),
**cpuset**(7),
**sched**(7)

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
