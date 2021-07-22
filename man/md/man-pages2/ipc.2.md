# ipc(2) - System V IPC system calls

Linux, 2017-09-15

    int ipc(unsigned int call, int first, int second, int third,
            void *ptr, long fifth);

<a name="description"></a>

# Description

**ipc**()
is a common kernel entry point for the System&nbsp;V IPC calls
for messages, semaphores, and shared memory.
_call_
determines which IPC function to invoke;
the other arguments are passed through to the appropriate call.

User-space programs should call the appropriate functions by their usual names.
Only standard library implementors and kernel hackers need to know about
**ipc**().

<a name="conforming-to"></a>

# Conforming to

**ipc**()
is Linux-specific, and should not be used in programs
intended to be portable.

<a name="notes"></a>

# Notes

On some architectures—for example x86-64 and ARM—there is no
**ipc**()
system call; instead,
**msgctl**(2),
**semctl**(2),
**shmctl**(2),
and so on really are implemented as separate system calls.

<a name="see-also"></a>

# See Also

**msgctl**(2),
**msgget**(2),
**msgrcv**(2),
**msgsnd**(2),
**semctl**(2),
**semget**(2),
**semop**(2),
**semtimedop**(2),
**shmat**(2),
**shmctl**(2),
**shmdt**(2),
**shmget**(2),
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
