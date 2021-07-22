# setns(2) - reassociate thread with a namespace

Linux, 2017-09-15

    #define _GNU_SOURCE             /* See feature_test_macros(7) */
    #include <sched.h>
    
    int setns(int fd, int nstype);

<a name="description"></a>

# Description

Given a file descriptor referring to a namespace,
reassociate the calling thread with that namespace.

The
_fd_
argument is a file descriptor referring to one of the namespace entries in a
_/proc/[pid]/ns/_
directory; see
**namespaces**(7)
for further information on
_/proc/[pid]/ns/_.
The calling thread will be reassociated with the corresponding namespace,
subject to any constraints imposed by the
_nstype_
argument.

The
_nstype_
argument specifies which type of namespace
the calling thread may be reassociated with.
This argument can have one of the following values:

* **0**  
  Allow any type of namespace to be joined.
* **CLONE_NEWCGROUP** (since Linux 4.6)  
  _fd_
  must refer to a cgroup namespace.
* **CLONE_NEWIPC** (since Linux 3.0)  
  _fd_
  must refer to an IPC namespace.
* **CLONE_NEWNET** (since Linux 3.0)  
  _fd_
  must refer to a network namespace.
* **CLONE_NEWNS** (since Linux 3.8)  
  _fd_
  must refer to a mount namespace.
* **CLONE_NEWPID** (since Linux 3.8)  
  _fd_
  must refer to a descendant PID namespace.
* **CLONE_NEWUSER** (since Linux 3.8)  
  _fd_
  must refer to a user namespace.
* **CLONE_NEWUTS** (since Linux 3.0)  
  _fd_
  must refer to a UTS namespace.

Specifying
_nstype_
as 0 suffices if the caller knows (or does not care)
what type of namespace is referred to by
_fd_.
Specifying a nonzero value for
_nstype_
is useful if the caller does not know what type of namespace is referred to by
_fd_
and wants to ensure that the namespace is of a particular type.
(The caller might not know the type of the namespace referred to by
_fd_
if the file descriptor was opened by another process and, for example,
passed to the caller via a UNIX domain socket.)

If
_fd_
refers to a PID namespaces, the semantics are somewhat different
from other namespace types:
reassociating the calling thread with a PID namespace changes only
the PID namespace that subsequently created child processes of
the caller will be placed in;
it does not change the PID namespace of the caller itself.
Reassociating with a PID namespace is allowed only if the
PID namespace specified by
_fd_
is a descendant (child, grandchild, etc.)
of the PID namespace of the caller.
For further details on PID namespaces, see
**pid_namespaces**(7).

A process reassociating itself with a user namespace must have the
**CAP_SYS_ADMIN**

capability in the target user namespace.
Upon successfully joining a user namespace,
a process is granted all capabilities in that namespace,
regardless of its user and group IDs.
A multithreaded process may not change user namespace with
**setns**().
It is not permitted to use
**setns**()
to reenter the caller's current user namespace.
This prevents a caller that has dropped capabilities from regaining
those capabilities via a call to
**setns**().
For security reasons,


a process can't join a new user namespace if it is sharing
filesystem-related attributes
(the attributes whose sharing is controlled by the
**clone**(2)
**CLONE_FS**
flag) with another process.
For further details on user namespaces, see
**user_namespaces**(7).

A process may not be reassociated with a new mount namespace if it is
multithreaded.

Changing the mount namespace requires that the caller possess both
**CAP_SYS_CHROOT**
and
**CAP_SYS_ADMIN**
capabilities in its own user namespace and
**CAP_SYS_ADMIN**
in the target mount namespace.
See
**user_namespaces**(7)
for details on the interaction of user namespaces and mount namespaces.

Using
**setns**()
to change the caller's cgroup namespace does not change
the caller's cgroup memberships.

<a name="return-value"></a>

# Return Value

On success,
**setns**()
returns 0.
On failure, -1 is returned and
_errno_
is set to indicate the error.

<a name="errors"></a>

# Errors


* **EBADF**  
  _fd_
  is not a valid file descriptor.
* **EINVAL**  
  _fd_
  refers to a namespace whose type does not match that specified in
  _nstype_.
* **EINVAL**  
  There is problem with reassociating
  the thread with the specified namespace.
*   
  **EINVAL**
  The caller tried to join an ancestor (parent, grandparent, and so on)
  PID namespace.
* **EINVAL**  
  The caller attempted to join the user namespace
  in which it is already a member.
* **EINVAL**  
  
  The caller shares filesystem
  (**CLONE_FS**)
  state (in particular, the root directory)
  with other processes and tried to join a new user namespace.
* **EINVAL**  
  
  The caller is multithreaded and tried to join a new user namespace.
* **ENOMEM**  
  Cannot allocate sufficient memory to change the specified namespace.
* **EPERM**  
  The calling thread did not have the required capability
  for this operation.

<a name="versions"></a>

# Versions

The
**setns**()
system call first appeared in Linux in kernel 3.0;
library support was added to glibc in version 2.14.

<a name="conforming-to"></a>

# Conforming to

The
**setns**()
system call is Linux-specific.

<a name="notes"></a>

# Notes

Not all of the attributes that can be shared when
a new thread is created using
**clone**(2)
can be changed using
**setns**().

<a name="example"></a>

# Example

The program below takes two or more arguments.
The first argument specifies the pathname of a namespace file in an existing
_/proc/[pid]/ns/_
directory.
The remaining arguments specify a command and its arguments.
The program opens the namespace file, joins that namespace using
**setns**(),
and executes the specified command inside that namespace.

The following shell session demonstrates the use of this program
(compiled as a binary named
_ns_exec_)
in conjunction with the
**CLONE_NEWUTS**
example program in the
**clone**(2)
man page (complied as a binary named
_newuts_).

We begin by executing the example program in
**clone**(2)
in the background.
That program creates a child in a separate UTS namespace.
The child changes the hostname in its namespace,
and then both processes display the hostnames in their UTS namespaces,
so that we can see that they are different.

.in +4n
.EX
$ **su**                   # Need privilege for namespace operations
Password:
# **./newuts bizarro &**
[1] 3549
clone() returned 3550
uts.nodename in child:  bizarro
uts.nodename in parent: antero
# **uname -n**             # Verify hostname in the shell
antero
.EE
.in

We then run the program shown below,
using it to execute a shell.
Inside that shell, we verify that the hostname is the one
set by the child created by the first program:

.in +4n
.EX
# **./ns_exec /proc/3550/ns/uts /bin/bash**
# **uname -n**             # Executed in shell started by ns_exec
bizarro
.EE
.in

<a name="program-source"></a>

### Program source

.EX
#define _GNU_SOURCE
#include &lt;fcntl.h&gt;
#include &lt;sched.h&gt;
#include &lt;unistd.h&gt;
#include &lt;stdlib.h&gt;
#include &lt;stdio.h&gt;

#define errExit(msg)    do { perror(msg); exit(EXIT_FAILURE); &nbsp;                       } while (0)

int
main(int argc, char *argv[])
{
    int fd;

    if (argc &lt; 3) {
        fprintf(stderr, "%s /proc/PID/ns/FILE cmd args...\\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    fd = open(argv[1], O_RDONLY); /* Get file descriptor for namespace */
    if (fd == -1)
        errExit("open");

    if (setns(fd, 0) == -1)       /* Join that namespace */
        errExit("setns");

    execvp(argv[2], &argv[2]);    /* Execute a command in namespace */
    errExit("execvp");
}
.EE

<a name="see-also"></a>

# See Also

**nsenter**(1),
**clone**(2),
**fork**(2),
**unshare**(2),
**vfork**(2),
**namespaces**(7),
**unix**(7)

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
