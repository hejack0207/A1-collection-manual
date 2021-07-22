# sysinfo(2) - return system information

Linux, 2017-09-15

```
#include <sys/sysinfo.h> 
 int sysinfo(struct sysinfo *info);
```

<a name="description"></a>

# Description

**sysinfo**()
returns certain statistics on memory and swap usage,
as well as the load average.

Until Linux 2.3.16,
**sysinfo**()
returned information in the following structure:

.in +4n
.EX
struct sysinfo {
    long uptime;             /* Seconds since boot */
    unsigned long loads[3];  /* 1, 5, and 15 minute load averages */
    unsigned long totalram;  /* Total usable main memory size */
    unsigned long freeram;   /* Available memory size */
    unsigned long sharedram; /* Amount of shared memory */
    unsigned long bufferram; /* Memory used by buffers */
    unsigned long totalswap; /* Total swap space size */
    unsigned long freeswap;  /* Swap space still available */
    unsigned short procs;    /* Number of current processes */
    char _f[22];             /* Pads structure to 64 bytes */
};
.EE
.in

In the above structure, the sizes of the memory and swap fields
are given in bytes.

Since Linux 2.3.23 (i386) and Linux 2.3.48
(all architectures) the structure is:

.in +4n
.EX
struct sysinfo {
    long uptime;             /* Seconds since boot */
    unsigned long loads[3];  /* 1, 5, and 15 minute load averages */
    unsigned long totalram;  /* Total usable main memory size */
    unsigned long freeram;   /* Available memory size */
    unsigned long sharedram; /* Amount of shared memory */
    unsigned long bufferram; /* Memory used by buffers */
    unsigned long totalswap; /* Total swap space size */
    unsigned long freeswap;  /* Swap space still available */
    unsigned short procs;    /* Number of current processes */
    unsigned long totalhigh; /* Total high memory size */
    unsigned long freehigh;  /* Available high memory size */
    unsigned int mem_unit;   /* Memory unit size in bytes */
    char _f[20-2*sizeof(long)-sizeof(int)];
                             /* Padding to 64 bytes */
};
.EE
.in

In the above structure,
sizes of the memory and swap fields are given as multiples of
_mem_unit_
bytes.

<a name="return-value"></a>

# Return Value

On success,
**sysinfo**()
returns zero.
On error, -1 is returned, and
_errno_
is set to indicate the cause of the error.

<a name="errors"></a>

# Errors


* **EFAULT**  
  _info_
  is not a valid address.

<a name="versions"></a>

# Versions

**sysinfo**()
first appeared in Linux 0.98.pl6.

<a name="conforming-to"></a>

# Conforming to

This function is Linux-specific, and should not be used in programs
intended to be portable.

<a name="notes"></a>

# Notes

All of the information provided by this system call is also available via
_/proc/meminfo_
and
_/proc/loadavg_.

<a name="see-also"></a>

# See Also

**proc**(5)

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
