# sysctl(2) - read/write system parameters

Linux, 2017-09-15

    #include <unistd.h>
    #include <linux/sysctl.h>
    
    int _sysctl(struct __sysctl_args *args);
```

 Note: There is no glibc wrapper for this system call; see NOTES.
```

<a name="description"></a>

# Description

**Do not use this system call!**
See NOTES.

The
**_sysctl**()
call reads and/or writes kernel parameters.
For example, the hostname,
or the maximum number of open files.
The argument has the form

.in +4n
.EX
struct __sysctl_args {
    int    *name;    /* integer vector describing variable */
    int     nlen;    /* length of this vector */
    void   *oldval;  /* 0 or address where to store old value */
    size_t *oldlenp; /* available room for old value,
                        overwritten by actual size of old value */
    void   *newval;  /* 0 or address of new value */
    size_t  newlen;  /* size of new value */
};
.EE
.in

This call does a search in a tree structure, possibly resembling
a directory tree under
_/proc/sys_,
and if the requested item is found calls some appropriate routine
to read or modify the value.

<a name="return-value"></a>

# Return Value

Upon successful completion,
**_sysctl**()
returns 0.
Otherwise, a value of -1 is returned and
_errno_
is set to indicate the error.

<a name="errors"></a>

# Errors


* **EACCES**, **EPERM**  
  No search permission for one of the encountered "directories",
  or no read permission where
  _oldval_
  was nonzero, or no write permission where
  _newval_
  was nonzero.
* **EFAULT**  
  The invocation asked for the previous value by setting
  _oldval_
  non-NULL, but allowed zero room in
  _oldlenp_.
* **ENOTDIR**  
  _name_
  was not found.

<a name="conforming-to"></a>

# Conforming to

This call is Linux-specific, and should not be used in programs
intended to be portable.
A
**sysctl**()
call has been present in Linux since version 1.3.57.
It originated in
4.4BSD.
Only Linux has the
_/proc/sys_
mirror, and the object naming schemes differ between Linux and 4.4BSD,
but the declaration of the
**sysctl**()
function is the same in both.

<a name="notes"></a>

# Notes

Glibc does not provide a wrapper for this system call; call it using
**syscall**(2).
Or rather...
_don't_
call it:
use of this system call has long been discouraged,
and it is so unloved that
**it is likely to disappear in a future kernel version**.

Since Linux 2.6.24,
uses of this system call result in warnings in the kernel log.


Remove it from your programs now; use the
_/proc/sys_
interface instead.

This system call is available only if the kernel was configured with the
**CONFIG_SYSCTL_SYSCALL**
option.

<a name="bugs"></a>

# Bugs

The object names vary between kernel versions,
making this system call worthless for applications.

Not all available objects are properly documented.

It is not yet possible to change operating system by writing to
_/proc/sys/kernel/ostype_.

<a name="example"></a>

# Example

.EX
#define _GNU_SOURCE
#include &lt;unistd.h&gt;
#include &lt;sys/syscall.h&gt;
#include &lt;string.h&gt;
#include &lt;stdio.h&gt;
#include &lt;stdlib.h&gt;
#include &lt;linux/sysctl.h&gt;

int _sysctl(struct __sysctl_args *args );

#define OSNAMESZ 100

int
main(void)
{
    struct __sysctl_args args;
    char osname[OSNAMESZ];
    size_t osnamelth;
    int name[] = { CTL_KERN, KERN_OSTYPE };

    memset(&args, 0, sizeof(struct __sysctl_args));
    args.name = name;
    args.nlen = sizeof(name)/sizeof(name[0]);
    args.oldval = osname;
    args.oldlenp = &osnamelth;

    osnamelth = sizeof(osname);

    if (syscall(SYS__sysctl, &args) == -1) {
        perror("_sysctl");
        exit(EXIT_FAILURE);
    }
    printf("This machine is running %*s\\n", osnamelth, osname);
    exit(EXIT_SUCCESS);
}
.EE

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
