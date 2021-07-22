# semop(2) - System V semaphore operations

Linux, 2017-09-15

    #include <sys/types.h>
    #include <sys/ipc.h>
    #include <sys/sem.h>
    
    int semop(int semid, struct sembuf *sops, size_t nsops);
    
    int semtimedop(int semid, struct sembuf *sops, size_t nsops,
                   const struct timespec *timeout);
```

 .in -4n Feature Test Macro Requirements for glibc (see feature_test_macros(7)): .in 
 semtimedop(): _GNU_SOURCE
```

<a name="description"></a>

# Description

Each semaphore in a System&nbsp;V semaphore set
has the following associated values:

.in +4n
.EX
unsigned short  semval;   /* semaphore value */
unsigned short  semzcnt;  /* # waiting for zero */
unsigned short  semncnt;  /* # waiting for increase */
pid_t           sempid;   /* PID of process that last
.in
.EE

**semop**()
performs operations on selected semaphores in the set indicated by
_semid_.
Each of the
_nsops_
elements in the array pointed to by
_sops_
is a structure that
specifies an operation to be performed on a single semaphore.
The elements of this structure are of type
_struct sembuf_,
containing the following members:

.in +4n
.EX
unsigned short sem_num;  /* semaphore number */
short          sem_op;   /* semaphore operation */
short          sem_flg;  /* operation flags */
.EE
.in

Flags recognized in
_sem_flg_
are
**IPC_NOWAIT**
and
**SEM_UNDO**.
If an operation specifies
**SEM_UNDO**,
it will be automatically undone when the process terminates.

The set of operations contained in
_sops_
is performed in
_array order_,
and
_atomically_,
that is, the operations are performed either as a complete unit,
or not at all.
The behavior of the system call if not all operations can be
performed immediately depends on the presence of the
**IPC_NOWAIT**
flag in the individual
_sem_flg_
fields, as noted below.

Each operation is performed on the
_sem_num_-th
semaphore of the semaphore set, where the first semaphore of the set
is numbered 0.
There are three types of operation, distinguished by the value of
_sem_op_.

If
_sem_op_
is a positive integer, the operation adds this value to
the semaphore value
(_semval_).
Furthermore, if
**SEM_UNDO**
is specified for this operation, the system subtracts the value
_sem_op_
from the semaphore adjustment
(_semadj_)
value for this semaphore.
This operation can always proceed—it never forces a thread to wait.
The calling process must have alter permission on the semaphore set.

If
_sem_op_
is zero, the process must have read permission on the semaphore
set.
This is a "wait-for-zero" operation: if
_semval_
is zero, the operation can immediately proceed.
Otherwise, if
**IPC_NOWAIT**
is specified in
_sem_flg_,
**semop**()
fails with
_errno_
set to
**EAGAIN**
(and none of the operations in
_sops_
is performed).
Otherwise,
_semzcnt_
(the count of threads waiting until this semaphore's value becomes zero)
is incremented by one and the thread sleeps until
one of the following occurs:

* ·  
  _semval_
  becomes 0, at which time the value of
  _semzcnt_
  is decremented.
* ·  
  The semaphore set
  is removed:
  **semop**()
  fails, with
  _errno_
  set to
  **EIDRM**.
* ·  
  The calling thread catches a signal:
  the value of
  _semzcnt_
  is decremented and
  **semop**()
  fails, with
  _errno_
  set to
  **EINTR**.

If
_sem_op_
is less than zero, the process must have alter permission on the
semaphore set.
If
_semval_
is greater than or equal to the absolute value of
_sem_op_,
the operation can proceed immediately:
the absolute value of
_sem_op_
is subtracted from
_semval_,
and, if
**SEM_UNDO**
is specified for this operation, the system adds the absolute value of
_sem_op_
to the semaphore adjustment
(_semadj_)
value for this semaphore.
If the absolute value of
_sem_op_
is greater than
_semval_,
and
**IPC_NOWAIT**
is specified in
_sem_flg_,
**semop**()
fails, with
_errno_
set to
**EAGAIN**
(and none of the operations in
_sops_
is performed).
Otherwise,
_semncnt_
(the counter of threads waiting for this semaphore's value to increase)
is incremented by one and the thread sleeps until
one of the following occurs:

* ·  
  _semval_
  becomes greater than or equal to the absolute value of
  _sem_op_:
  the operation now proceeds, as described above.
* ·  
  The semaphore set is removed from the system:
  **semop**()
  fails, with
  _errno_
  set to
  **EIDRM**.
* ·  
  The calling thread catches a signal:
  the value of
  _semncnt_
  is decremented and
  **semop**()
  fails, with
  _errno_
  set to
  **EINTR**.

On successful completion, the
_sempid_
value for each semaphore specified in the array pointed to by
_sops_
is set to the caller's process ID.
In addition, the
_sem_otime_


is set to the current time.

<a name="semtimedop"></a>

### semtimedop()

**semtimedop**()
behaves identically to
**semop**()
except that in those cases where the calling thread would sleep,
the duration of that sleep is limited by the amount of elapsed
time specified by the
_timespec_
structure whose address is passed in the
_timeout_
argument.
(This sleep interval will be rounded up to the system clock granularity,
and kernel scheduling delays mean that the interval
may overrun by a small amount.)
If the specified time limit has been reached,
**semtimedop**()
fails with
_errno_
set to
**EAGAIN**
(and none of the operations in
_sops_
is performed).
If the
_timeout_
argument is NULL,
then
**semtimedop**()
behaves exactly like
**semop**().

Note that if
**semtimedop**()
is interrupted by a signal, causing the call to fail with the error
**EINTR**,
the contents of
_timeout_
are left unchanged.

<a name="return-value"></a>

# Return Value

If successful,
**semop**()
and
**semtimedop**()
return 0;
otherwise they return -1
with
_errno_
indicating the error.

<a name="errors"></a>

# Errors

On failure,
_errno_
is set to one of the following:

* **E2BIG**  
  The argument
  _nsops_
  is greater than
  **SEMOPM**,
  the maximum number of operations allowed per system
  call.
* **EACCES**  
  The calling process does not have the permissions required
  to perform the specified semaphore operations,
  and does not have the
  **CAP_IPC_OWNER**
  capability in the user namespace that governs its IPC namespace.
* **EAGAIN**  
  An operation could not proceed immediately and either
  **IPC_NOWAIT**
  was specified in
  _sem_flg_
  or the time limit specified in
  _timeout_
  expired.
* **EFAULT**  
  An address specified in either the
  _sops_
  or the
  _timeout_
  argument isn't accessible.
* **EFBIG**  
  For some operation the value of
  _sem_num_
  is less than 0 or greater than or equal to the number
  of semaphores in the set.
* **EIDRM**  
  The semaphore set was removed.
* **EINTR**  
  While blocked in this system call, the thread caught a signal; see
  **signal**(7).
* **EINVAL**  
  The semaphore set doesn't exist, or
  _semid_
  is less than zero, or
  _nsops_
  has a nonpositive value.
* **ENOMEM**  
  The
  _sem_flg_
  of some operation specified
  **SEM_UNDO**
  and the system does not have enough memory to allocate the undo
  structure.
* **ERANGE**  
  For some operation
  _sem_op+semval_
  is greater than
  **SEMVMX**,
  the implementation dependent maximum value for
  _semval_.

<a name="versions"></a>

# Versions

**semtimedop**()
first appeared in Linux 2.5.52,
and was subsequently backported into kernel 2.4.22.
Glibc support for
**semtimedop**()
first appeared in version 2.3.3.

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
_sem_undo_
structures of a process aren't inherited by the child produced by
**fork**(2),
but they are inherited across an
**execve**(2)
system call.

**semop**()
is never automatically restarted after being interrupted by a signal handler,
regardless of the setting of the
**SA_RESTART**
flag when establishing a signal handler.

A semaphore adjustment
(_semadj_)
value is a per-process, per-semaphore integer that is the negated sum
of all operations performed on a semaphore specifying the
**SEM_UNDO**
flag.
Each process has a list of
_semadj_
values—one value for each semaphore on which it has operated using
**SEM_UNDO**.
When a process terminates, each of its per-semaphore
_semadj_
values is added to the corresponding semaphore,
thus undoing the effect of that process's operations on the semaphore
(but see BUGS below).
When a semaphore's value is directly set using the
**SETVAL**
or
**SETALL**
request to
**semctl**(2),
the corresponding
_semadj_
values in all processes are cleared.
The
**clone**(2)
**CLONE_SYSVSEM**
flag allows more than one process to share a
_semadj_
list; see
**clone**(2)
for details.

The _semval_, _sempid_, _semzcnt_, and _semnct_ values
for a semaphore can all be retrieved using appropriate
**semctl**(2)
calls.

<a name="semaphore-limits"></a>

### Semaphore limits

The following limits on semaphore set resources affect the
**semop**()
call:

* **SEMOPM**  
  Maximum number of operations allowed for one
  **semop**()
  call.
  Before Linux 3.19,
  
  the default value for this limit was 32.
  Since Linux 3.19, the default value is 500.
  On Linux, this limit can be read and modified via the third field of
  _/proc/sys/kernel/sem_.
  
  _Note_:
  this limit should not be raised above 1000,
  
  because of the risk of that
  **semop**()
  fails due to kernel memory fragmentation when allocating memory to copy the
  _sops_
  array.
* **SEMVMX**  
  Maximum allowable value for
  _semval_:
  implementation dependent (32767).

The implementation has no intrinsic limits for
the adjust on exit maximum value
(**SEMAEM**),
the system wide maximum number of undo structures
(**SEMMNU**)
and the per-process maximum number of undo entries system parameters.

<a name="bugs"></a>

# Bugs

When a process terminates, its set of associated
_semadj_
structures is used to undo the effect of all of the
semaphore operations it performed with the
**SEM_UNDO**
flag.
This raises a difficulty: if one (or more) of these semaphore adjustments
would result in an attempt to decrease a semaphore's value below zero,
what should an implementation do?
One possible approach would be to block until all the semaphore
adjustments could be performed.
This is however undesirable since it could force process termination to
block for arbitrarily long periods.
Another possibility is that such semaphore adjustments could be ignored
altogether (somewhat analogously to failing when
**IPC_NOWAIT**
is specified for a semaphore operation).
Linux adopts a third approach: decreasing the semaphore value
as far as possible (i.e., to zero) and allowing process
termination to proceed immediately.

In kernels 2.6.x, x &lt;= 10, there is a bug that in some circumstances
prevents a thread that is waiting for a semaphore value to become
zero from being woken up when the value does actually become zero.
This bug is fixed in kernel 2.6.11.





<a name="example"></a>

# Example

The following code segment uses
**semop**()
to atomically wait for the value of semaphore 0 to become zero,
and then increment the semaphore value by one.

.in +4n
.EX
struct sembuf sops[2];
int semid;

/* Code to set _semid_ omitted */

sops[0].sem_num = 0;        /* Operate on semaphore 0 */
sops[0].sem_op = 0;         /* Wait for value to equal 0 */
sops[0].sem_flg = 0;

sops[1].sem_num = 0;        /* Operate on semaphore 0 */
sops[1].sem_op = 1;         /* Increment value by one */
sops[1].sem_flg = 0;

if (semop(semid, sops, 2) == -1) {
    perror("semop");
    exit(EXIT_FAILURE);
}
.EE
.in

<a name="see-also"></a>

# See Also

**clone**(2),
**semctl**(2),
**semget**(2),
**sigaction**(2),
**capabilities**(7),
**sem_overview**(7),
**svipc**(7),
**time**(7)

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
