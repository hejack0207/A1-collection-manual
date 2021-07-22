# namespaces(7) - overview of Linux namespaces

Linux, 2018-02-02


<a name="description"></a>

# Description

A namespace wraps a global system resource in an abstraction that
makes it appear to the processes within the namespace that they
have their own isolated instance of the global resource.
Changes to the global resource are visible to other processes
that are members of the namespace, but are invisible to other processes.
One use of namespaces is to implement containers.

Linux provides the following namespaces:
.TS
lB lB lB
l lB l.
Namespace	Constant	Isolates
Cgroup	CLONE_NEWCGROUP	Cgroup root directory
IPC	CLONE_NEWIPC	System V IPC, POSIX message queues
Network	CLONE_NEWNET	Network devices, stacks, ports, etc.
Mount	CLONE_NEWNS	Mount points
PID	CLONE_NEWPID	Process IDs
User	CLONE_NEWUSER	User and group IDs
UTS	CLONE_NEWUTS	Hostname and NIS domain name
.TE

This page describes the various namespaces and the associated
_/proc_
files, and summarizes the APIs for working with namespaces.




<a name="the-namespaces-api"></a>

### The namespaces API

As well as various
_/proc_
files described below,
the namespaces API includes the following system calls:

* **clone**(2)  
  The
  **clone**(2)
  system call creates a new process.
  If the
  _flags_
  argument of the call specifies one or more of the
  **CLONE_NEW***
  flags listed below, then new namespaces are created for each flag,
  and the child process is made a member of those namespaces.
  (This system call also implements a number of features
  unrelated to namespaces.)
* **setns**(2)  
  The
  **setns**(2)
  system call allows the calling process to join an existing namespace.
  The namespace to join is specified via a file descriptor that refers to
  one of the
  _/proc/[pid]/ns_
  files described below.
* **unshare**(2)  
  The
  **unshare**(2)
  system call moves the calling process to a new namespace.
  If the
  _flags_
  argument of the call specifies one or more of the
  **CLONE_NEW***
  flags listed below, then new namespaces are created for each flag,
  and the calling process is made a member of those namespaces.
  (This system call also implements a number of features
  unrelated to namespaces.)

Creation of new namespaces using
**clone**(2)
and
**unshare**(2)
in most cases requires the
**CAP_SYS_ADMIN**
capability.
User namespaces are the exception: since Linux 3.8,
no privilege is required to create a user namespace.




<a name="the-procpidns-directory"></a>

### The /proc/[pid]/ns/ directory

Each process has a
_/proc/[pid]/ns/_

subdirectory containing one entry for each namespace that
supports being manipulated by
**setns**(2):

.in +4n
.EX
$ **ls -l /proc/$$/ns**
total 0
lrwxrwxrwx. 1 mtk mtk 0 Apr 28 12:46 cgroup -&gt; cgroup:[4026531835]
lrwxrwxrwx. 1 mtk mtk 0 Apr 28 12:46 ipc -&gt; ipc:[4026531839]
lrwxrwxrwx. 1 mtk mtk 0 Apr 28 12:46 mnt -&gt; mnt:[4026531840]
lrwxrwxrwx. 1 mtk mtk 0 Apr 28 12:46 net -&gt; net:[4026531969]
lrwxrwxrwx. 1 mtk mtk 0 Apr 28 12:46 pid -&gt; pid:[4026531836]
lrwxrwxrwx. 1 mtk mtk 0 Apr 28 12:46 pid_for_children -&gt; pid:[4026531834]
lrwxrwxrwx. 1 mtk mtk 0 Apr 28 12:46 user -&gt; user:[4026531837]
lrwxrwxrwx. 1 mtk mtk 0 Apr 28 12:46 uts -&gt; uts:[4026531838]
.EE
.in

Bind mounting (see
**mount**(2))
one of the files in this directory
to somewhere else in the filesystem keeps
the corresponding namespace of the process specified by
_pid_
alive even if all processes currently in the namespace terminate.

Opening one of the files in this directory
(or a file that is bind mounted to one of these files)
returns a file handle for
the corresponding namespace of the process specified by
_pid_.
As long as this file descriptor remains open,
the namespace will remain alive,
even if all processes in the namespace terminate.
The file descriptor can be passed to
**setns**(2).

In Linux 3.7 and earlier, these files were visible as hard links.
Since Linux 3.8,

they appear as symbolic links.
If two processes are in the same namespace,
then the device IDs and inode numbers of their
_/proc/[pid]/ns/xxx_
symbolic links will be the same; an application can check this using the
_stat.st_dev_
and
_stat.st_ino_
fields returned by
**stat**(2).
The content of this symbolic link is a string containing
the namespace type and inode number as in the following example:

.in +4n
.EX
$ **readlink /proc/$$/ns/uts**
uts:[4026531838]
.EE
.in

The symbolic links in this subdirectory are as follows:

* _/proc/[pid]/ns/cgroup_ (since Linux 4.6)  
  This file is a handle for the cgroup namespace of the process.
* _/proc/[pid]/ns/ipc_ (since Linux 3.0)  
  This file is a handle for the IPC namespace of the process.
* _/proc/[pid]/ns/mnt_ (since Linux 3.8)  
  
  This file is a handle for the mount namespace of the process.
* _/proc/[pid]/ns/net_ (since Linux 3.0)  
  This file is a handle for the network namespace of the process.
* _/proc/[pid]/ns/pid_ (since Linux 3.8)  
  
  This file is a handle for the PID namespace of the process.
  This handle is permanent for the lifetime of the process
  (i.e., a process's PID namespace membership never changes).
* _/proc/[pid]/ns/pid_for_children_ (since Linux 4.12)  
  
  This file is a handle for the PID namespace of
  child processes created by this process.
  This can change as a consequence of calls to
  **unshare**(2)
  and
  **setns**(2)
  (see
  **pid_namespaces**(7)),
  so the file may differ from
  _/proc/[pid]/ns/pid_.
  The symbolic link gains a value only after the first child process
  is created in the namespace.
  (Beforehand,
  **readlink**(2)
  of the symbolic link will return an empty buffer.)
* _/proc/[pid]/ns/user_ (since Linux 3.8)  
  
  This file is a handle for the user namespace of the process.
* _/proc/[pid]/ns/uts_ (since Linux 3.0)  
  This file is a handle for the UTS namespace of the process.

Permission to dereference or read
(**readlink**(2))
these symbolic links is governed by a ptrace access mode
**PTRACE_MODE_READ_FSCREDS**
check; see
**ptrace**(2).




<a name="the-procsysuser-directory"></a>

### The /proc/sys/user directory

The files in the
_/proc/sys/user_
directory (which is present since Linux 4.9) expose limits
on the number of namespaces of various types that can be created.
The files are as follows:

* _max_cgroup_namespaces_  
  The value in this file defines a per-user limit on the number of
  cgroup namespaces that may be created in the user namespace.
* _max_ipc_namespaces_  
  The value in this file defines a per-user limit on the number of
  ipc namespaces that may be created in the user namespace.
* _max_mnt_namespaces_  
  The value in this file defines a per-user limit on the number of
  mount namespaces that may be created in the user namespace.
* _max_net_namespaces_  
  The value in this file defines a per-user limit on the number of
  network namespaces that may be created in the user namespace.
* _max_pid_namespaces_  
  The value in this file defines a per-user limit on the number of
  pid namespaces that may be created in the user namespace.
* _max_user_namespaces_  
  The value in this file defines a per-user limit on the number of
  user namespaces that may be created in the user namespace.
* _max_uts_namespaces_  
  The value in this file defines a per-user limit on the number of
  user namespaces that may be created in the user namespace.

Note the following details about these files:

* *  
  The values in these files are modifiable by privileged processes.
* *  
  The values exposed by these files are the limits for the user namespace
  in which the opening process resides.
* *  
  The limits are per-user.
  Each user in the same user namespace
  can create namespaces up to the defined limit.
* *  
  The limits apply to all users, including UID 0.
* *  
  These limits apply in addition to any other per-namespace
  limits (such as those for PID and user namespaces) that may be enforced.
* *  
  Upon encountering these limits,
  **clone**(2)
  and
  **unshare**(2)
  fail with the error
  **ENOSPC**.
* *  
  For the initial user namespace,
  the default value in each of these files is half the limit on the number
  of threads that may be created
  (_/proc/sys/kernel/threads-max_).
  In all descendant user namespaces, the default value in each file is
  **MAXINT**.
* *  
  When a namespace is created, the object is also accounted
  against ancestor namespaces.
  More precisely:
    * +  
      Each user namespace has a creator UID.
    * +  
      When a namespace is created,
      it is accounted against the creator UIDs in each of the
      ancestor user namespaces,
      and the kernel ensures that the corresponding namespace limit
      for the creator UID in the ancestor namespace is not exceeded.
    * +  
      The aforementioned point ensures that creating a new user namespace
      cannot be used as a means to escape the limits in force
      in the current user namespace.





<a name="cgroup-namespaces-clone_newcgroup"></a>

### Cgroup namespaces (CLONE_NEWCGROUP)

See
**cgroup_namespaces**(7).




<a name="ipc-namespaces-clone_newipc"></a>

### IPC namespaces (CLONE_NEWIPC)

IPC namespaces isolate certain IPC resources,
namely, System V IPC objects (see
**svipc**(7))
and (since Linux 2.6.30)


POSIX message queues (see
**mq_overview**(7)).
The common characteristic of these IPC mechanisms is that IPC
objects are identified by mechanisms other than filesystem
pathnames.

Each IPC namespace has its own set of System V IPC identifiers and
its own POSIX message queue filesystem.
Objects created in an IPC namespace are visible to all other processes
that are members of that namespace,
but are not visible to processes in other IPC namespaces.

The following
_/proc_
interfaces are distinct in each IPC namespace:

* *  
  The POSIX message queue interfaces in
  _/proc/sys/fs/mqueue_.
* *  
  The System V IPC interfaces in
  _/proc/sys/kernel_,
  namely:
  _msgmax_,
  _msgmnb_,
  _msgmni_,
  _sem_,
  _shmall_,
  _shmmax_,
  _shmmni_,
  and
  _shm_rmid_forced_.
* *  
  The System V IPC interfaces in
  _/proc/sysvipc_.

When an IPC namespace is destroyed
(i.e., when the last process that is a member of the namespace terminates),
all IPC objects in the namespace are automatically destroyed.

Use of IPC namespaces requires a kernel that is configured with the
**CONFIG_IPC_NS**
option.




<a name="network-namespaces-clone_newnet"></a>

### Network namespaces (CLONE_NEWNET)

See
**network_namespaces**(7).




<a name="mount-namespaces-clone_newns"></a>

### Mount namespaces (CLONE_NEWNS)

See
**mount_namespaces**(7).




<a name="pid-namespaces-clone_newpid"></a>

### PID namespaces (CLONE_NEWPID)

See
**pid_namespaces**(7).




<a name="user-namespaces-clone_newuser"></a>

### User namespaces (CLONE_NEWUSER)

See
**user_namespaces**(7).




<a name="uts-namespaces-clone_newuts"></a>

### UTS namespaces (CLONE_NEWUTS)

UTS namespaces provide isolation of two system identifiers:
the hostname and the NIS domain name.
These identifiers are set using
**sethostname**(2)
and
**setdomainname**(2),
and can be retrieved using
**uname**(2),
**gethostname**(2),
and
**getdomainname**(2).

Use of UTS namespaces requires a kernel that is configured with the
**CONFIG_UTS_NS**
option.

<a name="example"></a>

# Example

See
**clone**(2)
and
**user_namespaces**(7).

<a name="see-also"></a>

# See Also

**nsenter**(1),
**readlink**(1),
**unshare**(1),
**clone**(2),
**ioctl_ns**(2),
**setns**(2),
**unshare**(2),
**proc**(5),
**capabilities**(7),
**cgroup_namespaces**(7),
**cgroups**(7),
**credentials**(7),
**network_namespaces**(7),
**pid_namespaces**(7),
**user_namespaces**(7),
**lsns**(8),
**switch_root**(8)

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
