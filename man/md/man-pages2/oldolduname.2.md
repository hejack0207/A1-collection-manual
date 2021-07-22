# uname(2) - get name and information about current kernel

Linux, 2017-09-15

```
#include <sys/utsname.h> 
 int uname(struct utsname *buf);
```

<a name="description"></a>

# Description

**uname**()
returns system information in the structure pointed to by
_buf_.
The
_utsname_
struct is defined in
_&lt;sys/utsname.h&gt;_:

.in +4n
.EX
struct utsname {
    char sysname[];    /* Operating system name (e.g., "Linux") */
    char nodename[];   /* Name within "some implementation-defined
                          network" */
    char release[];    /* Operating system release (e.g., "2.6.28") */
    char version[];    /* Operating system version */
    char machine[];    /* Hardware identifier */
#ifdef _GNU_SOURCE
    char domainname[]; /* NIS or YP domain name */
#endif
};
.EE
.in

The length of the arrays in a
_struct utsname_
is unspecified (see NOTES);
the fields are terminated by a null byte ('\\0').

<a name="return-value"></a>

# Return Value

On success, zero is returned.
On error, -1 is returned, and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors


* **EFAULT**  
  _buf_
  is not valid.

<a name="conforming-to"></a>

# Conforming to

POSIX.1-2001, POSIX.1-2008, SVr4.
There is no
**uname**()
call in 4.3BSD.

The
_domainname_
member (the NIS or YP domain name) is a GNU extension.

<a name="notes"></a>

# Notes

This is a system call, and the operating system presumably knows
its name, release and version.
It also knows what hardware it runs on.
So, four of the fields of the struct are meaningful.
On the other hand, the field
_nodename_
is meaningless:
it gives the name of the present machine in some undefined
network, but typically machines are in more than one network
and have several names.
Moreover, the kernel has no way of knowing
about such things, so it has to be told what to answer here.
The same holds for the additional
_domainname_
field.

To this end, Linux uses the system calls
**sethostname**(2)
and
**setdomainname**(2).
Note that there is no standard that says that the hostname set by
**sethostname**(2)
is the same string as the
_nodename_
field of the struct returned by
**uname**()
(indeed, some systems allow a 256-byte hostname and an 8-byte nodename),
but this is true on Linux.
The same holds for
**setdomainname**(2)
and the
_domainname_
field.

The length of the fields in the struct varies.
Some operating systems
or libraries use a hardcoded 9 or 33 or 65 or 257.
Other systems use
**SYS_NMLN**
or
**_SYS_NMLN**
or
**UTSLEN**
or
**_UTSNAME_LENGTH**.
Clearly, it is a bad
idea to use any of these constants; just use sizeof(...).
Often 257 is chosen in order to have room for an internet hostname.

Part of the utsname information is also accessible via
_/proc/sys/kernel/_{_ostype_,
_hostname_,
_osrelease_,
_version_,
_domainname_}.

<a name="c-librarykernel-differences"></a>

### C library/kernel differences


Over time, increases in the size of the
_utsname_
structure have led to three successive versions of
**uname**():
_sys_olduname_()
(slot
___NR_oldolduname_),
_sys_uname_()
(slot
___NR_olduname_),
and
_sys_newuname_()
(slot
___NR_uname)_.
The first one

used length 9 for all fields;
the second

used 65;
the third also uses 65 but adds the
_domainname_
field.
The glibc
**uname**()
wrapper function hides these details from applications,
invoking the most recent version of the system call provided by the kernel.

<a name="see-also"></a>

# See Also

**uname**(1),
**getdomainname**(2),
**gethostname**(2),
**namespaces**(7)

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
