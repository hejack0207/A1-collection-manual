# renice(1) - alter priority of running processes

util-linux, July 2014

```
renice [-n] priority [-g|-p|-u] identifier...
```

<a name="description"></a>

# Description

**renice**
alters the scheduling priority of one or more running processes.  The
first argument is the _priority_ value to be used.
The other arguments are interpreted as process IDs (by default),
process group IDs, user IDs, or user names.
**renice**'ing
a process group causes all processes in the process group to have their
scheduling priority altered.
**renice**'ing
a user causes all processes owned by the user to have their scheduling
priority altered.


<a name="options"></a>

# Options


* **-n**,** --priority **_priority_  
  Specify the scheduling
  _priority_
  to be used for the process, process group, or user.  Use of the option
  **-n** or **--priority**
  is optional, but when used it must be the first argument.
* **-g**,**--pgrp**  
  Interpret the succeeding arguments as process group IDs.
* **-p**,**--pid**  
  Interpret the succeeding arguments as process IDs
  (the default).
* **-u**,**--user**  
  Interpret the succeeding arguments as usernames or UIDs.
* **-V**,** --version**  
  Display version information and exit.
* **-h**,** --help**  
  Display help text and exit.

<a name="examples"></a>

# Examples

The following command would change the priority of the processes with
PIDs 987 and 32, plus all processes owned by the users daemon and root:

* **       renice +1 987 -u daemon root -p 32**  

<a name="notes"></a>

# Notes

Users other than the superuser may only alter the priority of processes they
own.  Furthermore, an unprivileged user can only
_increase_
the \`\`nice value'' (i.e., choose a lower priority)
and such changes are irreversible unless (since Linux 2.6.12)
the user has a suitable \`\`nice'' resource limit (see
**ulimit**(1)
and
**getrlimit**(2)).

The superuser may alter the priority of any process and set the priority to any
value in the range -20 to 19.
Useful priorities are: 19 (the affected processes will run only when nothing
else in the system wants to), 0 (the \`\`base'' scheduling priority), anything
negative (to make things go very fast).

<a name="files"></a>

# Files


* _/etc/passwd_  
  to map user names to user IDs

<a name="see-also"></a>

# See Also

**nice**(1),
**getpriority**(2),
**setpriority**(2),
**credentials**(7),
**sched**(7)

<a name="history"></a>

# History

The
**renice**
command appeared in 4.0BSD.

<a name="availability"></a>

# Availability

The renice command is part of the util-linux package and is available from
[Linux Kernel Archive](https://​www.kernel.org​/pub​/linux​/utils​/util-linux/).
