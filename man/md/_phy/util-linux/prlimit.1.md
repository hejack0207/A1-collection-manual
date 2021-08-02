# prlimit(1) - get and set process resource limits

util-linux, July 2014

```
prlimit [options] [--resource[=limits] [--pid&nbsp;PID]
</synopsis>

<synopsis>
prlimit [options] [--resource[=limits] command [argument...]
```


<a name="description"></a>

# Description

Given a process ID and one or more resources, **prlimit** tries to retrieve
and/or modify the limits.

When _command_ is given,
**prlimit**
will run this command with the given arguments.

The _limits_ parameter is composed of a soft and a hard value, separated
by a colon (:), in order to modify the existing values.  If no _limits_ are
given, **prlimit** will display the current values.  If one of the values
is not given, then the existing one will be used.  To specify the unlimited or
infinity limit (RLIM_INFINITY), the -1 or 'unlimited' string can be passed.

Because of the nature of limits, the soft limit must be lower or equal to the
high limit (also called the ceiling).  To see all available resource limits,
refer to the RESOURCE OPTIONS section.


* _soft_:_hard_    Specify both limits.  
* _soft_:        Specify only the soft limit.  
* :_hard_        Specify only the hard limit.  
* _value_        Specify both limits to the same value.  
  

<a name="general-options"></a>

# General Options


* **-h, --help**  
  Display help text and exit.
* **--noheadings**  
  Do not print a header line.
* **-o, --output list**  
  Define the output columns to use.  If no output arrangement is specified,
  then a default set is used.
  Use **--help** to get a list of all supported columns.
* **-p, --pid**  
  Specify the process id; if none is given, the running process will be used.
* **--raw**  
  Use the raw output format.
* **--verbose**  
  Verbose mode.
* **-V, --version**  
  Display version information and exit.
  

<a name="resource-options"></a>

# Resource Options


* **-c, --core**[=_limits_]  
  Maximum size of a core file.
* **-d, --data**[=_limits_]  
  Maximum data size.
* **-e, --nice**[=_limits_]  
  Maximum nice priority allowed to raise.
* **-f, --fsize**[=_limits_]  
  Maximum file size.
* **-i, --sigpending**[=_limits_]  
  Maximum number of pending signals.
* **-l, --memlock**[=_limits_]  
  Maximum locked-in-memory address space.
* **-m, --rss**[=_limits_]  
  Maximum Resident Set Size (RSS).
* **-n, --nofile**[=_limits_]  
  Maximum number of open files.
* **-q, --msgqueue**[=_limits_]  
  Maximum number of bytes in POSIX message queues.
* **-r, --rtprio**[=_limits_]  
  Maximum real-time priority.
* **-s, --stack**[=_limits_]  
  Maximum size of the stack.
* **-t, --cpu**[=_limits_]  
  CPU time, in seconds.
* **-u, --nproc**[=_limits_]  
  Maximum number of processes.
* **-v, --as**[=_limits_]  
  Address space limit.
* **-x, --locks**[=_limits_]  
  Maximum number of file locks held.
* **-y, --rttime**[=_limits_]  
  Timeout for real-time tasks.
  

<a name="examples"></a>

# Examples


* **prlimit --pid 13134**  
  Display limit values for all current resources.
* **prlimit --pid 13134 --rss --nofile=1024:4095**  
  Display the limits of the RSS, and set the soft and hard limits for the number
  of open files to 1024 and 4095, respectively.
* **prlimit --pid 13134 --nproc=512:**  
  Modify only the soft limit for the number of processes.
* **prlimit --pid $$ --nproc=unlimited**  
  Set for the current process both the soft and ceiling values for the number of
  processes to unlimited.
* **prlimit --cpu=10 sort -u hugefile**  
  Set both the soft and hard CPU time limit to ten seconds and run 'sort'.
  

<a name="see-also"></a>

# See Also

**ulimit**(1),
**prlimit**(2)


<a name="notes"></a>

# Notes

The prlimit system call is supported since Linux 2.6.36, older kernels will
break this program.


<a name="authors"></a>

# Authors

    Davidlohr Bueso <dave@gnu.org> - In memory of Dennis M. Ritchie.

<a name="availability"></a>

# Availability

The prlimit command is part of the util-linux package and is available from
https://www.kernel.org/pub/linux/utils/util-linux/.
