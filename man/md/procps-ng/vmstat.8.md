# vmstat(8) - Report virtual memory statistics

procps-ng, September 2011

```
vmstat [options] [delay [count]]
```

<a name="description"></a>

# Description

**vmstat**
reports information about processes, memory, paging, block IO, traps, disks
and cpu activity.

The first report produced gives averages since the last reboot.  Additional
reports give information on a sampling period of length
_delay_.
The process and memory reports are instantaneous in either case.

<a name="options"></a>

# Options


* _delay_  
  The
  _delay_
  between updates in seconds.  If no
  _delay_
  is specified, only one report is printed with the average values since boot.
* _count_  
  Number of updates.  In absence of
  _count_,
  when
  _delay_
  is defined, default is infinite.
* **-a**, **--active**  
  Display active and  inactive memory, given a 2.5.41 kernel or better.
* **-f**, **--forks**  
  The
  **-f**
  switch displays the number of forks since boot.  This includes the fork,
  vfork, and clone system calls, and is equivalent to the total number of tasks
  created.  Each process is represented by one or more tasks, depending on
  thread usage.  This display does not repeat.
* **-m**, **--slabs**  
  Displays slabinfo.
* **-n**, **--one-header**  
  Display the header only once rather than periodically.
* **-s**, **--stats**  
  Displays a table of various event counters and memory statistics.  This
  display does not repeat.
* **-d**, **--disk**  
  Report disk statistics (2.5.70 or above required).
* **-D**, **--disk-sum**  
  Report some summary statistics about disk activity.
* **-p**, **--partition** _device_  
  Detailed statistics about partition (2.5.70 or above required).
* **-S**, **--unit** _character_  
  Switches outputs between 1000
  (_k_),
  1024
  (_K_),
  1000000
  (_m_),
  or 1048576
  (_M_)
  bytes.  Note this does not change the swap (si/so) or block (bi/bo)
  fields.
* **-t**, **--timestamp**  
  Append timestamp to each line
* **-w**, **--wide**  
  Wide output mode (useful for systems with higher amount of memory,
  where the default output mode suffers from unwanted column breakage).
  The output is wider than 80 characters per line.
* **-V**, **--version**  
  Display version information and exit.
* **-h**, **--help**  
  Display help and exit.

<a name="field-description-for-vm-mode"></a>

# Field Description for Vm Mode

.SS
**Procs**
    r: The number of runnable processes (running or waiting for run time).
    b: The number of processes in uninterruptible sleep.

.SS
**Memory**
    swpd: the amount of virtual memory used.
    free: the amount of idle memory.
    buff: the amount of memory used as buffers.
    cache: the amount of memory used as cache.
    inact: the amount of inactive memory.  (-a option)
    active: the amount of active memory.  (-a option)

.SS
**Swap**
    si: Amount of memory swapped in from disk (/s).
    so: Amount of memory swapped to disk (/s).

.SS
**IO**
    bi: Blocks received from a block device (blocks/s).
    bo: Blocks sent to a block device (blocks/s).

.SS
**System**
    in: The number of interrupts per second, including the clock.
    cs: The number of context switches per second.

.SS
**CPU**
These are percentages of total CPU time.
    us: Time spent running non-kernel code.  (user time, including nice time)
    sy: Time spent running kernel code.  (system time)
    id: Time spent idle.  Prior to Linux 2.5.41, this includes IO-wait time.
    wa: Time spent waiting for IO.  Prior to Linux 2.5.41, included in idle.
    st: Time stolen from a virtual machine.  Prior to Linux 2.6.11, unknown.


<a name="field-description-for-disk-mode"></a>

# Field Description for Disk Mode

.SS
**Reads**
    total: Total reads completed successfully
    merged: grouped reads (resulting in one I/O)
    sectors: Sectors read successfully
    ms: milliseconds spent reading

.SS
**Writes**
    total: Total writes completed successfully
    merged: grouped writes (resulting in one I/O)
    sectors: Sectors written successfully
    ms: milliseconds spent writing

.SS
**IO**
    cur: I/O in progress
    s: seconds spent for I/O


<a name="field-description-for-disk-partition-mode"></a>

# Field Description for Disk Partition Mode

    reads: Total number of reads issued to this partition
    read sectors: Total read sectors for partition
    writes : Total number of writes issued to this partition
    requested writes: Total number of write requests made for partition


<a name="field-description-for-slab-mode"></a>

# Field Description for Slab Mode

    cache: Cache name
    num: Number of currently active objects
    total: Total number of available objects
    size: Size of each object
    pages: Number of pages with at least one active object

<a name="notes"></a>

# Notes

**vmstat **
does not require special permissions.

These reports are intended to help identify system bottlenecks.  Linux
**vmstat**
does not count itself as a running process.

All linux blocks are currently 1024 bytes.  Old kernels may report blocks as
512 bytes, 2048 bytes, or 4096 bytes.

Since procps 3.1.9, vmstat lets you choose units (k, K, m, M).  Default is K
(1024 bytes) in the default mode.

vmstat uses slabinfo 1.1

<a name="files"></a>

# Files

.ta
    /proc/meminfo
    /proc/stat
    /proc/*/stat

<a name="see-also"></a>

# See Also

**free**(1),
**iostat**(1),
**mpstat**(1),
**ps**(1),
**sar**(1),
**top**(1)


<a name="bugs"></a>

# Bugs

Does not tabulate the block io per device or count the number of system calls.

<a name="authors"></a>

# Authors

Written by
.UR al172@yfn.​ysu.​edu
Henry Ware
.UE .  
.UR ffrederick@users.​sourceforge.​net
Fabian Fr\('ed\('erick
.UE
(diskstat, slab, partitions...)

<a name="reporting-bugs"></a>

# Reporting Bugs

Please send bug reports to
.UR procps@freelists.org
.UE
