# _syscall(2) - invoking a system call without library support (OBSOLETE)

Linux, 2017-09-15

```
#include <linux/unistd.h> 
 A _syscall macro 
 desired system call
```

<a name="description"></a>

# Description

The important thing to know about a system call is its prototype.
You need to know how many arguments, their types,
and the function return type.
There are seven macros that make the actual call into the system easier.
They have the form:

.in +4n
.EX
_syscall_X_(_type_,_name_,_type1_,_arg1_,_type2_,_arg2_,...)
.EE
.in

where

* _X_
  is 0–6, which are the number of arguments taken by the
  system call
* _type_
  is the return type of the system call
* _name_
  is the name of the system call
* _typeN_
  is the Nth argument's type
* _argN_
  is the name of the Nth argument

These macros create a function called
_name_
with the arguments you
specify.
Once you include the _syscall() in your source file,
you call the system call by
_name_.

<a name="files"></a>

# Files

_/usr/include/linux/unistd.h_

<a name="conforming-to"></a>

# Conforming to

The use of these macros is Linux-specific, and deprecated.

<a name="notes"></a>

# Notes

Starting around kernel 2.6.18, the _syscall macros were removed
from header files supplied to user space.
Use
**syscall**(2)
instead.
(Some architectures, notably ia64, never provided the _syscall macros;
on those architectures,
**syscall**(2)
was always required.)

The _syscall() macros
_do not_
produce a prototype.
You may have to
create one, especially for C++ users.

System calls are not required to return only positive or negative error
codes.
You need to read the source to be sure how it will return errors.
Usually, it is the negative of a standard error code,
for example,
-_EPERM_.
The _syscall() macros will return the result
_r_
of the system call
when
_r_
is nonnegative, but will return -1 and set the variable
_errno_
to
-_r_
when
_r_
is negative.
For the error codes, see
**errno**(3).

When defining a system call, the argument types
_must_
be
passed by-value or by-pointer (for aggregates like structs).












<a name="example"></a>

# Example

.EX
#include &lt;stdio.h&gt;
#include &lt;stdlib.h&gt;
#include &lt;errno.h&gt;
#include &lt;linux/unistd.h&gt;       /* for _syscallX macros/related stuff */
#include &lt;linux/kernel.h&gt;       /* for struct sysinfo */

_syscall1(int, sysinfo, struct sysinfo *, info);

int
main(void)
{
    struct sysinfo s_info;
    int error;

    error = sysinfo(&s_info);
    printf("code error = %d\\n", error);
    printf("Uptime = %lds\\nLoad: 1 min %lu / 5 min %lu / 15 min %lu\\n"
           "RAM: total %lu / free %lu / shared %lu\\n"
           "Memory in buffers = %lu\\nSwap: total %lu / free %lu\\n"
           "Number of processes = %d\\n",
           s_info.uptime, s_info.loads[0],
           s_info.loads[1], s_info.loads[2],
           s_info.totalram, s_info.freeram,
           s_info.sharedram, s_info.bufferram,
           s_info.totalswap, s_info.freeswap,
           s_info.procs);
    exit(EXIT_SUCCESS);
}
.EE

<a name="sample-output"></a>

### Sample output

.EX
code error = 0
uptime = 502034s
Load: 1 min 13376 / 5 min 5504 / 15 min 1152
RAM: total 15343616 / free 827392 / shared 8237056
Memory in buffers = 5066752
Swap: total 27881472 / free 24698880
Number of processes = 40
.EE

<a name="see-also"></a>

# See Also

**intro**(2),
**syscall**(2),
**errno**(3)

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
