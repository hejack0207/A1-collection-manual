# sigaltstack(2) - set and/or get signal stack context

Linux, 2017-11-08

```
#include <signal.h> 
 int sigaltstack(const stack_t *ss, stack_t *old_ss); 
 .in -4n Feature Test Macro Requirements for glibc (see feature_test_macros(7)): .in 
 sigaltstack(): .RS 4 _XOPEN_SOURCE&nbsp;>=&nbsp;500
</synopsis>

<synopsis>
    || /* Since glibc 2.12: */ _POSIX_C_SOURCE&nbsp;>=&nbsp;200809L     || /* Glibc versions <= 2.19: */ _BSD_SOURCE .RE
```

<a name="description"></a>

# Description

**sigaltstack**()
allows a process to define a new alternate
signal stack and/or retrieve the state of an existing
alternate signal stack.
An alternate signal stack is used during the
execution of a signal handler if the establishment of that handler (see
**sigaction**(2))
requested it.

The normal sequence of events for using an alternate signal stack
is the following:

* 1.  
  Allocate an area of memory to be used for the alternate
  signal stack.
* 2.  
  Use
  **sigaltstack**()
  to inform the system of the existence and
  location of the alternate signal stack.
* 3.  
  When establishing a signal handler using
  **sigaction**(2),
  inform the system that the signal handler should be executed
  on the alternate signal stack by
  specifying the **SA\_ONSTACK** flag.

The _ss_ argument is used to specify a new
alternate signal stack, while the _old\_ss_ argument
is used to retrieve information about the currently
established signal stack.
If we are interested in performing just one
of these tasks, then the other argument can be specified as NULL.

The
_stack_t_
type used to type the arguments of this function is defined as follows:

.in +4n
.EX
typedef struct {
    void  *ss_sp;     /* Base address of stack */
    int    ss_flags;  /* Flags */
    size_t ss_size;   /* Number of bytes in stack */
} stack_t;
.EE
.in

To establish a new alternate signal stack,
the fields of this structure are set as follows:

* _ss.ss_flags_  
  This field contains either 0, or the following flag:
    * **SS_AUTODISARM** (since Linux 4.7)  
      
      
      Clear the alternate signal stack settings on entry to the signal handler.
      When the signal handler returns,
      the previous alternate signal stack settings are restored.
    * This flag was added in order make it safe
      to switch away from the signal handler with
      **swapcontext**(3).
      Without this flag, a subsequently handled signal will corrupt
      the state of the switched-away signal handler.
      On kernels where this flag is not supported,
      **sigaltstack**()
      fails with the error
      **EINVAL**
      when this flag is supplied.
* _ss.ss_sp_  
  This field specifies the starting address of the stack.
  When a signal handler is invoked on the alternate stack,
  the kernel automatically aligns the address given in _ss.ss\_sp_
  to a suitable address boundary for the underlying hardware architecture.
* _ss.ss_size_  
  This field specifies the size of the stack.
  The constant **SIGSTKSZ** is defined to be large enough
  to cover the usual size requirements for an alternate signal stack,
  and the constant **MINSIGSTKSZ** defines the minimum
  size required to execute a signal handler.

To disable an existing stack, specify _ss.ss\_flags_
as **SS\_DISABLE**.
In this case, the kernel ignores any other flags in
_ss.ss_flags_
and the remaining fields
in _ss_.

If _old\_ss_ is not NULL, then it is used to return information about
the alternate signal stack which was in effect prior to the
call to
**sigaltstack**().
The _old\_ss.ss\_sp_ and _old\_ss.ss\_size_ fields return the starting
address and size of that stack.
The _old\_ss.ss\_flags_ may return either of the following values:

* **SS_ONSTACK**  
  The process is currently executing on the alternate signal stack.
  (Note that it is not possible
  to change the alternate signal stack if the process is
  currently executing on it.)
* **SS_DISABLE**  
  The alternate signal stack is currently disabled.
* Alternatively, this value is returned if the process is currently
  executing on an alternate signal stack that was established using the
  **SS_AUTODISARM**
  flag.
  In this case, it is safe to switch away from the signal handler with
  **swapcontext**(3).
  It is also possible to set up a different alternative signal stack
  using a further call to
  **sigaltstack**().
  
  
  
  
  
* **SS_AUTODISARM**  
  The alternate signal stack has been marked to be autodisarmed
  as described above.

By specifying
_ss_
as NULL, and
_old_ss_
as a non-NULL value, one can obtain the current settings for
the alternate signal stack without changing them.

<a name="return-value"></a>

# Return Value

**sigaltstack**()
returns 0 on success, or -1 on failure with
_errno_ set to indicate the error.

<a name="errors"></a>

# Errors


* **EFAULT**  
  Either _ss_ or _old\_ss_ is not NULL and points to an area
  outside of the process's address space.
* **EINVAL**  
  _ss_ is not NULL and the _ss\_flags_ field contains
  an invalid flag.
* **ENOMEM**  
  The specified size of the new alternate signal stack
  _ss.ss_size_
  was less than
  **MINSTKSZ**.
* **EPERM**  
  An attempt was made to change the alternate signal stack while
  it was active (i.e., the process was already executing
  on the current alternate signal stack).

<a name="attributes"></a>

# Attributes

For an explanation of the terms used in this section, see
**attributes**(7).
.TS
allbox;
lb lb lb
l l l.
Interface	Attribute	Value
T{
**sigaltstack**()
T}	Thread safety	MT-Safe
.TE

<a name="conforming-to"></a>

# Conforming to

POSIX.1-2001, POSIX.1-2008, SUSv2, SVr4.

The
**SS_AUTODISARM**
flag is a Linux extension.

<a name="notes"></a>

# Notes

The most common usage of an alternate signal stack is to handle the
**SIGSEGV**
signal that is generated if the space available for the
normal process stack is exhausted: in this case, a signal handler for
**SIGSEGV**
cannot be invoked on the process stack; if we wish to handle it,
we must use an alternate signal stack.

Establishing an alternate signal stack is useful if a process
expects that it may exhaust its standard stack.
This may occur, for example, because the stack grows so large
that it encounters the upwardly growing heap, or it reaches a
limit established by a call to **setrlimit(RLIMIT_STACK, &rlim)**.
If the standard stack is exhausted, the kernel sends
the process a **SIGSEGV** signal.
In these circumstances the only way to catch this signal is
on an alternate signal stack.

On most hardware architectures supported by Linux, stacks grow
downward.
**sigaltstack**()
automatically takes account
of the direction of stack growth.

Functions called from a signal handler executing on an alternate
signal stack will also use the alternate signal stack.
(This also applies to any handlers invoked for other signals while
the process is executing on the alternate signal stack.)
Unlike the standard stack, the system does not
automatically extend the alternate signal stack.
Exceeding the allocated size of the alternate signal stack will
lead to unpredictable results.

A successful call to
**execve**(2)
removes any existing alternate
signal stack.
A child process created via
**fork**(2)
inherits a copy of its parent's alternate signal stack settings.

**sigaltstack**()
supersedes the older
**sigstack**()
call.
For backward compatibility, glibc also provides
**sigstack**().
All new applications should be written using
**sigaltstack**().

<a name="history"></a>

### History

4.2BSD had a
**sigstack**()
system call.
It used a slightly
different struct, and had the major disadvantage that the caller
had to know the direction of stack growth.

<a name="example"></a>

# Example

The following code segment demonstrates the use of
**sigaltstack**()
(and
**sigaction**(2))
to install an alternate signal stack that is employed by a handler
for the
**SIGSEGV**
signal:

.in +4n
.EX
stack_t ss;

ss.ss_sp = malloc(SIGSTKSZ);
if (ss.ss_sp == NULL) {
    perror("malloc");
    exit(EXIT_FAILURE);
}

ss.ss_size = SIGSTKSZ;
ss.ss_flags = 0;
if (sigaltstack(&ss, NULL) == -1) {
    perror("sigaltstack");
    exit(EXIT_FAILURE);
}

sa.sa_flags = SA_ONSTACK;
sa.sa_handler = handler();      /* Address of a signal handler */
sigemptyset(&sa.sa_mask);
if (sigaction(SIGSEGV, &sa, NULL) == -1) {
    perror("sigaction");
    exit(EXIT_FAILURE);
}
.EE
.in

<a name="bugs"></a>

# Bugs

In Linux 2.2 and earlier, the only flag that could be specified
in
_ss.sa_flags_
was
**SS_DISABLE**.
In the lead up to the release of the Linux 2.4 kernel,





a change was made to allow
**sigaltstack**()
to allow
_ss.ss_flags==SS_ONSTACK_
with the same meaning as
_ss.ss_flags==0_
(i.e., the inclusion of
**SS_ONSTACK**
in
_ss.ss_flags_
is a no-op).
On other implementations, and according to POSIX.1,
**SS_ONSTACK**
appears only as a reported flag in
_old_ss.ss_flags_.
On Linux, there is no need ever to specify
**SS_ONSTACK**
in
_ss.ss_flags_,
and indeed doing so should be avoided on portability grounds:
various other systems

give an error if
**SS_ONSTACK**
is specified in
_ss.ss_flags_.

<a name="see-also"></a>

# See Also

**execve**(2),
**setrlimit**(2),
**sigaction**(2),
**siglongjmp**(3),
**sigsetjmp**(3),
**signal**(7)

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
