# msgctl(2) - System V message control operations

Linux, 2017-09-15

    #include <sys/types.h>
    #include <sys/ipc.h>
    #include <sys/msg.h>
    
    int msgctl(int msqid, int cmd, struct msqid_ds *buf);

<a name="description"></a>

# Description

**msgctl**()
performs the control operation specified by
_cmd_
on the System&nbsp;V message queue with identifier
_msqid_.

The
_msqid_ds_
data structure is defined in _&lt;sys/msg.h&gt;_ as follows:

.in +4n
.EX
struct msqid_ds {
    struct ipc_perm msg_perm;     /* Ownership and permissions */
    time_t          msg_stime;    /* Time of last msgsnd(2) */
    time_t          msg_rtime;    /* Time of last msgrcv(2) */
    time_t          msg_ctime;    /* Time of last change */
    unsigned long   __msg_cbytes; /* Current number of bytes in
                                     queue (nonstandard) */
    msgqnum_t       msg_qnum;     /* Current number of messages
                                     in queue */
    msglen_t        msg_qbytes;   /* Maximum number of bytes
                                     allowed in queue */
    pid_t           msg_lspid;    /* PID of last msgsnd(2) */
    pid_t           msg_lrpid;    /* PID of last msgrcv(2) */
};
.EE
.in

The
_ipc_perm_
structure is defined as follows
(the highlighted fields are settable using
**IPC_SET**):

.in +4n
.EX
struct ipc_perm {
    key_t          __key;       /* Key supplied to msgget(2) */
    uid_t          **uid**;         /* Effective UID of owner */
    gid_t          **gid**;         /* Effective GID of owner */
    uid_t          cuid;        /* Effective UID of creator */
    gid_t          cgid;        /* Effective GID of creator */
    unsigned short **mode**;        /* Permissions */
    unsigned short __seq;       /* Sequence number */
};
.EE
.in

Valid values for
_cmd_
are:

* **IPC_STAT**  
  Copy information from the kernel data structure associated with
  _msqid_
  into the
  _msqid_ds_
  structure pointed to by
  _buf_.
  The caller must have read permission on the message queue.
* **IPC_SET**  
  Write the values of some members of the
  _msqid_ds_
  structure pointed to by
  _buf_
  to the kernel data structure associated with this message queue,
  updating also its
  _msg_ctime_
  member.
  The following members of the structure are updated:
  _msg_qbytes_,
  _msg_perm.uid_,
  _msg_perm.gid_,
  and (the least significant 9 bits of)
  _msg_perm.mode_.
  The effective UID of the calling process must match the owner
  (_msg_perm.uid_)
  or creator
  (_msg_perm.cuid_)
  of the message queue, or the caller must be privileged.
  Appropriate privilege (Linux: the
  **CAP_SYS_RESOURCE**
  capability) is required to raise the
  _msg_qbytes_
  value beyond the system parameter
  **MSGMNB**.
* **IPC_RMID**  
  Immediately remove the message queue,
  awakening all waiting reader and writer processes (with an error
  return and
  _errno_
  set to
  **EIDRM**).
  The calling process must have appropriate privileges
  or its effective user ID must be either that of the creator or owner
  of the message queue.
  The third argument to
  **msgctl**()
  is ignored in this case.
* **IPC_INFO** (Linux-specific)  
  Return information about system-wide message queue limits and
  parameters in the structure pointed to by
  _buf_.
  This structure is of type
  _msginfo_
  (thus, a cast is required),
  defined in
  _&lt;sys/msg.h&gt;_
  if the
  **_GNU_SOURCE**
  feature test macro is defined:
* .in +4n
  .EX
  struct msginfo {
      int msgpool; /* Size in kibibytes of buffer pool
                      used to hold message data;
                      unused within kernel */
      int msgmap;  /* Maximum number of entries in message
                      map; unused within kernel */
      int msgmax;  /* Maximum number of bytes that can be
                      written in a single message */
      int msgmnb;  /* Maximum number of bytes that can be
                      written to queue; used to initialize
                      msg_qbytes during queue creation
                      (msgget(2)) */
      int msgmni;  /* Maximum number of message queues */
      int msgssz;  /* Message segment size;
                      unused within kernel */
      int msgtql;  /* Maximum number of messages on all queues
                      in system; unused within kernel */
      unsigned short int msgseg;
                   /* Maximum number of segments;
                      unused within kernel */
  };
  .EE
  .in
* The
  _msgmni_,
  _msgmax_,
  and
  _msgmnb_
  settings can be changed via
  _/proc_
  files of the same name; see
  **proc**(5)
  for details.
* **MSG_INFO** (Linux-specific)  
  Return a
  _msginfo_
  structure containing the same information as for
  **IPC_INFO**,
  except that the following fields are returned with information
  about system resources consumed by message queues: the
  _msgpool_
  field returns the number of message queues that currently exist
  on the system; the
  _msgmap_
  field returns the total number of messages in all queues
  on the system; and the
  _msgtql_
  field returns the total number of bytes in all messages
  in all queues on the system.
* **MSG_STAT** (Linux-specific)  
  Return a
  _msqid_ds_
  structure as for
  **IPC_STAT**.
  However, the
  _msqid_
  argument is not a queue identifier, but instead an index into
  the kernel's internal array that maintains information about
  all message queues on the system.

<a name="return-value"></a>

# Return Value

On success,
**IPC_STAT**,
**IPC_SET**,
and
**IPC_RMID**
return 0.
A successful
**IPC_INFO**
or
**MSG_INFO**
operation returns the index of the highest used entry in the
kernel's internal array recording information about all
message queues.
(This information can be used with repeated
**MSG_STAT**
operations to obtain information about all queues on the system.)
A successful
**MSG_STAT**
operation returns the identifier of the queue whose index was given in
_msqid_.

On error, -1 is returned with
_errno_
indicating the error.

<a name="errors"></a>

# Errors

On failure,
_errno_
is set to one of the following:

* **EACCES**  
  The argument
  _cmd_
  is equal to
  **IPC_STAT**
  or
  **MSG_STAT**,
  but the calling process does not have read permission on the message queue
  _msqid_,
  and does not have the
  **CAP_IPC_OWNER**
  capability in the user namespace that governs its IPC namespace.
* **EFAULT**  
  The argument
  _cmd_
  has the value
  **IPC_SET**
  or
  **IPC_STAT**,
  but the address pointed to by
  _buf_
  isn't accessible.
* **EIDRM**  
  The message queue was removed.
* **EINVAL**  
  Invalid value for
  _cmd_
  or
  _msqid_.
  Or: for a
  **MSG_STAT**
  operation, the index value specified in
  _msqid_
  referred to an array slot that is currently unused.
* **EPERM**  
  The argument
  _cmd_
  has the value
  **IPC_SET**
  or
  **IPC_RMID**,
  but the effective user ID of the calling process is not the creator
  (as found in
  _msg_perm.cuid_)
  or the owner
  (as found in
  _msg_perm.uid_)
  of the message queue,
  and the caller is not privileged (Linux: does not have the
  **CAP_SYS_ADMIN**
  capability).
* **EPERM**  
  An attempt
  (**IPC_SET**)
  was made to increase
  _msg_qbytes_
  beyond the system parameter
  **MSGMNB**,
  but the caller is not privileged (Linux: does not have the
  **CAP_SYS_RESOURCE**
  capability).

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



The
**IPC_INFO**,
**MSG_STAT**
and
**MSG_INFO**
operations are used by the
**ipcs**(1)
program to provide information on allocated resources.
In the future these may modified or moved to a
_/proc_
filesystem interface.

Various fields in the _struct msqid\_ds_ were
typed as
_short_
under Linux 2.2
and have become
_long_
under Linux 2.4.
To take advantage of this,
a recompilation under glibc-2.1.91 or later should suffice.
(The kernel distinguishes old and new calls by an
**IPC_64**
flag in
_cmd_.)

<a name="see-also"></a>

# See Also

**msgget**(2),
**msgrcv**(2),
**msgsnd**(2),
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
