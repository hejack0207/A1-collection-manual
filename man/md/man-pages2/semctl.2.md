# semctl(2) - System V semaphore control operations

Linux, 2017-09-15

    #include <sys/types.h>
    #include <sys/ipc.h>
    #include <sys/sem.h>
    
    int semctl(int semid, int semnum, int cmd, ...);

<a name="description"></a>

# Description

**semctl**()
performs the control operation specified by
_cmd_
on the System&nbsp;V semaphore set identified by
_semid_,
or on the
_semnum_-th
semaphore of that set.
(The semaphores in a set are numbered starting at 0.)

This function has three or four arguments, depending on
_cmd_.
When there are four, the fourth has the type
_union semun_.
The _calling program_ must define this union as follows:

.in +4n
.EX
union semun {
    int              val;    /* Value for SETVAL */
    struct semid_ds *buf;    /* Buffer for IPC_STAT, IPC_SET */
    unsigned short  *array;  /* Array for GETALL, SETALL */
    struct seminfo  *__buf;  /* Buffer for IPC_INFO
                                (Linux-specific) */
};
.EE
.in

The
_semid_ds_
data structure is defined in _&lt;sys/sem.h&gt;_ as follows:

.in +4n
.EX
struct semid_ds {
    struct ipc_perm sem_perm;  /* Ownership and permissions */
    time_t          sem_otime; /* Last semop time */
    time_t          sem_ctime; /* Last change time */
    unsigned long   sem_nsems; /* No. of semaphores in set */
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
    key_t          __key; /* Key supplied to semget(2) */
    uid_t          **uid**;   /* Effective UID of owner */
    gid_t          **gid**;   /* Effective GID of owner */
    uid_t          cuid;  /* Effective UID of creator */
    gid_t          cgid;  /* Effective GID of creator */
    unsigned short **mode**;  /* Permissions */
    unsigned short __seq; /* Sequence number */
};
.EE
.in

Valid values for
_cmd_
are:

* **IPC_STAT**  
  Copy information from the kernel data structure associated with
  _semid_
  into the
  _semid_ds_
  structure pointed to by
  _arg.buf_.
  The argument
  _semnum_
  is ignored.
  The calling process must have read permission on the semaphore set.
* **IPC_SET**  
  Write the values of some members of the
  _semid_ds_
  structure pointed to by
  _arg.buf_
  to the kernel data structure associated with this semaphore set,
  updating also its
  _sem_ctime_
  member.
  The following members of the structure are updated:
  _sem_perm.uid_,
  _sem_perm.gid_,
  and (the least significant 9 bits of)
  _sem_perm.mode_.
  The effective UID of the calling process must match the owner
  (_sem_perm.uid_)
  or creator
  (_sem_perm.cuid_)
  of the semaphore set, or the caller must be privileged.
  The argument
  _semnum_
  is ignored.
* **IPC_RMID**  
  Immediately remove the semaphore set,
  awakening all processes blocked in
  **semop**(2)
  calls on the set (with an error return and
  _errno_
  set to
  **EIDRM**).
  The effective user ID of the calling process must
  match the creator or owner of the semaphore set,
  or the caller must be privileged.
  The argument
  _semnum_
  is ignored.
* **IPC_INFO** (Linux-specific)  
  Return information about system-wide semaphore limits and
  parameters in the structure pointed to by
  _arg.__buf_.
  This structure is of type
  _seminfo_,
  defined in
  _&lt;sys/sem.h&gt;_
  if the
  **_GNU_SOURCE**
  feature test macro is defined:
* .in +4n
  .EX
  struct  seminfo {
      int semmap;  /* Number of entries in semaphore
                      map; unused within kernel */
      int semmni;  /* Maximum number of semaphore sets */
      int semmns;  /* Maximum number of semaphores in all
                      semaphore sets */
      int semmnu;  /* System-wide maximum number of undo
                      structures; unused within kernel */
      int semmsl;  /* Maximum number of semaphores in a
                      set */
      int semopm;  /* Maximum number of operations for
                      semop(2) */
      int semume;  /* Maximum number of undo entries per
                      process; unused within kernel */
      int semusz;  /* Size of struct sem_undo */
      int semvmx;  /* Maximum semaphore value */
      int semaem;  /* Max. value that can be recorded for
                      semaphore adjustment (SEM_UNDO) */
  };
  .EE
  .in
* The
  _semmsl_,
  _semmns_,
  _semopm_,
  and
  _semmni_
  settings can be changed via
  _/proc/sys/kernel/sem_;
  see
  **proc**(5)
  for details.
* **SEM_INFO** (Linux-specific)  
  Return a
  _seminfo_
  structure containing the same information as for
  **IPC_INFO**,
  except that the following fields are returned with information
  about system resources consumed by semaphores: the
  _semusz_
  field returns the number of semaphore sets that currently exist
  on the system; and the
  _semaem_
  field returns the total number of semaphores in all semaphore sets
  on the system.
* **SEM_STAT** (Linux-specific)  
  Return a
  _semid_ds_
  structure as for
  **IPC_STAT**.
  However, the
  _semid_
  argument is not a semaphore identifier, but instead an index into
  the kernel's internal array that maintains information about
  all semaphore sets on the system.
* **GETALL**  
  Return
  **semval**
  (i.e., the current value)
  for all semaphores of the set into
  _arg.array_.
  The argument
  _semnum_
  is ignored.
  The calling process must have read permission on the semaphore set.
* **GETNCNT**  
  Return the value of
  **semncnt**
  for the
  _semnum_-th
  semaphore of the set
  (i.e., the number of processes waiting for an increase of
  **semval**
  for the
  _semnum_-th
  semaphore of the set).
  The calling process must have read permission on the semaphore set.
* **GETPID**  
  Return the value of
  **sempid**
  for the
  _semnum_-th
  semaphore of the set.
  This is the PID of the process that last performed an operation on
  that semaphore (but see NOTES).
  The calling process must have read permission on the semaphore set.
* **GETVAL**  
  Return the value of
  **semval**
  for the
  _semnum_-th
  semaphore of the set.
  The calling process must have read permission on the semaphore set.
* **GETZCNT**  
  Return the value of
  **semzcnt**
  for the
  _semnum_-th
  semaphore of the set
  (i.e., the number of processes waiting for
  **semval**
  of the
  _semnum_-th
  semaphore of the set to become 0).
  The calling process must have read permission on the semaphore set.
* **SETALL**  
  Set
  **semval**
  for all semaphores of the set using
  _arg.array_,
  updating also the
  _sem_ctime_
  member of the
  _semid_ds_
  structure associated with the set.
  Undo entries (see
  **semop**(2))
  are cleared for altered semaphores in all processes.
  If the changes to semaphore values would permit blocked
  **semop**(2)
  calls in other processes to proceed, then those processes are woken up.
  The argument
  _semnum_
  is ignored.
  The calling process must have alter (write) permission on
  the semaphore set.
* **SETVAL**  
  Set the value of
  **semval**
  to
  _arg.val_
  for the
  _semnum_-th
  semaphore of the set, updating also the
  _sem_ctime_
  member of the
  _semid_ds_
  structure associated with the set.
  Undo entries are cleared for altered semaphores in all processes.
  If the changes to semaphore values would permit blocked
  **semop**(2)
  calls in other processes to proceed, then those processes are woken up.
  The calling process must have alter permission on the semaphore set.

<a name="return-value"></a>

# Return Value

On failure,
**semctl**()
returns -1
with
_errno_
indicating the error.

Otherwise, the system call returns a nonnegative value depending on
_cmd_
as follows:

* **GETNCNT**  
  the value of
  **semncnt**.
* **GETPID**  
  the value of
  **sempid**.
* **GETVAL**  
  the value of
  **semval**.
* **GETZCNT**  
  the value of
  **semzcnt**.
* **IPC_INFO**  
  the index of the highest used entry in the
  kernel's internal array recording information about all
  semaphore sets.
  (This information can be used with repeated
  **SEM_STAT**
  operations to obtain information about all semaphore sets on the system.)
* **SEM_INFO**  
  as for
  **IPC_INFO**.
* **SEM_STAT**  
  the identifier of the semaphore set whose index was given in
  _semid_.

All other
_cmd_
values return 0 on success.

<a name="errors"></a>

# Errors

On failure,
_errno_
will be set to one of the following:

* **EACCES**  
  The argument
  _cmd_
  has one of the values
  **GETALL**,
  **GETPID**,
  **GETVAL**,
  **GETNCNT**,
  **GETZCNT**,
  **IPC_STAT**,
  **SEM_STAT**,
  **SETALL**,
  or
  **SETVAL**
  and the calling process does not have the required
  permissions on the semaphore set and does not have the
  **CAP_IPC_OWNER**
  capability in the user namespace that governs its IPC namespace.
* **EFAULT**  
  The address pointed to by
  _arg.buf_
  or
  _arg.array_
  isn't accessible.
* **EIDRM**  
  The semaphore set was removed.
* **EINVAL**  
  Invalid value for
  _cmd_
  or
  _semid_.
  Or: for a
  **SEM_STAT**
  operation, the index value specified in
  _semid_
  referred to an array slot that is currently unused.
* **EPERM**  
  The argument
  _cmd_
  has the value
  **IPC_SET**
  or
  **IPC_RMID**
  but the effective user ID of the calling process is not the creator
  (as found in
  _sem_perm.cuid_)
  or the owner
  (as found in
  _sem_perm.uid_)
  of the semaphore set,
  and the process does not have the
  **CAP_SYS_ADMIN**
  capability.
* **ERANGE**  
  The argument
  _cmd_
  has the value
  **SETALL**
  or
  **SETVAL**
  and the value to which
  **semval**
  is to be set (for some semaphore of the set) is less than 0
  or greater than the implementation limit
  **SEMVMX**.

<a name="conforming-to"></a>

# Conforming to

POSIX.1-2001, POSIX.1-2008, SVr4.


POSIX.1 specifies the

_sem_nsems_
field of the
_semid_ds_
structure as having the type
_unsigned&nbsp;short_,
and the field is so defined on most other systems.
It was also so defined on Linux 2.2 and earlier,
but, since Linux 2.4, the field has the type
_unsigned&nbsp;long_.

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
**SEM_STAT**
and
**SEM_INFO**
operations are used by the
**ipcs**(1)
program to provide information on allocated resources.
In the future these may modified or moved to a
_/proc_
filesystem interface.

Various fields in a _struct semid\_ds_ were typed as
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

In some earlier versions of glibc, the
_semun_
union was defined in _&lt;sys/sem.h&gt;_, but POSIX.1 requires

that the caller define this union.
On versions of glibc where this union is _not_ defined,
the macro
**_SEM_SEMUN_UNDEFINED**
is defined in _&lt;sys/sem.h&gt;_.

The following system limit on semaphore sets affects a
**semctl**()
call:

* **SEMVMX**  
  Maximum value for
  **semval**:
  implementation dependent (32767).

For greater portability, it is best to always call
**semctl**()
with four arguments.


<a name="the-sempid-value"></a>

### The sempid value

POSIX.1 defines
_sempid_
as the "process ID of [the] last operation" on a semaphore,
and explicitly notes that this value is set by a successful
**semop**(2)
call, with the implication that no other interface affects the
_sempid_
value.

While some implementations conform to the behavior specified in POSIX.1,
others do not.
(The fault here probably lies with POSIX.1 inasmuch as it likely failed
to capture the full range of existing implementation behaviors.)
Various other implementations

also update
_sempid_
for the other operations that update the value of a semaphore: the
**SETVAL**
and
**SETALL**
operations, as well as the semaphore adjustments performed
on process termination as a consequence of the use of the
**SEM_UNDO**
flag (see
**semop**(2)).

Linux also updates
_sempid_
for
**SETVAL**
operations and semaphore adjustments.
However, somewhat inconsistently, up to and including 4.5,
Linux did not update
_sempid_
for
**SETALL**
operations.
This was rectified

in Linux 4.6.

<a name="see-also"></a>

# See Also

**ipc**(2),
**semget**(2),
**semop**(2),
**capabilities**(7),
**sem_overview**(7),
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
