# semget(2) - get a System V semaphore set identifier

Linux, 2018-04-30

    #include <sys/types.h>
    #include <sys/ipc.h>
    #include <sys/sem.h>
```

 int semget(key_t key, int nsems, int semflg);
```

<a name="description"></a>

# Description

The
**semget**()
system call returns the System&nbsp;V semaphore set identifier
associated with the argument
_key_.
It may be used either to obtain the identifier of a previously created
semaphore set (when
_semflg_
is zero and
_key_
does not have the value
**IPC_PRIVATE**),
or to create a new set.

A new set of
_nsems_
semaphores is created if
_key_
has the value
**IPC_PRIVATE**
or if no existing semaphore set is associated with
_key_
and
**IPC_CREAT**
is specified in
_semflg_.

If
_semflg_
specifies both
**IPC_CREAT**
and
**IPC_EXCL**
and a semaphore set already exists for
_key_,
then
**semget**()
fails with
_errno_
set to
**EEXIST**.
(This is analogous to the effect of the combination
**O_CREAT | O_EXCL**
for
**open**(2).)

Upon creation, the least significant 9 bits of the argument
_semflg_
define the permissions (for owner, group and others)
for the semaphore set.
These bits have the same format, and the same
meaning, as the
_mode_
argument of
**open**(2)
(though the execute permissions are
not meaningful for semaphores, and write permissions mean permission
to alter semaphore values).

When creating a new semaphore set,
**semget**()
initializes the set's associated data structure,
_semid_ds_
(see
**semctl**(2)),
as follows:

* _sem_perm.cuid_
  and
  _sem_perm.uid_
  are set to the effective user ID of the calling process.
* _sem_perm.cgid_
  and
  _sem_perm.gid_
  are set to the effective group ID of the calling process.
* The least significant 9 bits of
  _sem_perm.mode_
  are set to the least significant 9 bits of
  _semflg_.
* _sem_nsems_
  is set to the value of
  _nsems_.
* _sem_otime_
  is set to 0.
* _sem_ctime_
  is set to the current time.

The argument
_nsems_
can be 0
(a don't care)
when a semaphore set is not being created.
Otherwise,
_nsems_
must be greater than 0
and less than or equal to the maximum number of semaphores per semaphore set
(**SEMMSL**).

If the semaphore set already exists, the permissions are
verified.


<a name="return-value"></a>

# Return Value

If successful, the return value will be the semaphore set identifier
(a nonnegative integer), otherwise, -1
is returned, with
_errno_
indicating the error.

<a name="errors"></a>

# Errors

On failure,
_errno_
will be set to one of the following:

* **EACCES**  
  A semaphore set exists for
  _key_,
  but the calling process does not have permission to access the set,
  and does not have the
  **CAP_IPC_OWNER**
  capability in the user namespace that governs its IPC namespace.
* **EEXIST**  
  **IPC_CREAT**
  and
  **IPC_EXCL**
  were specified in
  _semflg_,
  but a semaphore set already exists for
  _key_.
  
  
  
* **EINVAL**  
  _nsems_
  is less than 0 or greater than the limit on the number
  of semaphores per semaphore set
  (**SEMMSL**).
* **EINVAL**  
  A semaphore set corresponding to
  _key_
  already exists, but
  _nsems_
  is larger than the number of semaphores in that set.
* **ENOENT**  
  No semaphore set exists for
  _key_
  and
  _semflg_
  did not specify
  **IPC_CREAT**.
* **ENOMEM**  
  A semaphore set has to be created but the system does not have
  enough memory for the new data structure.
* **ENOSPC**  
  A semaphore set has to be created but the system limit for the maximum
  number of semaphore sets
  (**SEMMNI**),
  or the system wide maximum number of semaphores
  (**SEMMNS**),
  would be exceeded.

<a name="conforming-to"></a>

# Conforming to

SVr4, POSIX.1-2001.



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
the system call ignores all but the least significant 9 bits of
_semflg_
and creates a new semaphore set (on success).


<a name="semaphore-initialization"></a>

### Semaphore initialization

The values of the semaphores in a newly created set are indeterminate.
(POSIX.1-2001 and POSIX.1-2008 are explicit on this point,
although POSIX.1-2008 notes that a future version of the standard
may require an implementation to initialize the semaphores to 0.)
Although Linux, like many other implementations,
initializes the semaphore values to 0,
a portable application cannot rely on this:
it should explicitly initialize the semaphores to the desired values.




Initialization can be done using
**semctl**(2)
**SETVAL**
or
**SETALL**
operation.
Where multiple peers do not know who will be the first to
initialize the set, checking for a nonzero
_sem_otime_
in the associated data structure retrieved by a
**semctl**(2)
**IPC_STAT**
operation can be used to avoid races.


<a name="semaphore-limits"></a>

### Semaphore limits

The following limits on semaphore set resources affect the
**semget**()
call:

* **SEMMNI**  
  System-wide limit on the number of semaphore sets.
  On Linux systems before version 3.19,
  the default value for this limit was 128.
  Since Linux 3.19,
  
  the default value is 32,000.
  On Linux, this limit can be read and modified via the fourth field of
  _/proc/sys/kernel/sem_.
  
* **SEMMSL**  
  Maximum number of semaphores per semaphore ID.
  On Linux systems before version 3.19,
  the default value for this limit was 250.
  Since Linux 3.19,
  
  the default value is 32,000.
  On Linux, this limit can be read and modified via the first field of
  _/proc/sys/kernel/sem_.
* **SEMMNS**  
  System-wide limit on the number of semaphores: policy dependent
  (on Linux, this limit can be read and modified via the second field of
  _/proc/sys/kernel/sem_).
  Note that the number of semaphores system-wide
  is also limited by the product of
  **SEMMSL**
  and
  **SEMMNI**.

<a name="bugs"></a>

# Bugs

The name choice
**IPC_PRIVATE**
was perhaps unfortunate,
**IPC_NEW**
would more clearly show its function.

<a name="see-also"></a>

# See Also

**semctl**(2),
**semop**(2),
**ftok**(3),
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
