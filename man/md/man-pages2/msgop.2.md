# msgop(2) - System V message queue operations

Linux, 2017-09-15

    #include <sys/types.h>
    #include <sys/ipc.h>
    #include <sys/msg.h>
    
    int msgsnd(int msqid, const void *msgp, size_t msgsz, int msgflg);
    
    ssize_t msgrcv(int msqid, void *msgp, size_t msgsz, long msgtyp,
                   int msgflg);

<a name="description"></a>

# Description

The
**msgsnd**()
and
**msgrcv**()
system calls are used, respectively, to send messages to,
and receive messages from, a System&nbsp;V message queue.
The calling process must have write permission on the message queue
in order to send a message, and read permission to receive a message.

The
_msgp_
argument is a pointer to a caller-defined structure
of the following general form:

.in +4n
.EX
struct msgbuf {
    long mtype;       /* message type, must be &gt; 0 */
    char mtext[1];    /* message data */
};
.EE
.in

The
_mtext_
field is an array (or other structure) whose size is specified by
_msgsz_,
a nonnegative integer value.
Messages of zero length (i.e., no
_mtext_
field) are permitted.
The
_mtype_
field must have a strictly positive integer value.
This value can be
used by the receiving process for message selection
(see the description of
**msgrcv**()
below).

<a name="msgsnd"></a>

### msgsnd()

The
**msgsnd**()
system call appends a copy of the message pointed to by
_msgp_
to the message queue whose identifier is specified
by
_msqid_.

If sufficient space is available in the queue,
**msgsnd**()
succeeds immediately.
The queue capacity is governed by the
_msg_qbytes_
field in the associated data structure for the message queue.
During queue creation this field is initialized to
**MSGMNB**
bytes, but this limit can be modified using
**msgctl**(2).
A message queue is considered to be full if either of the following
conditions is true:

* *  
  Adding a new message to the queue would cause the total number of bytes
  in the queue to exceed the queue's maximum size (the
  _msg_qbytes_
  field).
* *  
  Adding another message to the queue would cause the total number of messages
  in the queue to exceed the queue's maximum size (the
  _msg_qbytes_
  field).
  This check is necessary to prevent an unlimited number of zero-length
  messages being placed on the queue.
  Although such messages contain no data,
  they nevertheless consume (locked) kernel memory.

If insufficient space is available in the queue, then the default
behavior of
**msgsnd**()
is to block until space becomes available.
If
**IPC_NOWAIT**
is specified in
_msgflg_,
then the call instead fails with the error
**EAGAIN**.

A blocked
**msgsnd**()
call may also fail if:

* *  
  the queue is removed,
  in which case the system call fails with
  _errno_
  set to
  **EIDRM**;
  or
* *  
  a signal is caught, in which case the system call fails
  with
  _errno_
  set to
  **EINTR**;**see**
  **signal**(7).
  (**msgsnd**()
  is never automatically restarted after being interrupted by a
  signal handler, regardless of the setting of the
  **SA_RESTART**
  flag when establishing a signal handler.)

Upon successful completion the message queue data structure is updated
as follows:

* _msg_lspid_
  is set to the process ID of the calling process.
* _msg_qnum_
  is incremented by 1.
* _msg_stime_
  is set to the current time.

<a name="msgrcv"></a>

### msgrcv()

The
**msgrcv**()
system call removes a message from the queue specified by
_msqid_
and places it in the buffer
pointed to by
_msgp_.

The argument
_msgsz_
specifies the maximum size in bytes for the member
_mtext_
of the structure pointed to by the
_msgp_
argument.
If the message text has length greater than
_msgsz_,
then the behavior depends on whether
**MSG_NOERROR**
is specified in
_msgflg_.
If
**MSG_NOERROR**
is specified, then
the message text will be truncated (and the truncated part will be
lost); if
**MSG_NOERROR**
is not specified, then
the message isn't removed from the queue and
the system call fails returning -1 with
_errno_
set to
**E2BIG**.

Unless
**MSG_COPY**
is specified in
_msgflg_
(see below),
the
_msgtyp_
argument specifies the type of message requested, as follows:

* *  
  If
  _msgtyp_
  is 0,
  then the first message in the queue is read.
* *  
  If
  _msgtyp_
  is greater than 0,
  then the first message in the queue of type
  _msgtyp_
  is read, unless
  **MSG_EXCEPT**
  was specified in
  _msgflg_,
  in which case
  the first message in the queue of type not equal to
  _msgtyp_
  will be read.
* *  
  If
  _msgtyp_
  is less than 0,
  then the first message in the queue with the lowest type less than or
  equal to the absolute value of
  _msgtyp_
  will be read.

The
_msgflg_
argument is a bit mask constructed by ORing together zero or more
of the following flags:

* **IPC_NOWAIT**  
  Return immediately if no message of the requested type is in the queue.
  The system call fails with
  _errno_
  set to
  **ENOMSG**.
* **MSG_COPY** (since Linux 3.8)  
  
  Nondestructively fetch a copy of the message at the ordinal position
  in the queue specified by
  _msgtyp_
  (messages are considered to be numbered starting at 0).
* This flag must be specified in conjunction with
  **IPC_NOWAIT**,
  with the result that, if there is no message available at the given position,
  the call fails immediately with the error
  **ENOMSG**.
  Because they alter the meaning of
  _msgtyp_
  in orthogonal ways,
  **MSG_COPY**
  and
  **MSG_EXCEPT**
  may not both be specified in
  _msgflg_.
* The
  **MSG_COPY**
  flag was added for the implementation of
  the kernel checkpoint-restore facility and
  is available only if the kernel was built with the
  **CONFIG_CHECKPOINT_RESTORE**
  option.
* **MSG_EXCEPT**  
  Used with
  _msgtyp_
  greater than 0
  to read the first message in the queue with message type that differs
  from
  _msgtyp_.
* **MSG_NOERROR**  
  To truncate the message text if longer than
  _msgsz_
  bytes.

If no message of the requested type is available and
**IPC_NOWAIT**
isn't specified in
_msgflg_,
the calling process is blocked until one of the following conditions occurs:

* *  
  A message of the desired type is placed in the queue.
* *  
  The message queue is removed from the system.
  In this case, the system call fails with
  _errno_
  set to
  **EIDRM**.
* *  
  The calling process catches a signal.
  In this case, the system call fails with
  _errno_
  set to
  **EINTR**.
  (**msgrcv**()
  is never automatically restarted after being interrupted by a
  signal handler, regardless of the setting of the
  **SA_RESTART**
  flag when establishing a signal handler.)

Upon successful completion the message queue data structure is updated
as follows:

* _msg_lrpid_
  is set to the process ID of the calling process.
* _msg_qnum_
  is decremented by 1.
* _msg_rtime_
  is set to the current time.

<a name="return-value"></a>

# Return Value

On failure both functions return -1
with
_errno_
indicating the error,
otherwise
**msgsnd**()
returns 0
and
**msgrcv**()
returns the number of bytes actually copied into the
_mtext_
array.

<a name="errors"></a>

# Errors

When
**msgsnd**()
fails,
_errno_
will be set to one among the following values:

* **EACCES**  
  The calling process does not have write permission on the message queue,
  and does not have the
  **CAP_IPC_OWNER**
  capability.
* **EAGAIN**  
  The message can't be sent due to the
  _msg_qbytes_
  limit for the queue and
  **IPC_NOWAIT**
  was specified in
  _msgflg_.
* **EFAULT**  
  The address pointed to by
  _msgp_
  isn't accessible.
* **EIDRM**  
  The message queue was removed.
* **EINTR**  
  Sleeping on a full message queue condition, the process caught a signal.
* **EINVAL**  
  Invalid
  _msqid_
  value, or nonpositive
  _mtype_
  value, or
  invalid
  _msgsz_
  value (less than 0 or greater than the system value
  **MSGMAX**).
* **ENOMEM**  
  The system does not have enough memory to make a copy of the
  message pointed to by
  _msgp_.

When
**msgrcv**()
fails,
_errno_
will be set to one among the following values:

* **E2BIG**  
  The message text length is greater than
  _msgsz_
  and
  **MSG_NOERROR**
  isn't specified in
  _msgflg_.
* **EACCES**  
  The calling process does not have read permission on the message queue,
  and does not have the
  **CAP_IPC_OWNER**
  capability in the user namespace that governs its IPC namespace.
* **EFAULT**  
  The address pointed to by
  _msgp_
  isn't accessible.
* **EIDRM**  
  While the process was sleeping to receive a message,
  the message queue was removed.
* **EINTR**  
  While the process was sleeping to receive a message,
  the process caught a signal; see
  **signal**(7).
* **EINVAL**  
  _msqid_
  was invalid, or
  _msgsz_
  was less than 0.
* **EINVAL** (since Linux 3.14)  
  _msgflg_
  specified
  **MSG_COPY**,
  but not
  **IPC_NOWAIT**.
* **EINVAL** (since Linux 3.14)  
  _msgflg_
  specified both
  **MSG_COPY**
  and
  **MSG_EXCEPT**.
* **ENOMSG**  
  **IPC_NOWAIT**
  was specified in
  _msgflg_
  and no message of the requested type existed on the message queue.
* **ENOMSG**  
  **IPC_NOWAIT**
  and
  **MSG_COPY**
  were specified in
  _msgflg_
  and the queue contains less than
  _msgtyp_
  messages.
* **ENOSYS** (since Linux 3.8)  
  _MSG_COPY_
  was specified in
  _msgflg_,
  and this kernel was configured without
  **CONFIG_CHECKPOINT_RESTORE**.

<a name="conforming-to"></a>

# Conforming to

POSIX.1-2001, POSIX.1-2008, SVr4.

The
**MSG_EXCEPT**
and
**MSG_COPY**
flags are Linux-specific;
their definitions can be obtained by defining the
**_GNU_SOURCE**

feature test macro.

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
_msgp_
argument is declared as _struct msgbuf&nbsp;*_ in
glibc 2.0 and 2.1.
It is declared as _void&nbsp;*_
in glibc 2.2 and later, as required by SUSv2 and SUSv3.

The following limits on message queue resources affect the
**msgsnd**()
call:

* **MSGMAX**  
  Maximum size of a message text, in bytes (default value: 8192 bytes).
  On Linux, this limit can be read and modified via
  _/proc/sys/kernel/msgmax_.
* **MSGMNB**  
  Maximum number of bytes that can be held in a message queue
  (default value: 16384 bytes).
  On Linux, this limit can be read and modified via
  _/proc/sys/kernel/msgmnb_.
  A privileged process
  (Linux: a process with the
  **CAP_SYS_RESOURCE**
  capability)
  can increase the size of a message queue beyond
  **MSGMNB**
  using the
  **msgctl**(2)
  **IPC_SET**
  operation.

The implementation has no intrinsic system-wide limits on the
number of message headers
(**MSGTQL**)
and the number of bytes in the message pool
(**MSGPOOL**).

<a name="bugs"></a>

# Bugs

In Linux 3.13 and earlier,
if
**msgrcv**()
was called with the
**MSG_COPY**
flag, but without
**IPC_NOWAIT**,
and the message queue contained less than
_msgtyp_
messages, then the call would block until the next message is written
to the queue.

At that point, the call would return a copy of the message,
_regardless_
of whether that message was at the ordinal position
_msgtyp_.
This bug is fixed

in Linux 3.14.

Specifying both
**MSG_COPY**
and
**MSC_EXCEPT**
in
_msgflg_
is a logical error (since these flags impose different interpretations on
_msgtyp_).
In Linux 3.13 and earlier,

this error was not diagnosed by
**msgrcv**().
This bug is fixed

in Linux 3.14.

<a name="example"></a>

# Example

The program below demonstrates the use of
**msgsnd**()
and
**msgrcv**().

The example program is first run with the **-s** option to send a
message and then run again with the **-r** option to receive a
message.

The following shell session shows a sample run of the program:

.in +4n
.EX
$** ./a.out -s**
sent: a message at Wed Mar  4 16:25:45 2015

$** ./a.out -r**
message received: a message at Wed Mar  4 16:25:45 2015
.EE
.in

<a name="program-source"></a>

### Program source


.EX
#include &lt;stdio.h&gt;
#include &lt;stdlib.h&gt;
#include &lt;string.h&gt;
#include &lt;time.h&gt;
#include &lt;unistd.h&gt;
#include &lt;errno.h&gt;
#include &lt;sys/types.h&gt;
#include &lt;sys/ipc.h&gt;
#include &lt;sys/msg.h&gt;

struct msgbuf {
    long mtype;
    char mtext[80];
};

static void
usage(char *prog_name, char *msg)
{
    if (msg != NULL)
        fputs(msg, stderr);

    fprintf(stderr, "Usage: %s [options]\\n", prog_name);
    fprintf(stderr, "Options are:\\n");
    fprintf(stderr, "-s        send message using msgsnd()\\n");
    fprintf(stderr, "-r        read message using msgrcv()\\n");
    fprintf(stderr, "-t        message type (default is 1)\\n");
    fprintf(stderr, "-k        message queue key (default is 1234)\\n");
    exit(EXIT_FAILURE);
}

static void
send_msg(int qid, int msgtype)
{
    struct msgbuf msg;
    time_t t;

    msg.mtype = msgtype;

    time(&t);
    snprintf(msg.mtext, sizeof(msg.mtext), "a message at %s",
            ctime(&t));

    if (msgsnd(qid, (void *) &msg, sizeof(msg.mtext),
                IPC_NOWAIT) == -1) {
        perror("msgsnd error");
        exit(EXIT_FAILURE);
    }
    printf("sent: %s\\n", msg.mtext);
}

static void
get_msg(int qid, int msgtype)
{
    struct msgbuf msg;

    if (msgrcv(qid, (void *) &msg, sizeof(msg.mtext), msgtype,
               MSG_NOERROR | IPC_NOWAIT) == -1) {
        if (errno != ENOMSG) {
            perror("msgrcv");
            exit(EXIT_FAILURE);
        }
        printf("No message available for msgrcv()\\n");
    } else
        printf("message received: %s\\n", msg.mtext);
}

int
main(int argc, char *argv[])
{
    int qid, opt;
    int mode = 0;               /* 1 = send, 2 = receive */
    int msgtype = 1;
    int msgkey = 1234;

    while ((opt = getopt(argc, argv, "srt:k:")) != -1) {
        switch (opt) {
        case 's':
            mode = 1;
            break;
        case 'r':
            mode = 2;
            break;
        case 't':
            msgtype = atoi(optarg);
            if (msgtype &lt;= 0)
                usage(argv[0], "-t option must be greater than 0\\n");
            break;
        case 'k':
            msgkey = atoi(optarg);
            break;
        default:
            usage(argv[0], "Unrecognized option\\n");
        }
    }

    if (mode == 0)
        usage(argv[0], "must use either -s or -r option\\n");

    qid = msgget(msgkey, IPC_CREAT | 0666);

    if (qid == -1) {
        perror("msgget");
        exit(EXIT_FAILURE);
    }

    if (mode == 2)
        get_msg(qid, msgtype);
    else
        send_msg(qid, msgtype);

    exit(EXIT_SUCCESS);
}
.EE

<a name="see-also"></a>

# See Also

**msgctl**(2),
**msgget**(2),
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
