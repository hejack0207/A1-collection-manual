# create_module(2) - create a loadable module entry

Linux, 2017-09-15

    #include <linux/module.h>
    
    caddr_t create_module(const char *name, size_t size);
```

 Note: No declaration of this system call is provided in glibc headers; see NOTES.
```

<a name="description"></a>

# Description

_Note_:
This system call is present only in kernels before Linux 2.6.

**create_module**()
attempts to create a loadable module entry and reserve the kernel memory
that will be needed to hold the module.
This system call requires privilege.

<a name="return-value"></a>

# Return Value

On success, returns the kernel address at which the module will reside.
On error, -1 is returned and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors


* **EEXIST**  
  A module by that name already exists.
* **EFAULT**  
  _name_
  is outside the program's accessible address space.
* **EINVAL**  
  The requested size is too small even for the module header information.
* **ENOMEM**  
  The kernel could not allocate a contiguous block of memory large
  enough for the module.
* **ENOSYS**  
  **create_module**()
  is not supported in this version of the kernel
  (e.g., the kernel is version 2.6 or later).
* **EPERM**  
  The caller was not privileged
  (did not have the
  **CAP_SYS_MODULE**
  capability).

<a name="versions"></a>

# Versions

This system call is present on Linux only up until kernel 2.4;
it was removed in Linux 2.6.


<a name="conforming-to"></a>

# Conforming to

**create_module**()
is Linux-specific.

<a name="notes"></a>

# Notes

This obsolete system call is not supported by glibc.
No declaration is provided in glibc headers, but, through a quirk of history,
glibc versions before 2.23 did export an ABI for this system call.
Therefore, in order to employ this system call,
it was sufficient to manually declare the interface in your code;
alternatively, you could invoke the system call using
**syscall**(2).

<a name="see-also"></a>

# See Also

**delete_module**(2),
**init_module**(2),
**query_module**(2)

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
