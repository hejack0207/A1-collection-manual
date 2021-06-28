# syscalls(2) - Linux system calls

Linux, 2018-02-02

```
Linux system calls.
```

<a name="description"></a>

# Description

The system call is the fundamental interface between an application
and the Linux kernel.

<a name="system-calls-and-library-wrapper-functions"></a>

### System calls and library wrapper functions

System calls are generally not invoked directly,
but rather via wrapper functions in glibc (or perhaps some other library).
For details of direct invocation of a system call, see
**intro**(2).
Often, but not always, the name of the wrapper function is the same
as the name of the system call that it invokes.
For example, glibc contains a function
**truncate**()
which invokes the underlying "truncate" system call.

Often the glibc wrapper function is quite thin, doing little work
other than copying arguments to the right registers
before invoking the system call,
and then setting
_errno_
appropriately after the system call has returned.
(These are the same steps that are performed by
**syscall**(2),
which can be used to invoke system calls
for which no wrapper function is provided.)
Note: system calls indicate a failure by returning a negative error
number to the caller;
when this happens,
the wrapper function negates the returned error number
(to make it positive), copies it to
_errno_,
and returns -1 to the caller of the wrapper.

Sometimes, however, the wrapper function does some extra work
before invoking the system call.
For example, nowadays there are (for reasons described below) two
related system calls,
**truncate**(2)
and
**truncate64**(2),
and the glibc
**truncate**()
wrapper function checks which of those system calls
are provided by the kernel and determines which should be employed.

<a name="system-call-list"></a>

### System call list

Below is a list of the Linux system calls.
In the list, the
_Kernel_
column indicates the kernel version
for those system calls that were new in Linux 2.2,
or have appeared since that kernel version.
Note the following points:

* *  
  Where no kernel version is indicated,
  the system call appeared in kernel 1.0 or earlier.
* *  
  Where a system call is marked "1.2"
  this means the system call probably appeared in a 1.1.x kernel version,
  and first appeared in a stable kernel with 1.2.
  (Development of the 1.2 kernel was initiated from a branch of kernel
  1.0.6 via the 1.1.x unstable kernel series.)
* *  
  Where a system call is marked "2.0"
  this means the system call probably appeared in a 1.3.x kernel version,
  and first appeared in a stable kernel with 2.0.
  (Development of the 2.0 kernel was initiated from a branch of kernel
  1.2.x, somewhere around 1.2.10,
  via the 1.3.x unstable kernel series.)
  
  
  
  
  
  
  
  
  
* *  
  Where a system call is marked "2.2"
  this means the system call probably appeared in a 2.1.x kernel version,
  and first appeared in a stable kernel with 2.2.0.
  (Development of the 2.2 kernel was initiated from a branch of kernel
  2.0.21 via the 2.1.x unstable kernel series.)
* *  
  Where a system call is marked "2.4"
  this means the system call probably appeared in a 2.3.x kernel version,
  and first appeared in a stable kernel with 2.4.0.
  (Development of the 2.4 kernel was initiated from a branch of
  kernel 2.2.8 via the 2.3.x unstable kernel series.)
* *  
  Where a system call is marked "2.6"
  this means the system call probably appeared in a 2.5.x kernel version,
  and first appeared in a stable kernel with 2.6.0.
  (Development of kernel 2.6 was initiated from a branch
  of kernel 2.4.15 via the 2.5.x unstable kernel series.)
* *  
  Starting with kernel 2.6.0, the development model changed,
  and new system calls may appear in each 2.6.x release.
  In this case, the exact version number where the system call appeared
  is shown.
  This convention continues with the 3.x kernel series,
  which followed on from kernel 2.6.39, and the 4.x kernel series,
  which followed on from kernel 3.19.
* *  
  In some cases, a system call was added to a stable kernel
  series after it branched from the previous stable kernel
  series, and then backported into the earlier stable kernel series.
  For example some system calls that appeared in 2.6.x were also backported
  into a 2.4.x release after 2.4.15.
  When this is so, the version where the system call appeared
  in both of the major kernel series is listed.

The list of system calls that are available as at kernel 4.11
(or in a few cases only on older kernels) is as follows:




.TS
l2 le l
---
l l l.
**System call**	**Kernel**	**Notes**

**\_llseek**(2)	1.2
**\_newselect**(2)	2.0
**\_sysctl**(2)	2.0
**accept**(2)	2.0	See notes on **socketcall**(2)
**accept4**(2)	2.6.28
**access**(2)	1.0
**acct**(2)	1.0
**add\_key**(2)	2.6.10
**adjtimex**(2)	1.0
**alarm**(2)	1.0
**alloc\_hugepages**(2)	2.5.36	Removed in 2.5.44
**bdflush**(2)	1.2	T{
Deprecated (does nothing)  
since 2.6
T}
**bind**(2)	2.0	See notes on **socketcall**(2)
**bpf**(2)	3.18
**brk**(2)	1.0
**cacheflush**(2)	1.2	Not on x86
**capget**(2)	2.2
**capset**(2)	2.2
**chdir**(2)	1.0
**chmod**(2)	1.0
**chown**(2)	2.2	T{
See **chown**(2) for  
version details
T}
**chown32**(2)	2.4
**chroot**(2)	1.0
**clock\_adjtime**(2)	2.6.39
**clock\_getres**(2)	2.6
**clock\_gettime**(2)	2.6
**clock\_nanosleep**(2)	2.6
**clock\_settime**(2)	2.6
**clone**(2)	1.0
**close**(2)	1.0
**connect**(2)	2.0	See notes on **socketcall**(2)
**copy\_file\_range**(2)	4.5
**creat**(2)	1.0
**create\_module**(2)	1.0	Removed in 2.6
**delete\_module**(2)	1.0
**dup**(2)	1.0
**dup2**(2)	1.0
**dup3**(2)	2.6.27
**epoll\_create**(2)	2.6
**epoll\_create1**(2)	2.6.27
**epoll\_ctl**(2)	2.6
**epoll\_pwait**(2)	2.6.19
**epoll\_wait**(2)	2.6
**eventfd**(2)	2.6.22
**eventfd2**(2)	2.6.27
**execve**(2)	1.0
**execveat**(2)	3.19
**exit**(2)	1.0
**exit\_group**(2)	2.6
**faccessat**(2)	2.6.16
**fadvise64**(2)	2.6

**fadvise64\_64**(2)	2.6
**fallocate**(2)	2.6.23
**fanotify\_init**(2)	2.6.37
**fanotify\_mark**(2)	2.6.37


**fchdir**(2)	1.0
**fchmod**(2)	1.0
**fchmodat**(2)	2.6.16
**fchown**(2)	1.0
**fchown32**(2)	2.4
**fchownat**(2)	2.6.16
**fcntl**(2)	1.0
**fcntl64**(2)	2.4
**fdatasync**(2)	2.0
**fgetxattr**(2)	2.6; 2.4.18
**finit\_module**(2)	3.8
**flistxattr**(2)	2.6; 2.4.18
**flock**(2)	2.0
**fork**(2)	1.0
**free\_hugepages**(2)	2.5.36	Removed in 2.5.44
**fremovexattr**(2)	2.6; 2.4.18
**fsetxattr**(2)	2.6; 2.4.18
**fstat**(2)	1.0
**fstat64**(2)	2.4
**fstatat64**(2)	2.6.16
**fstatfs**(2)	1.0
**fstatfs64**(2)	2.6
**fsync**(2)	1.0
**ftruncate**(2)	1.0
**ftruncate64**(2)	2.4
**futex**(2)	2.6
**futimesat**(2)	2.6.16
**get\_kernel\_syms**(2)	1.0	Removed in 2.6
**get\_mempolicy**(2)	2.6.6
**get\_robust\_list**(2)	2.6.17
**get\_thread\_area**(2)	2.6
**getcpu**(2)	2.6.19
**getcwd**(2)	2.2
**getdents**(2)	2.0
**getdents64**(2)	2.4
**getegid**(2)	1.0
**getegid32**(2)	2.4
**geteuid**(2)	1.0
**geteuid32**(2)	2.4
**getgid**(2)	1.0
**getgid32**(2)	2.4
**getgroups**(2)	1.0
**getgroups32**(2)	2.4
**getitimer**(2)	1.0
**getpeername**(2)	2.0	See notes on **socketcall**(2)
**getpagesize**(2)	2.0	Not on x86
**getpgid**(2)	1.0
**getpgrp**(2)	1.0
**getpid**(2)	1.0
**getppid**(2)	1.0
**getpriority**(2)	1.0
**getrandom**(2)	3.17
**getresgid**(2)	2.2
**getresgid32**(2)	2.4
**getresuid**(2)	2.2
**getresuid32**(2)	2.4
**getrlimit**(2)	1.0
**getrusage**(2)	1.0
**getsid**(2)	2.0
**getsockname**(2)	2.0	See notes on **socketcall**(2)
**getsockopt**(2)	2.0	See notes on **socketcall**(2)
**gettid**(2)	2.4.11
**gettimeofday**(2)	1.0
**getuid**(2)	1.0
**getuid32**(2)	2.4
**getunwind**(2)	2.4.8	ia64; deprecated
**getxattr**(2)	2.6; 2.4.18
**init\_module**(2)	1.0
**inotify\_add\_watch**(2)	2.6.13
**inotify\_init**(2)	2.6.13
**inotify\_init1**(2)	2.6.27
**inotify\_rm\_watch**(2)	2.6.13
**io\_cancel**(2)	2.6
**io\_destroy**(2)	2.6
**io\_getevents**(2)	2.6
**io\_setup**(2)	2.6
**io\_submit**(2)	2.6
**ioctl**(2)	1.0
**ioperm**(2)	1.0
**iopl**(2)	1.0
**ioprio\_get**(2)	2.6.13
**ioprio\_set**(2)	2.6.13
**ipc**(2)	1.0

**kcmp**(2)	3.5
**kern\_features**(2)	3.7	Sparc64


**kexec\_file\_load**(2)	3.17
**kexec\_load**(2)	2.6.13


**keyctl**(2)	2.6.10
**kill**(2)	1.0
**lchown**(2)	1.0	T{
See **chown**(2) for  
version details
T}
**lchown32**(2)	2.4
**lgetxattr**(2)	2.6; 2.4.18
**link**(2)	1.0
**linkat**(2)	2.6.16
**listen**(2)	2.0	See notes on **socketcall**(2)
**listxattr**(2)	2.6; 2.4.18
**llistxattr**(2)	2.6; 2.4.18
**lookup\_dcookie**(2)	2.6
**lremovexattr**(2)	2.6; 2.4.18
**lseek**(2)	1.0
**lsetxattr**(2)	2.6; 2.4.18
**lstat**(2)	1.0
**lstat64**(2)	2.4
**madvise**(2)	2.4
**mbind**(2)	2.6.6

**membarrier**(2)	3.17
**memfd\_create**(2)	3.17
**migrate\_pages**(2)	2.6.16
**mincore**(2)	2.4
**mkdir**(2)	1.0
**mkdirat**(2)	2.6.16
**mknod**(2)	1.0
**mknodat**(2)	2.6.16
**mlock**(2)	2.0
**mlock2**(2)	4.4
**mlockall**(2)	2.0
**mmap**(2)	1.0
**mmap2**(2)	2.4
**modify\_ldt**(2)	1.0
**mount**(2)	1.0
**move\_pages**(2)	2.6.18
**mprotect**(2)	1.0
**mq\_getsetattr**(2)	2.6.6

**mq\_notify**(2)	2.6.6
**mq\_open**(2)	2.6.6
**mq\_timedreceive**(2)	2.6.6
**mq\_timedsend**(2)	2.6.6
**mq\_unlink**(2)	2.6.6
**mremap**(2)	2.0
**msgctl**(2)	2.0	See notes on **ipc**(2)
**msgget**(2)	2.0	See notes on **ipc**(2)
**msgrcv**(2)	2.0	See notes on **ipc**(2)
**msgsnd**(2)	2.0	See notes on **ipc**(2)
**msync**(2)	2.0


**munlock**(2)	2.0
**munlockall**(2)	2.0
**munmap**(2)	1.0
**name\_to\_handle\_at**(2)	2.6.39
**nanosleep**(2)	2.0
**nfsservctl**(2)	2.2	Removed in 3.1
**nice**(2)	1.0
**oldfstat**(2)	1.0
**oldlstat**(2)	1.0
**oldolduname**(2)	1.0
**oldstat**(2)	1.0
**olduname**(2)	1.0
**open**(2)	1.0
**open\_by\_handle\_at**(2)	2.6.39
**openat**(2)	2.6.16
**pause**(2)	1.0
**pciconfig\_iobase**(2)	2.2.15; 2.4	Not on x86

**pciconfig\_read**(2)	2.0.26; 2.2	Not on x86

**pciconfig\_write**(2)	2.0.26; 2.2	Not on x86

**perf\_event\_open**(2)	2.6.31	T{
Was perf_counter_open() in  
2.6.31; renamed in 2.6.32
T}
**personality**(2)	1.2
**perfctr**(2)	2.2	Sparc; removed in 2.6.34

**perfmonctl**(2)	2.4	ia64
**pipe**(2)	1.0
**pipe2**(2)	2.6.27
**pivot\_root**(2)	2.4
**pkey\_alloc**(2)	4.8
**pkey\_free**(2)	4.8
**pkey\_mprotect**(2)	4.8
**poll**(2)	2.0.36; 2.2
**ppc\_rtas**(2)	2.6.2	PowerPC only
**ppc\_swapcontext**(2)	2.6.3	PowerPC only
**ppoll**(2)	2.6.16
**prctl**(2)	2.2
**pread64**(2)		T{
Added as "pread" in 2.2;  
renamed "pread64" in 2.6
T}
**preadv**(2)	2.6.30
**preadv2**(2)	4.6
**prlimit64**(2)	2.6.36
**process\_vm\_readv**(2)	3.2
**process\_vm\_writev**(2)	3.2
**pselect6**(2)	2.6.16

**ptrace**(2)	1.0
**pwrite64**(2)		T{
Added as "pwrite" in 2.2;  
renamed "pwrite64" in 2.6
T}
**pwritev**(2)	2.6.30
**pwritev2**(2)	4.6
**query\_module**(2)	2.2	Removed in 2.6
**quotactl**(2)	1.0
**read**(2)	1.0
**readahead**(2)	2.4.13
**readdir**(2)	1.0

**readlink**(2)	1.0
**readlinkat**(2)	2.6.16
**readv**(2)	2.0
**reboot**(2)	1.0
**recv**(2)	2.0	See notes on **socketcall**(2)
**recvfrom**(2)	2.0	See notes on **socketcall**(2)
**recvmsg**(2)	2.0	See notes on **socketcall**(2)
**recvmmsg**(2)	2.6.33
**remap\_file\_pages**(2)	2.6	Deprecated since 3.16
**removexattr**(2)	2.6; 2.4.18
**rename**(2)	1.0
**renameat**(2)	2.6.16
**renameat2**(2)	3.15
**request\_key**(2)	2.6.10
**restart\_syscall**(2)	2.6
**rmdir**(2)	1.0
**rt\_sigaction**(2)	2.2
**rt\_sigpending**(2)	2.2
**rt\_sigprocmask**(2)	2.2
**rt\_sigqueueinfo**(2)	2.2
**rt\_sigreturn**(2)	2.2
**rt\_sigsuspend**(2)	2.2
**rt\_sigtimedwait**(2)	2.2
**rt\_tgsigqueueinfo**(2)	2.6.31
**s390\_runtime\_instr**(2)	3.7	s390 only
**s390\_pci\_mmio\_read**(2)	3.19	s390 only
**s390\_pci\_mmio\_write**(2)	3.19	s390 only
**s390\_sthyi**(2)	4.15	s390 only
**sched\_get\_priority\_max**(2)	2.0
**sched\_get\_priority\_min**(2)	2.0
**sched\_getaffinity**(2)	2.6
**sched\_getattr**(2)	3.14
**sched\_getparam**(2)	2.0
**sched\_getscheduler**(2)	2.0
**sched\_rr\_get\_interval**(2)	2.0
**sched\_setaffinity**(2)	2.6
**sched\_setattr**(2)	3.14
**sched\_setparam**(2)	2.0
**sched\_setscheduler**(2)	2.0
**sched\_yield**(2)	2.0
**seccomp**(2)	3.17
**select**(2)	1.0
**semctl**(2)	2.0	See notes on **ipc**(2)
**semget**(2)	2.0	See notes on **ipc**(2)
**semop**(2)	2.0	See notes on **ipc**(2)
**semtimedop**(2)	2.6; 2.4.22
**send**(2)	2.0	See notes on **socketcall**(2)
**sendfile**(2)	2.2
**sendfile64**(2)	2.6; 2.4.19
**sendmmsg**(2)	3.0
**sendmsg**(2)	2.0	See notes on **socketcall**(2)
**sendto**(2)	2.0	See notes on **socketcall**(2)
**set\_mempolicy**(2)	2.6.6
**set\_robust\_list**(2)	2.6.17
**set\_thread\_area**(2)	2.6
**set\_tid\_address**(2)	2.6


**setdomainname**(2)	1.0
**setfsgid**(2)	1.2
**setfsgid32**(2)	2.4
**setfsuid**(2)	1.2
**setfsuid32**(2)	2.4
**setgid**(2)	1.0
**setgid32**(2)	2.4
**setgroups**(2)	1.0
**setgroups32**(2)	2.4
**sethostname**(2)	1.0
**setitimer**(2)	1.0
**setns**(2)	3.0
**setpgid**(2)	1.0
**setpriority**(2)	1.0
**setregid**(2)	1.0
**setregid32**(2)	2.4
**setresgid**(2)	2.2
**setresgid32**(2)	2.4
**setresuid**(2)	2.2
**setresuid32**(2)	2.4
**setreuid**(2)	1.0
**setreuid32**(2)	2.4
**setrlimit**(2)	1.0
**setsid**(2)	1.0
**setsockopt**(2)	2.0	See notes on **socketcall**(2)
**settimeofday**(2)	1.0
**setuid**(2)	1.0
**setuid32**(2)	2.4
**setup**(2)	1.0	Removed in 2.2
**setxattr**(2)	2.6; 2.4.18
**sgetmask**(2)	1.0
**shmat**(2)	2.0	See notes on **ipc**(2)
**shmctl**(2)	2.0	See notes on **ipc**(2)
**shmdt**(2)	2.0	See notes on **ipc**(2)
**shmget**(2)	2.0	See notes on **ipc**(2)
**shutdown**(2)	2.0	See notes on **socketcall**(2)
**sigaction**(2)	1.0
**sigaltstack**(2)	2.2
**signal**(2)	1.0
**signalfd**(2)	2.6.22
**signalfd4**(2)	2.6.27
**sigpending**(2)	1.0
**sigprocmask**(2)	1.0
**sigreturn**(2)	1.0
**sigsuspend**(2)	1.0
**socket**(2)	2.0	See notes on **socketcall**(2)
**socketcall**(2)	1.0

**socketpair**(2)	2.0	See notes on **socketcall**(2)
**splice**(2)	2.6.17
**spu\_create**(2)	2.6.16	PowerPC only
**spu\_run**(2)	2.6.16	PowerPC only
**ssetmask**(2)	1.0
**stat**(2)	1.0
**stat64**(2)	2.4
**statfs**(2)	1.0
**statfs64**(2)	2.6
**statx**(2)	4.11
**stime**(2)	1.0
**subpage\_prot**(2)	2.6.25	PowerPC only
**swapoff**(2)	1.0
**swapon**(2)	1.0
**symlink**(2)	1.0
**symlinkat**(2)	2.6.16
**sync**(2)	1.0
**sync\_file\_range**(2)	2.6.17
**sync\_file\_range2**(2)	2.6.22



**syncfs**(2)	2.6.39
**sysfs**(2)	1.2
**sysinfo**(2)	1.0
**syslog**(2)	1.0

**tee**(2)	2.6.17
**tgkill**(2)	2.6
**time**(2)	1.0
**timer\_create**(2)	2.6
**timer\_delete**(2)	2.6
**timer\_getoverrun**(2)	2.6
**timer\_gettime**(2)	2.6
**timer\_settime**(2)	2.6
**timerfd\_create**(2)	2.6.25
**timerfd\_gettime**(2)	2.6.25
**timerfd\_settime**(2)	2.6.25
**times**(2)	1.0
**tkill**(2)	2.6; 2.4.22
**truncate**(2)	1.0
**truncate64**(2)	2.4
**ugetrlimit**(2)	2.4
**umask**(2)	1.0
**umount**(2)	1.0

**umount2**(2)	2.2

**uname**(2)	1.0
**unlink**(2)	1.0
**unlinkat**(2)	2.6.16
**unshare**(2)	2.6.16
**uselib**(2)	1.0
**ustat**(2)	1.0
**userfaultfd**(2)	4.3
**utime**(2)	1.0
**utimensat**(2)	2.6.22
**utimes**(2)	2.2
**utrap\_install**(2)	2.2	Sparc only


**vfork**(2)	2.2
**vhangup**(2)	1.0
**vm86old**(2)	1.0	T{
Was "vm86"; renamed in
2.0.28/2.2
T}
**vm86**(2)	2.0.28; 2.2
**vmsplice**(2)	2.6.17
**wait4**(2)	1.0
**waitid**(2)	2.6.10
**waitpid**(2)	1.0
**write**(2)	1.0
**writev**(2)	2.0
.TE

On many platforms, including x86-32, socket calls are all multiplexed
(via glibc wrapper functions) through
**socketcall**(2)
and similarly System&nbsp;V IPC calls are multiplexed through
**ipc**(2).

Although slots are reserved for them in the system call table,
the following system calls are not implemented in the standard kernel:
**afs_syscall**(2),
**break**(2),
**ftime**(2),
**getpmsg**(2),
**gtty**(2),
**idle**(2),
**lock**(2),
**madvise1**(2),
**mpx**(2),
**phys**(2),
**prof**(2),
**profil**(2),
**putpmsg**(2),


**security**(2),

**stty**(2),
**tuxcall**(2),
**ulimit**(2),
and
**vserver**(2)
(see also
**unimplemented**(2)).
However,
**ftime**(3),
**profil**(3),
and
**ulimit**(3)
exist as library routines.
The slot for
**phys**(2)
is in use since kernel 2.1.116 for
**umount**(2);
**phys**(2)
will never be implemented.
The
**getpmsg**(2)
and
**putpmsg**(2)
calls are for kernels patched to support STREAMS,
and may never be in the standard kernel.

There was briefly
**set_zone_reclaim**(2),
added in Linux 2.6.13, and removed in 2.6.16;
this system call was never available to user space.

<a name="notes"></a>

# Notes


Roughly speaking, the code belonging to the system call
with number __NR_xxx defined in
_/usr/include/asm/unistd.h_
can be found in the Linux kernel source in the routine
_sys_xxx_().
(The dispatch table for i386 can be found in
_/usr/src/linux/arch/i386/kernel/entry.S_.)
There are many exceptions, however, mostly because
older system calls were superseded by newer ones,
and this has been treated somewhat unsystematically.
On platforms with
proprietary operating-system emulation,
such as parisc, sparc, sparc64, and alpha,
there are many additional system calls; mips64 also contains a full
set of 32-bit system calls.

Over time, changes to the interfaces of some system calls have been
necessary.
One reason for such changes was the need to increase the size of
structures or scalar values passed to the system call.
Because of these changes, certain architectures
(notably, longstanding 32-bit architectures such as i386)
now have various groups of related system calls (e.g.,
**truncate**(2)
and
**truncate64**(2))
which perform similar tasks, but which vary in
details such as the size of their arguments.
(As noted earlier, applications are generally unaware of this:
the glibc wrapper functions do some work to ensure that the right
system call is invoked, and that ABI compatibility is
preserved for old binaries.)
Examples of systems calls that exist in multiple versions are
the following:

* *  
  By now there are three different versions of
  **stat**(2):
  _sys_stat_()
  (slot
  ___NR_oldstat_),
  _sys_newstat_()
  (slot
  ___NR_stat_),
  and
  _sys_stat64_()
  (slot
  ___NR_stat64_),
  with the last being the most current.
  
  
  
  A similar story applies for
  **lstat**(2)
  and
  **fstat**(2).
* *  
  Similarly, the defines
  ___NR_oldolduname_,
  ___NR_olduname_,
  and
  ___NR_uname_
  refer to the routines
  _sys_olduname_(),
  _sys_uname_()
  and
  _sys_newuname_().
* *  
  In Linux 2.0, a new version of
  **vm86**(2)
  appeared, with the old and the new kernel routines being named
  _sys_vm86old_()
  and
  _sys_vm86_().
* *  
  In Linux 2.4, a new version of
  **getrlimit**(2)
  appeared, with the old and the new kernel routines being named
  _sys_old_getrlimit_()
  (slot
  ___NR_getrlimit_)
  and
  _sys_getrlimit_()
  (slot
  ___NR_ugetrlimit_).
* *  
  Linux 2.4 increased the size of user and group IDs from 16 to 32 bits.
  
  
  To support this change, a range of system calls were added
  (e.g.,
  **chown32**(2),
  **getuid32**(2),
  **getgroups32**(2),
  **setresuid32**(2)),
  superseding earlier calls of the same name without the
  "32" suffix.
* *  
  Linux 2.4 added support for applications on 32-bit architectures
  to access large files (i.e., files for which the sizes and
  file offsets can't be represented in 32 bits.)
  To support this change, replacements were required for system calls
  that deal with file offsets and sizes.
  Thus the following system calls were added:
  **fcntl64**(2),
  **getdents64**(2),
  **stat64**(2),
  **statfs64**(2),
  **truncate64**(2),
  and their analogs that work with file descriptors or
  symbolic links.
  These system calls supersede the older system calls
  which, except in the case of the "stat" calls,
  have the same name without the "64" suffix.
* On newer platforms that only have 64-bit file access and 32-bit UIDs/GIDs
  (e.g., alpha, ia64, s390x, x86-64), there is just a single version of
  the UID/GID and file access system calls.
  On platforms (typically, 32-bit platforms) where the *64 and *32 calls exist,
  the other versions are obsolete.
* *  
  The
  _rt_sig*_
  calls were added in kernel 2.2 to support the addition
  of real-time signals (see
  **signal**(7)).
  These system calls supersede the older system calls of the same
  name without the "rt_" prefix.
* *  
  The
  **select**(2)
  and
  **mmap**(2)
  system calls use five or more arguments,
  which caused problems in the way
  argument passing on the i386 used to be set up.
  Thus, while other architectures have
  _sys_select_()
  and
  _sys_mmap_()
  corresponding to
  ___NR_select_
  and
  ___NR_mmap_,
  on i386 one finds
  _old_select_()
  and
  _old_mmap_()
  (routines that use a pointer to an
  argument block) instead.
  These days passing five arguments
  is not a problem any more, and there is a
  ___NR__newselect_
  
  that corresponds directly to
  _sys_select_()
  and similarly
  ___NR_mmap2_.
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  

<a name="see-also"></a>

# See Also

**intro**(2),
**syscall**(2),
**unimplemented**(2),
**errno**(3),
**libc**(7),
**vdso**(7)

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
