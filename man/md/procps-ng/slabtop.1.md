# slabtop(1) - display kernel slab cache information in real time

procps-ng, June 2011

```
slabtop [options]
```

<a name="description"></a>

# Description

**slabtop**
displays detailed kernel slab cache information in real time.  It displays a
listing of the top caches sorted by one of the listed sort criteria.  It also
displays a statistics header filled with slab layer information.

<a name="options"></a>

# Options

Normal invocation of
**slabtop**
does not require any options.  The behavior, however, can be fine-tuned by
specifying one or more of the following flags:

* **-d**, **--delay**=_N_  
  Refresh the display every
  _n_
  in seconds.  By default,
  **slabtop**
  refreshes the display every three seconds.  To exit the program, hit
  **q.**
* **-s**, **--sort**=_S_  
  Sort by _S_, where _S_ is one of the sort criteria.
* **-o**, **--once**  
  Display the output once and then exit.
* **-V**, **--version**  
  Display version information and exit.
* **-h**, **--help**  
  Display usage information and exit.

<a name="sort-criteria"></a>

# Sort Criteria

The following are valid sort criteria used to sort the individual slab caches
and thereby determine what are the "top" slab caches to display.  The default
sort criteria is to sort by the number of objects ("o").

The sort criteria can also be changed while slabtop is running by pressing
the associated character.
.TS
l l l.
**character	description	header**
a	number of active objects	ACTIVE
b	objects per slab	OBJ/SLAB
c	cache size	CACHE SIZE
l	number of slabs	SLABS
v	number of active slabs	N/A
n	name	NAME​
o	number of objects	OBJS
p	pages per slab	N/A
s	object size	OBJ SIZE
u	cache utilization	USE
.TE

<a name="commands"></a>

# Commands

**slabtop**
accepts keyboard commands from the user during use.  The following are
supported.  In the case of letters, both cases are accepted.

Each of the valid sort characters are also accepted, to change the sort
routine. See the section
**SORT CRITERIA**.

* **&lt;SPACEBAR&gt;**  
  Refresh the screen.
* **Q**  
  Quit the program.

<a name="files"></a>

# Files


* _/proc/slabinfo_  
  slab information

<a name="see-also"></a>

# See Also

**free**(1),
**ps**(1),
**top**(1),
**vmstat**(8)

<a name="notes"></a>

# Notes

Currently,
**slabtop**
requires a 2.4 or later kernel (specifically, a version 1.1 or later
_/proc/slabinfo_).
Kernel 2.2 should be supported in the future.

The slabtop statistic header is tracking how many bytes of slabs are being
used and is not a measure of physical memory.  The 'Slab' field in the
/proc/meminfo file is tracking information about used slab physical memory.

<a name="authors"></a>

# Authors

Written by Chris Rivera and Robert Love.

**slabtop**
was inspired by Martin Bligh's perl script,
**vmtop**.

<a name="reporting-bugs"></a>

# Reporting Bugs

Please send bug reports to
.UR procps@freelists.org
.UE
