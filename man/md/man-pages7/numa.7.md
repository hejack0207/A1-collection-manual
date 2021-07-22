# numa(7) - overview of Non-Uniform Memory Architecture

Linux, 2012-08-05


<a name="description"></a>

# Description

Non-Uniform Memory Access (NUMA) refers to multiprocessor systems
whose memory is divided into multiple memory nodes.
The access time of a memory node depends on
the relative locations of the accessing CPU and the accessed node.
(This contrasts with a symmetric multiprocessor system,
where the access time for all of the memory is the same for all CPUs.)
Normally, each CPU on a NUMA system has a local memory node whose
contents can be accessed faster than the memory in
the node local to another CPU
or the memory on a bus shared by all CPUs.

<a name="numa-system-calls"></a>

### NUMA system calls

The Linux kernel implements the following NUMA-related system calls:
**get_mempolicy**(2),
**mbind**(2),
**migrate_pages**(2),
**move_pages**(2),
and
**set_mempolicy**(2).
However, applications should normally use the interface provided by
_libnuma_;
see "Library Support" below.

<a name="procnumbernuma_maps-since-linux-2614"></a>

### /proc/[number]/numa_maps  (since Linux 2.6.14)


This file displays information about a process's
NUMA memory policy and allocation.

Each line contains information about a memory range used by the process,
displaying—among other information—the effective memory policy for
that memory range and on which nodes the pages have been allocated.

_numa_maps_
is a read-only file.
When
_/proc/&lt;pid&gt;/numa_maps_
is read, the kernel will scan the virtual address space of the
process and report how memory is used.
One line is displayed for each unique memory range of the process.

The first field of each line shows the starting address of the memory range.
This field allows a correlation with the contents of the
_/proc/&lt;pid&gt;/maps_
file,
which contains the end address of the range and other information,
such as the access permissions and sharing.

The second field shows the memory policy currently in effect for the
memory range.
Note that the effective policy is not necessarily the policy
installed by the process for that memory range.
Specifically, if the process installed a "default" policy for that range,
the effective policy for that range will be the process policy,
which may or may not be "default".

The rest of the line contains information about the pages allocated in
the memory range, as follows:

* _N&lt;node&gt;=&lt;nr_pages&gt;_  
  The number of pages allocated on
  _&lt;node&gt;_.
  _&lt;nr_pages&gt;_
  includes only pages currently mapped by the process.
  Page migration and memory reclaim may have temporarily unmapped pages
  associated with this memory range.
  These pages may show up again only after the process has
  attempted to reference them.
  If the memory range represents a shared memory area or file mapping,
  other processes may currently have additional pages mapped in a
  corresponding memory range.
* _file=&lt;filename&gt;_  
  The file backing the memory range.
  If the file is mapped as private, write accesses may have generated
  COW (Copy-On-Write) pages in this memory range.
  These pages are displayed as anonymous pages.
* _heap_  
  Memory range is used for the heap.
* _stack_  
  Memory range is used for the stack.
* _huge_  
  Huge memory range.
  The page counts shown are huge pages and not regular sized pages.
* _anon=&lt;pages&gt;_  
  The number of anonymous page in the range.
* _dirty=&lt;pages&gt;_  
  Number of dirty pages.
* _mapped=&lt;pages&gt;_  
  Total number of mapped pages, if different from
  _dirty_
  and
  _anon_
  pages.
* _mapmax=&lt;count&gt;_  
  Maximum mapcount (number of processes mapping a single page) encountered
  during the scan.
  This may be used as an indicator of the degree of sharing occurring in a
  given memory range.
* _swapcache=&lt;count&gt;_  
  Number of pages that have an associated entry on a swap device.
* _active=&lt;pages&gt;_  
  The number of pages on the active list.
  This field is shown only if different from the number of pages in this range.
  This means that some inactive pages exist in the memory range that may be
  removed from memory by the swapper soon.
* _writeback=&lt;pages&gt;_  
  Number of pages that are currently being written out to disk.

<a name="conforming-to"></a>

# Conforming to

No standards govern NUMA interfaces.

<a name="notes"></a>

# Notes

The Linux NUMA system calls and
_/proc_
interface are available only
if the kernel was configured and built with the
**CONFIG_NUMA**
option.

<a name="library-support"></a>

### Library support

Link with _-lnuma_
to get the system call definitions.
_libnuma_
and the required
_&lt;numaif.h&gt;_
header are available in the
_numactl_
package.

However, applications should not use these system calls directly.
Instead, the higher level interface provided by the
**numa**(3)
functions in the
_numactl_
package is recommended.
The
_numactl_
package is available at
[](ftp://oss.sgi.com​/www​/projects​/libnuma​/download/).
The package is also included in some Linux distributions.
Some distributions include the development library and header
in the separate
_numactl-devel_
package.

<a name="see-also"></a>

# See Also

**get_mempolicy**(2),
**mbind**(2),
**move_pages**(2),
**set_mempolicy**(2),
**numa**(3),
**cpuset**(7),
**numactl**(8)

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
