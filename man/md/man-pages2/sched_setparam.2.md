# sched_setparam(2) - set and get scheduling parameters

Linux, 2017-09-15

    #include <sched.h>
    
    int sched_setparam(pid_t pid, const struct sched_param *param);
    
    int sched_getparam(pid_t pid, struct sched_param *param);
    
    struct sched_param {
        ...
        int sched_priority;
        ...
    };

<a name="description"></a>

# Description

**sched_setparam**()
sets the scheduling parameters associated with the scheduling policy
for the process identified by _pid_.
If _pid_ is zero, then
the parameters of the calling process are set.
The interpretation of
the argument _param_ depends on the scheduling
policy of the process identified by
_pid_.
See
**sched**(7)
for a description of the scheduling policies supported under Linux.

**sched_getparam**()
retrieves the scheduling parameters for the
process identified by _pid_.
If _pid_ is zero, then the parameters
of the calling process are retrieved.

**sched_setparam**()
checks the validity of _param_ for the scheduling policy of the
thread.
The value _param-&gt;sched\_priority_ must lie within the
range given by
**sched_get_priority_min**(2)
and
**sched_get_priority_max**(2).

For a discussion of the privileges and resource limits related to
scheduling priority and policy, see
**sched**(7).

POSIX systems on which
**sched_setparam**()
and
**sched_getparam**()
are available define
**_POSIX_PRIORITY_SCHEDULING**
in _&lt;unistd.h&gt;_.

<a name="return-value"></a>

# Return Value

On success,
**sched_setparam**()
and
**sched_getparam**()
return 0.
On error, -1 is returned, and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors


* **EINVAL**  
  Invalid arguments:
  _param_
  is NULL or
  _pid_
  is negative
* **EINVAL**  
  (**sched_setparam**())
  The argument _param_ does not make sense for the current
  scheduling policy.
* **EPERM**  
  (**sched_setparam**())
  The calling process does not have appropriate privileges
  (Linux: does not have the
  **CAP_SYS_NICE**
  capability).
* **ESRCH**  
  The process whose ID is _pid_ could not be found.

<a name="conforming-to"></a>

# Conforming to

POSIX.1-2001, POSIX.1-2008.

<a name="notes"></a>

# Notes


Scheduling parameters are in fact per-thread
attributes on Linux;
see
**sched**(7).

<a name="see-also"></a>

# See Also

.nh
**getpriority**(2),
**nice**(2),
**sched_get_priority_max**(2),
**sched_get_priority_min**(2),
**sched_getaffinity**(2),
**sched_getscheduler**(2),
**sched_setaffinity**(2),
**sched_setattr**(2),
**sched_setscheduler**(2),
**setpriority**(2),
**capabilities**(7),
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
