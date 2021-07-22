# getcpu(2) - determine CPU and NUMA node on which the calling thread is running

Linux, 2017-09-15

    #include <linux/getcpu.h>
    
    int getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *tcache);
```

 Note: There is no glibc wrapper for this system call; see NOTES.
```

<a name="description"></a>

# Description

The
**getcpu**()
system call identifies the processor and node on which the calling
thread or process is currently running and writes them into the
integers pointed to by the
_cpu_
and
_node_
arguments.
The processor is a unique small integer identifying a CPU.
The node is a unique small identifier identifying a NUMA node.
When either
_cpu_
or
_node_
is NULL nothing is written to the respective pointer.

The third argument to this system call is nowadays unused,
and should be specified as NULL
unless portability to Linux 2.6.23 or earlier is required (see NOTES).

The information placed in
_cpu_
is guaranteed to be current only at the time of the call:
unless the CPU affinity has been fixed using
**sched_setaffinity**(2),
the kernel might change the CPU at any time.
(Normally this does not happen
because the scheduler tries to minimize movements between CPUs to
keep caches hot, but it is possible.)
The caller must allow for the possibility that the information returned in
_cpu_
and
_node_
is no longer current by the time the call returns.

<a name="return-value"></a>

# Return Value

On success, 0 is returned.
On error, -1 is returned, and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors


* **EFAULT**  
  Arguments point outside the calling process's address space.

<a name="versions"></a>

# Versions

**getcpu**()
was added in kernel 2.6.19 for x86-64 and i386.

<a name="conforming-to"></a>

# Conforming to

**getcpu**()
is Linux-specific.

<a name="notes"></a>

# Notes

Linux makes a best effort to make this call as fast as possible.
(On some architectures, this is done via an implementation in the
**vdso**(7).)
The intention of
**getcpu**()
is to allow programs to make optimizations with per-CPU data
or for NUMA optimization.

Glibc does not provide a wrapper for this system call; call it using
**syscall**(2);
or use
**sched_getcpu**(3)
instead.

The
_tcache_
argument is unused since Linux 2.6.24.




In earlier kernels,
if this argument was non-NULL,
then it specified a pointer to a caller-allocated buffer in thread-local
storage that was used to provide a caching mechanism for
**getcpu**().
Use of the cache could speed
**getcpu**()
calls, at the cost that there was a very small chance that
the returned information would be out of date.
The caching mechanism was considered to cause problems when
migrating threads between CPUs, and so the argument is now ignored.

































<a name="see-also"></a>

# See Also

**mbind**(2),
**sched_setaffinity**(2),
**set_mempolicy**(2),
**sched_getcpu**(3),
**cpuset**(7),
**vdso**(7)

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
