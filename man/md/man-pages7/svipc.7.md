# svipc(7) - System V interprocess communication mechanisms

Linux, 2016-03-15

    #include <sys/msg.h>
    #include <sys/sem.h>
    #include <sys/shm.h>

<a name="description"></a>

# Description

This manual page refers to the Linux implementation of the System V
interprocess communication (IPC) mechanisms:
message queues, semaphore sets, and shared memory segments.
In the following, the word
_resource_
means an instantiation of one among such mechanisms.

<a name="resource-access-permissions"></a>

### Resource access permissions

For each resource, the system uses a common structure of type
_struct ipc_perm_
to store information needed in determining permissions to perform an
IPC operation.
The
_ipc_perm_
structure includes the following members:

.in +4n
.EX
struct ipc_perm {
    uid_t          cuid;   /* creator user ID */
    gid_t          cgid;   /* creator group ID */
    uid_t          uid;    /* owner user ID */
    gid_t          gid;    /* owner group ID */
    unsigned short mode;   /* r/w permissions */
};
.EE
.in

The
_mode_
member of the
_ipc_perm_
structure defines, with its lower 9 bits, the access permissions to the
resource for a process executing an IPC system call.
The permissions are interpreted as follows:

        0400    Read by user.
        0200    Write by user.
        0040    Read by group.
        0020    Write by group.
        0004    Read by others.
        0002    Write by others.

Bits 0100, 0010, and 0001 (the execute bits) are unused by the system.
Furthermore,
"write"
effectively means
"alter"
for a semaphore set.

The same system header file also defines the following symbolic
constants:

* **IPC_CREAT**  
  Create entry if key doesn't exist.
* **IPC_EXCL**  
  Fail if key exists.
* **IPC_NOWAIT**  
  Error if request must wait.
* **IPC_PRIVATE**  
  Private key.
* **IPC_RMID**  
  Remove resource.
* **IPC_SET**  
  Set resource options.
* **IPC_STAT**  
  Get resource options.

Note that
**IPC_PRIVATE**
is a
_key_t_
type, while all the other symbolic constants are flag fields and can
be OR'ed into an
_int_
type variable.

<a name="message-queues"></a>

### Message queues

A message queue is uniquely identified by a positive integer
(its _msqid_)
and has an associated data structure of type
_struct msqid_ds_,
defined in
_&lt;sys/msg.h&gt;_,
containing the following members:

.in +4n
.EX
struct msqid_ds {
    struct ipc_perm msg_perm;
    msgqnum_t       msg_qnum;    /* no of messages on queue */
    msglen_t        msg_qbytes;  /* bytes max on a queue */
    pid_t           msg_lspid;   /* PID of last msgsnd(2) call */
    pid_t           msg_lrpid;   /* PID of last msgrcv(2) call */
    time_t          msg_stime;   /* last msgsnd(2) time */
    time_t          msg_rtime;   /* last msgrcv(2) time */
    time_t          msg_ctime;   /* last change time */
};
.EE
.in

* _msg_perm_  
  _ipc_perm_
  structure that specifies the access permissions on the message
  queue.
* _msg_qnum_  
  Number of messages currently on the message queue.
* _msg_qbytes_  
  Maximum number of bytes of message text allowed on the message
  queue.
* _msg_lspid_  
  ID of the process that performed the last
  **msgsnd**(2)
  system call.
* _msg_lrpid_  
  ID of the process that performed the last
  **msgrcv**(2)
  system call.
* _msg_stime_  
  Time of the last
  **msgsnd**(2)
  system call.
* _msg_rtime_  
  Time of the last
  **msgrcv**(2)
  system call.
* _msg_ctime_  
  Time of the last
  system call that changed a member of the
  _msqid_ds_
  structure.

<a name="semaphore-sets"></a>

### Semaphore sets

A semaphore set is uniquely identified by a positive integer
(its _semid_)
and has an associated data structure of type
_struct semid_ds_,
defined in
_&lt;sys/sem.h&gt;_,
containing the following members:

* .in +4n
  .EX
  struct semid_ds {
      struct ipc_perm sem_perm;
      time_t          sem_otime;   /* last operation time */
      time_t          sem_ctime;   /* last change time */
      unsigned long   sem_nsems;   /* count of sems in set */
  };
  .EE
  .in
* _sem_perm_  
  _ipc_perm_
  structure that specifies the access permissions on the semaphore
  set.
* _sem_otime_  
  Time of last
  **semop**(2)
  system call.
* _sem_ctime_  
  Time of last
  **semctl**(2)
  system call that changed a member of the above structure or of one
  semaphore belonging to the set.
* _sem_nsems_  
  Number of semaphores in the set.
  Each semaphore of the set is referenced by a nonnegative integer
  ranging from
  **0**
  to
  _sem_nsems-1_.

A semaphore is a data structure of type
_struct sem_
containing the following members:

.in +4n
.EX
struct sem {
    int semval;  /* semaphore value */
    int sempid;  /* PID of process that last modified */


};
.EE
.in

* _semval_  
  Semaphore value: a nonnegative integer.
* _sempid_  
  PID of the last process that modified the value of
  this semaphore.
  
  
  
  
  
  
  
  
  
  

<a name="shared-memory-segments"></a>

### Shared memory segments

A shared memory segment is uniquely identified by a positive integer
(its _shmid_)
and has an associated data structure of type
_struct shmid_ds_,
defined in
_&lt;sys/shm.h&gt;_,
containing the following members:

.in +4n
.EX
struct shmid_ds {
    struct ipc_perm shm_perm;
    size_t          shm_segsz;   /* size of segment */
    pid_t           shm_cpid;    /* PID of creator */
    pid_t           shm_lpid;    /* PID, last operation */
    shmatt_t        shm_nattch;  /* no. of current attaches */
    time_t          shm_atime;   /* time of last attach */
    time_t          shm_dtime;   /* time of last detach */
    time_t          shm_ctime;   /* time of last change */
};
.EE
.in

* _shm_perm_  
  _ipc_perm_
  structure that specifies the access permissions on the shared memory
  segment.
* _shm_segsz_  
  Size in bytes of the shared memory segment.
* _shm_cpid_  
  ID of the process that created the shared memory segment.
* _shm_lpid_  
  ID of the last process that executed a
  **shmat**(2)
  or
  **shmdt**(2)
  system call.
* _shm_nattch_  
  Number of current alive attaches for this shared memory segment.
* _shm_atime_  
  Time of the last
  **shmat**(2)
  system call.
* _shm_dtime_  
  Time of the last
  **shmdt**(2)
  system call.
* _shm_ctime_  
  Time of the last
  **shmctl**(2)
  system call that changed
  _shmid_ds_.

<a name="ipc-namespaces"></a>

### IPC namespaces

For a discussion of the interaction of System V IPC objects and
IPC namespaces, see
**namespaces**(7).

<a name="see-also"></a>

# See Also

**ipcmk**(1),
**ipcrm**(1),
**ipcs**(1),
**lsipc**(1),
**ipc**(2),
**msgctl**(2),
**msgget**(2),
**msgrcv**(2),
**msgsnd**(2),
**semctl**(2),
**semget**(2),
**semop**(2),
**shmat**(2),
**shmctl**(2),
**shmdt**(2),
**shmget**(2),
**ftok**(3),
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
