# kcmp(2) - compare two processes to determine if they share a kernel resource

Linux, 2017-09-15

    #include <linux/kcmp.h>
    
    int kcmp(pid_t pid1, pid_t pid2, int type,
             unsigned long idx1, unsigned long idx2);
```

 Note: There is no glibc wrapper for this system call; see NOTES.
```

<a name="description"></a>

# Description

The
**kcmp**()
system call can be used to check whether the two processes identified by
_pid1_
and
_pid2_
share a kernel resource such as virtual memory, file descriptors,
and so on.

Permission to employ
**kcmp**()
is governed by ptrace access mode
**PTRACE_MODE_READ_REALCREDS**
checks against both
_pid1_
and
_pid2_;
see
**ptrace**(2).

The
_type_
argument specifies which resource is to be compared in the two processes.
It has one of the following values:

* **KCMP_FILE**  
  Check whether a file descriptor
  _idx1_
  in the process
  _pid1_
  refers to the same open file description (see
  **open**(2))
  as file descriptor
  _idx2_
  in the process
  _pid2_.
  The existence of two file descriptors that refer to the same
  open file description can occur as a result of
  **dup**(2)
  (and similar)
  **fork**(2),
  or passing file descriptors via a domain socket (see
  **unix**(7)).
* **KCMP_FILES**  
  Check whether the processes share the same set of open file descriptors.
  The arguments
  _idx1_
  and
  _idx2_
  are ignored.
  See the discussion of the
  **CLONE_FILES**
  flag in
  **clone**(2).
* **KCMP_FS**  
  Check whether the processes share the same filesystem information
  (i.e., file mode creation mask, working directory, and filesystem root).
  The arguments
  _idx1_
  and
  _idx2_
  are ignored.
  See the discussion of the
  **CLONE_FS**
  flag in
  **clone**(2).
* **KCMP_IO**  
  Check whether the processes share I/O context.
  The arguments
  _idx1_
  and
  _idx2_
  are ignored.
  See the discussion of the
  **CLONE_IO**
  flag in
  **clone**(2).
* **KCMP_SIGHAND**  
  Check whether the processes share the same table of signal dispositions.
  The arguments
  _idx1_
  and
  _idx2_
  are ignored.
  See the discussion of the
  **CLONE_SIGHAND**
  flag in
  **clone**(2).
* **KCMP_SYSVSEM**  
  Check whether the processes share the same
  list of System&nbsp;V semaphore undo operations.
  The arguments
  _idx1_
  and
  _idx2_
  are ignored.
  See the discussion of the
  **CLONE_SYSVSEM**
  flag in
  **clone**(2).
* **KCMP_VM**  
  Check whether the processes share the same address space.
  The arguments
  _idx1_
  and
  _idx2_
  are ignored.
  See the discussion of the
  **CLONE_VM**
  flag in
  **clone**(2).
* **KCMP_EPOLL_TFD** (since Linux 4.13)  
  
  Check whether the file descriptor
  _idx1_
  of the process
  _pid1_
  is present in the
  **epoll**(7)
  instance described by
  _idx2_
  of the process
  _pid2_.
  The argument
  _idx2_
  is a pointer to a structure where the target file is described.
  This structure has the form:

.in +4n
.EX
struct kcmp_epoll_slot {
    __u32 efd;
    __u32 tfd;
    __u64 toff;
};
.EE
.in

Within this structure,
_efd_
is an epoll file descriptor returned from
**epoll_create**(2),
_tfd_
is a target file descriptor number, and
_toff_
is a target file offset counted from zero.
Several different targets may be registered with
the same file descriptor number and setting a specific
offset helps to investigate each of them.

Note the
**kcmp**()
is not protected against false positives which may occur if
the processes are currently running.
One should stop the processes by sending
**SIGSTOP**
(see
**signal**(7))
prior to inspection with this system call to obtain meaningful results.

<a name="return-value"></a>

# Return Value

The return value of a successful call to
**kcmp**()
is simply the result of arithmetic comparison
of kernel pointers (when the kernel compares resources, it uses their
memory addresses).

The easiest way to explain is to consider an example.
Suppose that
_v1_
and
_v2_
are the addresses of appropriate resources, then the return value
is one of the following:

* 0  
  _v1_
  is equal to
  _v2_;
  in other words, the two processes share the resource.
* 1  
  _v1_
  is less than
  _v2_.
* 2  
  _v1_
  is greater than
  _v2_.
* 3  
  _v1_
  is not equal to
  _v2_,
  but ordering information is unavailable.

On error, -1 is returned, and
_errno_
is set appropriately.

**kcmp**()
was designed to return values suitable for sorting.
This is particularly handy if one needs to compare
a large number of file descriptors.

<a name="errors"></a>

# Errors


* **EBADF**  
  _type_
  is
  **KCMP_FILE**
  and
  _fd1_
  or
  _fd2_
  is not an open file descriptor.
* **EINVAL**  
  _type_
  is invalid.
* **EPERM**  
  Insufficient permission to inspect process resources.
  The
  **CAP_SYS_PTRACE**
  capability is required to inspect processes that you do not own.
  Other ptrace limitations may also apply, such as
  **CONFIG_SECURITY_YAMA**,
  which, when
  _/proc/sys/kernel/yama/ptrace_scope_
  is 2, limits
  **kcmp**()
  to child processes;
  see
  **ptrace**(2).
* **ESRCH**  
  Process
  _pid1_
  or
  _pid2_
  does not exist.
* **EFAULT**  
  The epoll slot addressed by
  _idx2_
  is outside of the user's address space.
* **ENOENT**  
  The target file is not present in
  **epoll**(7)
  instance.

<a name="versions"></a>

# Versions

The
**kcmp**()
system call first appeared in Linux 3.5.

<a name="conforming-to"></a>

# Conforming to

**kcmp**()
is Linux-specific and should not be used in programs intended to be portable.

<a name="notes"></a>

# Notes

Glibc does not provide a wrapper for this system call; call it using
**syscall**(2).

This system call is available only if the kernel was configured with
**CONFIG_CHECKPOINT_RESTORE**.
The main use of the system call is for the
checkpoint/restore in user space (CRIU) feature.
The alternative to this system call would have been to expose suitable
process information via the
**proc**(5)
filesystem; this was deemed to be unsuitable for security reasons.

See
**clone**(2)
for some background information on the shared resources
referred to on this page.

<a name="example"></a>

# Example

The program below uses
**kcmp**()
to test whether pairs of file descriptors refer to
the same open file description.
The program tests different cases for the file descriptor pairs,
as described in the program output.
An example run of the program is as follows:

.in +4n
.EX
$ **./a.out**
Parent PID is 1144
Parent opened file on FD 3

PID of child of fork() is 1145
	Compare duplicate FDs from different processes:
		kcmp(1145, 1144, KCMP_FILE, 3, 3) ==&gt; same
Child opened file on FD 4
	Compare FDs from distinct open()s in same process:
		kcmp(1145, 1145, KCMP_FILE, 3, 4) ==&gt; different
Child duplicated FD 3 to create FD 5
	Compare duplicated FDs in same process:
		kcmp(1145, 1145, KCMP_FILE, 3, 5) ==&gt; same
.EE
.in

<a name="program-source"></a>

### Program source


.EX
#define _GNU_SOURCE
#include &lt;sys/syscall.h&gt;
#include &lt;sys/wait.h&gt;
#include &lt;sys/stat.h&gt;
#include &lt;stdlib.h&gt;
#include &lt;stdio.h&gt;
#include &lt;unistd.h&gt;
#include &lt;fcntl.h&gt;
#include &lt;linux/kcmp.h&gt;

#define errExit(msg)    do { perror(msg); exit(EXIT_FAILURE); &nbsp;                       } while (0)

static int
kcmp(pid_t pid1, pid_t pid2, int type,
     unsigned long idx1, unsigned long idx2)
{
    return syscall(SYS_kcmp, pid1, pid2, type, idx1, idx2);
}

static void
test_kcmp(char *msg, id_t pid1, pid_t pid2, int fd_a, int fd_b)
{
    printf("\\t%s\\n", msg);
    printf("\\t\\tkcmp(%ld, %ld, KCMP_FILE, %d, %d) ==&gt; %s\\n",
            (long) pid1, (long) pid2, fd_a, fd_b,
            (kcmp(pid1, pid2, KCMP_FILE, fd_a, fd_b) == 0) ?
                        "same" : "different");
}

int
main(int argc, char *argv[])
{
    int fd1, fd2, fd3;
    char pathname[] = "/tmp/kcmp.test";

    fd1 = open(pathname, O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);
    if (fd1 == -1)
        errExit("open");

    printf("Parent PID is %ld\\n", (long) getpid());
    printf("Parent opened file on FD %d\\n\\n", fd1);

    switch (fork()) {
    case -1:
        errExit("fork");

    case 0:
        printf("PID of child of fork() is %ld\\n", (long) getpid());

        test_kcmp("Compare duplicate FDs from different processes:",
                getpid(), getppid(), fd1, fd1);

        fd2 = open(pathname, O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);
        if (fd2 == -1)
            errExit("open");
        printf("Child opened file on FD %d\\n", fd2);

        test_kcmp("Compare FDs from distinct open()s in same process:",
                getpid(), getpid(), fd1, fd2);

        fd3 = dup(fd1);
        if (fd3 == -1)
            errExit("dup");
        printf("Child duplicated FD %d to create FD %d\\n", fd1, fd3);

        test_kcmp("Compare duplicated FDs in same process:",
                getpid(), getpid(), fd1, fd3);
        break;

    default:
        wait(NULL);
    }

    exit(EXIT_SUCCESS);
}
.EE

<a name="see-also"></a>

# See Also

**clone**(2),
**unshare**(2)

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
