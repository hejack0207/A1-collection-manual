# msgget(2) - get a System V message queue identifier

Linux, 2018-04-30

    #include <sys/types.h>
    #include <sys/ipc.h>
    #include <sys/msg.h>
    
    int msgget(key_t key, int msgflg);

<a name="description"></a>

# Description

The
**msgget**()
system call returns the System&nbsp;V message queue identifier associated
with the value of the
_key_
argument.
It may be used either to obtain the identifier of a previously created
message queue (when
_msgflg_
is zero and
_key_
does not have the value
**IPC_PRIVATE**),
or to create a new set.

A new message queue is created if
_key_
has the value
**IPC_PRIVATE**
or
_key_
isn't
**IPC_PRIVATE**,
no message queue with the given key
_key_
exists, and
**IPC_CREAT**
is specified in
_msgflg_.

If
_msgflg_
specifies both
**IPC_CREAT**
and
**IPC_EXCL**
and a message queue already exists for
_key_,
then
**msgget**()
fails with
_errno_
set to
**EEXIST**.
(This is analogous to the effect of the combination
**O_CREAT | O_EXCL**
for
**open**(2).)

Upon creation, the least significant bits of the argument
_msgflg_
define the permissions of the message queue.
These permission bits have the same format and semantics
as the permissions specified for the
_mode_
argument of
**open**(2).
(The execute permissions are not used.)

If a new message queue is created,
then its associated data structure
_msqid_ds_
(see
**msgctl**(2))
is initialized as follows:

* _msg_perm.cuid_
  and
  _msg_perm.uid_
  are set to the effective user ID of the calling process.
* _msg_perm.cgid_
  and
  _msg_perm.gid_
  are set to the effective group ID of the calling process.
* The least significant 9 bits of
  _msg_perm.mode_
  are set to the least significant 9 bits of
  _msgflg_.
* _msg_qnum_,
  _msg_lspid_,
  _msg_lrpid_,
  _msg_stime_,
  and
  _msg_rtime_
  are set to 0.
* _msg_ctime_
  is set to the current time.
* _msg_qbytes_
  is set to the system limit
  **MSGMNB**.

If the message queue already exists the permissions are
verified, and a check is made to see if it is marked for
destruction.

<a name="return-value"></a>

# Return Value

If successful, the return value will be the message queue identifier (a
nonnegative integer), otherwise -1
with
_errno_
indicating the error.

<a name="errors"></a>

# Errors

On failure,
_errno_
is set to one of the following values:

* **EACCES**  
  A message queue exists for
  _key_,
  but the calling process does not have permission to access the queue,
  and does not have the
  **CAP_IPC_OWNER**
  capability in the user namespace that governs its IPC namespace.
* **EEXIST**  
  **IPC_CREAT**
  and
  **IPC_EXCL**
  were specified in
  _msgflg_,
  but a message queue already exists for
  _key_.
* **ENOENT**  
  No message queue exists for
  _key_
  and
  _msgflg_
  did not specify
  **IPC_CREAT**.
* **ENOMEM**  
  A message queue has to be created but the system does not have enough
  memory for the new data structure.
* **ENOSPC**  
  A message queue has to be created but the system limit for the maximum
  number of message queues
  (**MSGMNI**)
  would be exceeded.

<a name="conforming-to"></a>

# Conforming to

POSIX.1-2001, POSIX.1-2008, SVr4.

<a name="notes"></a>

# Notes

The inclusion of
_&lt;sys/types.h&gt;_
and
_&lt;sys/ipc.h&gt;_
isn't required on Linux or by any version of POSIX.
However,
some old implementations required the inclusion of these header files,
and the SVID also documented their inclusion.
Applications intended to be portable to such old systems may need
to include these header files.



**IPC_PRIVATE**
isn't a flag field but a
_key_t_
type.
If this special value is used for
_key_,
the system call ignores everything but the least significant 9 bits of
_msgflg_
and creates a new message queue (on success).

The following is a system limit on message queue resources affecting a
**msgget**()
call:

* **MSGMNI**  
  System-wide limit on the number of message queues.
  Before Linux 3.19,
  
  the default value for this limit was calculated using a formula
  based on available system memory.
  Since Linux 3.19, the default value is 32,000.
  On Linux, this limit can be read and modified via
  _/proc/sys/kernel/msgmni_.

<a name="linux-notes"></a>

### Linux notes

Until version 2.3.20, Linux would return
**EIDRM**
for a
**msgget**()
on a message queue scheduled for deletion.

<a name="bugs"></a>

# Bugs

The name choice
**IPC_PRIVATE**
was perhaps unfortunate,
**IPC_NEW**
would more clearly show its function.

<a name="see-also"></a>

# See Also

**msgctl**(2),
**msgrcv**(2),
**msgsnd**(2),
**ftok**(3),
**capabilities**(7),
**mq_overview**(7),
**svipc**(7)

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
