# proc(5) - process information pseudo-filesystem

Linux, 2019-11-19


<a name="description"></a>

# Description

The
**proc**
filesystem is a pseudo-filesystem which provides an interface to
kernel data structures.
It is commonly mounted at
_/proc_.
Typically, it is mounted automatically by the system,
but it can also be mounted manually using a command such as:

.in +4n
.EX
mount -t proc proc /proc
.EE
.in

Most of the files in the
**proc**
filesystem are read-only,
but some files are writable, allowing kernel variables to be changed.


<a name="mount-options"></a>

### Mount options

The
**proc**
filesystem supports the following mount options:

* **hidepid**=_n_ (since Linux 3.3)  
  
  This option controls who can access the information in
  _/proc/[pid]_
  directories.
  The argument,
  _n_,
  is one of the following values:
    * 0  
      Everybody may access all
      _/proc/[pid]_
      directories.
      This is the traditional behavior,
      and the default if this mount option is not specified.
    * 1  
      Users may not access files and subdirectories inside any
      _/proc/[pid]_
      directories but their own (the
      _/proc/[pid]_
      directories themselves remain visible).
      Sensitive files such as
      _/proc/[pid]/cmdline_
      and
      _/proc/[pid]/status_
      are now protected against other users.
      This makes it impossible to learn whether any user is running a
      specific program
      (so long as the program doesn't otherwise reveal itself by its behavior).
      
      
      
      
      
    * 2  
      As for mode 1, but in addition the
      _/proc/[pid]_
      directories belonging to other users become invisible.
      This means that
      _/proc/[pid]_
      entries can no longer be used to discover the PIDs on the system.
      This doesn't hide the fact that a process with a specific PID value exists
      (it can be learned by other means, for example, by "kill -0 $PID"),
      but it hides a process's UID and GID,
      which could otherwise be learned by employing
      **stat**(2)
      on a
      _/proc/[pid]_
      directory.
      This greatly complicates an attacker's task of gathering
      information about running processes (e.g., discovering whether
      some daemon is running with elevated privileges,
      whether another user is running some sensitive program,
      whether other users are running any program at all, and so on).
* **gid**=_gid_ (since Linux 3.3)  
  
  Specifies the ID of a group whose members are authorized to
  learn process information otherwise prohibited by
  **hidepid**
  (i.e., users in this group behave as though
  _/proc_
  was mounted with
  _hidepid=0_).
  This group should be used instead of approaches such as putting
  nonroot users into the
  **sudoers**(5)
  file.
  

<a name="overview"></a>

### Overview

Underneath
_/proc_,
there are the following general groups of files and subdirectories:

* _/proc/[pid]_ subdirectories  
  Each one of these subdirectories contains files and subdirectories
  exposing information about the process with the corresponding process ID.
* Underneath each of the
  _/proc/[pid]_
  directories, a
  _task_
  subdirectory contains subdirectories of the form
  _task/[tid]_,
  which contain corresponding information about each of the threads
  in the process, where
  _tid_
  is the kernel thread ID of the thread.
* The
  _/proc/[pid]_
  subdirectories are visible when iterating through
  _/proc_
  with
  **getdents**(2)
  (and thus are visible when one uses
  **ls**(1)
  to view the contents of
  _/proc_).
* _/proc/[tid]_ subdirectories  
  Each one of these subdirectories contains files and subdirectories
  exposing information about the thread with the corresponding thread ID.
  The contents of these directories are the same as the corresponding
  _/proc/[pid]/task/[tid]_
  directories.
* The
  _/proc/[tid]_
  subdirectories are
  _not_
  visible when iterating through
  _/proc_
  with
  **getdents**(2)
  (and thus are
  _not_
  visible when one uses
  **ls**(1)
  to view the contents of
  _/proc_).
* _/proc/self_  
  When a process accesses this magic symbolic link,
  it resolves to the process's own
  _/proc/[pid]_
  directory.
* _/proc/thread-self_  
  When a thread accesses this magic symbolic link,
  it resolves to the process's own
  _/proc/self/task/[tid]_
  directory.
* _/proc/[a-z]*_  
  Various other files and subdirectories under
  _/proc_
  expose system-wide information.

All of the above are described in more detail below.


<a name="files-and-directories"></a>

### Files and directories

The following list provides details of many of the files and directories
under the
_/proc_
hierarchy.

* _/proc/[pid]_  
  There is a numerical subdirectory for each running process; the
  subdirectory is named by the process ID.
  Each
  _/proc/[pid]_
  subdirectory contains the pseudo-files and directories described below.
* The files inside each
  _/proc/[pid]_
  directory are normally owned by the effective user and
  effective group ID of the process.
  However, as a security measure, the ownership is made
  _root:root_
  if the process's "dumpable" attribute is set to a value other than 1.
* Before Linux 4.11,
  
  _root:root_
  meant the "global" root user ID and group ID
  (i.e., UID 0 and GID 0 in the initial user namespace).
  Since Linux 4.11,
  if the process is in a noninitial user namespace that has a
  valid mapping for user (group) ID 0 inside the namespace, then
  the user (group) ownership of the files under
  _/proc/[pid]_
  is instead made the same as the root user (group) ID of the namespace.
  This means that inside a container,
  things work as expected for the container "root" user.
* The process's "dumpable" attribute may change for the following reasons:
    * *  
      The attribute was explicitly set via the
      **prctl**(2)
      **PR_SET_DUMPABLE**
      operation.
    * *  
      The attribute was reset to the value in the file
      _/proc/sys/fs/suid_dumpable_
      (described below), for the reasons described in
      **prctl**(2).
* Resetting the "dumpable" attribute to 1 reverts the ownership of the
  _/proc/[pid]/*_
  files to the process's effective UID and GID.
* _/proc/[pid]/attr_  
  
  
  
  
  
  
  
  
  The files in this directory provide an API for security modules.
  The contents of this directory are files that can be read and written
  in order to set security-related attributes.
  This directory was added to support SELinux,
  but the intention was that the API be general enough to support
  other security modules.
  For the purpose of explanation,
  examples of how SELinux uses these files are provided below.
* This directory is present only if the kernel was configured with
  **CONFIG_SECURITY**.
* _/proc/[pid]/attr/current_ (since Linux 2.6.0)  
  The contents of this file represent the current
  security attributes of the process.
* In SELinux, this file is used to get the security context of a process.
  Prior to Linux 2.6.11, this file could not be used to set the security
  context (a write was always denied), since SELinux limited process security
  transitions to
  **execve**(2)
  (see the description of
  _/proc/[pid]/attr/exec_,
  below).
  Since Linux 2.6.11, SELinux lifted this restriction and began supporting
  "set" operations via writes to this node if authorized by policy,
  although use of this operation is only suitable for applications that are
  trusted to maintain any desired separation between the old and new security
  contexts.
* Prior to Linux 2.6.28, SELinux did not allow threads within a
  multi-threaded process to set their security context via this node
  as it would yield an inconsistency among the security contexts of the
  threads sharing the same memory space.
  Since Linux 2.6.28, SELinux lifted
  this restriction and began supporting "set" operations for threads within
  a multithreaded process if the new security context is bounded by the old
  security context, where the bounded relation is defined in policy and
  guarantees that the new security context has a subset of the permissions
  of the old security context.
* Other security modules may choose to support "set" operations via
  writes to this node.
* _/proc/[pid]/attr/exec_ (since Linux 2.6.0)  
  This file represents the attributes to assign to the
  process upon a subsequent
  **execve**(2).
* In SELinux,
  this is needed to support role/domain transitions, and
  **execve**(2)
  is the preferred point to make such transitions because it offers better
  control over the initialization of the process in the new security label
  and the inheritance of state.
  In SELinux, this attribute is reset on
  **execve**(2)
  so that the new program reverts to the default behavior for any
  **execve**(2)
  calls that it may make.
  In SELinux, a process can set
  only its own
  _/proc/[pid]/attr/exec_
  attribute.
* _/proc/[pid]/attr/fscreate_ (since Linux 2.6.0)  
  This file represents the attributes to assign to files
  created by subsequent calls to
  **open**(2),
  **mkdir**(2),
  **symlink**(2),
  and
  **mknod**(2)
* SELinux employs this file to support creation of a file
  (using the aforementioned system calls)
  in a secure state,
  so that there is no risk of inappropriate access being obtained
  between the time of creation and the time that attributes are set.
  In SELinux, this attribute is reset on
  **execve**(2),
  so that the new program reverts to the default behavior for
  any file creation calls it may make, but the attribute will persist
  across multiple file creation calls within a program unless it is
  explicitly reset.
  In SELinux, a process can set only its own
  _/proc/[pid]/attr/fscreate_
  attribute.
* _/proc/[pid]/attr/keycreate_ (since Linux 2.6.18)  
  
  If a process writes a security context into this file,
  all subsequently created keys
  (**add_key**(2))
  will be labeled with this context.
  For further information, see the kernel source file
  _Documentation/security/keys/core.rst_
  (or file
  
  _Documentation/security/keys.txt_
  on Linux between 3.0 and 4.13, or
  
  _Documentation/keys.txt_
  before Linux 3.0).
* _/proc/[pid]/attr/prev_ (since Linux 2.6.0)  
  This file contains the security context of the process before the last
  **execve**(2);
  that is, the previous value of
  _/proc/[pid]/attr/current_.
* _/proc/[pid]/attr/socketcreate_ (since Linux 2.6.18)  
  
  If a process writes a security context into this file,
  all subsequently created sockets will be labeled with this context.
* _/proc/[pid]/autogroup_ (since Linux 2.6.38)  
  
  See
  **sched**(7).
* _/proc/[pid]/auxv_ (since 2.6.0)  
  
  This contains the contents of the ELF interpreter information passed
  to the process at exec time.
  The format is one _unsigned long_ ID
  plus one _unsigned long_ value for each entry.
  The last entry contains two zeros.
  See also
  **getauxval**(3).
* Permission to access this file is governed by a ptrace access mode
  **PTRACE_MODE_READ_FSCREDS**
  check; see
  **ptrace**(2).
* _/proc/[pid]/cgroup_ (since Linux 2.6.24)  
  See
  **cgroups**(7).
* _/proc/[pid]/clear_refs_ (since Linux 2.6.22)  
  
  
  
  
  
  
* This is a write-only file, writable only by owner of the process.
* The following values may be written to the file:
    * 1 (since Linux 2.6.22)  
      
      Reset the PG_Referenced and ACCESSED/YOUNG
      bits for all the pages associated with the process.
      (Before kernel 2.6.32, writing any nonzero value to this file
      had this effect.)
    * 2 (since Linux 2.6.32)  
      
      Reset the PG_Referenced and ACCESSED/YOUNG
      bits for all anonymous pages associated with the process.
    * 3 (since Linux 2.6.32)  
      
      Reset the PG_Referenced and ACCESSED/YOUNG
      bits for all file-mapped pages associated with the process.
* Clearing the PG_Referenced and ACCESSED/YOUNG bits provides a method
  to measure approximately how much memory a process is using.
  One first inspects the values in the "Referenced" fields
  for the VMAs shown in
  _/proc/[pid]/smaps_
  to get an idea of the memory footprint of the
  process.
  One then clears the PG_Referenced and ACCESSED/YOUNG bits
  and, after some measured time interval,
  once again inspects the values in the "Referenced" fields
  to get an idea of the change in memory footprint of the
  process during the measured interval.
  If one is interested only in inspecting the selected mapping types,
  then the value 2 or 3 can be used instead of 1.
* Further values can be written to affect different properties:
    * 4 (since Linux 3.11)  
      Clear the soft-dirty bit for all the pages associated with the process.
      
      This is used (in conjunction with
      _/proc/[pid]/pagemap_)
      by the check-point restore system to discover which pages of a process
      have been dirtied since the file
      _/proc/[pid]/clear_refs_
      was written to.
    * 5 (since Linux 4.0)  
      
      Reset the peak resident set size ("high water mark") to the process's
      current resident set size value.
* Writing any value to
  _/proc/[pid]/clear_refs_
  other than those listed above has no effect.
* The
  _/proc/[pid]/clear_refs_
  file is present only if the
  **CONFIG_PROC_PAGE_MONITOR**
  kernel configuration option is enabled.
* _/proc/[pid]/cmdline_  
  This read-only file holds the complete command line for the process,
  unless the process is a zombie.
  
  In the latter case, there is nothing in this file:
  that is, a read on this file will return 0 characters.
  The command-line arguments appear in this file as a set of
  strings separated by null bytes ('\e0'),
  with a further null byte after the last string.
* _/proc/[pid]/comm_ (since Linux 2.6.33)  
  
  This file exposes the process's
  _comm_
  value—that is, the command name associated with the process.
  Different threads in the same process may have different
  _comm_
  values, accessible via
  _/proc/[pid]/task/[tid]/comm_.
  A thread may modify its
  _comm_
  value, or that of any of other thread in the same thread group (see
  the discussion of
  **CLONE_THREAD**
  in
  **clone**(2)),
  by writing to the file
  _/proc/self/task/[tid]/comm_.
  Strings longer than
  **TASK_COMM_LEN**
  (16) characters are silently truncated.
* This file provides a superset of the
  **prctl**(2)
  **PR_SET_NAME**
  and
  **PR_GET_NAME**
  operations, and is employed by
  **pthread_setname_np**(3)
  when used to rename threads other than the caller.
* _/proc/[pid]/coredump_filter_ (since Linux 2.6.23)  
  See
  **core**(5).
* _/proc/[pid]/cpuset_ (since Linux 2.6.12)  
  
  See
  **cpuset**(7).
* _/proc/[pid]/cwd_  
  This is a symbolic link to the current working directory of the process.
  To find out the current working directory of process 20,
  for instance, you can do this:
* .in +4n
  .EX
  $** cd /proc/20/cwd; /bin/pwd**
  .EE
  .in
* Note that the
  _pwd_
  command is often a shell built-in, and might
  not work properly.
  In
  **bash**(1),
  you may use
  _pwd&nbsp;-P_.
* 
  In a multithreaded process, the contents of this symbolic link
  are not available if the main thread has already terminated
  (typically by calling
  **pthread_exit**(3)).
* Permission to dereference or read
  (**readlink**(2))
  this symbolic link is governed by a ptrace access mode
  **PTRACE_MODE_READ_FSCREDS**
  check; see
  **ptrace**(2).
* _/proc/[pid]/environ_  
  This file contains the initial environment that was set
  when the currently executing program was started via
  **execve**(2).
  The entries are separated by null bytes ('\e0'),
  and there may be a null byte at the end.
  Thus, to print out the environment of process 1, you would do:
* .in +4n
  .EX
  $** cat /proc/1/environ | tr '\e000' '\en'**
  .EE
  .in
* If, after an
  **execve**(2),
  the process modifies its environment
  (e.g., by calling functions such as
  **putenv**(3)
  or modifying the
  **environ**(7)
  variable directly),
  this file will
  _not_
  reflect those changes.
* Furthermore, a process may change the memory location that this file refers via
  **prctl**(2)
  operations such as
  **PR_SET_MM_ENV_START**.
* Permission to access this file is governed by a ptrace access mode
  **PTRACE_MODE_READ_FSCREDS**
  check; see
  **ptrace**(2).
* _/proc/[pid]/exe_  
  Under Linux 2.2 and later, this file is a symbolic link
  containing the actual pathname of the executed command.
  This symbolic link can be dereferenced normally; attempting to open
  it will open the executable.
  You can even type
  _/proc/[pid]/exe_
  to run another copy of the same executable that is being run by
  process [pid].
  If the pathname has been unlinked, the symbolic link will contain the
  string '(deleted)' appended to the original pathname.
  
  In a multithreaded process, the contents of this symbolic link
  are not available if the main thread has already terminated
  (typically by calling
  **pthread_exit**(3)).
* Permission to dereference or read
  (**readlink**(2))
  this symbolic link is governed by a ptrace access mode
  **PTRACE_MODE_READ_FSCREDS**
  check; see
  **ptrace**(2).
* Under Linux 2.0 and earlier,
  _/proc/[pid]/exe_
  is a pointer to the binary which was executed,
  and appears as a symbolic link.
  A
  **readlink**(2)
  call on this file under Linux 2.0 returns a string in the format:
*     [device]:inode
* For example, [0301]:1502 would be inode 1502 on device major 03 (IDE,
  MFM, etc. drives) minor 01 (first partition on the first drive).
* **find**(1)
  with the
  _-inum_
  option can be used to locate the file.
* _/proc/[pid]/fd/_  
  This is a subdirectory containing one entry for each file which the
  process has open, named by its file descriptor, and which is a
  symbolic link to the actual file.
  Thus, 0 is standard input, 1 standard output, 2 standard error, and so on.
* For file descriptors for pipes and sockets,
  the entries will be symbolic links whose content is the
  file type with the inode.
  A
  **readlink**(2)
  call on this file returns a string in the format:
*     type:[inode]
* For example,
  _socket:[2248868]_
  will be a socket and its inode is 2248868.
  For sockets, that inode can be used to find more information
  in one of the files under
  _/proc/net/_.
* For file descriptors that have no corresponding inode
  (e.g., file descriptors produced by
  **bpf**(2),
  **epoll_create**(2),
  **eventfd**(2),
  **inotify_init**(2),
  **perf_event_open**(2),
  **signalfd**(2),
  **timerfd_create**(2),
  and
  **userfaultfd**(2)),
  the entry will be a symbolic link with contents of the form
*     anon_inode:&lt;file-type&gt;
* In many cases (but not all), the
  _file-type_
  is surrounded by square brackets.
* For example, an epoll file descriptor will have a symbolic link
  whose content is the string
  _anon_inode:[eventpoll]_.
* 
  In a multithreaded process, the contents of this directory
  are not available if the main thread has already terminated
  (typically by calling
  **pthread_exit**(3)).
* Programs that take a filename as a command-line argument,
  but don't take input from standard input if no argument is supplied,
  and programs that write to a file named as a command-line argument,
  but don't send their output to standard output
  if no argument is supplied, can nevertheless be made to use
  standard input or standard output by using
  _/proc/[pid]/fd_
  files as command-line arguments.
  For example, assuming that
  _-i_
  is the flag designating an input file and
  _-o_
  is the flag designating an output file:
* .in +4n
  .EX
  $** foobar -i /proc/self/fd/0 -o /proc/self/fd/1 ...**
  .EE
  .in
* and you have a working filter.
  
  
  
  
* _/proc/self/fd/N_
  is approximately the same as
  _/dev/fd/N_
  in some UNIX and UNIX-like systems.
  Most Linux MAKEDEV scripts symbolically link
  _/dev/fd_
  to
  _/proc/self/fd_,
  in fact.
* Most systems provide symbolic links
  _/dev/stdin_,
  _/dev/stdout_,
  and
  _/dev/stderr_,
  which respectively link to the files
  _0_,
  _1_,
  and
  _2_
  in
  _/proc/self/fd_.
  Thus the example command above could be written as:
* .in +4n
  .EX
  $** foobar -i /dev/stdin -o /dev/stdout ...**
  .EE
  .in
* Permission to dereference or read
  (**readlink**(2))
  the symbolic links in this directory is governed by a ptrace access mode
  **PTRACE_MODE_READ_FSCREDS**
  check; see
  **ptrace**(2).
* Note that for file descriptors referring to inodes (pipes and sockets, see above),
  those inodes still have permission bits and ownership information
  distinct from those of the
  _/proc/[pid]/fd_
  entry,
  and that the owner may differ from the user and group IDs of the process.
  An unprivileged process may lack permissions to open them, as in this example:
* .in +4n
  .EX
  $** echo test | sudo -u nobody cat**
  test
  $** echo test | sudo -u nobody cat /proc/self/fd/0**
  cat: /proc/self/fd/0: Permission denied
  .EE
  .in
* File descriptor 0 refers to the pipe created by the shell
  and owned by that shell's user, which is not
  _nobody_,
  so
  **cat**
  does not have permission to create a new file descriptor to read from that inode,
  even though it can still read from its existing file descriptor 0.
* _/proc/[pid]/fdinfo/_ (since Linux 2.6.22)  
  This is a subdirectory containing one entry for each file which the
  process has open, named by its file descriptor.
  The files in this directory are readable only by the owner of the process.
  The contents of each file can be read to obtain information
  about the corresponding file descriptor.
  The content depends on the type of file referred to by the
  corresponding file descriptor.
* For regular files and directories, we see something like:
* .in +4n
  .EX
  $** cat /proc/12015/fdinfo/4**
  pos:    1000
  flags:  01002002
  mnt_id: 21
  .EE
  .in
* The fields are as follows:
    * _pos_  
      This is a decimal number showing the file offset.
    * _flags_  
      This is an octal number that displays the
      file access mode and file status flags (see
      **open**(2)).
      If the close-on-exec file descriptor flag is set, then
      _flags_
      will also include the value
      **O_CLOEXEC**.
    * Before Linux 3.1,
      
      this field incorrectly displayed the setting of
      **O_CLOEXEC**
      at the time the file was opened,
      rather than the current setting of the close-on-exec flag.
    * .I  
      _mnt_id_
      This field, present since Linux 3.15,
      
      is the ID of the mount point containing this file.
      See the description of
      _/proc/[pid]/mountinfo_.
* For eventfd file descriptors (see
  **eventfd**(2)),
  we see (since Linux 3.8)
  
  the following fields:
* .in +4n
  .EX
  pos:	0
  flags:	02
  mnt_id:	10
  eventfd-count:               40
  .EE
  .in
* _eventfd-count_
  is the current value of the eventfd counter, in hexadecimal.
* For epoll file descriptors (see
  **epoll**(7)),
  we see (since Linux 3.8)
  
  the following fields:
* .in +4n
  .EX
  pos:	0
  flags:	02
  mnt_id:	10
  tfd:        9 events:       19 data: 74253d2500000009
  tfd:        7 events:       19 data: 74253d2500000007
  .EE
  .in
* Each of the lines beginning
  _tfd_
  describes one of the file descriptors being monitored via
  the epoll file descriptor (see
  **epoll_ctl**(2)
  for some details).
  The
  _tfd_
  field is the number of the file descriptor.
  The
  _events_
  field is a hexadecimal mask of the events being monitored for this file
  descriptor.
  The
  _data_
  field is the data value associated with this file descriptor.
* For signalfd file descriptors (see
  **signalfd**(2)),
  we see (since Linux 3.8)
  
  the following fields:
* .in +4n
  .EX
  pos:	0
  flags:	02
  mnt_id:	10
  sigmask:	0000000000000006
  .EE
  .in
* _sigmask_
  is the hexadecimal mask of signals that are accepted via this
  signalfd file descriptor.
  (In this example, bits 2 and 3 are set, corresponding to the signals
  **SIGINT**
  and
  **SIGQUIT**;
  see
  **signal**(7).)
* For inotify file descriptors (see
  **inotify**(7)),
  we see (since Linux 3.8)
  the following fields:
* .in +4n
  .EX
  pos:	0
  flags:	00
  mnt_id:	11
  inotify wd:2 ino:7ef82a sdev:800001 mask:800afff ignored_mask:0 fhandle-bytes:8 fhandle-type:1 f_handle:2af87e00220ffd73
  inotify wd:1 ino:192627 sdev:800001 mask:800afff ignored_mask:0 fhandle-bytes:8 fhandle-type:1 f_handle:27261900802dfd73
  .EE
  .in
* Each of the lines beginning with "inotify" displays information about
  one file or directory that is being monitored.
  The fields in this line are as follows:
    * _wd_  
      A watch descriptor number (in decimal).
    * _ino_  
      The inode number of the target file (in hexadecimal).
    * _sdev_  
      The ID of the device where the target file resides (in hexadecimal).
    * _mask_  
      The mask of events being monitored for the target file (in hexadecimal).
* If the kernel was built with exportfs support, the path to the target
  file is exposed as a file handle, via three hexadecimal fields:
  _fhandle-bytes_,
  _fhandle-type_,
  and
  _f_handle_.
* For fanotify file descriptors (see
  **fanotify**(7)),
  we see (since Linux 3.8)
  the following fields:
* .in +4n
  .EX
  pos:	0
  flags:	02
  mnt_id:	11
  fanotify flags:0 event-flags:88002
  fanotify ino:19264f sdev:800001 mflags:0 mask:1 ignored_mask:0 fhandle-bytes:8 fhandle-type:1 f_handle:4f261900a82dfd73
  .EE
  .in
* The fourth line displays information defined when the fanotify group
  was created via
  **fanotify_init**(2):
    * _flags_  
      The
      _flags_
      argument given to
      **fanotify_init**(2)
      (expressed in hexadecimal).
    * _event-flags_  
      The
      _event_f_flags_
      argument given to
      **fanotify_init**(2)
      (expressed in hexadecimal).
* Each additional line shown in the file contains information
  about one of the marks in the fanotify group.
  Most of these fields are as for inotify, except:
    * _mflags_  
      The flags associated with the mark
      (expressed in hexadecimal).
    * _mask_  
      The events mask for this mark
      (expressed in hexadecimal).
    * _ignored_mask_  
      The mask of events that are ignored for this mark
      (expressed in hexadecimal).
* For details on these fields, see
  **fanotify_mark**(2).
* For timerfd file descriptors (see
  **timerfd**(2)),
  we see (since Linux 3.17)
  
  the following fields:
* .in +4n
  .EX
  pos:    0
  flags:  02004002
  mnt_id: 13
  clockid: 0
  ticks: 0
  settime flags: 03
  it_value: (7695568592, 640020877)
  it_interval: (0, 0)
  .EE
  .in
    * _clockid_  
      This is the numeric value of the clock ID
      (corresponding to one of the
      **CLOCK_***
      constants defined via
      _&lt;time.h&gt;_)
      that is used to mark the progress of the timer (in this example, 0 is
      **CLOCK_REALTIME**).
    * _ticks_  
      This is the number of timer expirations that have occurred,
      (i.e., the value that
      **read**(2)
      on it would return).
    * _settime flags_  
      This field lists the flags with which the timerfd was last armed (see
      **timerfd_settime**(2)),
      in octal
      (in this example, both
      **TFD_TIMER_ABSTIME**
      and
      **TFD_TIMER_CANCEL_ON_SET**
      are set).
    * _it_value_  
      This field contains the amount of time until the timer will next expire,
      expressed in seconds and nanoseconds.
      This is always expressed as a relative value,
      regardless of whether the timer was created using the
      **TFD_TIMER_ABSTIME**
      flag.
    * _it_interval_  
      This field contains the interval of the timer,
      in seconds and nanoseconds.
      (The
      _it_value_
      and
      _it_interval_
      fields contain the values that
      **timerfd_gettime**(2)
      on this file descriptor would return.)
* _/proc/[pid]/gid_map_ (since Linux 3.5)  
  See
  **user_namespaces**(7).
* _/proc/[pid]/io_ (since kernel 2.6.20)  
  
  This file contains I/O statistics for the process, for example:
* .in +4n
  .EX
  #** cat /proc/3828/io**
  rchar: 323934931
  wchar: 323929600
  syscr: 632687
  syscw: 632675
  read_bytes: 0
  write_bytes: 323932160
  cancelled_write_bytes: 0
  .EE
  .in
* The fields are as follows:
    * _rchar_: characters read  
      The number of bytes which this task has caused to be read from storage.
      This is simply the sum of bytes which this process passed to
      **read**(2)
      and similar system calls.
      It includes things such as terminal I/O and
      is unaffected by whether or not actual
      physical disk I/O was required (the read might have been satisfied from
      pagecache).
    * _wchar_: characters written  
      The number of bytes which this task has caused, or shall cause to be written
      to disk.
      Similar caveats apply here as with
      _rchar_.
    * _syscr_: read syscalls  
      Attempt to count the number of read I/O operations—that is,
      system calls such as
      **read**(2)
      and
      **pread**(2).
    * _syscw_: write syscalls  
      Attempt to count the number of write I/O operations—that is,
      system calls such as
      **write**(2)
      and
      **pwrite**(2).
    * _read_bytes_: bytes read  
      Attempt to count the number of bytes which this process really did cause to
      be fetched from the storage layer.
      This is accurate for block-backed filesystems.
    * _write_bytes_: bytes written  
      Attempt to count the number of bytes which this process caused to be sent to
      the storage layer.
    * _cancelled_write_bytes_:  
      The big inaccuracy here is truncate.
      If a process writes 1MB to a file and then deletes the file,
      it will in fact perform no writeout.
      But it will have been accounted as having caused 1MB of write.
      In other words: this field represents the number of bytes which this process
      caused to not happen, by truncating pagecache.
      A task can cause "negative" I/O too.
      If this task truncates some dirty pagecache,
      some I/O which another task has been accounted for
      (in its
      _write_bytes_)
      will not be happening.
* _Note_:
  In the current implementation, things are a bit racy on 32-bit systems:
  if process A reads process B's
  _/proc/[pid]/io_
  while process B is updating one of these 64-bit counters,
  process A could see an intermediate result.
* Permission to access this file is governed by a ptrace access mode
  **PTRACE_MODE_READ_FSCREDS**
  check; see
  **ptrace**(2).
* _/proc/[pid]/limits_ (since Linux 2.6.24)  
  This file displays the soft limit, hard limit, and units of measurement
  for each of the process's resource limits (see
  **getrlimit**(2)).
  Up to and including Linux 2.6.35,
  this file is protected to allow reading only by the real UID of the process.
  Since Linux 2.6.36,
  
  this file is readable by all users on the system.
  
  
  
* _/proc/[pid]/map_files/_(since_kernel_3.3)  
  
  This subdirectory contains entries corresponding to memory-mapped
  files (see
  **mmap**(2)).
  Entries are named by memory region start and end
  address pair (expressed as hexadecimal numbers),
  and are symbolic links to the mapped files themselves.
  Here is an example, with the output wrapped and reformatted to fit on an 80-column display:
* .in +4n
  .EX
  #** ls -l /proc/self/map_files/**
  lr--------. 1 root root 64 Apr 16 21:31
              3252e00000-3252e20000 -&gt; /usr/lib64/ld-2.15.so
  ...
  .EE
  .in
* Although these entries are present for memory regions that were
  mapped with the
  **MAP_FILE**
  flag, the way anonymous shared memory (regions created with the
  **MAP_ANON | MAP_SHARED**
  flags)
  is implemented in Linux
  means that such regions also appear on this directory.
  Here is an example where the target file is the deleted
  _/dev/zero_
  one:
* .in +4n
  .EX
  lrw-------. 1 root root 64 Apr 16 21:33
              7fc075d2f000-7fc075e6f000 -&gt; /dev/zero (deleted)
  .EE
  .in
* This directory appears only if the
  **CONFIG_CHECKPOINT_RESTORE**
  kernel configuration option is enabled.
  Privilege
  (**CAP_SYS_ADMIN**)
  
  
  
  
  is required to view the contents of this directory.
* _/proc/[pid]/maps_  
  A file containing the currently mapped memory regions and their access
  permissions.
  See
  **mmap**(2)
  for some further information about memory mappings.
* Permission to access this file is governed by a ptrace access mode
  **PTRACE_MODE_READ_FSCREDS**
  check; see
  **ptrace**(2).
* The format of the file is:
* .in 4n
  .EX
  _address           perms offset  dev   inode       pathname_
  00400000-00452000 r-xp 00000000 08:02 173521      /usr/bin/dbus-daemon
  00651000-00652000 r--p 00051000 08:02 173521      /usr/bin/dbus-daemon
  00652000-00655000 rw-p 00052000 08:02 173521      /usr/bin/dbus-daemon
  00e03000-00e24000 rw-p 00000000 00:00 0           [heap]
  00e24000-011f7000 rw-p 00000000 00:00 0           [heap]
  ...
  35b1800000-35b1820000 r-xp 00000000 08:02 135522  /usr/lib64/ld-2.15.so
  35b1a1f000-35b1a20000 r--p 0001f000 08:02 135522  /usr/lib64/ld-2.15.so
  35b1a20000-35b1a21000 rw-p 00020000 08:02 135522  /usr/lib64/ld-2.15.so
  35b1a21000-35b1a22000 rw-p 00000000 00:00 0
  35b1c00000-35b1dac000 r-xp 00000000 08:02 135870  /usr/lib64/libc-2.15.so
  35b1dac000-35b1fac000 ---p 001ac000 08:02 135870  /usr/lib64/libc-2.15.so
  35b1fac000-35b1fb0000 r--p 001ac000 08:02 135870  /usr/lib64/libc-2.15.so
  35b1fb0000-35b1fb2000 rw-p 001b0000 08:02 135870  /usr/lib64/libc-2.15.so
  ...
  f2c6ff8c000-7f2c7078c000 rw-p 00000000 00:00 0    [stack:986]
  ...
  7fffb2c0d000-7fffb2c2e000 rw-p 00000000 00:00 0   [stack]
  7fffb2d48000-7fffb2d49000 r-xp 00000000 00:00 0   [vdso]
  .EE
  .in
* The
  _address_
  field is the address space in the process that the mapping occupies.
  The
  _perms_
  field is a set of permissions:
* .in +4
  .EX
  r = read
  w = write
  x = execute
  s = shared
  p = private (copy on write)
  .EE
  .in
* The
  _offset_
  field is the offset into the file/whatever;
  _dev_
  is the device
  (major:minor);
  _inode_
  is the inode on that device.
  0 indicates that no inode is associated with the memory region,
  as would be the case with BSS (uninitialized data).
* The
  _pathname_
  field will usually be the file that is backing the mapping.
  For ELF files,
  you can easily coordinate with the
  _offset_
  field by looking at the
  Offset field in the ELF program headers
  (_readelf&nbsp;-l_).
* There are additional helpful pseudo-paths:
    * _[stack]_  
      The initial process's (also known as the main thread's) stack.
    * _[stack:&lt;tid&gt;]_ (from Linux 3.4 to 4.4)  
      
      
      A thread's stack (where the
      _&lt;tid&gt;_
      is a thread ID).
      It corresponds to the
      _/proc/[pid]/task/[tid]/_
      path.
      This field was removed in Linux 4.5, since providing this information
      for a process with large numbers of threads is expensive.
    * _[vdso]_  
      The virtual dynamically linked shared object.
      See
      **vdso**(7).
    * _[heap]_  
      The process's heap.
      .in
* If the
  _pathname_
  field is blank,
  this is an anonymous mapping as obtained via
  **mmap**(2).
  There is no easy way to coordinate this back to a process's source,
  short of running it through
  **gdb**(1),
  **strace**(1),
  or similar.
* _pathname_
  is shown unescaped except for newline characters, which are replaced
  with an octal escape sequence.
  As a result, it is not possible to determine whether the original
  pathname contained a newline character or the literal
  _\ee012_
  character sequence.
* If the mapping is file-backed and the file has been deleted, the string
  " (deleted)" is appended to the pathname.
  Note that this is ambiguous too.
* Under Linux 2.0, there is no field giving pathname.
* _/proc/[pid]/mem_  
  This file can be used to access the pages of a process's memory through
  **open**(2),
  **read**(2),
  and
  **lseek**(2).
* Permission to access this file is governed by a ptrace access mode
  **PTRACE_MODE_ATTACH_FSCREDS**
  check; see
  **ptrace**(2).
* _/proc/[pid]/mountinfo_ (since Linux 2.6.26)  
  
  
  This file contains information about mount points
  in the process's mount namespace (see
  **mount_namespaces**(7)).
  It supplies various information
  (e.g., propagation state, root of mount for bind mounts,
  identifier for each mount and its parent) that is missing from the (older)
  _/proc/[pid]/mounts_
  file, and fixes various other problems with that file
  (e.g., nonextensibility,
  failure to distinguish per-mount versus per-superblock options).
* The file contains lines of the form:
* .in 0n
  .EX
  36 35 98:0 /mnt1 /mnt2 rw,noatime master:1 - ext3 /dev/root rw,errors=continue
  (1)(2)(3)   (4)   (5)      (6)      (7)   (8) (9)   (10)         (11)
  .in
  .EE
* The numbers in parentheses are labels for the descriptions below:
    * (1)  
      mount ID: a unique ID for the mount (may be reused after
      **umount**(2)).
    * (2)  
      parent ID: the ID of the parent mount
      (or of self for the root of this mount namespace's mount tree).
    * If a new mount is stacked on top of a previous existing mount
      (so that it hides the existing mount) at pathname P,
      then the parent of the new mount is the previous mount at that location.
      Thus, when looking at all the mounts stacked at a particular location,
      the top-most mount is the one that is not the parent
      of any other mount at the same location.
      (Note, however, that this top-most mount will be accessible only if
      the longest path subprefix of P that is a mount point
      is not itself hidden by a stacked mount.)
    * If the parent mount point lies outside the process's root directory (see
      **chroot**(2)),
      the ID shown here won't have a corresponding record in
      _mountinfo_
      whose mount ID (field 1) matches this parent mount ID
      (because mount points that lie outside the process's root directory
      are not shown in
      _mountinfo_).
      As a special case of this point,
      the process's root mount point may have a parent mount
      (for the initramfs filesystem) that lies
      
      
      outside the process's root directory,
      and an entry for that mount point will not appear in
      _mountinfo_.
    * (3)  
      major:minor: the value of
      _st_dev_
      for files on this filesystem (see
      **stat**(2)).
    * (4)  
      root: the pathname of the directory in the filesystem
      which forms the root of this mount.
    * (5)  
      mount point: the pathname of the mount point relative
      to the process's root directory.
    * (6)  
      mount options: per-mount options (see
      **mount**(2)).
    * (7)  
      optional fields: zero or more fields of the form "tag[:value]"; see below.
    * (8)  
      separator: the end of the optional fields is marked by a single hyphen.
    * (9)  
      filesystem type: the filesystem type in the form "type[.subtype]".
    * (10)  
      mount source: filesystem-specific information or "none".
    * (11)  
      super options: per-superblock options (see
      **mount**(2)).
* Currently, the possible optional fields are
  _shared_,
  _master_,
  _propagate_from_,
  and
  _unbindable_.
  See
  **mount_namespaces**(7)
  for a description of these fields.
  Parsers should ignore all unrecognized optional fields.
* For more information on mount propagation see:
  _Documentation/filesystems/sharedsubtree.txt_
  in the Linux kernel source tree.
* _/proc/[pid]/mounts_ (since Linux 2.4.19)  
  This file lists all the filesystems currently mounted in the
  process's mount namespace (see
  **mount_namespaces**(7)).
  The format of this file is documented in
  **fstab**(5).
* Since kernel version 2.6.15, this file is pollable:
  after opening the file for reading, a change in this file
  (i.e., a filesystem mount or unmount) causes
  **select**(2)
  to mark the file descriptor as having an exceptional condition, and
  **poll**(2)
  and
  **epoll_wait**(2)
  mark the file as having a priority event
  (**POLLPRI**).
  (Before Linux 2.6.30,
  a change in this file was indicated by the file descriptor
  being marked as readable for
  **select**(2),
  and being marked as having an error condition for
  **poll**(2)
  and
  **epoll_wait**(2).)
* _/proc/[pid]/mountstats_ (since Linux 2.6.17)  
  This file exports information (statistics, configuration information)
  about the mount points in the process's mount namespace (see
  **mount_namespaces**(7)).
  Lines in this file have the form:
* .in +4n
  .EX
  device /dev/sda7 mounted on /home with fstype ext3 [statistics]
  (       1      )            ( 2 )             (3 ) (4)
  .EE
  .in
* The fields in each line are:
    * (1)  
      The name of the mounted device
      (or "nodevice" if there is no corresponding device).
    * (2)  
      The mount point within the filesystem tree.
    * (3)  
      The filesystem type.
    * (4)  
      Optional statistics and configuration information.
      Currently (as at Linux 2.6.26), only NFS filesystems export
      information via this field.
* This file is readable only by the owner of the process.
* _/proc/[pid]/net_ (since Linux 2.6.25)  
  See the description of
  _/proc/net_.
* _/proc/[pid]/ns/_ (since Linux 3.0)  
  
  This is a subdirectory containing one entry for each namespace that
  supports being manipulated by
  **setns**(2).
  For more information, see
  **namespaces**(7).
* _/proc/[pid]/numa_maps_ (since Linux 2.6.14)  
  See
  **numa**(7).
* _/proc/[pid]/oom_adj_ (since Linux 2.6.11)  
  This file can be used to adjust the score used to select which process
  should be killed in an out-of-memory (OOM) situation.
  The kernel uses this value for a bit-shift operation of the process's
  _oom_score_
  value:
  valid values are in the range -16 to +15,
  plus the special value -17,
  which disables OOM-killing altogether for this process.
  A positive score increases the likelihood of this
  process being killed by the OOM-killer;
  a negative score decreases the likelihood.
* The default value for this file is 0;
  a new process inherits its parent's
  _oom_adj_
  setting.
  A process must be privileged
  (**CAP_SYS_RESOURCE**)
  to update this file.
* Since Linux 2.6.36, use of this file is deprecated in favor of
  _/proc/[pid]/oom_score_adj_.
* _/proc/[pid]/oom_score_ (since Linux 2.6.11)  
  
  
  
  This file displays the current score that the kernel gives to
  this process for the purpose of selecting a process
  for the OOM-killer.
  A higher score means that the process is more likely to be
  selected by the OOM-killer.
  The basis for this score is the amount of memory used by the process,
  with increases (+) or decreases (-) for factors including:
  
  
  
    * *  
      whether the process is privileged (-).
      
* Before kernel 2.6.36 the following factors were also used in the calculation of oom_score:
    * *  
      whether the process creates a lot of children using
      **fork**(2)
      (+);
    * *  
      whether the process has been running a long time,
      or has used a lot of CPU time (-);
    * *  
      whether the process has a low nice value (i.e., &gt; 0) (+); and
    * *  
      whether the process is making direct hardware access (-).
      
* The
  _oom_score_
  also reflects the adjustment specified by the
  _oom_score_adj_
  or
  _oom_adj_
  setting for the process.
* _/proc/[pid]/oom_score_adj_ (since Linux 2.6.36)  
  
  This file can be used to adjust the badness heuristic used to select which
  process gets killed in out-of-memory conditions.
* The badness heuristic assigns a value to each candidate task ranging from 0
  (never kill) to 1000 (always kill) to determine which process is targeted.
  The units are roughly a proportion along that range of
  allowed memory the process may allocate from,
  based on an estimation of its current memory and swap use.
  For example, if a task is using all allowed memory,
  its badness score will be 1000.
  If it is using half of its allowed memory, its score will be 500.
* There is an additional factor included in the badness score: root
  processes are given 3% extra memory over other tasks.
* The amount of "allowed" memory depends on the context
  in which the OOM-killer was called.
  If it is due to the memory assigned to the allocating task's cpuset
  being exhausted,
  the allowed memory represents the set of mems assigned to that
  cpuset (see
  **cpuset**(7)).
  If it is due to a mempolicy's node(s) being exhausted,
  the allowed memory represents the set of mempolicy nodes.
  If it is due to a memory limit (or swap limit) being reached,
  the allowed memory is that configured limit.
  Finally, if it is due to the entire system being out of memory, the
  allowed memory represents all allocatable resources.
* The value of
  _oom_score_adj_
  is added to the badness score before it
  is used to determine which task to kill.
  Acceptable values range from -1000
  (OOM_SCORE_ADJ_MIN) to +1000 (OOM_SCORE_ADJ_MAX).
  This allows user space to control the preference for OOM-killing,
  ranging from always preferring a certain
  task or completely disabling it from OOM killing.
  The lowest possible value, -1000, is
  equivalent to disabling OOM-killing entirely for that task,
  since it will always report a badness score of 0.
* Consequently, it is very simple for user space to define
  the amount of memory to consider for each task.
  Setting an
  _oom_score_adj_
  value of +500, for example,
  is roughly equivalent to allowing the remainder of tasks sharing the
  same system, cpuset, mempolicy, or memory controller resources
  to use at least 50% more memory.
  A value of -500, on the other hand, would be roughly
  equivalent to discounting 50% of the task's
  allowed memory from being considered as scoring against the task.
* For backward compatibility with previous kernels,
  _/proc/[pid]/oom_adj_
  can still be used to tune the badness score.
  Its value is
  scaled linearly with
  _oom_score_adj_.
* Writing to
  _/proc/[pid]/oom_score_adj_
  or
  _/proc/[pid]/oom_adj_
  will change the other with its scaled value.
* The
  **choom**(1)
  program provides a command-line interface for adjusting the
  _oom_score_adj_
  value of a running process or a newly executed command.
* _/proc/[pid]/pagemap_ (since Linux 2.6.25)  
  This file shows the mapping of each of the process's virtual pages
  into physical page frames or swap area.
  It contains one 64-bit value for each virtual page,
  with the bits set as follows:
    * 63  
      If set, the page is present in RAM.
    * 62  
      If set, the page is in swap space
    * 61 (since Linux 3.5)  
      The page is a file-mapped page or a shared anonymous page.
    * 60–57 (since Linux 3.11)  
      Zero
      
    * 56 (since Linux 4.2)  
      
      
      The page is exclusively mapped.
    * 55 (since Linux 3.11)  
      PTE is soft-dirty
      (see the kernel source file
      _Documentation/admin-guide/mm/soft-dirty.rst_).
    * 54–0  
      If the page is present in RAM (bit 63), then these bits
      provide the page frame number, which can be used to index
      _/proc/kpageflags_
      and
      _/proc/kpagecount_.
      If the page is present in swap (bit 62),
      then bits 4–0 give the swap type, and bits 54–5 encode the swap offset.
* Before Linux 3.11, bits 60–55 were
  used to encode the base-2 log of the page size.
* To employ
  _/proc/[pid]/pagemap_
  efficiently, use
  _/proc/[pid]/maps_
  to determine which areas of memory are actually mapped and seek
  to skip over unmapped regions.
* The
  _/proc/[pid]/pagemap_
  file is present only if the
  **CONFIG_PROC_PAGE_MONITOR**
  kernel configuration option is enabled.
* Permission to access this file is governed by a ptrace access mode
  **PTRACE_MODE_READ_FSCREDS**
  check; see
  **ptrace**(2).
* _/proc/[pid]/personality_ (since Linux 2.6.28)  
  
  This read-only file exposes the process's execution domain, as set by
  **personality**(2).
  The value is displayed in hexadecimal notation.
* Permission to access this file is governed by a ptrace access mode
  **PTRACE_MODE_ATTACH_FSCREDS**
  check; see
  **ptrace**(2).
* _/proc/[pid]/root_  
  UNIX and Linux support the idea of a per-process root of the
  filesystem, set by the
  **chroot**(2)
  system call.
  This file is a symbolic link that points to the process's
  root directory, and behaves in the same way as
  _exe_,
  and
  _fd/*_.
* Note however that this file is not merely a symbolic link.
  It provides the same view of the filesystem (including namespaces and the
  set of per-process mounts) as the process itself.
  An example illustrates this point.
  In one terminal, we start a shell in new user and mount namespaces,
  and in that shell we create some new mount points:
* .in +4n
  .EX
  $ **PS1='sh1# ' unshare -Urnm**
  sh1# **mount -t tmpfs tmpfs /etc**  # Mount empty tmpfs at /etc
  sh1# **mount --bind /usr /dev**     # Mount /usr at /dev
  sh1# **echo $$**
  27123
  .EE
  .in
* In a second terminal window, in the initial mount namespace,
  we look at the contents of the corresponding mounts in
  the initial and new namespaces:
* .in +4n
  .EX
  $ **PS1='sh2# ' sudo sh**
  sh2# **ls /etc | wc -l**                  # In initial NS
  309
  sh2# **ls /proc/27123/root/etc | wc -l**  # /etc in other NS
  0                                     # The empty tmpfs dir
  sh2# **ls /dev | wc -l**                  # In initial NS
  205
  sh2# **ls /proc/27123/root/dev | wc -l**  # /dev in other NS
  11                                    # Actually bind
                                        # mounted to /usr
  sh2# **ls /usr | wc -l**                  # /usr in initial NS
  11
  .EE
  .in
* 
  In a multithreaded process, the contents of the
  _/proc/[pid]/root_
  symbolic link are not available if the main thread has already terminated
  (typically by calling
  **pthread_exit**(3)).
* Permission to dereference or read
  (**readlink**(2))
  this symbolic link is governed by a ptrace access mode
  **PTRACE_MODE_READ_FSCREDS**
  check; see
  **ptrace**(2).
  
  
  
* _/proc/[pid]/seccomp_ (Linux 2.6.12 to 2.6.22)  
  This file can be used to read and change the process's
  secure computing (seccomp) mode setting.
  It contains the value 0 if the process is not in seccomp mode,
  and 1 if the process is in strict seccomp mode (see
  **seccomp**(2)).
  Writing 1 to this file places the process irreversibly in strict seccomp mode.
  (Further attempts to write to the file fail with the
  **EPERM**
  error.)
* In Linux 2.6.23,
  this file went away, to be replaced by the
  **prctl**(2)
  **PR_GET_SECCOMP**
  and
  **PR_SET_SECCOMP**
  operations (and later by
  **seccomp**(2)
  and the
  _Seccomp_
  field in
  _/proc/[pid]/status_).
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
* _/proc/[pid]/setgroups_ (since Linux 3.19)  
  See
  **user_namespaces**(7).
* _/proc/[pid]/smaps_ (since Linux 2.6.14)  
  This file shows memory consumption for each of the process's mappings.
  (The
  **pmap**(1)
  command displays similar information,
  in a form that may be easier for parsing.)
  For each mapping there is a series of lines such as the following:
* .in +4n
  .EX
  00400000-0048a000 r-xp 00000000 fd:03 960637       /bin/bash
  Size:                552 kB
  Rss:                 460 kB
  Pss:                 100 kB
  Shared_Clean:        452 kB
  Shared_Dirty:          0 kB
  Private_Clean:         8 kB
  Private_Dirty:         0 kB
  Referenced:          460 kB
  Anonymous:             0 kB
  AnonHugePages:         0 kB
  ShmemHugePages:        0 kB
  ShmemPmdMapped:        0 kB
  Swap:                  0 kB
  KernelPageSize:        4 kB
  MMUPageSize:           4 kB
  KernelPageSize:        4 kB
  MMUPageSize:           4 kB
  Locked:                0 kB
  ProtectionKey:         0
  VmFlags: rd ex mr mw me dw
  .EE
  .in
* The first of these lines shows the same information as is displayed
  for the mapping in
  _/proc/[pid]/maps_.
  The following lines show the size of the mapping,
  the amount of the mapping that is currently resident in RAM ("Rss"),
  the process's proportional share of this mapping ("Pss"),
  the number of clean and dirty shared pages in the mapping,
  and the number of clean and dirty private pages in the mapping.
  "Referenced" indicates the amount of memory currently marked as
  referenced or accessed.
  "Anonymous" shows the amount of memory
  that does not belong to any file.
  "Swap" shows how much
  would-be-anonymous memory is also used, but out on swap.
* The "KernelPageSize" line (available since Linux 2.6.29)
  is the page size used by the kernel to back the virtual memory area.
  This matches the size used by the MMU in the majority of cases.
  However, one counter-example occurs on PPC64 kernels
  whereby a kernel using 64kB as a base page size may still use 4kB
  pages for the MMU on older processors.
  To distinguish the two attributes, the "MMUPageSize" line
  (also available since Linux 2.6.29)
  reports the page size used by the MMU.
* The "Locked" indicates whether the mapping is locked in memory
  or not.
* The "ProtectionKey" line (available since Linux 4.9, on x86 only)
  contains the memory protection key (see
  **pkeys**(7))
  associated with the virtual memory area.
  This entry is present only if the kernel was built with the
  **CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS**
  configuration option.
* The "VmFlags" line (available since Linux 3.8)
  represents the kernel flags associated with the virtual memory area,
  encoded using the following two-letter codes:
*     rd  - readable
      wr  - writable
      ex  - executable
      sh  - shared
      mr  - may read
      mw  - may write
      me  - may execute
      ms  - may share
      gd  - stack segment grows down
      pf  - pure PFN range
      dw  - disabled write to the mapped file
      lo  - pages are locked in memory
      io  - memory mapped I/O area
      sr  - sequential read advise provided
      rr  - random read advise provided
      dc  - do not copy area on fork
      de  - do not expand area on remapping
      ac  - area is accountable
      nr  - swap space is not reserved for the area
      ht  - area uses huge tlb pages
      nl  - non-linear mapping
      ar  - architecture specific flag
      dd  - do not include area into core dump
      sd  - soft-dirty flag
      mm  - mixed map area
      hg  - huge page advise flag
      nh  - no-huge page advise flag
      mg  - mergeable advise flag
* "ProtectionKey" field contains the memory protection key (see
  **pkeys**(5))
  associated with the virtual memory area.
  Present only if the kernel was built with the
  **CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS**
  configuration option. (since Linux 4.6)
* The
  _/proc/[pid]/smaps_
  file is present only if the
  **CONFIG_PROC_PAGE_MONITOR**
  kernel configuration option is enabled.
* _/proc/[pid]/stack_ (since Linux 2.6.29)  
  
  This file provides a symbolic trace of the function calls in this
  process's kernel stack.
  This file is provided only if the kernel was built with the
  **CONFIG_STACKTRACE**
  configuration option.
* Permission to access this file is governed by a ptrace access mode
  **PTRACE_MODE_ATTACH_FSCREDS**
  check; see
  **ptrace**(2).
* _/proc/[pid]/stat_  
  Status information about the process.
  This is used by
  **ps**(1).
  It is defined in the kernel source file
  _fs/proc/array.c_.
* The fields, in order, with their proper
  **scanf**(3)
  format specifiers, are listed below.
  Whether or not certain of these fields display valid information is governed by
  a ptrace access mode
  **PTRACE_MODE_READ_FSCREDS**&nbsp;|&nbsp;**PTRACE_MODE_NOAUDIT**
  check (refer to
  **ptrace**(2)).
  If the check denies access, then the field value is displayed as 0.
  The affected fields are indicated with the marking [PT].
*     * (1) _pid_ &nbsp;%d    
      The process ID.
    * (2) _comm_ &nbsp;%s  
      The filename of the executable, in parentheses.
      This is visible whether or not the executable is swapped out.
    * (3) _state_ &nbsp;%c  
      One of the following characters, indicating process state:
        * R  
          Running
        * S  
          Sleeping in an interruptible wait
        * D  
          Waiting in uninterruptible
          disk sleep
        * Z  
          Zombie
        * T  
          Stopped (on a signal) or (before Linux 2.6.33) trace stopped
        * t  
          
          Tracing stop (Linux 2.6.33 onward)
        * W  
          Paging (only before Linux 2.6.0)
        * X  
          Dead (from Linux 2.6.0 onward)
        * x  
          
          Dead (Linux 2.6.33 to
          
          3.13 only)
        * K  
          
          Wakekill (Linux 2.6.33 to
          
          3.13 only)
        * W  
          
          Waking (Linux 2.6.33 to
          
          3.13 only)
        * P  
          
          Parked (Linux 3.9 to
          
          3.13 only)
    * (4) _ppid_ &nbsp;%d  
      The PID of the parent of this process.
    * (5) _pgrp_ &nbsp;%d  
      The process group ID of the process.
    * (6) _session_ &nbsp;%d  
      The session ID of the process.
    * (7) _tty\_nr_ &nbsp;%d  
      The controlling terminal of the process.
      (The minor device number is contained in the combination of bits
      31 to 20 and 7 to 0;
      the major device number is in bits 15 to 8.)
    * (8) _tpgid_ &nbsp;%d  
      
      The ID of the foreground process group of the controlling
      terminal of the process.
    * (9) _flags_ &nbsp;%u  
      The kernel flags word of the process.
      For bit meanings,
      see the PF_* defines in the Linux kernel source file
      _include/linux/sched.h_.
      Details depend on the kernel version.
    * The format for this field was %lu before Linux 2.6.
    * (10) _minflt_ &nbsp;%lu  
      The number of minor faults the process has made which have not
      required loading a memory page from disk.
    * (11) _cminflt_ &nbsp;%lu  
      The number of minor faults that the process's
      waited-for children have made.
    * (12) _majflt_ &nbsp;%lu  
      The number of major faults the process has made which have
      required loading a memory page from disk.
    * (13) _cmajflt_ &nbsp;%lu  
      The number of major faults that the process's
      waited-for children have made.
    * (14) _utime_ &nbsp;%lu  
      Amount of time that this process has been scheduled in user mode,
      measured in clock ticks (divide by
      _sysconf(_SC_CLK_TCK)_).
      This includes guest time, _guest\_time_
      (time spent running a virtual CPU, see below),
      so that applications that are not aware of the guest time field
      do not lose that time from their calculations.
    * (15) _stime_ &nbsp;%lu  
      Amount of time that this process has been scheduled in kernel mode,
      measured in clock ticks (divide by
      _sysconf(_SC_CLK_TCK)_).
    * (16) _cutime_ &nbsp;%ld  
      Amount of time that this process's
      waited-for children have been scheduled in user mode,
      measured in clock ticks (divide by
      _sysconf(_SC_CLK_TCK)_).
      (See also
      **times**(2).)
      This includes guest time, _cguest\_time_
      (time spent running a virtual CPU, see below).
    * (17) _cstime_ &nbsp;%ld  
      Amount of time that this process's
      waited-for children have been scheduled in kernel mode,
      measured in clock ticks (divide by
      _sysconf(_SC_CLK_TCK)_).
    * (18) _priority_ &nbsp;%ld  
      (Explanation for Linux 2.6)
      For processes running a real-time scheduling policy
      (_policy_
      below; see
      **sched_setscheduler**(2)),
      this is the negated scheduling priority, minus one;
      that is, a number in the range -2 to -100,
      corresponding to real-time priorities 1 to 99.
      For processes running under a non-real-time scheduling policy,
      this is the raw nice value
      (**setpriority**(2))
      as represented in the kernel.
      The kernel stores nice values as numbers
      in the range 0 (high) to 39 (low),
      corresponding to the user-visible nice range of -20 to 19.
    * Before Linux 2.6, this was a scaled value based on
      the scheduler weighting given to this process.
      
    * (19) _nice_ &nbsp;%ld  
      The nice value (see
      **setpriority**(2)),
      a value in the range 19 (low priority) to -20 (high priority).
      
      
      
      
      
      
      
      
      
      
    * (20) _num\_threads_ &nbsp;%ld  
      Number of threads in this process (since Linux 2.6).
      Before kernel 2.6, this field was hard coded to 0 as a placeholder
      for an earlier removed field.
    * (21) _itrealvalue_ &nbsp;%ld  
      The time in jiffies before the next
      **SIGALRM**
      is sent to the process due to an interval timer.
      Since kernel 2.6.17, this field is no longer maintained,
      and is hard coded as 0.
    * (22) _starttime_ &nbsp;%llu  
      The time the process started after system boot.
      In kernels before Linux 2.6, this value was expressed in jiffies.
      Since Linux 2.6, the value is expressed in clock ticks (divide by
      _sysconf(_SC_CLK_TCK)_).
    * The format for this field was %lu before Linux 2.6.
    * (23) _vsize_ &nbsp;%lu  
      Virtual memory size in bytes.
    * (24) _rss_ &nbsp;%ld  
      Resident Set Size: number of pages the process has in real memory.
      This is just the pages which
      count toward text, data, or stack space.
      This does not include pages
      which have not been demand-loaded in, or which are swapped out.
    * (25) _rsslim_ &nbsp;%lu  
      Current soft limit in bytes on the rss of the process;
      see the description of
      **RLIMIT_RSS**
      in
      **getrlimit**(2).
    * (26) _startcode_ &nbsp;%lu &nbsp;[PT]  
      The address above which program text can run.
    * (27) _endcode_ &nbsp;%lu &nbsp;[PT]  
      The address below which program text can run.
    * (28) _startstack_ &nbsp;%lu &nbsp;[PT]  
      The address of the start (i.e., bottom) of the stack.
    * (29) _kstkesp_ &nbsp;%lu &nbsp;[PT]  
      The current value of ESP (stack pointer), as found in the
      kernel stack page for the process.
    * (30) _kstkeip_ &nbsp;%lu &nbsp;[PT]  
      The current EIP (instruction pointer).
    * (31) _signal_ &nbsp;%lu  
      The bitmap of pending signals, displayed as a decimal number.
      Obsolete, because it does not provide information on real-time signals; use
      _/proc/[pid]/status_
      instead.
    * (32) _blocked_ &nbsp;%lu  
      The bitmap of blocked signals, displayed as a decimal number.
      Obsolete, because it does not provide information on real-time signals; use
      _/proc/[pid]/status_
      instead.
    * (33) _sigignore_ &nbsp;%lu  
      The bitmap of ignored signals, displayed as a decimal number.
      Obsolete, because it does not provide information on real-time signals; use
      _/proc/[pid]/status_
      instead.
    * (34) _sigcatch_ &nbsp;%lu  
      The bitmap of caught signals, displayed as a decimal number.
      Obsolete, because it does not provide information on real-time signals; use
      _/proc/[pid]/status_
      instead.
    * (35) _wchan_ &nbsp;%lu &nbsp;[PT]  
      This is the "channel" in which the process is waiting.
      It is the address of a location in the kernel where the process is sleeping.
      The corresponding symbolic name can be found in
      _/proc/[pid]/wchan_.
    * (36) _nswap_ &nbsp;%lu  
      
      Number of pages swapped (not maintained).
    * (37) _cnswap_ &nbsp;%lu  
      
      Cumulative _nswap_ for child processes (not maintained).
    * (38) _exit\_signal_ &nbsp;%d &nbsp;(since Linux 2.1.22)  
      Signal to be sent to parent when we die.
    * (39) _processor_ &nbsp;%d &nbsp;(since Linux 2.2.8)  
      CPU number last executed on.
    * (40) _rt\_priority_ &nbsp;%u &nbsp;(since Linux 2.5.19)  
      Real-time scheduling priority, a number in the range 1 to 99 for
      processes scheduled under a real-time policy,
      or 0, for non-real-time processes (see
      **sched_setscheduler**(2)).
    * (41) _policy_ &nbsp;%u &nbsp;(since Linux 2.5.19)  
      Scheduling policy (see
      **sched_setscheduler**(2)).
      Decode using the SCHED_* constants in
      _linux/sched.h_.
    * The format for this field was %lu before Linux 2.6.22.
    * (42) _delayacct\_blkio\_ticks_ &nbsp;%llu &nbsp;(since Linux 2.6.18)  
      Aggregated block I/O delays, measured in clock ticks (centiseconds).
    * (43) _guest\_time_ &nbsp;%lu &nbsp;(since Linux 2.6.24)  
      Guest time of the process (time spent running a virtual CPU
      for a guest operating system), measured in clock ticks (divide by
      _sysconf(_SC_CLK_TCK)_).
    * (44) _cguest\_time_ &nbsp;%ld &nbsp;(since Linux 2.6.24)  
      Guest time of the process's children, measured in clock ticks (divide by
      _sysconf(_SC_CLK_TCK)_).
    * (45) _start\_data_ &nbsp;%lu &nbsp;(since Linux 3.3) &nbsp;[PT]  
      
      Address above which program initialized and
      uninitialized (BSS) data are placed.
    * (46) _end\_data_ &nbsp;%lu &nbsp;(since Linux 3.3) &nbsp;[PT]  
      
      Address below which program initialized and
      uninitialized (BSS) data are placed.
    * (47) _start\_brk_ &nbsp;%lu &nbsp;(since Linux 3.3) &nbsp;[PT]  
      
      Address above which program heap can be expanded with
      **brk**(2).
    * (48) _arg\_start_ &nbsp;%lu &nbsp;(since Linux 3.5) &nbsp;[PT]  
      
      Address above which program command-line arguments
      (_argv_)
      are placed.
    * (49) _arg\_end_ &nbsp;%lu &nbsp;(since Linux 3.5) &nbsp;[PT]  
      
      Address below program command-line arguments
      (_argv_)
      are placed.
    * (50) _env\_start_ &nbsp;%lu &nbsp;(since Linux 3.5) &nbsp;[PT]  
      
      Address above which program environment is placed.
    * (51) _env\_end_ &nbsp;%lu &nbsp;(since Linux 3.5) &nbsp;[PT]  
      
      Address below which program environment is placed.
    * (52) _exit\_code_ &nbsp;%d &nbsp;(since Linux 3.5) &nbsp;[PT]  
      
      The thread's exit status in the form reported by
      **waitpid**(2).
* _/proc/[pid]/statm_  
  Provides information about memory usage, measured in pages.
  The columns are:
* .in +4n
  .EX
  size       (1) total program size
             (same as VmSize in _/proc/[pid]/status_)
  resident   (2) resident set size
             (same as VmRSS in _/proc/[pid]/status_)
  shared     (3) number of resident shared pages (i.e., backed by a file)
             (same as RssFile+RssShmem in _/proc/[pid]/status_)
  text       (4) text (code)
  
  lib        (5) library (unused since Linux 2.6; always 0)
  data       (6) data + stack
  
  dt         (7) dirty pages (unused since Linux 2.6; always 0)
  .EE
  .in
* _/proc/[pid]/status_  
  Provides much of the information in
  _/proc/[pid]/stat_
  and
  _/proc/[pid]/statm_
  in a format that's easier for humans to parse.
  Here's an example:
* .in +4n
  .EX
  $** cat /proc/$$/status**
  Name:   bash
  Umask:  0022
  State:  S (sleeping)
  Tgid:   17248
  Ngid:   0
  Pid:    17248
  PPid:   17200
  TracerPid:      0
  Uid:    1000    1000    1000    1000
  Gid:    100     100     100     100
  FDSize: 256
  Groups: 16 33 100
  NStgid: 17248
  NSpid:  17248
  NSpgid: 17248
  NSsid:  17200
  VmPeak:	  131168 kB
  VmSize:	  131168 kB
  VmLck:	       0 kB
  VmPin:	       0 kB
  VmHWM:	   13484 kB
  VmRSS:	   13484 kB
  RssAnon:	   10264 kB
  RssFile:	    3220 kB
  RssShmem:	       0 kB
  VmData:	   10332 kB
  VmStk:	     136 kB
  VmExe:	     992 kB
  VmLib:	    2104 kB
  VmPTE:	      76 kB
  VmPMD:	      12 kB
  VmSwap:	       0 kB
  HugetlbPages:          0 kB		# 4.4
  CoreDumping:	0                       # 4.15
  Threads:        1
  SigQ:   0/3067
  SigPnd: 0000000000000000
  ShdPnd: 0000000000000000
  SigBlk: 0000000000010000
  SigIgn: 0000000000384004
  SigCgt: 000000004b813efb
  CapInh: 0000000000000000
  CapPrm: 0000000000000000
  CapEff: 0000000000000000
  CapBnd: ffffffffffffffff
  CapAmb:	0000000000000000
  NoNewPrivs:     0
  Seccomp:        0
  Speculation_Store_Bypass:       vulnerable
  Cpus_allowed:   00000001
  Cpus_allowed_list:      0
  Mems_allowed:   1
  Mems_allowed_list:      0
  voluntary_ctxt_switches:        150
  nonvoluntary_ctxt_switches:     545
  .EE
  .in
* The fields are as follows:
    * *  
      _Name_:
      Command run by this process.
    * *  
      _Umask_:
      Process umask, expressed in octal with a leading zero; see
      **umask**(2).
      (Since Linux 4.7.)
    * *  
      _State_:
      Current state of the process.
      One of
      "R (running)",
      "S (sleeping)",
      "D (disk sleep)",
      "T (stopped)",
      "T (tracing stop)",
      "Z (zombie)",
      or
      "X (dead)".
    * *  
      _Tgid_:
      Thread group ID (i.e., Process ID).
    * *  
      _Ngid_:
      NUMA group ID (0 if none; since Linux 3.13).
    * *  
      _Pid_:
      Thread ID (see
      **gettid**(2)).
    * *  
      _PPid_:
      PID of parent process.
    * *  
      _TracerPid_:
      PID of process tracing this process (0 if not being traced).
    * *  
      _Uid_, _Gid_:
      Real, effective, saved set, and filesystem UIDs (GIDs).
    * *  
      _FDSize_:
      Number of file descriptor slots currently allocated.
    * *  
      _Groups_:
      Supplementary group list.
    * *  
      _NStgid_:
      Thread group ID (i.e., PID) in each of the PID namespaces of which
      _[pid]_
      is a member.
      The leftmost entry shows the value with respect to the PID namespace
      of the process that mounted this procfs (or the root namespace
      if mounted by the kernel),
      followed by the value in successively nested inner namespaces.
      
      (Since Linux 4.1.)
    * *  
      _NSpid_:
      Thread ID in each of the PID namespaces of which
      _[pid]_
      is a member.
      The fields are ordered as for
      _NStgid_.
      (Since Linux 4.1.)
    * *  
      _NSpgid_:
      Process group ID in each of the PID namespaces of which
      _[pid]_
      is a member.
      The fields are ordered as for
      _NStgid_.
      (Since Linux 4.1.)
    * *  
      _NSsid_:
      descendant namespace session ID hierarchy
      Session ID in each of the PID namespaces of which
      _[pid]_
      is a member.
      The fields are ordered as for
      _NStgid_.
      (Since Linux 4.1.)
    * *  
      _VmPeak_:
      Peak virtual memory size.
    * *  
      _VmSize_:
      Virtual memory size.
    * *  
      _VmLck_:
      Locked memory size (see
      **mlock**(2)).
    * *  
      _VmPin_:
      Pinned memory size
      
      (since Linux 3.2).
      These are pages that can't be moved because something needs to
      directly access physical memory.
    * *  
      _VmHWM_:
      Peak resident set size ("high water mark").
    * *  
      _VmRSS_:
      Resident set size.
      Note that the value here is the sum of
      _RssAnon_,
      _RssFile_,
      and
      _RssShmem_.
    * *  
      _RssAnon_:
      Size of resident anonymous memory.
      
      (since Linux 4.5).
    * *  
      _RssFile_:
      Size of resident file mappings.
      
      (since Linux 4.5).
    * *  
      _RssShmem_:
      Size of resident shared memory (includes System V shared memory,
      mappings from
      **tmpfs**(5),
      and shared anonymous mappings).
      
      (since Linux 4.5).
    * *  
      _VmData_, _VmStk_, _VmExe_:
      Size of data, stack, and text segments.
    * *  
      _VmLib_:
      Shared library code size.
    * *  
      _VmPTE_:
      Page table entries size (since Linux 2.6.10).
    * *  
      _VmPMD_:
      
      Size of second-level page tables (added in Linux 4.0; removed in Linux 4.15).
    * *  
      _VmSwap_:
      
      Swapped-out virtual memory size by anonymous private pages;
      shmem swap usage is not included (since Linux 2.6.34).
    * *  
      _HugetlbPages_:
      Size of hugetlb memory portions
      
      (since Linux 4.4).
    * *  
      _CoreDumping_:
      Contains the value 1 if the process is currently dumping core,
      and 0 if it is not
      
      (since Linux 4.15).
      This information can be used by a monitoring process to avoid killing
      a process that is currently dumping core,
      which could result in a corrupted core dump file.
    * *  
      _Threads_:
      Number of threads in process containing this thread.
    * *  
      _SigQ_:
      This field contains two slash-separated numbers that relate to
      queued signals for the real user ID of this process.
      The first of these is the number of currently queued
      signals for this real user ID, and the second is the
      resource limit on the number of queued signals for this process
      (see the description of
      **RLIMIT_SIGPENDING**
      in
      **getrlimit**(2)).
    * *  
      _SigPnd_, _ShdPnd_:
      Mask (expressed in hexadecimal)
      of signals pending for thread and for process as a whole (see
      **pthreads**(7)
      and
      **signal**(7)).
    * *  
      _SigBlk_, _SigIgn_, _SigCgt_:
      Masks (expressed in hexadecimal)
      indicating signals being blocked, ignored, and caught (see
      **signal**(7)).
    * *  
      _CapInh_, _CapPrm_, _CapEff_:
      Masks (expressed in hexadecimal)
      of capabilities enabled in inheritable, permitted, and effective sets
      (see
      **capabilities**(7)).
    * *  
      _CapBnd_:
      Capability bounding set, expressed in hexadecimal
      (since Linux 2.6.26, see
      **capabilities**(7)).
    * *  
      _CapAmb_:
      Ambient capability set, expressed in hexadecimal
      (since Linux 4.3, see
      **capabilities**(7)).
    * *  
      _NoNewPrivs_:
      
      Value of the
      _no_new_privs_
      bit
      (since Linux 4.10, see
      **prctl**(2)).
    * *  
      _Seccomp_:
      
      Seccomp mode of the process
      (since Linux 3.8, see
      **seccomp**(2)).
      0 means
      **SECCOMP_MODE_DISABLED**;
      1 means
      **SECCOMP_MODE_STRICT**;
      2 means
      **SECCOMP_MODE_FILTER**.
      This field is provided only if the kernel was built with the
      **CONFIG_SECCOMP**
      kernel configuration option enabled.
    * *  
      _Speculation_Store_Bypass_:
      
      Speculation flaw mitigation state
      (since Linux 4.17, see
      **prctl**(2)).
    * *  
      _Cpus_allowed_:
      Hexadecimal mask of CPUs on which this process may run
      (since Linux 2.6.24, see
      **cpuset**(7)).
    * *  
      _Cpus_allowed_list_:
      Same as previous, but in "list format"
      (since Linux 2.6.26, see
      **cpuset**(7)).
    * *  
      _Mems_allowed_:
      Mask of memory nodes allowed to this process
      (since Linux 2.6.24, see
      **cpuset**(7)).
    * *  
      _Mems_allowed_list_:
      Same as previous, but in "list format"
      (since Linux 2.6.26, see
      **cpuset**(7)).
    * *  
      _voluntary_ctxt_switches_, _nonvoluntary_ctxt_switches_:
      Number of voluntary and involuntary context switches (since Linux 2.6.23).
* _/proc/[pid]/syscall_ (since Linux 2.6.27)  
  
  This file exposes the system call number and argument registers for the
  system call currently being executed by the process,
  followed by the values of the stack pointer and program counter registers.
  The values of all six argument registers are exposed,
  although most system calls use fewer registers.
* If the process is blocked, but not in a system call,
  then the file displays -1 in place of the system call number,
  followed by just the values of the stack pointer and program counter.
  If process is not blocked, then the file contains just the string "running".
* This file is present only if the kernel was configured with
  **CONFIG_HAVE_ARCH_TRACEHOOK**.
* Permission to access this file is governed by a ptrace access mode
  **PTRACE_MODE_ATTACH_FSCREDS**
  check; see
  **ptrace**(2).
* _/proc/[pid]/task_ (since Linux 2.6.0)  
  
  This is a directory that contains one subdirectory
  for each thread in the process.
  The name of each subdirectory is the numerical thread ID
  (_[tid]_)
  of the thread (see
  **gettid**(2)).
* Within each of these subdirectories, there is a set of
  files with the same names and contents as under the
  _/proc/[pid]_
  directories.
  For attributes that are shared by all threads, the contents for
  each of the files under the
  _task/[tid]_
  subdirectories will be the same as in the corresponding
  file in the parent
  _/proc/[pid]_
  directory
  (e.g., in a multithreaded process, all of the
  _task/[tid]/cwd_
  files will have the same value as the
  _/proc/[pid]/cwd_
  file in the parent directory, since all of the threads in a process
  share a working directory).
  For attributes that are distinct for each thread,
  the corresponding files under
  _task/[tid]_
  may have different values (e.g., various fields in each of the
  _task/[tid]/status_
  files may be different for each thread),
  
  or they might not exist in
  _/proc/[pid]_
  at all.
* 
  In a multithreaded process, the contents of the
  _/proc/[pid]/task_
  directory are not available if the main thread has already terminated
  (typically by calling
  **pthread_exit**(3)).
* * _/proc/[pid]/task/[tid]/children_ (since Linux 3.5)  
  
  A space-separated list of child tasks of this task.
  Each child task is represented by its TID.
* 
  This option is intended for use by the checkpoint-restore (CRIU) system,
  and reliably provides a list of children only if all of the child processes
  are stopped or frozen.
  It does not work properly if children of the target task exit while
  the file is being read!
  Exiting children may cause non-exiting children to be omitted from the list.
  This makes this interface even more unreliable than classic PID-based
  approaches if the inspected task and its children aren't frozen,
  and most code should probably not use this interface.
* Until Linux 4.2, the presence of this file was governed by the
  **CONFIG_CHECKPOINT_RESTORE**
  kernel configuration option.
  Since Linux 4.2,
  
  it is governed by the
  **CONFIG_PROC_CHILDREN**
  option.
* _/proc/[pid]/timers_ (since Linux 3.10)  
  
  
  A list of the POSIX timers for this process.
  Each timer is listed with a line that starts with the string "ID:".
  For example:
* .in +4n
  .EX
  ID: 1
  signal: 60/00007fff86e452a8
  notify: signal/pid.2634
  ClockID: 0
  ID: 0
  signal: 60/00007fff86e452a8
  notify: signal/pid.2634
  ClockID: 1
  .EE
  .in
* The lines shown for each timer have the following meanings:
    * _ID_  
      The ID for this timer.
      This is not the same as the timer ID returned by
      **timer_create**(2);
      rather, it is the same kernel-internal ID that is available via the
      _si_timerid_
      field of the
      _siginfo_t_
      structure (see
      **sigaction**(2)).
    * _signal_  
      This is the signal number that this timer uses to deliver notifications
      followed by a slash, and then the
      _sigev_value_
      value supplied to the signal handler.
      Valid only for timers that notify via a signal.
    * _notify_  
      The part before the slash specifies the mechanism
      that this timer uses to deliver notifications,
      and is one of "thread", "signal", or "none".
      Immediately following the slash is either the string "tid" for timers
      with
      **SIGEV_THREAD_ID**
      notification, or "pid" for timers that notify by other mechanisms.
      Following the "." is the PID of the process
      (or the kernel thread ID of the thread)  that will be delivered
      a signal if the timer delivers notifications via a signal.
    * _ClockID_  
      This field identifies the clock that the timer uses for measuring time.
      For most clocks, this is a number that matches one of the user-space
      **CLOCK_***
      constants exposed via
      _&lt;time.h&gt;_.
      **CLOCK_PROCESS_CPUTIME_ID**
      timers display with a value of -6
      in this field.
      **CLOCK_THREAD_CPUTIME_ID**
      timers display with a value of -2
      in this field.
* This file is available only when the kernel was configured with
  **CONFIG_CHECKPOINT_RESTORE**.
* _/proc/[pid]/timerslack_ns_ (since Linux 4.6)  
  
  
  This file exposes the process's "current" timer slack value,
  expressed in nanoseconds.
  The file is writable,
  allowing the process's timer slack value to be changed.
  Writing 0 to this file resets the "current" timer slack to the
  "default" timer slack value.
  For further details, see the discussion of
  **PR_SET_TIMERSLACK**
  in
  **prctl**(2).
* Initially,
  permission to access this file was governed by a ptrace access mode
  **PTRACE_MODE_ATTACH_FSCREDS**
  check (see
  **ptrace**(2)).
  However, this was subsequently deemed too strict a requirement
  (and had the side effect that requiring a process to have the
  **CAP_SYS_PTRACE**
  capability would also allow it to view and change any process's memory).
  Therefore, since Linux 4.9,
  
  only the (weaker)
  **CAP_SYS_NICE**
  capability is required to access this file.
* _/proc/[pid]/uid_map_, _/proc/[pid]/gid_map_ (since Linux 3.5)  
  See
  **user_namespaces**(7).
* _/proc/[pid]/wchan_ (since Linux 2.6.0)  
  The symbolic name corresponding to the location
  in the kernel where the process is sleeping.
* Permission to access this file is governed by a ptrace access mode
  **PTRACE_MODE_READ_FSCREDS**
  check; see
  **ptrace**(2).
* _/proc/[tid]_  
  There  is a numerical subdirectory for each running thread
  that is not a thread group leader
  (i.e., a thread whose thread ID is not the same as its process ID);
  the subdirectory is named by the thread ID.
  Each one of these subdirectories contains files and subdirectories
  exposing information about the thread with the thread ID
  _tid_.
  The contents of these directories are the same as the corresponding
  _/proc/[pid]/task/[tid]_
  directories.
* The
  _/proc/[tid]_
  subdirectories are
  _not_
  visible when iterating through
  _/proc_
  with
  **getdents**(2)
  (and thus are
  _not_
  visible when one uses
  **ls**(1)
  to view the contents of
  _/proc_).
  However, the pathnames of these directories are visible to
  (i.e., usable as arguments in)
  system calls that operate on pathnames.
* _/proc/apm_  
  Advanced power management version and battery information when
  **CONFIG_APM**
  is defined at kernel compilation time.
* _/proc/buddyinfo_  
  This file contains information which is used for diagnosing memory
  fragmentation issues.
  Each line starts with the identification of the node and the name
  of the zone which together identify a memory region
  This is then
  followed by the count of available chunks of a certain order in
  which these zones are split.
  The size in bytes of a certain order is given by the formula:
*     (2^order)&nbsp;*&nbsp;PAGE_SIZE
* The binary buddy allocator algorithm inside the kernel will split
  one chunk into two chunks of a smaller order (thus with half the
  size) or combine two contiguous chunks into one larger chunk of
  a higher order (thus with double the size) to satisfy allocation
  requests and to counter memory fragmentation.
  The order matches the column number, when starting to count at zero.
* For example on an x86-64 system:
* .in -12n
  .EX
  Node 0, zone     DMA     1    1    1    0    2    1    1    0    1    1    3
  Node 0, zone   DMA32    65   47    4   81   52   28   13   10    5    1  404
  Node 0, zone  Normal   216   55  189  101   84   38   37   27    5    3  587
  .EE
  .in
* In this example, there is one node containing three zones and there
  are 11 different chunk sizes.
  If the page size is 4 kilobytes, then the first zone called
  _DMA_
  (on x86 the first 16 megabyte of memory) has 1 chunk of 4 kilobytes
  (order 0) available and has 3 chunks of 4 megabytes (order 10) available.
* If the memory is heavily fragmented, the counters for higher
  order chunks will be zero and allocation of large contiguous areas
  will fail.
* Further information about the zones can be found in
  _/proc/zoneinfo_.
* _/proc/bus_  
  Contains subdirectories for installed busses.
* _/proc/bus/pccard_  
  Subdirectory for PCMCIA devices when
  **CONFIG_PCMCIA**
  is set at kernel compilation time.
* _/proc/bus/pccard/drivers_  
* _/proc/bus/pci_  
  Contains various bus subdirectories and pseudo-files containing
  information about PCI busses, installed devices, and device
  drivers.
  Some of these files are not ASCII.
* _/proc/bus/pci/devices_  
  Information about PCI devices.
  They may be accessed through
  **lspci**(8)
  and
  **setpci**(8).
* _/proc/cgroups_ (since Linux 2.6.24)  
  See
  **cgroups**(7).
* _/proc/cmdline_  
  Arguments passed to the Linux kernel at boot time.
  Often done via a boot manager such as
  **lilo**(8)
  or
  **grub**(8).
* _/proc/config.gz_ (since Linux 2.6)  
  This file exposes the configuration options that were used
  to build the currently running kernel,
  in the same format as they would be shown in the
  _.config_
  file that resulted when configuring the kernel (using
  _make xconfig_,
  _make config_,
  or similar).
  The file contents are compressed; view or search them using
  **zcat**(1)
  and
  **zgrep**(1).
  As long as no changes have been made to the following file,
  the contents of
  _/proc/config.gz_
  are the same as those provided by:
* .in +4n
  .EX
  cat /lib/modules/$(uname -r)/build/.config
  .EE
  .in
* _/proc/config.gz_
  is provided only if the kernel is configured with
  **CONFIG_IKCONFIG_PROC**.
* _/proc/crypto_  
  A list of the ciphers provided by the kernel crypto API.
  For details, see the kernel
  _Linux Kernel Crypto API_
  documentation available under the kernel source directory
  _Documentation/crypto/_
  
  (or
  _Documentation/DocBook_
  before 4.10;
  the documentation can be built using a command such as
  _make htmldocs_
  in the root directory of the kernel source tree).
* _/proc/cpuinfo_  
  This is a collection of CPU and system architecture dependent items,
  for each supported architecture a different list.
  Two common entries are _processor_ which gives CPU number and
  _bogomips_; a system constant that is calculated
  during kernel initialization.
  SMP machines have information for
  each CPU.
  The
  **lscpu**(1)
  command gathers its information from this file.
* _/proc/devices_  
  Text listing of major numbers and device groups.
  This can be used by MAKEDEV scripts for consistency with the kernel.
* _/proc/diskstats_ (since Linux 2.5.69)  
  This file contains disk I/O statistics for each disk device.
  See the Linux kernel source file
  _Documentation/iostats.txt_
  for further information.
* _/proc/dma_  
  This is a list of the registered _ISA_ DMA (direct memory access)
  channels in use.
* _/proc/driver_  
  Empty subdirectory.
* _/proc/execdomains_  
  List of the execution domains (ABI personalities).
* _/proc/fb_  
  Frame buffer information when
  **CONFIG_FB**
  is defined during kernel compilation.
* _/proc/filesystems_  
  A text listing of the filesystems which are supported by the kernel,
  namely filesystems which were compiled into the kernel or whose kernel
  modules are currently loaded.
  (See also
  **filesystems**(5).)
  If a filesystem is marked with "nodev",
  this means that it does not require a block device to be mounted
  (e.g., virtual filesystem, network filesystem).
* Incidentally, this file may be used by
  **mount**(8)
  when no filesystem is specified and it didn't manage to determine the
  filesystem type.
  Then filesystems contained in this file are tried
  (excepted those that are marked with "nodev").
* _/proc/fs_  
  
  
  Contains subdirectories that in turn contain files
  with information about (certain) mounted filesystems.
* _/proc/ide_  
  This directory
  exists on systems with the IDE bus.
  There are directories for each IDE channel and attached device.
  Files include:
* .in +4n
  .EX
  cache              buffer size in KB
  capacity           number of sectors
  driver             driver version
  geometry           physical and logical geometry
  identify           in hexadecimal
  media              media type
  model              manufacturer's model number
  settings           drive settings
  smart_thresholds   in hexadecimal
  smart_values       in hexadecimal
  .EE
  .in
* The
  **hdparm**(8)
  utility provides access to this information in a friendly format.
* _/proc/interrupts_  
  This is used to record the number of interrupts per CPU per IO device.
  Since Linux 2.6.24,
  for the i386 and x86-64 architectures, at least, this also includes
  interrupts internal to the system (that is, not associated with a device
  as such), such as NMI (nonmaskable interrupt), LOC (local timer interrupt),
  and for SMP systems, TLB (TLB flush interrupt), RES (rescheduling
  interrupt), CAL (remote function call interrupt), and possibly others.
  Very easy to read formatting, done in ASCII.
* _/proc/iomem_  
  I/O memory map in Linux 2.4.
* _/proc/ioports_  
  This is a list of currently registered Input-Output port regions that
  are in use.
* _/proc/kallsyms_ (since Linux 2.5.71)  
  This holds the kernel exported symbol definitions used by the
  **modules**(X)
  tools to dynamically link and bind loadable modules.
  In Linux 2.5.47 and earlier, a similar file with slightly different syntax
  was named
  _ksyms_.
* _/proc/kcore_  
  This file represents the physical memory of the system and is stored
  in the ELF core file format.
  With this pseudo-file, and an unstripped
  kernel
  (_/usr/src/linux/vmlinux_)
  binary, GDB can be used to
  examine the current state of any kernel data structures.
* The total length of the file is the size of physical memory (RAM) plus
  4&nbsp;KiB.
* _/proc/keys_ (since Linux 2.6.10)  
  See
  **keyrings**(7).
* _/proc/key-users_ (since Linux 2.6.10)  
  See
  **keyrings**(7).
* _/proc/kmsg_  
  This file can be used instead of the
  **syslog**(2)
  system call to read kernel messages.
  A process must have superuser
  privileges to read this file, and only one process should read this
  file.
  This file should not be read if a syslog process is running
  which uses the
  **syslog**(2)
  system call facility to log kernel messages.
* Information in this file is retrieved with the
  **dmesg**(1)
  program.
* _/proc/kpagecgroup_ (since Linux 4.3)  
  
  This file contains a 64-bit inode number of
  the memory cgroup each page is charged to,
  indexed by page frame number (see the discussion of
  _/proc/[pid]/pagemap_).
* The
  _/proc/kpagecgroup_
  file is present only if the
  **CONFIG_MEMCG**
  kernel configuration option is enabled.
* _/proc/kpagecount_ (since Linux 2.6.25)  
  This file contains a 64-bit count of the number of
  times each physical page frame is mapped,
  indexed by page frame number (see the discussion of
  _/proc/[pid]/pagemap_).
* The
  _/proc/kpagecount_
  file is present only if the
  **CONFIG_PROC_PAGE_MONITOR**
  kernel configuration option is enabled.
* _/proc/kpageflags_ (since Linux 2.6.25)  
  This file contains 64-bit masks corresponding to each physical page frame;
  it is indexed by page frame number (see the discussion of
  _/proc/[pid]/pagemap_).
  The bits are as follows:
*      0 - KPF_LOCKED
       1 - KPF_ERROR
       2 - KPF_REFERENCED
       3 - KPF_UPTODATE
       4 - KPF_DIRTY
       5 - KPF_LRU
       6 - KPF_ACTIVE
       7 - KPF_SLAB
       8 - KPF_WRITEBACK
       9 - KPF_RECLAIM
      10 - KPF_BUDDY
      11 - KPF_MMAP           (since Linux 2.6.31)
      12 - KPF_ANON           (since Linux 2.6.31)
      13 - KPF_SWAPCACHE      (since Linux 2.6.31)
      14 - KPF_SWAPBACKED     (since Linux 2.6.31)
      15 - KPF_COMPOUND_HEAD  (since Linux 2.6.31)
      16 - KPF_COMPOUND_TAIL  (since Linux 2.6.31)
      17 - KPF_HUGE           (since Linux 2.6.31)
      18 - KPF_UNEVICTABLE    (since Linux 2.6.31)
      19 - KPF_HWPOISON       (since Linux 2.6.31)
      20 - KPF_NOPAGE         (since Linux 2.6.31)
      21 - KPF_KSM            (since Linux 2.6.32)
      22 - KPF_THP            (since Linux 3.4)
      23 - KPF_BALLOON        (since Linux 3.18)
  
      24 - KPF_ZERO_PAGE      (since Linux 4.0)
  
      25 - KPF_IDLE           (since Linux 4.3)
  
* For further details on the meanings of these bits,
  see the kernel source file
  _Documentation/admin-guide/mm/pagemap.rst_.
  Before kernel 2.6.29,
  
  
  **KPF_WRITEBACK**,
  **KPF_RECLAIM**,
  **KPF_BUDDY**,
  and
  **KPF_LOCKED**
  did not report correctly.
* The
  _/proc/kpageflags_
  file is present only if the
  **CONFIG_PROC_PAGE_MONITOR**
  kernel configuration option is enabled.
* _/proc/ksyms_ (Linux 1.1.23–2.5.47)  
  See
  _/proc/kallsyms_.
* _/proc/loadavg_  
  The first three fields in this file are load average figures
  giving the number of jobs in the run queue (state R)
  or waiting for disk I/O (state D) averaged over 1, 5, and 15 minutes.
  They are the same as the load average numbers given by
  **uptime**(1)
  and other programs.
  The fourth field consists of two numbers separated by a slash (/).
  The first of these is the number of currently runnable kernel
  scheduling entities (processes, threads).
  The value after the slash is the number of kernel scheduling entities
  that currently exist on the system.
  The fifth field is the PID of the process that was most
  recently created on the system.
* _/proc/locks_  
  This file shows current file locks
  (**flock**(2) and **fcntl**(2))
  and leases
  (**fcntl**(2)).
* An example of the content shown in this file is the following:
* .in +4n
  .EX
  1: POSIX  ADVISORY  READ  5433 08:01:7864448 128 128
  2: FLOCK  ADVISORY  WRITE 2001 08:01:7864554 0 EOF
  3: FLOCK  ADVISORY  WRITE 1568 00:2f:32388 0 EOF
  4: POSIX  ADVISORY  WRITE 699 00:16:28457 0 EOF
  5: POSIX  ADVISORY  WRITE 764 00:16:21448 0 0
  6: POSIX  ADVISORY  READ  3548 08:01:7867240 1 1
  7: POSIX  ADVISORY  READ  3548 08:01:7865567 1826 2335
  8: OFDLCK ADVISORY  WRITE -1 08:01:8713209 128 191
  .EE
  .in
* The fields shown in each line are as follows:
    * (1)  
      The ordinal position of the lock in the list.
    * (2)  
      The lock type.
      Values that may appear here include:
        * **FLOCK**  
          This is a BSD file lock created using
          **flock**(2).
        * **OFDLCK**  
          This is an open file description (OFD) lock created using
          **fcntl**(2).
        * **POSIX**  
          This is a POSIX byte-range lock created using
          **fcntl**(2).
    * (3)  
      Among the strings that can appear here are the following:
        * **ADVISORY**  
          This is an advisory lock.
        * **MANDATORY**  
          This is a mandatory lock.
    * (4)  
      The type of lock.
      Values that can appear here are:
        * **READ**  
          This is a POSIX or OFD read lock, or a BSD shared lock.
        * **WRITE**  
          This is a POSIX or OFD write lock, or a BSD exclusive lock.
    * (5)  
      The PID of the process that owns the lock.
    * Because OFD locks are not owned by a single process
      (since multiple processes may have file descriptors that
      refer to the same open file description),
      the value -1 is displayed in this field for OFD locks.
      (Before kernel 4.14,
      
      a bug meant that the PID of the process that
      initially acquired the lock was displayed instead of the value -1.)
    * (6)  
      Three colon-separated subfields that identify the major and minor device
      ID of the device containing the filesystem where the locked file resides,
      followed by the inode number of the locked file.
    * (7)  
      The byte offset of the first byte of the lock.
      For BSD locks, this value is always 0.
    * (8)  
      The byte offset of the last byte of the lock.
      **EOF**
      in this field means that the lock extends to the end of the file.
      For BSD locks, the value shown is always
      _EOF_.
* Since Linux 4.9,
  
  the list of locks shown in
  _/proc/locks_
  is filtered to show just the locks for the processes in the PID
  namespace (see
  **pid_namespaces**(7))
  for which the
  _/proc_
  filesystem was mounted.
  (In the initial PID namespace,
  there is no filtering of the records shown in this file.)
* The
  **lslocks**(8)
  command provides a bit more information about each lock.
* _/proc/malloc_ (only up to and including Linux 2.2)  
  
  This file is present only if
  **CONFIG_DEBUG_MALLOC**
  was defined during compilation.
* _/proc/meminfo_  
  This file reports statistics about memory usage on the system.
  It is used by
  **free**(1)
  to report the amount of free and used memory (both physical and swap)
  on the system as well as the shared memory and buffers used by the
  kernel.
  Each line of the file consists of a parameter name, followed by a colon,
  the value of the parameter, and an option unit of measurement (e.g., "kB").
  The list below describes the parameter names and
  the format specifier required to read the field value.
  Except as noted below,
  all of the fields have been present since at least Linux 2.6.0.
  Some fields are displayed only if the kernel was configured
  with various options; those dependencies are noted in the list.
    * _MemTotal_ %lu  
      Total usable RAM (i.e., physical RAM minus a few reserved
      bits and the kernel binary code).
    * _MemFree_ %lu  
      The sum of
      _LowFree_+_HighFree_.
    * _MemAvailable_ %lu (since Linux 3.14)  
      An estimate of how much memory is available for starting new
      applications, without swapping.
    * _Buffers_ %lu  
      Relatively temporary storage for raw disk blocks that
      shouldn't get tremendously large (20MB or so).
    * _Cached_ %lu  
      In-memory cache for files read from the disk (the page cache).
      Doesn't include
      _SwapCached_.
    * _SwapCached_ %lu  
      Memory that once was swapped out, is swapped back in but
      still also is in the swap file.
      (If memory pressure is high, these pages
      don't need to be swapped out again because they are already
      in the swap file.
      This saves I/O.)
    * _Active_ %lu  
      Memory that has been used more recently and usually not
      reclaimed unless absolutely necessary.
    * _Inactive_ %lu  
      Memory which has been less recently used.
      It is more eligible to be reclaimed for other purposes.
    * _Active(anon)_ %lu (since Linux 2.6.28)  
      [To be documented.]
    * _Inactive(anon)_ %lu (since Linux 2.6.28)  
      [To be documented.]
    * _Active(file)_ %lu (since Linux 2.6.28)  
      [To be documented.]
    * _Inactive(file)_ %lu (since Linux 2.6.28)  
      [To be documented.]
    * _Unevictable_ %lu (since Linux 2.6.28)  
      (From Linux 2.6.28 to 2.6.30,
      **CONFIG\_UNEVICTABLE\_LRU** was required.)
      [To be documented.]
    * _Mlocked_ %lu (since Linux 2.6.28)  
      (From Linux 2.6.28 to 2.6.30,
      **CONFIG\_UNEVICTABLE\_LRU** was required.)
      [To be documented.]
    * _HighTotal_ %lu  
      (Starting with Linux 2.6.19, **CONFIG\_HIGHMEM** is required.)
      Total amount of highmem.
      Highmem is all memory above ~860MB of physical memory.
      Highmem areas are for use by user-space programs,
      or for the page cache.
      The kernel must use tricks to access
      this memory, making it slower to access than lowmem.
    * _HighFree_%lu  
      (Starting with Linux 2.6.19, **CONFIG\_HIGHMEM** is required.)
      Amount of free highmem.
    * _LowTotal_%lu  
      (Starting with Linux 2.6.19, **CONFIG\_HIGHMEM** is required.)
      Total amount of lowmem.
      Lowmem is memory which can be used for everything that
      highmem can be used for, but it is also available for the
      kernel's use for its own data structures.
      Among many other things,
      it is where everything from
      _Slab_
      is allocated.
      Bad things happen when you're out of lowmem.
    * _LowFree_%lu  
      (Starting with Linux 2.6.19, **CONFIG\_HIGHMEM** is required.)
      Amount of free lowmem.
    * _MmapCopy_ %lu (since Linux 2.6.29)  
      (**CONFIG_MMU**
      is required.)
      [To be documented.]
    * _SwapTotal_ %lu  
      Total amount of swap space available.
    * _SwapFree_ %lu  
      Amount of swap space that is currently unused.
    * _Dirty_ %lu  
      Memory which is waiting to get written back to the disk.
    * _Writeback_ %lu  
      Memory which is actively being written back to the disk.
    * _AnonPages_ %lu (since Linux 2.6.18)  
      Non-file backed pages mapped into user-space page tables.
    * _Mapped_ %lu  
      Files which have been mapped into memory (with
      **mmap**(2)),
      such as libraries.
    * _Shmem_ %lu (since Linux 2.6.32)  
      Amount of memory consumed in
      **tmpfs**(5)
      filesystems.
    * _KReclaimable_ %lu (since Linux 4.20)  
      Kernel allocations that the kernel will attempt to reclaim
      under memory pressure.
      Includes
      _SReclaimable_
      (below), and other direct allocations with a shrinker.
    * _Slab_ %lu  
      In-kernel data structures cache.
      (See
      **slabinfo**(5).)
    * _SReclaimable_ %lu (since Linux 2.6.19)  
      Part of
      _Slab_,
      that might be reclaimed, such as caches.
    * _SUnreclaim_ %lu (since Linux 2.6.19)  
      Part of
      _Slab_,
      that cannot be reclaimed on memory pressure.
    * _KernelStack_ %lu (since Linux 2.6.32)  
      Amount of memory allocated to kernel stacks.
    * _PageTables_ %lu (since Linux 2.6.18)  
      Amount of memory dedicated to the lowest level of page tables.
    * _Quicklists_ %lu (since Linux 2.6.27)  
      (**CONFIG\_QUICKLIST** is required.)
      [To be documented.]
    * _NFS_Unstable_ %lu (since Linux 2.6.18)  
      NFS pages sent to the server, but not yet committed to stable storage.
    * _Bounce_ %lu (since Linux 2.6.18)  
      Memory used for block device "bounce buffers".
    * _WritebackTmp_ %lu (since Linux 2.6.26)  
      Memory used by FUSE for temporary writeback buffers.
    * _CommitLimit_ %lu (since Linux 2.6.10)  
      This is the total amount of memory currently available to
      be allocated on the system, expressed in kilobytes.
      This limit is adhered to
      only if strict overcommit accounting is enabled (mode 2 in
      _/proc/sys/vm/overcommit_memory_).
      The limit is calculated according to the formula described under
      _/proc/sys/vm/overcommit_memory_.
      For further details, see the kernel source file
      _Documentation/vm/overcommit-accounting.rst_.
    * _Committed_AS_ %lu  
      The amount of memory presently allocated on the system.
      The committed memory is a sum of all of the memory which
      has been allocated by processes, even if it has not been
      "used" by them as of yet.
      A process which allocates 1GB of memory (using
      **malloc**(3)
      or similar), but touches only 300MB of that memory will show up
      as using only 300MB of memory even if it has the address space
      allocated for the entire 1GB.
    * This 1GB is memory which has been "committed" to by the VM
      and can be used at any time by the allocating application.
      With strict overcommit enabled on the system (mode 2 in
      _/proc/sys/vm/overcommit_memory_),
      allocations which would exceed the
      _CommitLimit_
      will not be permitted.
      This is useful if one needs to guarantee that processes will not
      fail due to lack of memory once that memory has been successfully allocated.
    * _VmallocTotal_ %lu  
      Total size of vmalloc memory area.
    * _VmallocUsed_ %lu  
      Amount of vmalloc area which is used.
      Since Linux 4.4,
      
      this field is no longer calculated, and is hard coded as 0.
      See
      _/proc/vmallocinfo_.
    * _VmallocChunk_ %lu  
      Largest contiguous block of vmalloc area which is free.
      Since Linux 4.4,
      
      this field is no longer calculated and is hard coded as 0.
      See
      _/proc/vmallocinfo_.
    * _HardwareCorrupted_ %lu (since Linux 2.6.32)  
      (**CONFIG\_MEMORY\_FAILURE** is required.)
      [To be documented.]
    * _LazyFree_ %lu (since Linux 4.12)  
      Shows the amount of memory marked by
      **madvise**(2)
      **MADV_FREE**.
    * _AnonHugePages_ %lu (since Linux 2.6.38)  
      (**CONFIG\_TRANSPARENT\_HUGEPAGE** is required.)
      Non-file backed huge pages mapped into user-space page tables.
    * _ShmemHugePages_ %lu (since Linux 4.8)  
      (**CONFIG\_TRANSPARENT\_HUGEPAGE** is required.)
      Memory used by shared memory (shmem) and
      **tmpfs**(5)
      allocated with huge pages
    * _ShmemPmdMapped_ %lu (since Linux 4.8)  
      (**CONFIG\_TRANSPARENT\_HUGEPAGE** is required.)
      Shared memory mapped into user space with huge pages.
    * _CmaTotal_ %lu (since Linux 3.1)  
      Total CMA (Contiguous Memory Allocator) pages.
      (**CONFIG\_CMA** is required.)
    * _CmaFree_ %lu (since Linux 3.1)  
      Free CMA (Contiguous Memory Allocator) pages.
      (**CONFIG\_CMA** is required.)
    * _HugePages_Total_ %lu  
      (**CONFIG\_HUGETLB\_PAGE** is required.)
      The size of the pool of huge pages.
    * _HugePages_Free_ %lu  
      (**CONFIG\_HUGETLB\_PAGE** is required.)
      The number of huge pages in the pool that are not yet allocated.
    * _HugePages_Rsvd_ %lu (since Linux 2.6.17)  
      (**CONFIG\_HUGETLB\_PAGE** is required.)
      This is the number of huge pages for
      which a commitment to allocate from the pool has been made,
      but no allocation has yet been made.
      These reserved huge pages
      guarantee that an application will be able to allocate a
      huge page from the pool of huge pages at fault time.
    * _HugePages_Surp_ %lu (since Linux 2.6.24)  
      (**CONFIG\_HUGETLB\_PAGE** is required.)
      This is the number of huge pages in
      the pool above the value in
      _/proc/sys/vm/nr_hugepages_.
      The maximum number of surplus huge pages is controlled by
      _/proc/sys/vm/nr_overcommit_hugepages_.
    * _Hugepagesize_ %lu  
      (**CONFIG\_HUGETLB\_PAGE** is required.)
      The size of huge pages.
    * _DirectMap4k_ %lu (since Linux 2.6.27)  
      Number of bytes of RAM linearly mapped by kernel in 4kB pages.
      (x86.)
    * _DirectMap4M_ %lu (since Linux 2.6.27)  
      Number of bytes of RAM linearly mapped by kernel in 4MB pages.
      (x86 with
      **CONFIG_X86_64**
      or
      **CONFIG_X86_PAE**
      enabled.)
    * _DirectMap2M_ %lu (since Linux 2.6.27)  
      Number of bytes of RAM linearly mapped by kernel in 2MB pages.
      (x86 with neither
      **CONFIG_X86_64**
      nor
      **CONFIG_X86_PAE**
      enabled.)
    * _DirectMap1G_ %lu (since Linux 2.6.27)  
      (x86 with
      **CONFIG_X86_64**
      and
      **CONFIG_X86_DIRECT_GBPAGES**
      enabled.)
* _/proc/modules_  
  A text list of the modules that have been loaded by the system.
  See also
  **lsmod**(8).
* _/proc/mounts_  
  Before kernel 2.4.19, this file was a list
  of all the filesystems currently mounted on the system.
  With the introduction of per-process mount namespaces in Linux 2.4.19 (see
  **mount_namespaces**(7)),
  this file became a link to
  _/proc/self/mounts_,
  which lists the mount points of the process's own mount namespace.
  The format of this file is documented in
  **fstab**(5).
* _/proc/mtrr_  
  Memory Type Range Registers.
  See the Linux kernel source file
  _Documentation/x86/mtrr.txt_
  
  (or
  _Documentation/mtrr.txt_
  before Linux 2.6.28)
  for details.
* _/proc/net_  
  This directory contains various files and subdirectories containing
  information about the networking layer.
  The files contain ASCII structures and are,
  therefore, readable with
  **cat**(1).
  However, the standard
  **netstat**(8)
  suite provides much cleaner access to these files.
* With the advent of network namespaces,
  various information relating to the network stack is virtualized (see
  **network_namespaces**(7)).
  Thus, since Linux 2.6.25,
  
  _/proc/net_
  is a symbolic link to the directory
  _/proc/self/net_,
  which contains the same files and directories as listed below.
  However, these files and directories now expose information
  for the network namespace of which the process is a member.
* _/proc/net/arp_  
  This holds an ASCII readable dump of the kernel ARP table used for
  address resolutions.
  It will show both dynamically learned and preprogrammed ARP entries.
  The format is:
* .in 7n
  .EX
  IP address     HW type   Flags     HW address          Mask   Device
  192.168.0.50   0x1       0x2       00:50:BF:25:68:F3   *      eth0
  192.168.0.250  0x1       0xc       00:00:00:00:00:00   *      eth0
  .EE
  .in
* Here "IP address" is the IPv4 address of the machine and the "HW type"
  is the hardware type of the address from RFC&nbsp;826.
  The flags are the internal
  flags of the ARP structure (as defined in
  _/usr/include/linux/if_arp.h_)
  and
  the "HW address" is the data link layer mapping for that IP address if
  it is known.
* _/proc/net/dev_  
  The dev pseudo-file contains network device status information.
  This gives
  the number of received and sent packets, the number of errors and
  collisions
  and other basic statistics.
  These are used by the
  **ifconfig**(8)
  program to report device status.
  The format is:
* .in 1n
  .EX
  Inter-|   Receive                                                |  Transmit
   face |bytes    packets errs drop fifo frame compressed multicast|bytes    packets errs drop fifo colls carrier compressed
      lo: 2776770   11307    0    0    0     0          0         0  2776770   11307    0    0    0     0       0          0
    eth0: 1215645    2751    0    0    0     0          0         0  1782404    4324    0    0    0   427       0          0
    ppp0: 1622270    5552    1    0    0     0          0         0   354130    5669    0    0    0     0       0          0
    tap0:    7714      81    0    0    0     0          0         0     7714      81    0    0    0     0       0          0
  .EE
  .in
  
  
  
  
  
  
* _/proc/net/dev_mcast_  
  Defined in
  _/usr/src/linux/net/core/dev_mcast.c_:
* .in +4
  .EX
  indx interface_name  dmi_u dmi_g dmi_address
  2    eth0            1     0     01005e000001
  3    eth1            1     0     01005e000001
  4    eth2            1     0     01005e000001
  .EE
  .in
* _/proc/net/igmp_  
  Internet Group Management Protocol.
  Defined in
  _/usr/src/linux/net/core/igmp.c_.
* _/proc/net/rarp_  
  This file uses the same format as the
  _arp_
  file and contains the current reverse mapping database used to provide
  **rarp**(8)
  reverse address lookup services.
  If RARP is not configured into the
  kernel,
  this file will not be present.
* _/proc/net/raw_  
  Holds a dump of the RAW socket table.
  Much of the information is not of
  use
  apart from debugging.
  The "sl" value is the kernel hash slot for the
  socket,
  the "local_address" is the local address and protocol number pair.
  "St" is
  the internal status of the socket.
  The "tx_queue" and "rx_queue" are the
  outgoing and incoming data queue in terms of kernel memory usage.
  The "tr", "tm-&gt;when", and "rexmits" fields are not used by RAW.
  The "uid"
  field holds the effective UID of the creator of the socket.
  
  
  
  
* _/proc/net/snmp_  
  This file holds the ASCII data needed for the IP, ICMP, TCP, and UDP
  management
  information bases for an SNMP agent.
* _/proc/net/tcp_  
  Holds a dump of the TCP socket table.
  Much of the information is not
  of use apart from debugging.
  The "sl" value is the kernel hash slot
  for the socket, the "local_address" is the local address and port number pair.
  The "rem_address" is the remote address and port number pair
  (if connected).
  "St" is the internal status of the socket.
  The "tx_queue" and "rx_queue" are the
  outgoing and incoming data queue in terms of kernel memory usage.
  The "tr", "tm-&gt;when", and "rexmits" fields hold internal information of
  the kernel socket state and are useful only for debugging.
  The "uid"
  field holds the effective UID of the creator of the socket.
* _/proc/net/udp_  
  Holds a dump of the UDP socket table.
  Much of the information is not of
  use apart from debugging.
  The "sl" value is the kernel hash slot for the
  socket, the "local_address" is the local address and port number pair.
  The "rem_address" is the remote address and port number pair
  (if connected).
  "St" is the internal status of the socket.
  The "tx_queue" and "rx_queue" are the outgoing and incoming data queue
  in terms of kernel memory usage.
  The "tr", "tm-&gt;when", and "rexmits" fields
  are not used by UDP.
  The "uid"
  field holds the effective UID of the creator of the socket.
  The format is:
* .in 1n
  .EX
  sl  local_address rem_address   st tx_queue rx_queue tr rexmits  tm-&gt;when uid
   1: 01642C89:0201 0C642C89:03FF 01 00000000:00000001 01:000071BA 00000000 0
   1: 00000000:0801 00000000:0000 0A 00000000:00000000 00:00000000 6F000100 0
   1: 00000000:0201 00000000:0000 0A 00000000:00000000 00:00000000 00000000 0
  .EE
  .in
* * _/proc/net/unix_  
  Lists the UNIX domain sockets present within the system and their
  status.
  The format is:
* .in 1n
  .EX
  Num RefCount Protocol Flags    Type St Inode Path
   0: 00000002 00000000 00000000 0001 03    42
   1: 00000001 00000000 00010000 0001 01  1948 /dev/printer
  .EE
  .in
* The fields are as follows:
    * _Num_:  
      the kernel table slot number.
    * _RefCount_:  
      the number of users of the socket.
    * _Protocol_:  
      currently always 0.
    * _Flags_:  
      the internal kernel flags holding the status of the socket.
    * _Type_:  
      the socket type.
      For
      **SOCK_STREAM**
      sockets, this is 0001; for
      **SOCK_DGRAM**
      sockets, it is 0002; and for
      **SOCK_SEQPACKET**
      sockets, it is 0005.
    * _St_:  
      the internal state of the socket.
    * _Inode_:  
      the inode number of the socket.
    * _Path_:  
      the bound pathname (if any) of the socket.
      Sockets in the abstract namespace are included in the list,
      and are shown with a
      _Path_
      that commences with the character '@'.
* _/proc/net/netfilter/nfnetlink_queue_  
  This file contains information about netfilter user-space queueing, if used.
  Each line represents a queue.
  Queues that have not been subscribed to
  by user space are not shown.
* .in +4n
  .EX
     1   4207     0  2 65535     0     0        0  1
    (1)   (2)    (3)(4)  (5)    (6)   (7)      (8)
  .EE
  .in
* The fields in each line are:
    * (1)  
      The ID of the queue.
      This matches what is specified in the
      **--queue-num**
      or
      **--queue-balance**
      options to the
      **iptables**(8)
      NFQUEUE target.
      See
      **iptables-extensions**(8)
      for more information.
    * (2)  
      The netlink port ID subscribed to the queue.
    * (3)  
      The number of packets currently queued and waiting to be processed by
      the application.
    * (4)  
      The copy mode of the queue.
      It is either 1 (metadata only) or 2
      (also copy payload data to user space).
    * (5)  
      Copy range; that is, how many bytes of packet payload should be copied to
      user space at most.
    * (6)  
      queue dropped.
      Number of packets that had to be dropped by the kernel because
      too many packets are already waiting for user space to send back the mandatory
      accept/drop verdicts.
    * (7)  
      queue user dropped.
      Number of packets that were dropped within the netlink
      subsystem.
      Such drops usually happen when the corresponding socket buffer is
      full; that is, user space is not able to read messages fast enough.
    * (8)  
      sequence number.
      Every queued packet is associated with a (32-bit)
      monotonically-increasing sequence number.
      This shows the ID of the most recent packet queued.
* The last number exists only for compatibility reasons and is always 1.
* _/proc/partitions_  
  Contains the major and minor numbers of each partition as well as the number
  of 1024-byte blocks and the partition name.
* _/proc/pci_  
  This is a listing of all PCI devices found during kernel initialization
  and their configuration.
* This file has been deprecated in favor of a new
  _/proc_
  interface for PCI
  (_/proc/bus/pci_).
  It became optional in Linux 2.2 (available with
  **CONFIG_PCI_OLD_PROC**
  set at kernel compilation).
  It became once more nonoptionally enabled in Linux 2.4.
  Next, it was deprecated in Linux 2.6 (still available with
  **CONFIG_PCI_LEGACY_PROC**
  set), and finally removed altogether since Linux 2.6.17.
  
  
* _/proc/profile_ (since Linux 2.4)  
  This file is present only if the kernel was booted with the
  _profile=1_
  command-line option.
  It exposes kernel profiling information in a binary format for use by
  **readprofile**(1).
  Writing (e.g., an empty string) to this file resets the profiling counters;
  on some architectures,
  writing a binary integer "profiling multiplier" of size
  _sizeof(int)_
  sets the profiling interrupt frequency.
* _/proc/scsi_  
  A directory with the
  _scsi_
  mid-level pseudo-file and various SCSI low-level
  driver directories,
  which contain a file for each SCSI host in this system, all of
  which give the status of some part of the SCSI IO subsystem.
  These files contain ASCII structures and are, therefore, readable with
  **cat**(1).
* You can also write to some of the files to reconfigure the subsystem or
  switch certain features on or off.
* _/proc/scsi/scsi_  
  This is a listing of all SCSI devices known to the kernel.
  The listing is similar to the one seen during bootup.
  scsi currently supports only the _add-single-device_ command which
  allows root to add a hotplugged device to the list of known devices.
* The command
* .in +4n
  .EX
  echo 'scsi add-single-device 1 0 5 0' &gt; /proc/scsi/scsi
  .EE
  .in
* will cause
  host scsi1 to scan on SCSI channel 0 for a device on ID 5 LUN 0.
  If there
  is already a device known on this address or the address is invalid, an
  error will be returned.
* _/proc/scsi/[drivername]_  
  _[drivername]_ can currently be NCR53c7xx, aha152x, aha1542, aha1740,
  aic7xxx, buslogic, eata_dma, eata_pio, fdomain, in2000, pas16, qlogic,
  scsi_debug, seagate, t128, u15-24f, ultrastore, or wd7000.
  These directories show up for all drivers that registered at least one
  SCSI HBA.
  Every directory contains one file per registered host.
  Every host-file is named after the number the host was assigned during
  initialization.
* Reading these files will usually show driver and host configuration,
  statistics, and so on.
* Writing to these files allows different things on different hosts.
  For example, with the _latency_ and _nolatency_ commands,
  root can switch on and off command latency measurement code in the
  eata_dma driver.
  With the _lockup_ and _unlock_ commands,
  root can control bus lockups simulated by the scsi_debug driver.
* _/proc/self_  
  This directory refers to the process accessing the
  _/proc_
  filesystem,
  and is identical to the
  _/proc_
  directory named by the process ID of the same process.
* _/proc/slabinfo_  
  Information about kernel caches.
  See
  **slabinfo**(5)
  for details.
* _/proc/stat_  
  kernel/system statistics.
  Varies with architecture.
  Common
  entries include:
    * _cpu 10132153 290696 3084719 46828483 16683 0 25195 0 175628 0_  
      .TQ
      _cpu0 1393280 32966 572056 13343292 6130 0 17875 0 23933 0_
      The amount of time, measured in units of
      USER_HZ (1/100ths of a second on most architectures, use
      _sysconf(_SC_CLK_TCK)_
      to obtain the right value),
      
      that the system ("cpu" line) or the specific CPU ("cpu_N_" line)
      spent in various states:
        * _user_  
          (1) Time spent in user mode.
        * _nice_  
          (2) Time spent in user mode with low priority (nice).
        * _system_  
          (3) Time spent in system mode.
        * _idle_  
          (4) Time spent in the idle task.
          
          
          
          This value should be USER_HZ times the
          second entry in the
          _/proc/uptime_
          pseudo-file.
        * _iowait_ (since Linux 2.5.41)  
          (5) Time waiting for I/O to complete.
          This value is not reliable, for the following reasons:
          
            * 1.  
              The CPU will not wait for I/O to complete;
              iowait is the time that a task is waiting for I/O to complete.
              When a CPU goes into idle state for outstanding task I/O,
              another task will be scheduled on this CPU.
            * 2.  
              On a multi-core CPU,
              the task waiting for I/O to complete is not running on any CPU,
              so the iowait of each CPU is difficult to calculate.
            * 3.  
              The value in this field may
              _decrease_
              in certain conditions.
        * _irq_ (since Linux 2.6.0)  
          
          (6) Time servicing interrupts.
        * _softirq_ (since Linux 2.6.0  
          
          (7) Time servicing softirqs.
        * _steal_ (since Linux 2.6.11)  
          (8) Stolen time, which is the time spent in other operating systems when
          running in a virtualized environment
        * _guest_ (since Linux 2.6.24)  
          (9) Time spent running a virtual CPU for guest
          operating systems under the control of the Linux kernel.
          
        * _guest_nice_ (since Linux 2.6.33)  
          
          (10) Time spent running a niced guest (virtual CPU for guest
          operating systems under the control of the Linux kernel).
    * _page 5741 1808_  
      The number of pages the system paged in and the number that were paged
      out (from disk).
    * _swap 1 0_  
      The number of swap pages that have been brought in and out.
    *   
      
      _intr 1462898_
      This line shows counts of interrupts serviced since boot time,
      for each of the possible system interrupts.
      The first column is the total of all interrupts serviced
      including unnumbered architecture specific interrupts;
      each subsequent column is the total for that particular numbered interrupt.
      Unnumbered interrupts are not shown, only summed into the total.
    * _disk_io: (2,0):(31,30,5764,1,2) (3,0):_...  
      (major,disk_idx):(noinfo, read_io_ops, blks_read, write_io_ops, blks_written)  
      (Linux 2.4 only)
    * _ctxt 115315_  
      The number of context switches that the system underwent.
    * _btime 769041601_  
      boot time, in seconds since the Epoch, 1970-01-01 00:00:00 +0000 (UTC).
    * _processes 86031_  
      Number of forks since boot.
    * _procs_running 6_  
      Number of processes in runnable state.
      (Linux 2.5.45 onward.)
    * _procs_blocked 2_  
      Number of processes blocked waiting for I/O to complete.
      (Linux 2.5.45 onward.)
    * _softirq 229245889 94 60001584 13619 5175704 2471304 28 51212741 59130143 0 51240672_  
      
      This line shows the number of softirq for all CPUs.
      The first column is the total of all softirqs and
      each subsequent column is the total for particular softirq.
      (Linux 2.6.31 onward.)
* _/proc/swaps_  
  Swap areas in use.
  See also
  **swapon**(8).
* _/proc/sys_  
  This directory (present since 1.3.57) contains a number of files
  and subdirectories corresponding to kernel variables.
  These variables can be read and sometimes modified using
  the _/proc_ filesystem, and the (deprecated)
  **sysctl**(2)
  system call.
* String values may be terminated by either '\e0' or '\en'.
* Integer and long values may be written either in decimal or in
  hexadecimal notation (e.g. 0x3FFF).
  When writing multiple integer or long values, these may be separated
  by any of the following whitespace characters:
  '&nbsp;', '\et', or '\en'.
  Using other separators leads to the error
  **EINVAL**.
* _/proc/sys/abi_ (since Linux 2.4.10)  
  This directory may contain files with application binary information.
  
  See the Linux kernel source file
  _Documentation/sysctl/abi.txt_
  for more information.
* _/proc/sys/debug_  
  This directory may be empty.
* _/proc/sys/dev_  
  This directory contains device-specific information (e.g.,
  _dev/cdrom/info_).
  On
  some systems, it may be empty.
* _/proc/sys/fs_  
  This directory contains the files and subdirectories for kernel variables
  related to filesystems.
* _/proc/sys/fs/binfmt_misc_  
  Documentation for files in this directory can be found
  in the Linux kernel source in the file
  _Documentation/admin-guide/binfmt-misc.rst_
  (or in
  _Documentation/binfmt_misc.txt_
  on older kernels).
* _/proc/sys/fs/dentry-state_ (since Linux 2.2)  
  This file contains information about the status of the
  directory cache (dcache).
  The file contains six numbers,
  _nr_dentry_, _nr_unused_, _age_limit_ (age in seconds), 
  _want_pages_
  (pages requested by system) and two dummy values.
    * *  
      _nr_dentry_
      is the number of allocated dentries (dcache entries).
      This field is unused in Linux 2.2.
    * *  
      _nr_unused_
      is the number of unused dentries.
    * *  
      _age_limit_
      
      is the age in seconds after which dcache entries
      can be reclaimed when memory is short.
    * *  
      _want_pages_
      
      is nonzero when the kernel has called shrink_dcache_pages() and the
      dcache isn't pruned yet.
* _/proc/sys/fs/dir-notify-enable_  
  This file can be used to disable or enable the
  _dnotify_
  interface described in
  **fcntl**(2)
  on a system-wide basis.
  A value of 0 in this file disables the interface,
  and a value of 1 enables it.
* _/proc/sys/fs/dquot-max_  
  This file shows the maximum number of cached disk quota entries.
  On some (2.4) systems, it is not present.
  If the number of free cached disk quota entries is very low and
  you have some awesome number of simultaneous system users,
  you might want to raise the limit.
* _/proc/sys/fs/dquot-nr_  
  This file shows the number of allocated disk quota
  entries and the number of free disk quota entries.
* _/proc/sys/fs/epoll_ (since Linux 2.6.28)  
  This directory contains the file
  _max_user_watches_,
  which can be used to limit the amount of kernel memory consumed by the
  _epoll_
  interface.
  For further details, see
  **epoll**(7).
* _/proc/sys/fs/file-max_  
  This file defines
  a system-wide limit on the number of open files for all processes.
  System calls that fail when encountering this limit fail with the error
  **ENFILE**.
  (See also
  **setrlimit**(2),
  which can be used by a process to set the per-process limit,
  **RLIMIT_NOFILE**,
  on the number of files it may open.)
  If you get lots
  of error messages in the kernel log about running out of file handles
  (look for "VFS: file-max limit &lt;number&gt; reached"),
  try increasing this value:
* .in +4n
  .EX
  echo 100000 &gt; /proc/sys/fs/file-max
  .EE
  .in
* Privileged processes
  (**CAP_SYS_ADMIN**)
  can override the
  _file-max_
  limit.
* _/proc/sys/fs/file-nr_  
  This (read-only) file contains three numbers:
  the number of allocated file handles
  (i.e., the number of files presently opened);
  the number of free file handles;
  and the maximum number of file handles (i.e., the same value as
  _/proc/sys/fs/file-max_).
  If the number of allocated file handles is close to the
  maximum, you should consider increasing the maximum.
  Before Linux 2.6,
  the kernel allocated file handles dynamically,
  but it didn't free them again.
  Instead the free file handles were kept in a list for reallocation;
  the "free file handles" value indicates the size of that list.
  A large number of free file handles indicates that there was
  a past peak in the usage of open file handles.
  Since Linux 2.6, the kernel does deallocate freed file handles,
  and the "free file handles" value is always zero.
* _/proc/sys/fs/inode-max_ (only present until Linux 2.2)  
  This file contains the maximum number of in-memory inodes.
  This value should be 3–4 times larger
  than the value in
  _file-max_,
  since _stdin_, _stdout_
  and network sockets also need an inode to handle them.
  When you regularly run out of inodes, you need to increase this value.
* Starting with Linux 2.4,
  there is no longer a static limit on the number of inodes,
  and this file is removed.
* _/proc/sys/fs/inode-nr_  
  This file contains the first two values from
  _inode-state_.
* _/proc/sys/fs/inode-state_  
  This file
  contains seven numbers:
  _nr_inodes_,
  _nr_free_inodes_,
  _preshrink_,
  and four dummy values (always zero).
* _nr_inodes_
  is the number of inodes the system has allocated.
  
  
  
  _nr_free_inodes_
  represents the number of free inodes.
* _preshrink_
  is nonzero when the
  _nr_inodes_
  &gt;
  _inode-max_
  and the system needs to prune the inode list instead of allocating more;
  since Linux 2.4, this field is a dummy value (always zero).
* _/proc/sys/fs/inotify_ (since Linux 2.6.13)  
  This directory contains files
  _max_queued_events_, _max_user_instances_, and _max_user_watches_,
  that can be used to limit the amount of kernel memory consumed by the
  _inotify_
  interface.
  For further details, see
  **inotify**(7).
* _/proc/sys/fs/lease-break-time_  
  This file specifies the grace period that the kernel grants to a process
  holding a file lease
  (**fcntl**(2))
  after it has sent a signal to that process notifying it
  that another process is waiting to open the file.
  If the lease holder does not remove or downgrade the lease within
  this grace period, the kernel forcibly breaks the lease.
* _/proc/sys/fs/leases-enable_  
  This file can be used to enable or disable file leases
  (**fcntl**(2))
  on a system-wide basis.
  If this file contains the value 0, leases are disabled.
  A nonzero value enables leases.
* _/proc/sys/fs/mount-max_ (since Linux 4.9)  
  
  The value in this file specifies the maximum number of mounts that may exist
  in a mount namespace.
  The default value in this file is 100,000.
* _/proc/sys/fs/mqueue_ (since Linux 2.6.6)  
  This directory contains files
  _msg_max_, _msgsize_max_, and _queues_max_,
  controlling the resources used by POSIX message queues.
  See
  **mq_overview**(7)
  for details.
* _/proc/sys/fs/nr_open_(since_Linux_2.6.25)  
  
  This file imposes ceiling on the value to which the
  **RLIMIT_NOFILE**
  resource limit can be raised (see
  **getrlimit**(2)).
  This ceiling is enforced for both unprivileged and privileged process.
  The default value in this file is 1048576.
  (Before Linux 2.6.25, the ceiling for
  **RLIMIT_NOFILE**
  was hard-coded to the same value.)
* _/proc/sys/fs/overflowgid_ and _/proc/sys/fs/overflowuid_  
  These files
  allow you to change the value of the fixed UID and GID.
  The default is 65534.
  Some filesystems support only 16-bit UIDs and GIDs, although in Linux
  UIDs and GIDs are 32 bits.
  When one of these filesystems is mounted
  with writes enabled, any UID or GID that would exceed 65535 is translated
  to the overflow value before being written to disk.
* _/proc/sys/fs/pipe-max-size_ (since Linux 2.6.35)  
  See
  **pipe**(7).
* _/proc/sys/fs/pipe-user-pages-hard_ (since Linux 4.5)  
  See
  **pipe**(7).
* _/proc/sys/fs/pipe-user-pages-soft_ (since Linux 4.5)  
  See
  **pipe**(7).
* _/proc/sys/fs/protected_hardlinks_ (since Linux 3.6)  
  
  When the value in this file is 0,
  no restrictions are placed on the creation of hard links
  (i.e., this is the historical behavior before Linux 3.6).
  When the value in this file is 1,
  a hard link can be created to a target file
  only if one of the following conditions is true:
    * *  
      The calling process has the
      **CAP_FOWNER**
      capability in its user namespace
      and the file UID has a mapping in the namespace.
    * *  
      The filesystem UID of the process creating the link matches
      the owner (UID) of the target file
      (as described in
      **credentials**(7),
      a process's filesystem UID is normally the same as its effective UID).
    * *  
      All of the following conditions are true:
        * ·  
          the target is a regular file;
        * ·  
          the target file does not have its set-user-ID mode bit enabled;
        * ·  
          the target file does not have both its set-group-ID and
          group-executable mode bits enabled; and
        * ·  
          the caller has permission to read and write the target file
          (either via the file's permissions mask or because it has
          suitable capabilities).
* The default value in this file is 0.
  Setting the value to 1
  prevents a longstanding class of security issues caused by
  hard-link-based time-of-check, time-of-use races,
  most commonly seen in world-writable directories such as
  _/tmp_.
  The common method of exploiting this flaw
  is to cross privilege boundaries when following a given hard link
  (i.e., a root process follows a hard link created by another user).
  Additionally, on systems without separated partitions,
  this stops unauthorized users from "pinning" vulnerable set-user-ID and
  set-group-ID files against being upgraded by
  the administrator, or linking to special files.
* _/proc/sys/fs/protected_symlinks_ (since Linux 3.6)  
  
  When the value in this file is 0,
  no restrictions are placed on following symbolic links
  (i.e., this is the historical behavior before Linux 3.6).
  When the value in this file is 1, symbolic links are followed only
  in the following circumstances:
    * *  
      the filesystem UID of the process following the link matches
      the owner (UID) of the symbolic link
      (as described in
      **credentials**(7),
      a process's filesystem UID is normally the same as its effective UID);
    * *  
      the link is not in a sticky world-writable directory; or
    * *  
      the symbolic link and its parent directory have the same owner (UID)
* A system call that fails to follow a symbolic link
  because of the above restrictions returns the error
  **EACCES**
  in
  _errno_.
* The default value in this file is 0.
  Setting the value to 1 avoids a longstanding class of security issues
  based on time-of-check, time-of-use races when accessing symbolic links.
* _/proc/sys/fs/suid_dumpable_ (since Linux 2.6.13)  
  
  The value in this file is assigned to a process's "dumpable" flag
  in the circumstances described in
  **prctl**(2).
  In effect,
  the value in this file determines whether core dump files are
  produced for set-user-ID or otherwise protected/tainted binaries.
  The "dumpable" setting also affects the ownership of files in a process's
  _/proc/[pid]_
  directory, as described above.
* Three different integer values can be specified:
    * _0&nbsp;(default)_  
      
      This provides the traditional (pre-Linux 2.6.13) behavior.
      A core dump will not be produced for a process which has
      changed credentials (by calling
      **seteuid**(2),
      **setgid**(2),
      or similar, or by executing a set-user-ID or set-group-ID program)
      or whose binary does not have read permission enabled.
    * _1&nbsp;("debug")_  
      
      All processes dump core when possible.
      (Reasons why a process might nevertheless not dump core are described in
      **core**(5).)
      The core dump is owned by the filesystem user ID of the dumping process
      and no security is applied.
      This is intended for system debugging situations only:
      this mode is insecure because it allows unprivileged users to
      examine the memory contents of privileged processes.
    * _2&nbsp;("suidsafe")_  
      
      Any binary which normally would not be dumped (see "0" above)
      is dumped readable by root only.
      This allows the user to remove the core dump file but not to read it.
      For security reasons core dumps in this mode will not overwrite one
      another or other files.
      This mode is appropriate when administrators are
      attempting to debug problems in a normal environment.
    * Additionally, since Linux 3.6,
      
      _/proc/sys/kernel/core_pattern_
      must either be an absolute pathname
      or a pipe command, as detailed in
      **core**(5).
      Warnings will be written to the kernel log if
      _core_pattern_
      does not follow these rules, and no core dump will be produced.
      
* For details of the effect of a process's "dumpable" setting
  on ptrace access mode checking, see
  **ptrace**(2).
* _/proc/sys/fs/super-max_  
  This file
  controls the maximum number of superblocks, and
  thus the maximum number of mounted filesystems the kernel
  can have.
  You need increase only
  _super-max_
  if you need to mount more filesystems than the current value in
  _super-max_
  allows you to.
* _/proc/sys/fs/super-nr_  
  This file
  contains the number of filesystems currently mounted.
* _/proc/sys/kernel_  
  This directory contains files controlling a range of kernel parameters,
  as described below.
* _/proc/sys/kernel/acct_  
  This file
  contains three numbers:
  _highwater_,
  _lowwater_,
  and
  _frequency_.
  If BSD-style process accounting is enabled, these values control
  its behavior.
  If free space on filesystem where the log lives goes below
  _lowwater_
  percent, accounting suspends.
  If free space gets above
  _highwater_
  percent, accounting resumes.
  _frequency_
  determines
  how often the kernel checks the amount of free space (value is in
  seconds).
  Default values are 4, 2 and 30.
  That is, suspend accounting if 2% or less space is free; resume it
  if 4% or more space is free; consider information about amount of free space
  valid for 30 seconds.
* _/proc/sys/kernel/auto_msgmni_ (Linux 2.6.27 to 3.18)  
  
  
  From Linux 2.6.27 to 3.18,
  this file was used to control recomputing of the value in
  _/proc/sys/kernel/msgmni_
  upon the addition or removal of memory or upon IPC namespace creation/removal.
  Echoing "1" into this file enabled
  _msgmni_
  automatic recomputing (and triggered a recomputation of
  _msgmni_
  based on the current amount of available memory and number of IPC namespaces).
  Echoing "0" disabled automatic recomputing.
  (Automatic recomputing was also disabled if a value was explicitly assigned to
  _/proc/sys/kernel/msgmni_.)
  The default value in
  _auto_msgmni_
  was 1.
* Since Linux 3.19, the content of this file has no effect (because
  _msgmni_
  
  defaults to near the maximum value possible),
  and reads from this file always return the value "0".
* _/proc/sys/kernel/cap_last_cap_ (since Linux 3.2)  
  See
  **capabilities**(7).
* _/proc/sys/kernel/cap-bound_ (from Linux 2.2 to 2.6.24)  
  This file holds the value of the kernel
  _capability bounding set_
  (expressed as a signed decimal number).
  This set is ANDed against the capabilities permitted to a process
  during
  **execve**(2).
  Starting with Linux 2.6.25,
  the system-wide capability bounding set disappeared,
  and was replaced by a per-thread bounding set; see
  **capabilities**(7).
* _/proc/sys/kernel/core_pattern_  
  See
  **core**(5).
* _/proc/sys/kernel/core_pipe_limit_  
  See
  **core**(5).
* _/proc/sys/kernel/core_uses_pid_  
  See
  **core**(5).
* _/proc/sys/kernel/ctrl-alt-del_  
  This file
  controls the handling of Ctrl-Alt-Del from the keyboard.
  When the value in this file is 0, Ctrl-Alt-Del is trapped and
  sent to the
  **init**(1)
  program to handle a graceful restart.
  When the value is greater than zero, Linux's reaction to a Vulcan
  Nerve Pinch (tm) will be an immediate reboot, without even
  syncing its dirty buffers.
  Note: when a program (like dosemu) has the keyboard in "raw"
  mode, the ctrl-alt-del is intercepted by the program before it
  ever reaches the kernel tty layer, and it's up to the program
  to decide what to do with it.
* _/proc/sys/kernel/dmesg_restrict_ (since Linux 2.6.37)  
  The value in this file determines who can see kernel syslog contents.
  A value of 0 in this file imposes no restrictions.
  If the value is 1, only privileged users can read the kernel syslog.
  (See
  **syslog**(2)
  for more details.)
  Since Linux 3.4,
  
  only users with the
  **CAP_SYS_ADMIN**
  capability may change the value in this file.
* _/proc/sys/kernel/domainname_ and _/proc/sys/kernel/hostname_  
  can be used to set the NIS/YP domainname and the
  hostname of your box in exactly the same way as the commands
  **domainname**(1)
  and
  **hostname**(1),
  that is:
* .in +4n
  .EX
  #** echo 'darkstar' &gt; /proc/sys/kernel/hostname**
  #** echo 'mydomain' &gt; /proc/sys/kernel/domainname**
  .EE
  .in
* has the same effect as
* .in +4n
  .EX
  #** hostname 'darkstar'**
  #** domainname 'mydomain'**
  .EE
  .in
* Note, however, that the classic darkstar.frop.org has the
  hostname "darkstar" and DNS (Internet Domain Name Server)
  domainname "frop.org", not to be confused with the NIS (Network
  Information Service) or YP (Yellow Pages) domainname.
  These two
  domain names are in general different.
  For a detailed discussion
  see the
  **hostname**(1)
  man page.
* _/proc/sys/kernel/hotplug_  
  This file
  contains the pathname for the hotplug policy agent.
  The default value in this file is
  _/sbin/hotplug_.
*   
  _/proc/sys/kernel/htab-reclaim_ (before Linux 2.4.9.2)
  (PowerPC only) If this file is set to a nonzero value,
  the PowerPC htab
  
  (see kernel file
  _Documentation/powerpc/ppc_htab.txt_)
  is pruned
  each time the system hits the idle loop.
* _/proc/sys/kernel/keys/*_  
  This directory contains various files that define parameters and limits
  for the key-management facility.
  These files are described in
  **keyrings**(7).
* _/proc/sys/kernel/kptr_restrict_ (since Linux 2.6.38)  
  
  The value in this file determines whether kernel addresses are exposed via
  _/proc_
  files and other interfaces.
  A value of 0 in this file imposes no restrictions.
  If the value is 1, kernel pointers printed using the
  _%pK_
  format specifier will be replaced with zeros unless the user has the
  **CAP_SYSLOG**
  capability.
  If the value is 2, kernel pointers printed using the
  _%pK_
  format specifier will be replaced with zeros regardless
  of the user's capabilities.
  The initial default value for this file was 1,
  but the default was changed
  
  to 0 in Linux 2.6.39.
  Since Linux 3.4,
  
  only users with the
  **CAP_SYS_ADMIN**
  capability can change the value in this file.
* _/proc/sys/kernel/l2cr_  
  (PowerPC only) This file
  contains a flag that controls the L2 cache of G3 processor
  boards.
  If 0, the cache is disabled.
  Enabled if nonzero.
* _/proc/sys/kernel/modprobe_  
  This file contains the pathname for the kernel module loader.
  The default value is
  _/sbin/modprobe_.
  The file is present only if the kernel is built with the
  **CONFIG_MODULES**
  (**CONFIG_KMOD**
  in Linux 2.6.26 and earlier)
  option enabled.
  It is described by the Linux kernel source file
  _Documentation/kmod.txt_
  (present only in kernel 2.4 and earlier).
* _/proc/sys/kernel/modules_disabled_ (since Linux 2.6.31)  
  
  
  A toggle value indicating if modules are allowed to be loaded
  in an otherwise modular kernel.
  This toggle defaults to off (0), but can be set true (1).
  Once true, modules can be neither loaded nor unloaded,
  and the toggle cannot be set back to false.
  The file is present only if the kernel is built with the
  **CONFIG_MODULES**
  option enabled.
* _/proc/sys/kernel/msgmax_ (since Linux 2.2)  
  This file defines
  a system-wide limit specifying the maximum number of bytes in
  a single message written on a System V message queue.
* _/proc/sys/kernel/msgmni_ (since Linux 2.4)  
  This file defines the system-wide limit on the number of
  message queue identifiers.
  See also
  _/proc/sys/kernel/auto_msgmni_.
* _/proc/sys/kernel/msgmnb_ (since Linux 2.2)  
  This file defines a system-wide parameter used to initialize the
  _msg_qbytes_
  setting for subsequently created message queues.
  The
  _msg_qbytes_
  setting specifies the maximum number of bytes that may be written to the
  message queue.
* _/proc/sys/kernel/ngroups_max_ (since Linux 2.6.4)  
  This is a read-only file that displays the upper limit on the
  number of a process's group memberships.
* _/proc/sys/kernel/ns_last_pid_ (since Linux 3.3)  
  See
  **pid_namespaces**(7).
* _/proc/sys/kernel/ostype_ and _/proc/sys/kernel/osrelease_  
  These files
  give substrings of
  _/proc/version_.
* _/proc/sys/kernel/overflowgid_ and _/proc/sys/kernel/overflowuid_  
  These files duplicate the files
  _/proc/sys/fs/overflowgid_
  and
  _/proc/sys/fs/overflowuid_.
* _/proc/sys/kernel/panic_  
  This file gives read/write access to the kernel variable
  _panic_timeout_.
  If this is zero, the kernel will loop on a panic; if nonzero,
  it indicates that the kernel should autoreboot after this number
  of seconds.
  When you use the
  software watchdog device driver, the recommended setting is 60.
* _/proc/sys/kernel/panic_on_oops_ (since Linux 2.5.68)  
  This file controls the kernel's behavior when an oops
  or BUG is encountered.
  If this file contains 0, then the system
  tries to continue operation.
  If it contains 1, then the system
  delays a few seconds (to give klogd time to record the oops output)
  and then panics.
  If the
  _/proc/sys/kernel/panic_
  file is also nonzero, then the machine will be rebooted.
* _/proc/sys/kernel/pid_max_ (since Linux 2.5.34)  
  This file specifies the value at which PIDs wrap around
  (i.e., the value in this file is one greater than the maximum PID).
  PIDs greater than this value are not allocated;
  thus, the value in this file also acts as a system-wide limit
  on the total number of processes and threads.
  The default value for this file, 32768,
  results in the same range of PIDs as on earlier kernels.
  On 32-bit platforms, 32768 is the maximum value for
  _pid_max_.
  On 64-bit systems,
  _pid_max_
  can be set to any value up to 2^22
  (**PID_MAX_LIMIT**,
  approximately 4 million).
  
  
  
* _/proc/sys/kernel/powersave-nap_ (PowerPC only)  
  This file contains a flag.
  If set, Linux-PPC will use the "nap" mode of
  powersaving,
  otherwise the "doze" mode will be used.
* _/proc/sys/kernel/printk_  
  See
  **syslog**(2).
* _/proc/sys/kernel/pty_ (since Linux 2.6.4)  
  This directory contains two files relating to the number of UNIX 98
  pseudoterminals (see
  **pts**(4))
  on the system.
* _/proc/sys/kernel/pty/max_  
  This file defines the maximum number of pseudoterminals.
  
  
  
* _/proc/sys/kernel/pty/nr_  
  This read-only file
  indicates how many pseudoterminals are currently in use.
* _/proc/sys/kernel/random_  
  This directory
  contains various parameters controlling the operation of the file
  _/dev/random_.
  See
  **random**(4)
  for further information.
* _/proc/sys/kernel/random/uuid_ (since Linux 2.4)  
  Each read from this read-only file returns a randomly generated 128-bit UUID,
  as a string in the standard UUID format.
* _/proc/sys/kernel/randomize_va_space_ (since Linux 2.6.12)  
  
  Select the address space layout randomization (ASLR) policy for the system
  (on architectures that support ASLR).
  Three values are supported for this file:
    * 0  
      Turn ASLR off.
      This is the default for architectures that don't support ASLR,
      and when the kernel is booted with the
      _norandmaps_
      parameter.
    * 1  
      Make the addresses of
      **mmap**(2)
      allocations, the stack, and the VDSO page randomized.
      Among other things, this means that shared libraries will be
      loaded at randomized addresses.
      The text segment of PIE-linked binaries will also be loaded
      at a randomized address.
      This value is the default if the kernel was configured with
      **CONFIG_COMPAT_BRK**.
    * 2  
      (Since Linux 2.6.25)
      
      Also support heap randomization.
      This value is the default if the kernel was not configured with
      **CONFIG_COMPAT_BRK**.
* _/proc/sys/kernel/real-root-dev_  
  This file is documented in the Linux kernel source file
  _Documentation/admin-guide/initrd.rst_
  
  (or
  _Documentation/initrd.txt_
  before Linux 4.10).
* _/proc/sys/kernel/reboot-cmd_ (Sparc only)   
  This file seems to be a way to give an argument to the SPARC
  ROM/Flash boot loader.
  Maybe to tell it what to do after
  rebooting?
* _/proc/sys/kernel/rtsig-max_  
  (Only in kernels up to and including 2.6.7; see
  **setrlimit**(2))
  This file can be used to tune the maximum number
  of POSIX real-time (queued) signals that can be outstanding
  in the system.
* _/proc/sys/kernel/rtsig-nr_  
  (Only in kernels up to and including 2.6.7.)
  This file shows the number of POSIX real-time signals currently queued.
* _/proc/[pid]/sched_autogroup_enabled_ (since Linux 2.6.38)  
  
  See
  **sched**(7).
* _/proc/sys/kernel/sched_child_runs_first_ (since Linux 2.6.23)  
  If this file contains the value zero, then, after a
  **fork**(2),
  the parent is first scheduled on the CPU.
  If the file contains a nonzero value,
  then the child is scheduled first on the CPU.
  (Of course, on a multiprocessor system,
  the parent and the child might both immediately be scheduled on a CPU.)
* _/proc/sys/kernel/sched_rr_timeslice_ms_ (since Linux 3.9)  
  See
  **sched_rr_get_interval**(2).
* _/proc/sys/kernel/sched_rt_period_us_ (since Linux 2.6.25)  
  See
  **sched**(7).
* _/proc/sys/kernel/sched_rt_runtime_us_ (since Linux 2.6.25)  
  See
  **sched**(7).
* _/proc/sys/kernel/seccomp_ (since Linux 4.14)  
  
  This directory provides additional seccomp information and
  configuration.
  See
  **seccomp**(2)
  for further details.
* _/proc/sys/kernel/sem_ (since Linux 2.4)  
  This file contains 4 numbers defining limits for System V IPC semaphores.
  These fields are, in order:
    * SEMMSL  
      The maximum semaphores per semaphore set.
    * SEMMNS  
      A system-wide limit on the number of semaphores in all semaphore sets.
    * SEMOPM  
      The maximum number of operations that may be specified in a
      **semop**(2)
      call.
    * SEMMNI  
      A system-wide limit on the maximum number of semaphore identifiers.
* _/proc/sys/kernel/sg-big-buff_  
  This file
  shows the size of the generic SCSI device (sg) buffer.
  You can't tune it just yet, but you could change it at
  compile time by editing
  _include/scsi/sg.h_
  and changing
  the value of
  **SG_BIG_BUFF**.
  However, there shouldn't be any reason to change this value.
* _/proc/sys/kernel/shm_rmid_forced_ (since Linux 3.1)  
  
  
  If this file is set to 1, all System V shared memory segments will
  be marked for destruction as soon as the number of attached processes
  falls to zero;
  in other words, it is no longer possible to create shared memory segments
  that exist independently of any attached process.
* The effect is as though a
  **shmctl**(2)
  **IPC_RMID**
  is performed on all existing segments as well as all segments
  created in the future (until this file is reset to 0).
  Note that existing segments that are attached to no process will be
  immediately destroyed when this file is set to 1.
  Setting this option will also destroy segments that were created,
  but never attached,
  upon termination of the process that created the segment with
  **shmget**(2).
* Setting this file to 1 provides a way of ensuring that
  all System V shared memory segments are counted against the
  resource usage and resource limits (see the description of
  **RLIMIT_AS**
  in
  **getrlimit**(2))
  of at least one process.
* Because setting this file to 1 produces behavior that is nonstandard
  and could also break existing applications,
  the default value in this file is 0.
  Set this file to 1 only if you have a good understanding
  of the semantics of the applications using
  System V shared memory on your system.
* _/proc/sys/kernel/shmall_ (since Linux 2.2)  
  This file
  contains the system-wide limit on the total number of pages of
  System V shared memory.
* _/proc/sys/kernel/shmmax_ (since Linux 2.2)  
  This file
  can be used to query and set the run-time limit
  on the maximum (System V IPC) shared memory segment size that can be
  created.
  Shared memory segments up to 1GB are now supported in the
  kernel.
  This value defaults to
  **SHMMAX**.
* _/proc/sys/kernel/shmmni_ (since Linux 2.4)  
  This file
  specifies the system-wide maximum number of System V shared memory
  segments that can be created.
* _/proc/sys/kernel/sysctl_writes_strict_ (since Linux 3.16)  
  
  
  
  
  The value in this file determines how the file offset affects
  the behavior of updating entries in files under
  _/proc/sys_.
  The file has three possible values:
    * -1  
      This provides legacy handling, with no printk warnings.
      Each
      **write**(2)
      must fully contain the value to be written,
      and multiple writes on the same file descriptor
      will overwrite the entire value, regardless of the file position.
    * 0  
      (default) This provides the same behavior as for -1,
      but printk warnings are written for processes that
      perform writes when the file offset is not 0.
    * 1  
      Respect the file offset when writing strings into
      _/proc/sys_
      files.
      Multiple writes will
      _append_
      to the value buffer.
      Anything written beyond the maximum length
      of the value buffer will be ignored.
      Writes to numeric
      _/proc/sys_
      entries must always be at file offset 0 and the value must be
      fully contained in the buffer provided to
      **write**(2).
      
      
      
      
      
      
      
      
      
      
* _/proc/sys/kernel/sysrq_  
  This file controls the functions allowed to be invoked by the SysRq key.
  By default,
  the file contains 1 meaning that every possible SysRq request is allowed
  (in older kernel versions, SysRq was disabled by default,
  and you were required to specifically enable it at run-time,
  but this is not the case any more).
  Possible values in this file are:
    * 0  
      Disable sysrq completely
    * 1  
      Enable all functions of sysrq
    * &gt; 1  
      Bit mask of allowed sysrq functions, as follows:
        * &nbsp;&nbsp;2  
          Enable control of console logging level
        * &nbsp;&nbsp;4  
          Enable control of keyboard (SAK, unraw)
        * &nbsp;&nbsp;8  
          Enable debugging dumps of processes etc.
        * &nbsp;16  
          Enable sync command
        * &nbsp;32  
          Enable remount read-only
        * &nbsp;64  
          Enable signaling of processes (term, kill, oom-kill)
        * 128  
          Allow reboot/poweroff
        * 256  
          Allow nicing of all real-time tasks
* This file is present only if the
  **CONFIG_MAGIC_SYSRQ**
  kernel configuration option is enabled.
  For further details see the Linux kernel source file
  _Documentation/admin-guide/sysrq.rst_
  
  (or
  _Documentation/sysrq.txt_
  before Linux 4.10).
* _/proc/sys/kernel/version_  
  This file contains a string such as:
*     #5 Wed Feb 25 21:49:24 MET 1998
* The "#5" means that
  this is the fifth kernel built from this source base and the
  date following it indicates the time the kernel was built.
* _/proc/sys/kernel/threads-max_ (since Linux 2.3.11)  
  
  This file specifies the system-wide limit on the number of
  threads (tasks) that can be created on the system.
* Since Linux 4.1,
  
  the value that can be written to
  _threads-max_
  is bounded.
  The minimum value that can be written is 20.
  The maximum value that can be written is given by the
  constant
  **FUTEX_TID_MASK**
  (0x3fffffff).
  If a value outside of this range is written to
  _threads-max_,
  the error
  **EINVAL**
  occurs.
* The value written is checked against the available RAM pages.
  If the thread structures would occupy too much (more than 1/8th)
  of the available RAM pages,
  _threads-max_
  is reduced accordingly.
* _/proc/sys/kernel/yama/ptrace_scope_ (since Linux 3.5)  
  See
  **ptrace**(2).
* _/proc/sys/kernel/zero-paged_ (PowerPC only)   
  This file
  contains a flag.
  When enabled (nonzero), Linux-PPC will pre-zero pages in
  the idle loop, possibly speeding up get_free_pages.
* _/proc/sys/net_  
  This directory contains networking stuff.
  Explanations for some of the files under this directory can be found in
  **tcp**(7)
  and
  **ip**(7).
* _/proc/sys/net/core/bpf_jit_enable_  
  See
  **bpf**(2).
* _/proc/sys/net/core/somaxconn_  
  This file defines a ceiling value for the
  _backlog_
  argument of
  **listen**(2);
  see the
  **listen**(2)
  manual page for details.
* _/proc/sys/proc_  
  This directory may be empty.
* _/proc/sys/sunrpc_  
  This directory supports Sun remote procedure call for network filesystem
  (NFS).
  On some systems, it is not present.
* _/proc/sys/user_ (since Linux 4.9)  
  See
  **namespaces**(7).
* _/proc/sys/vm_  
  This directory contains files for memory management tuning, buffer and
  cache management.
* _/proc/sys/vm/admin_reserve_kbytes_ (since Linux 3.10)  
  
  This file defines the amount of free memory (in KiB) on the system that
  should be reserved for users with the capability
  **CAP_SYS_ADMIN**.
* The default value in this file is the minimum of [3% of free pages, 8MiB]
  expressed as KiB.
  The default is intended to provide enough for the superuser
  to log in and kill a process, if necessary,
  under the default overcommit 'guess' mode (i.e., 0 in
  _/proc/sys/vm/overcommit_memory_).
* Systems running in "overcommit never" mode (i.e., 2 in
  _/proc/sys/vm/overcommit_memory_)
  should increase the value in this file to account
  for the full virtual memory size of the programs used to recover (e.g.,
  **login**(1)
  **ssh**(1),
  and
  **top**(1))
  Otherwise, the superuser may not be able to log in to recover the system.
  For example, on x86-64 a suitable value is 131072 (128MiB reserved).
* Changing the value in this file takes effect whenever
  an application requests memory.
* _/proc/sys/vm/compact_memory_ (since Linux 2.6.35)  
  When 1 is written to this file, all zones are compacted such that free
  memory is available in contiguous blocks where possible.
  The effect of this action can be seen by examining
  _/proc/buddyinfo_.
* Present only if the kernel was configured with
  **CONFIG_COMPACTION**.
* _/proc/sys/vm/drop_caches_ (since Linux 2.6.16)  
  Writing to this file causes the kernel to drop clean caches, dentries, and
  inodes from memory, causing that memory to become free.
  This can be useful for memory management testing and
  performing reproducible filesystem benchmarks.
  Because writing to this file causes the benefits of caching to be lost,
  it can degrade overall system performance.
* To free pagecache, use:
*     echo 1 &gt; /proc/sys/vm/drop_caches
* To free dentries and inodes, use:
*     echo 2 &gt; /proc/sys/vm/drop_caches
* To free pagecache, dentries and inodes, use:
*     echo 3 &gt; /proc/sys/vm/drop_caches
* Because writing to this file is a nondestructive operation and dirty objects
  are not freeable, the
  user should run
  **sync**(1)
  first.
* _/proc/sys/vm/legacy_va_layout_ (since Linux 2.6.9)  
  
  If nonzero, this disables the new 32-bit memory-mapping layout;
  the kernel will use the legacy (2.4) layout for all processes.
* _/proc/sys/vm/memory_failure_early_kill_ (since Linux 2.6.32)  
  
  Control how to kill processes when an uncorrected memory error
  (typically a 2-bit error in a memory module)
  that cannot be handled by the kernel
  is detected in the background by hardware.
  In some cases (like the page still having a valid copy on disk),
  the kernel will handle the failure
  transparently without affecting any applications.
  But if there is no other up-to-date copy of the data,
  it will kill processes to prevent any data corruptions from propagating.
* The file has one of the following values:
    * 1:  
      Kill all processes that have the corrupted-and-not-reloadable page mapped
      as soon as the corruption is detected.
      Note that this is not supported for a few types of pages,
      such as kernel internally
      allocated data or the swap cache, but works for the majority of user pages.
    * 0:  
      Unmap the corrupted page from all processes and kill a process
      only if it tries to access the page.
* The kill is performed using a
  **SIGBUS**
  signal with
  _si_code_
  set to
  **BUS_MCEERR_AO**.
  Processes can handle this if they want to; see
  **sigaction**(2)
  for more details.
* This feature is active only on architectures/platforms with advanced machine
  check handling and depends on the hardware capabilities.
* Applications can override the
  _memory_failure_early_kill_
  setting individually with the
  **prctl**(2)
  **PR_MCE_KILL**
  operation.
* Present only if the kernel was configured with
  **CONFIG_MEMORY_FAILURE**.
* _/proc/sys/vm/memory_failure_recovery_ (since Linux 2.6.32)  
  
  Enable memory failure recovery (when supported by the platform)
    * 1:  
      Attempt recovery.
    * 0:  
      Always panic on a memory failure.
* Present only if the kernel was configured with
  **CONFIG_MEMORY_FAILURE**.
* _/proc/sys/vm/oom_dump_tasks_ (since Linux 2.6.25)  
  
  Enables a system-wide task dump (excluding kernel threads) to be
  produced when the kernel performs an OOM-killing.
  The dump includes the following information
  for each task (thread, process):
  thread ID, real user ID, thread group ID (process ID),
  virtual memory size, resident set size,
  the CPU that the task is scheduled on,
  oom_adj score (see the description of
  _/proc/[pid]/oom_adj_),
  and command name.
  This is helpful to determine why the OOM-killer was invoked
  and to identify the rogue task that caused it.
* If this contains the value zero, this information is suppressed.
  On very large systems with thousands of tasks,
  it may not be feasible to dump the memory state information for each one.
  Such systems should not be forced to incur a performance penalty in
  OOM situations when the information may not be desired.
* If this is set to nonzero, this information is shown whenever the
  OOM-killer actually kills a memory-hogging task.
* The default value is 0.
* _/proc/sys/vm/oom_kill_allocating_task_ (since Linux 2.6.24)  
  
  This enables or disables killing the OOM-triggering task in
  out-of-memory situations.
* If this is set to zero, the OOM-killer will scan through the entire
  tasklist and select a task based on heuristics to kill.
  This normally selects a rogue memory-hogging task that
  frees up a large amount of memory when killed.
* If this is set to nonzero, the OOM-killer simply kills the task that
  triggered the out-of-memory condition.
  This avoids a possibly expensive tasklist scan.
* If
  _/proc/sys/vm/panic_on_oom_
  is nonzero, it takes precedence over whatever value is used in
  _/proc/sys/vm/oom_kill_allocating_task_.
* The default value is 0.
* _/proc/sys/vm/overcommit_kbytes_ (since Linux 3.14)  
  
  This writable file provides an alternative to
  _/proc/sys/vm/overcommit_ratio_
  for controlling the
  _CommitLimit_
  when
  _/proc/sys/vm/overcommit_memory_
  has the value 2.
  It allows the amount of memory overcommitting to be specified as
  an absolute value (in kB),
  rather than as a percentage, as is done with
  _overcommit_ratio_.
  This allows for finer-grained control of
  _CommitLimit_
  on systems with extremely large memory sizes.
* Only one of
  _overcommit_kbytes_
  or
  _overcommit_ratio_
  can have an effect:
  if
  _overcommit_kbytes_
  has a nonzero value, then it is used to calculate
  _CommitLimit_,
  otherwise
  _overcommit_ratio_
  is used.
  Writing a value to either of these files causes the
  value in the other file to be set to zero.
* _/proc/sys/vm/overcommit_memory_  
  This file contains the kernel virtual memory accounting mode.
  Values are:
    * 0: heuristic overcommit (this is the default)  
      1: always overcommit, never check  
      2: always check, never overcommit
* In mode 0, calls of
  **mmap**(2)
  with
  **MAP_NORESERVE**
  are not checked, and the default check is very weak,
  leading to the risk of getting a process "OOM-killed".
* In mode 1, the kernel pretends there is always enough memory,
  until memory actually runs out.
  One use case for this mode is scientific computing applications
  that employ large sparse arrays.
  In Linux kernel versions before 2.6.0, any nonzero value implies mode 1.
* In mode 2 (available since Linux 2.6), the total virtual address space
  that can be allocated
  (_CommitLimit_
  in
  _/proc/meminfo_)
  is calculated as
*     CommitLimit = (total_RAM - total_huge_TLB) *
                    overcommit_ratio / 100 + total_swap
* where:
    * *  
      _total_RAM_
      is the total amount of RAM on the system;
    * *  
      _total_huge_TLB_
      is the amount of memory set aside for huge pages;
    * *  
      _overcommit_ratio_
      is the value in
      _/proc/sys/vm/overcommit_ratio_;
      and
    * *  
      _total_swap_
      is the amount of swap space.
* For example, on a system with 16GB of physical RAM, 16GB
  of swap, no space dedicated to huge pages, and an
  _overcommit_ratio_
  of 50, this formula yields a
  _CommitLimit_
  of 24GB.
* Since Linux 3.14, if the value in
  _/proc/sys/vm/overcommit_kbytes_
  is nonzero, then
  _CommitLimit_
  is instead calculated as:
*     CommitLimit = overcommit_kbytes + total_swap
* See also the description of
  _/proc/sys/vm/admin_reserve_kbytes_
  and
  _/proc/sys/vm/user_reserve_kbytes_.
* _/proc/sys/vm/overcommit_ratio_ (since Linux 2.6.0)  
  This writable file defines a percentage by which memory
  can be overcommitted.
  The default value in the file is 50.
  See the description of
  _/proc/sys/vm/overcommit_memory_.
* _/proc/sys/vm/panic_on_oom_ (since Linux 2.6.18)  
  
  This enables or disables a kernel panic in
  an out-of-memory situation.
* If this file is set to the value 0,
  the kernel's OOM-killer will kill some rogue process.
  Usually, the OOM-killer is able to kill a rogue process and the
  system will survive.
* If this file is set to the value 1,
  then the kernel normally panics when out-of-memory happens.
  However, if a process limits allocations to certain nodes
  using memory policies
  (**mbind**(2)
  **MPOL_BIND**)
  or cpusets
  (**cpuset**(7))
  and those nodes reach memory exhaustion status,
  one process may be killed by the OOM-killer.
  No panic occurs in this case:
  because other nodes' memory may be free,
  this means the system as a whole may not have reached
  an out-of-memory situation yet.
* If this file is set to the value 2,
  the kernel always panics when an out-of-memory condition occurs.
* The default value is 0.
  1 and 2 are for failover of clustering.
  Select either according to your policy of failover.
* _/proc/sys/vm/swappiness_  
  
  The value in this file controls how aggressively the kernel will swap
  memory pages.
  Higher values increase aggressiveness, lower values
  decrease aggressiveness.
  The default value is 60.
* _/proc/sys/vm/user_reserve_kbytes_ (since Linux 3.10)  
  
  Specifies an amount of memory (in KiB) to reserve for user processes,
  This is intended to prevent a user from starting a single memory hogging
  process, such that they cannot recover (kill the hog).
  The value in this file has an effect only when
  _/proc/sys/vm/overcommit_memory_
  is set to 2 ("overcommit never" mode).
  In this case, the system reserves an amount of memory that is the minimum
  of [3% of current process size,
  _user_reserve_kbytes_].
* The default value in this file is the minimum of [3% of free pages, 128MiB]
  expressed as KiB.
* If the value in this file is set to zero,
  then a user will be allowed to allocate all free memory with a single process
  (minus the amount reserved by
  _/proc/sys/vm/admin_reserve_kbytes_).
  Any subsequent attempts to execute a command will result in
  "fork: Cannot allocate memory".
* Changing the value in this file takes effect whenever
  an application requests memory.
* _/proc/sysrq-trigger_ (since Linux 2.4.21)  
  Writing a character to this file triggers the same SysRq function as
  typing ALT-SysRq-&lt;character&gt; (see the description of
  _/proc/sys/kernel/sysrq_).
  This file is normally writable only by
  _root_.
  For further details see the Linux kernel source file
  _Documentation/admin-guide/sysrq.rst_
  
  (or
  _Documentation/sysrq.txt_
  before Linux 4.10).
* _/proc/sysvipc_  
  Subdirectory containing the pseudo-files
  _msg_, _sem_ and _shm_.
  These files list the System V Interprocess Communication (IPC) objects
  (respectively: message queues, semaphores, and shared memory)
  that currently exist on the system,
  providing similar information to that available via
  **ipcs**(1).
  These files have headers and are formatted (one IPC object per line)
  for easy understanding.
  **sysvipc**(7)
  provides further background on the information shown by these files.
* _/proc/thread-self_ (since Linux 3.17)  
  
  This directory refers to the thread accessing the
  _/proc_
  filesystem,
  and is identical to the
  _/proc/self/task/[tid]_
  directory named by the process thread ID
  (_[tid]_)
  of the same thread.
* _/proc/timer_list_ (since Linux 2.6.21)  
  
  This read-only file exposes a list of all currently pending
  (high-resolution) timers,
  all clock-event sources, and their parameters in a human-readable form.
* _/proc/timer_stats_ (from  Linux 2.6.21 until Linux 4.10)  
  
  
  
  
  
  This is a debugging facility to make timer (ab)use in a Linux
  system visible to kernel and user-space developers.
  It can be used by kernel and user-space developers to verify that
  their code does not make undue use of timers.
  The goal is to avoid unnecessary wakeups,
  thereby optimizing power consumption.
* If enabled in the kernel
  (**CONFIG_TIMER_STATS**),
  but not used,
  it has almost zero run-time overhead and a relatively small
  data-structure overhead.
  Even if collection is enabled at run time, overhead is low:
  all the locking is per-CPU and lookup is hashed.
* The
  _/proc/timer_stats_
  file is used both to control sampling facility and to read out the
  sampled information.
* The
  _timer_stats_
  functionality is inactive on bootup.
  A sampling period can be started using the following command:
* .in +4n
  .EX
  # echo 1 &gt; /proc/timer_stats
  .EE
  .in
* The following command stops a sampling period:
* .in +4n
  .EX
  # echo 0 &gt; /proc/timer_stats
  .EE
  .in
* The statistics can be retrieved by:
* .in +4n
  .EX
  $ cat /proc/timer_stats
  .EE
  .in
* While sampling is enabled, each readout from
  _/proc/timer_stats_
  will see
  newly updated statistics.
  Once sampling is disabled, the sampled information
  is kept until a new sample period is started.
  This allows multiple readouts.
* Sample output from
  _/proc/timer_stats_:
* .in 4n
  .EX
  $** cat /proc/timer_stats**
  Timer Stats Version: v0.3
  Sample period: 1.764 s
  Collection: active
    255,     0 swapper/3        hrtimer_start_range_ns (tick_sched_timer)
     71,     0 swapper/1        hrtimer_start_range_ns (tick_sched_timer)
     58,     0 swapper/0        hrtimer_start_range_ns (tick_sched_timer)
      4,  1694 gnome-shell      mod_delayed_work_on (delayed_work_timer_fn)
     17,     7 rcu_sched        rcu_gp_kthread (process_timeout)
  ...
      1,  4911 kworker/u16:0    mod_delayed_work_on (delayed_work_timer_fn)
     1D,  2522 kworker/0:0      queue_delayed_work_on (delayed_work_timer_fn)
  1029 total events, 583.333 events/sec
  .EE
  .in
* The output columns are:
    * *  
      a count of the number of events,
      optionally (since Linux 2.6.23) followed by the letter 'D'
      
      if this is a deferrable timer;
    * *  
      the PID of the process that initialized the timer;
    * *  
      the name of the process that initialized the timer;
    * *  
      the function where the timer was initialized; and
    * *  
      (in parentheses)
      the callback function that is associated with the timer.
* During the Linux 4.11 development cycle,
  this file  was removed because of security concerns,
  as it exposes information across namespaces.
  Furthermore, it is possible to obtain
  the same information via in-kernel tracing facilities such as ftrace.
* _/proc/tty_  
  Subdirectory containing the pseudo-files and subdirectories for
  tty drivers and line disciplines.
* _/proc/uptime_  
  This file contains two numbers (values in seconds): the uptime of the
  system (including time spent in suspend) and the amount of time spent
  in the idle process.
* _/proc/version_  
  This string identifies the kernel version that is currently running.
  It includes the contents of
  _/proc/sys/kernel/ostype_,
  _/proc/sys/kernel/osrelease_
  and
  _/proc/sys/kernel/version_.
  For example:
* .in 8n
  .EX
  Linux version 1.0.9 (quinlan@phaze) #1 Sat May 14 01:51:54 EDT 1994
  .EE
  .in
  
  
  
  
  
* _/proc/vmstat_ (since Linux 2.6.0)  
  This file displays various virtual memory statistics.
  Each line of this file contains a single name-value pair,
  delimited by white space.
  Some lines are present only if the kernel was configured with
  suitable options.
  (In some cases, the options required for particular files have changed
  across kernel versions, so they are not listed here.
  Details can be found by consulting the kernel source code.)
  The following fields may be present:
  
    * _nr_free_pages_ (since Linux 2.6.31)  
      
    * _nr_alloc_batch_ (since Linux 3.12)  
      
    * _nr_inactive_anon_ (since Linux 2.6.28)  
      
    * _nr_active_anon_ (since Linux 2.6.28)  
      
    * _nr_inactive_file_ (since Linux 2.6.28)  
      
    * _nr_active_file_ (since Linux 2.6.28)  
      
    * _nr_unevictable_ (since Linux 2.6.28)  
      
    * _nr_mlock_ (since Linux 2.6.28)  
      
    * _nr_anon_pages_ (since Linux 2.6.18)  
      
    * _nr_mapped_ (since Linux 2.6.0)  
    * _nr_file_pages_ (since Linux 2.6.18)  
      
    * _nr_dirty_ (since Linux 2.6.0)  
    * _nr_writeback_ (since Linux 2.6.0)  
    * _nr_slab_reclaimable_ (since Linux 2.6.19)  
      
      
    * _nr_slab_unreclaimable_ (since Linux 2.6.19)  
      
    * _nr_page_table_pages_ (since Linux 2.6.0)  
    * _nr_kernel_stack_ (since Linux 2.6.32)  
      
      Amount of memory allocated to kernel stacks.
    * _nr_unstable_ (since Linux 2.6.0)  
    * _nr_bounce_ (since Linux 2.6.12)  
      
    * _nr_vmscan_write_ (since Linux 2.6.19)  
      
    * _nr_vmscan_immediate_reclaim_ (since Linux 3.2)  
      
    * _nr_writeback_temp_ (since Linux 2.6.26)  
      
    * _nr_isolated_anon_ (since Linux 2.6.32)  
      
    * _nr_isolated_file_ (since Linux 2.6.32)  
      
    * _nr_shmem_ (since Linux 2.6.32)  
      
      Pages used by shmem and
      **tmpfs**(5).
    * _nr_dirtied_ (since Linux 2.6.37)  
      
    * _nr_written_ (since Linux 2.6.37)  
      
    * _nr_pages_scanned_ (since Linux 3.17)  
      
    * _numa_hit_ (since Linux 2.6.18)  
      
      
      
    * _numa_miss_ (since Linux 2.6.18)  
      
      
      
    * _numa_foreign_ (since Linux 2.6.18)  
      
      
      
    * _numa_interleave_ (since Linux 2.6.18)  
      
      
      
    * _numa_local_ (since Linux 2.6.18)  
      
      
      
    * _numa_other_ (since Linux 2.6.18)  
      
      
      
    * _workingset_refault_ (since Linux 3.15)  
      
      
      
    * _workingset_activate_ (since Linux 3.15)  
      
      
      
    * _workingset_nodereclaim_ (since Linux 3.15)  
      
      
      
    * _nr_anon_transparent_hugepages_ (since Linux 2.6.38)  
      
      
    * _nr_free_cma_ (since Linux 3.7)  
      
      Number of free CMA (Contiguous Memory Allocator) pages.
      
      
    * _nr_dirty_threshold_ (since Linux 2.6.37)  
      
      
      
    * _nr_dirty_background_threshold_ (since Linux 2.6.37)  
      
      
      
    * _pgpgin_ (since Linux 2.6.0)  
      
      
    * _pgpgout_ (since Linux 2.6.0)  
      
      
    * _pswpin_ (since Linux 2.6.0)  
      
      
    * _pswpout_ (since Linux 2.6.0)  
      
      
    * _pgalloc_dma_ (since Linux 2.6.5)  
      
      
      
    * _pgalloc_dma32_ (since Linux 2.6.16)  
      
      
      
    * _pgalloc_normal_ (since Linux 2.6.5)  
      
      
    * _pgalloc_high_ (since Linux 2.6.5)  
      
      
      
      
    * _pgalloc_movable_ (since Linux 2.6.23)  
      
      
      
    * _pgfree_ (since Linux 2.6.0)  
      
      
    * _pgactivate_ (since Linux 2.6.0)  
      
      
    * _pgdeactivate_ (since Linux 2.6.0)  
      
      
    * _pgfault_ (since Linux 2.6.0)  
      
      
    * _pgmajfault_ (since Linux 2.6.0)  
      
      
    * _pgrefill_dma_ (since Linux 2.6.5)  
      
      
      
    * _pgrefill_dma32_ (since Linux 2.6.16)  
      
      
      
    * _pgrefill_normal_ (since Linux 2.6.5)  
      
      
    * _pgrefill_high_ (since Linux 2.6.5)  
      
      
      
      
    * _pgrefill_movable_ (since Linux 2.6.23)  
      
      
      
      
      
      
      
      
      
      
    * _pgsteal_kswapd_dma_ (since Linux 3.4)  
      
      
      
      
    * _pgsteal_kswapd_dma32_ (since Linux 3.4)  
      
      
      
      
    * _pgsteal_kswapd_normal_ (since Linux 3.4)  
      
      
      
    * _pgsteal_kswapd_high_ (since Linux 3.4)  
      
      
      
      
      
    * _pgsteal_kswapd_movable_ (since Linux 3.4)  
      
      
      
    * _pgsteal_direct_dma_  
      
      
    * _pgsteal_direct_dma32_ (since Linux 3.4)  
      
      
      
    * _pgsteal_direct_normal_ (since Linux 3.4)  
      
      
      
    * _pgsteal_direct_high_ (since Linux 3.4)  
      
      
      
      
      
    * _pgsteal_direct_movable_ (since Linux 2.6.23)  
      
      
      
    * _pgscan_kswapd_dma_  
      
      
      
    * _pgscan_kswapd_dma32_ (since Linux 2.6.16)  
      
      
      
    * _pgscan_kswapd_normal_ (since Linux 2.6.5)  
      
      
    * _pgscan_kswapd_high_  
      
      
      
      
    * _pgscan_kswapd_movable_ (since Linux 2.6.23)  
      
      
      
    * _pgscan_direct_dma_  
      
      
    * _pgscan_direct_dma32_ (since Linux 2.6.16)  
      
      
      
    * _pgscan_direct_normal_  
      
      
    * _pgscan_direct_high_  
      
      
      
      
    * _pgscan_direct_movable_ (since Linux 2.6.23)  
      
      
      
    * _pgscan_direct_throttle_ (since Linux 3.6)  
      
      
      
    * _zone_reclaim_failed_ (since linux 2.6.31)  
      
      
      
      
      
    * _pginodesteal_ (since linux 2.6.0)  
      
      
    * _slabs_scanned_ (since linux 2.6.5)  
      
      
    * _kswapd_inodesteal_ (since linux 2.6.0)  
      
      
    * _kswapd_low_wmark_hit_quickly_ (since 2.6.33)  
      
      
      
    * _kswapd_high_wmark_hit_quickly_ (since 2.6.33)  
      
      
      
    * _pageoutrun_ (since Linux 2.6.0)  
      
      
    * _allocstall_ (since Linux 2.6.0)  
      
      
    * _pgrotated_ (since Linux 2.6.0)  
      
      
    * _drop_pagecache_ (since Linux 3.15)  
      
      
      
    * _drop_slab_ (since Linux 3.15)  
      
      
      
    * _numa_pte_updates_ (since Linux 3.8)  
      
      
      
      
      
    * _numa_huge_pte_updates_ (since Linux 3.13)  
      
      
      
      
      
    * _numa_hint_faults_ (since Linux 3.8)  
      
      
      
      
      
    * _numa_hint_faults_local_ (since Linux 3.8)  
      
      
      
      
      
    * _numa_pages_migrated_ (since Linux 3.8)  
      
      
      
      
      
      
      
    * _pgmigrate_success_ (since Linux 3.8)  
      
      
      
      
      
    * _pgmigrate_fail_ (since Linux 3.8)  
      
      
      
      
      
    * _compact_migrate_scanned_ (since Linux 3.8)  
      
      
      
      
      
      
      
    * _compact_free_scanned_ (since Linux 3.8)  
      
      
      
      
      
    * _compact_isolated_ (since Linux 3.8)  
      
      
      
      
      
    * _compact_stall_ (since Linux 2.6.35)  
      
      See the kernel source file
      _Documentation/admin-guide/mm/transhuge.rst_.
      
      
      
      
    * _compact_fail_ (since Linux 2.6.35)  
      
      See the kernel source file
      _Documentation/admin-guide/mm/transhuge.rst_.
      
      
      
      
    * _compact_success_ (since Linux 2.6.35)  
      
      See the kernel source file
      _Documentation/admin-guide/mm/transhuge.rst_.
      
      
      
      
    * _htlb_buddy_alloc_success_ (since Linux 2.6.26)  
      
      
      
      
      
    * _htlb_buddy_alloc_fail_ (since Linux 2.6.26)  
      
      
      
      
      
    * _unevictable_pgs_culled_ (since Linux 2.6.28)  
      
      
      
    * _unevictable_pgs_scanned_ (since Linux 2.6.28)  
      
      
      
    * _unevictable_pgs_rescued_ (since Linux 2.6.28)  
      
      
      
    * _unevictable_pgs_mlocked_ (since Linux 2.6.28)  
      
      
      
    * _unevictable_pgs_munlocked_ (since Linux 2.6.28)  
      
      
      
    * _unevictable_pgs_cleared_ (since Linux 2.6.28)  
      
      
      
    * _unevictable_pgs_stranded_ (since Linux 2.6.28)  
      
      
      
      
    * _thp_fault_alloc_ (since Linux 2.6.39)  
      
      See the kernel source file
      _Documentation/admin-guide/mm/transhuge.rst_.
      
      
      
      
    * _thp_fault_fallback_ (since Linux 2.6.39)  
      
      See the kernel source file
      _Documentation/admin-guide/mm/transhuge.rst_.
      
      
      
      
    * _thp_collapse_alloc_ (since Linux 2.6.39)  
      
      See the kernel source file
      _Documentation/admin-guide/mm/transhuge.rst_.
      
      
      
      
    * _thp_collapse_alloc_failed_ (since Linux 2.6.39)  
      
      See the kernel source file
      _Documentation/admin-guide/mm/transhuge.rst_.
      
      
      
      
    * _thp_split_ (since Linux 2.6.39)  
      
      See the kernel source file
      _Documentation/admin-guide/mm/transhuge.rst_.
      
      
      
      
    * _thp_zero_page_alloc_ (since Linux 3.8)  
      
      See the kernel source file
      _Documentation/admin-guide/mm/transhuge.rst_.
      
      
      
      
    * _thp_zero_page_alloc_failed_ (since Linux 3.8)  
      
      See the kernel source file
      _Documentation/admin-guide/mm/transhuge.rst_.
      
      
      
      
    * _balloon_inflate_ (since Linux 3.18)  
      
      
      
      
      
    * _balloon_deflate_ (since Linux 3.18)  
      
      
      
      
      
    * _balloon_migrate_ (since Linux 3.18)  
      
      
      
      
      
      
    * _nr_tlb_remote_flush_ (since Linux 3.12)  
      
      
      
      
      
    * _nr_tlb_remote_flush_received_ (since Linux 3.12)  
      
      
      
      
      
    * _nr_tlb_local_flush_all_ (since Linux 3.12)  
      
      
      
    * _nr_tlb_local_flush_one_ (since Linux 3.12)  
      
      
      
    * _vmacache_find_calls_ (since Linux 3.16)  
      
      
      
    * _vmacache_find_hits_ (since Linux 3.16)  
      
      
      
    * _vmacache_full_flushes_ (since Linux 3.19)  
      
      
      
* _/proc/zoneinfo_ (since Linux 2.6.13)  
  This file display information about memory zones.
  This is useful for analyzing virtual memory behavior.
  

<a name="notes"></a>

# Notes

Many files contain strings (e.g., the environment and command line)
that are in the internal format,
with subfields terminated by null bytes ('\e0').
When inspecting such files, you may find that the results are more readable
if you use a command of the following form to display them:

.in +4n
.EX
$** cat _file_ | tr '\e000' '\en'**
.EE
.in

This manual page is incomplete, possibly inaccurate, and is the kind
of thing that needs to be updated very often.




<a name="see-also"></a>

# See Also

**cat**(1),
**dmesg**(1),
**find**(1),
**free**(1),
**htop**(1),
**init**(1),
**ps**(1),
**pstree**(1),
**tr**(1),
**uptime**(1),
**chroot**(2),
**mmap**(2),
**readlink**(2),
**syslog**(2),
**slabinfo**(5),
**sysfs**(5),
**hier**(7),
**namespaces**(7),
**time**(7),
**arp**(8),
**hdparm**(8),
**ifconfig**(8),
**lsmod**(8),
**lspci**(8),
**mount**(8),
**netstat**(8),
**procinfo**(8),
**route**(8),
**sysctl**(8)

The Linux kernel source files:
_Documentation/filesystems/proc.txt_,
_Documentation/sysctl/fs.txt_,
_Documentation/sysctl/kernel.txt_,
_Documentation/sysctl/net.txt_,
and
_Documentation/sysctl/vm.txt_.

<a name="colophon"></a>

# Colophon

This page is part of release 5.04 of the Linux
_man-pages_
project.
A description of the project,
information about reporting bugs,
and the latest version of this page,
can be found at
https://www.kernel.org/doc/man-pages/.
