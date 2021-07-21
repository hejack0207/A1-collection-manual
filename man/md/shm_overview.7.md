# shm_overview(7) - overview of POSIX shared memory

Linux, 2016-12-12


<a name="description"></a>

# Description

The POSIX shared memory API allows processes to communicate information
by sharing a region of memory.

The interfaces employed in the API are:

* **shm_open**(3)  
  Create and open a new object, or open an existing object.
  This is analogous to
  **open**(2).
  The call returns a file descriptor for use by the other
  interfaces listed below.
* **ftruncate**(2)  
  Set the size of the shared memory object.
  (A newly created shared memory object has a length of zero.)
* **mmap**(2)  
  Map the shared memory object into the virtual address space
  of the calling process.
* **munmap**(2)  
  Unmap the shared memory object from the virtual address space
  of the calling process.
* **shm_unlink**(3)  
  Remove a shared memory object name.
* **close**(2)  
  Close the file descriptor allocated by
  **shm_open**(3)
  when it is no longer needed.
* **fstat**(2)  
  Obtain a
  _stat_
  structure that describes the shared memory object.
  Among the information returned by this call are the object's
  size
  (_st_size_),
  permissions
  (_st_mode_),
  owner
  (_st_uid_),
  and group
  (_st_gid_).
* **fchown**(2)  
  To change the ownership of a shared memory object.
* **fchmod**(2)  
  To change the permissions of a shared memory object.

<a name="versions"></a>

### Versions

POSIX shared memory is supported since Linux 2.4 and glibc 2.2.

<a name="persistence"></a>

### Persistence

POSIX shared memory objects have kernel persistence:
a shared memory object will exist until the system is shut down,
or until all processes have unmapped the object and it has been deleted with
**shm_unlink**(3)

<a name="linking"></a>

### Linking

Programs using the POSIX shared memory API must be compiled with
_cc -lrt_
to link against the real-time library,
_librt_.

<a name="accessing-shared-memory-objects-via-the-filesystem"></a>

### Accessing shared memory objects via the filesystem

On Linux, shared memory objects are created in a
(_tmpfs_(5))
virtual filesystem, normally mounted under
_/dev/shm_.
Since kernel 2.6.19, Linux supports the use of access control lists (ACLs)
to control the permissions of objects in the virtual filesystem.

<a name="notes"></a>

# Notes

Typically, processes must synchronize their access to a shared
memory object, using, for example, POSIX semaphores.

System V shared memory
(**shmget**(2),
**shmop**(2),
etc.) is an older shared memory API.
POSIX shared memory provides a simpler, and better designed interface;
on the other hand POSIX shared memory is somewhat less widely available
(especially on older systems) than System V shared memory.

<a name="see-also"></a>

# See Also

**fchmod**(2),
**fchown**(2),
**fstat**(2),
**ftruncate**(2),
**mmap**(2),
**mprotect**(2),
**munmap**(2),
**shmget**(2),
**shmop**(2),
**shm_open**(3),
**shm_unlink**(3),
**sem_overview**(7)

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
