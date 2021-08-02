# chrt(1) - manipulate the real-time attributes of a process

util-linux, January 2016

```
chrt [options] priority&nbsp;command&nbsp;[argument...]
chrt [options] -p [priority]&nbsp;pid
```

<a name="description"></a>

# Description


**chrt**
sets or retrieves the real-time scheduling attributes of an existing _pid_,
or runs _command_ with the given attributes.


<a name="policies"></a>

# Policies


* **-o**, **--other**  
  Set scheduling policy to
  **SCHED_OTHER**.
  This is the default Linux scheduling policy.
* **-f**, **--fifo**  
  Set scheduling policy to **SCHED\_FIFO**.
* **-r**, **--rr**  
  Set scheduling policy to
  **SCHED_RR**.
  When no policy is defined, the
  **SCHED_RR**
  is used as the default.
* **-b**, **--batch**  
  Set scheduling policy to
  **SCHED_BATCH**
  (Linux-specific, supported since 2.6.16).  The priority argument has to be set to zero.
* **-i**, **--idle**  
  Set scheduling policy to
  **SCHED_IDLE**
  (Linux-specific, supported since 2.6.23).  The priority argument has to be set to zero.
* **-d**,&nbsp;**--deadline**  
  Set scheduling policy to
  **SCHED_DEADLINE**
  (Linux-specific, supported since 3.14).  The priority argument has to be set to zero.
  See also **--sched-runtime**, **--sched-deadline** and
  **--sched-period**.  The relation between the options required by the kernel is
  runtime &lt;= deadline &lt;= period.
  **chrt**
  copies _period_ to _deadline_ if **--sched-deadline** is not specified and
  _deadline_ to _runtime_ if **--sched-runtime** is not specified.
  It means that at least **--sched-period** has to be specified.  See
  **sched**(7)
  for more details.
  

<a name="scheduling-options"></a>

# Scheduling Options


* **-T**, **--sched-runtime** _nanoseconds_  
  Specifies runtime parameter for SCHED_DEADLINE policy (Linux-specific).
* **-P**, **--sched-period** _nanoseconds_  
  Specifies period parameter for SCHED_DEADLINE policy (Linux-specific).
* **-D**, **--sched-deadline** _nanoseconds_  
  Specifies deadline parameter for SCHED_DEADLINE policy (Linux-specific).
* **-R**, **--reset-on-fork**  
  Add
  **SCHED_RESET_ON_FORK**
  flag to the
  **SCHED_FIFO**
  or
  **SCHED_RR**
  scheduling policy (Linux-specific, supported since 2.6.31).
  

<a name="options"></a>

# Options


* **-a**,&nbsp;**--all-tasks**  
  Set or retrieve the scheduling attributes of all the tasks (threads) for a
  given PID.
* **-m**,&nbsp;**--max**  
  Show minimum and maximum valid priorities, then exit.
* **-p**,&nbsp;**--pid**  
  Operate on an existing PID and do not launch a new task.
* **-v**,&nbsp;**--verbose**  
  Show status information.
* **-V**,&nbsp;**--version**  
  Display version information and exit.
* **-h**,&nbsp;**--help**  
  Display help text and exit.

<a name="usage"></a>

# Usage


* The default behavior is to run a new command:  
  **chrt**
  _priority_
  _command&nbsp;_[_arguments_]
* You can also retrieve the real-time attributes of an existing task:  
  **chrt -p**
  _pid_
* Or set them:  
  **chrt -r -p**
  _priority pid_

<a name="permissions"></a>

# Permissions

A user must possess
**CAP_SYS_NICE**
to change the scheduling attributes of a process.  Any user can retrieve the
scheduling information.


<a name="notes"></a>

# Notes

Only
**SCHED_FIFO**,
**SCHED_OTHER**
and
**SCHED_RR**
are part of POSIX 1003.1b Process Scheduling.  The other scheduling attributes
may be ignored on some systems.

Linux' default scheduling policy is
**SCHED_OTHER**.

<a name="see-also"></a>

# See Also

**nice**(1),
**renice**(1),
**taskset**(1),
**sched**(7)

See
**sched_setscheduler**(2)
for a description of the Linux scheduling scheme.

<a name="authors"></a>

# Authors

.UR [rml@tech9.net](mailto:rml@tech9.net)
Robert Love
.UE  
.UR [kzak@redhat.com](mailto:kzak@redhat.com)
Karel Zak
.UE

<a name="availability"></a>

# Availability

The chrt command is part of the util-linux package and is available from
https://www.kernel.org/pub/linux/utils/util-linux/.
