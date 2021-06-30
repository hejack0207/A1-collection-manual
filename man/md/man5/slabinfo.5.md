# slabinfo(5) - kernel slab allocator statistics

"", 2017-09-15

```
cat /proc/slabinfo
```

<a name="description"></a>

# Description

Frequently used objects in the Linux kernel
(buffer heads, inodes, dentries, etc.)
have their own cache.
The file
_/proc/slabinfo_
gives statistics on these caches.
The following (edited) output shows an example of the
contents of this file:

.in 0
.EX
$ **sudo cat /proc/slabinfo**
slabinfo - version: 2.1
# name    &lt;active_objs&gt; &lt;num_objs&gt; &lt;objsize&gt; &lt;objperslab&gt; &lt;pagesperslab&gt; ...
sigqueue      100  100  160   25  1 : tunables  0  0  0 : slabdata   4   4  0
sighand_cache 355   405 2112  15  8 : tunables  0  0  0 : slabdata  27  27  0
kmalloc-8192   96   96  8192   4  8 : tunables  0  0  0 : slabdata  24  24  0
...
.EE
.in

The first line of output includes a version number,
which allows an application that is reading the file to handle changes
in the file format.
(See VERSIONS, below.)
The next line lists the names of the columns in the remaining lines.

Each of the remaining lines displays information about a specified cache.
Following the cache name,
the output shown in each line shows three components for each cache:

* *  
  statistics
* *  
  tunables
* *  
  slabdata

The statistics are as follows:

* _active_objs_  
  The number of objects that are currently active (i.e., in use).
* _num_objs_  
  The total number of allocated objects
  (i.e., objects that are both in use and not in use).
* _objsize_  
  The size of objects in this slab, in bytes.
* _objperslab_  
  The number of objects stored in each slab.
* _pagesperslab_  
  The number of pages allocated for each slab.

The
_tunables_
entries in each line show tunable parameters for the corresponding cache.
When using the default SLUB allocator, there are no tunables, the
_/proc/slabinfo_
file is not writable, and the value 0 is shown in these fields.
When using the older SLAB allocator,
the tunables for a particular cache can be set by writing
lines of the following form to
_/proc/slabinfo_:

.in +4n
.EX
# **echo 'name limit batchcount sharedfactor' &gt; /proc/slabinfo**
.EE
.in

Here,
_name_
is the cache name, and
_limit_,
_batchcount_,
and
_sharedfactor_
are integers defining new values for the corresponding tunables.
The
_limit_
value should be a positive value,
_batchcount_
should be a positive value that is less than or equal to
_limit_,
and
_sharedfactor_
should be nonnegative.
If any of the specified values is invalid,
the cache settings are left unchanged.

The
_tunables_
entries in each line contain the following fields:

* _limit_  
  The maximum number of objects that will be cached.
  
  
  
* _batchcount_  
  On SMP systems, this specifies the number of objects to transfer at one time
  when refilling the available object list.
  
  
  
* _sharedfactor_  
  [To be documented]
  

The
_slabdata_
entries in each line contain the following fields:

* _active_slabs_  
  The number of active slabs.
* _nums_slabs_  
  The total number of slabs.
* _sharedavail_  
  [To be documented]

Note that because of object alignment and slab cache overhead,
objects are not normally packed tightly into pages.
Pages with even one in-use object are considered in-use and cannot be
freed.

Kernels configured with
**CONFIG_DEBUG_SLAB**
will also have additional statistics fields in each line,
and the first line of the file will contain the string "(statistics)".
The statistics field include : the high water mark of active
objects; the number of times objects have been allocated;
the number of times the cache has grown (new pages added
to this cache); the number of times the cache has been
reaped (unused pages removed from this cache); and the
number of times there was an error allocating new pages
to this cache.


























<a name="versions"></a>

# Versions

The
_/proc/slabinfo_
file first appeared in Linux 2.1.23.
The file is versioned,
and over time there have been a number of versions with different layouts:

* 1.0  
  Present throughout the Linux 2.2.x kernel series.
* 1.1  
  Present in the Linux 2.4.x kernel series.
  
* 1.2  
  A format that was briefly present in the Linux 2.5 development series.
  
* 2.0  
  Present in Linux 2.6.x kernels up to and including Linux 2.6.9.
  
* 2.1  
  The current format, which first appeared in Linux 2.6.10.

<a name="notes"></a>

# Notes

Only root can read and (if the kernel was configured with
**CONFIG_SLAB**)
write the
_/proc/slabinfo_
file.

The total amount of memory allocated to the SLAB/SLUB cache is shown in the
_Slab_
field of
_/proc/meminfo_.

<a name="see-also"></a>

# See Also

**slabtop**(1)

The kernel source file
_Documentation/vm/slub.txt_
and
_tools/vm/slabinfo.c_.

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
